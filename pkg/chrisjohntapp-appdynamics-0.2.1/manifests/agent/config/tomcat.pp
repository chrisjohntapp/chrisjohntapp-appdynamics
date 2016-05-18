# == Class: appdynamics::agent::config::tomcat
#
class appdynamics::agent::config::tomcat
(
  $agent_enable,
  $agent_base,
  $agent_home,
  $group,
  $user,
  $app,
  $tier,
  $controller_host,
  $controller_port,
  $controller_ssl_enabled,
  $enable_orchestration,
  $account_name,
  $account_access_key,
  $force_agent_registration,
  $node_name,
  $agent_options,
  $application_home,
)
{
  $agent_runtime_directory = "${agent_base}/${agent_home}"

  file { $agent_home:
    ensure => directory,
    path   => $agent_runtime_directory,
    group  => $group,
    owner  => $user,
    mode   => '0755',
  } ->

  exec { 'copy_java_agent_tomcat':
    path    => '/bin:/usr/bin',
    command => "cp -ar ${appdynamics::agent::java_agent_install_dir}/* ${agent_runtime_directory}/",
    onlyif  => "test $(find ${agent_runtime_directory} -type f | wc -l) -eq 0",
  } ->

  exec { 'tomcat_java_agent_file_permissions':
    path      => '/bin:/usr/bin',
    command   => "chown -R tomcat: ${agent_runtime_directory}",
    onlyif    => "test $(find ${agent_runtime_directory} ! -user tomcat | wc -l) -ne 0",
    subscribe => Class['appdynamics::agent::install'],
  } ->

  file { 'tomcat_controller-info_xml':
    path    => "${agent_runtime_directory}/conf/controller-info.xml",
    content => template('appdynamics/agent/tomcat/controller-info_xml.erb'),
    group   => $group,
    owner   => $user,
    mode    => '0644',
  }

  if $agent_enable
  {
    if $appdynamics::agent::tomcat_version == 6
    {
      file_line { 'enable_catalina_tomcat6':
        ensure  => present,
        path    => '/etc/default/tomcat6',
        line    => "JAVA_OPTS=\"\$JAVA_OPTS -javaagent:${agent_runtime_directory}/javaagent.jar\"",
        require => File['tomcat_controller-info_xml'],
        notify  => Service['tomcat6'],
      }
    }
    elsif $appdynamics::agent::tomcat_version == 7
    {
      file_line { 'enable_catalina_tomcat7':
        ensure  => present,
        path    => '/etc/default/tomcat7',
        line    => "JAVA_OPTS=\"\$JAVA_OPTS -javaagent:${agent_runtime_directory}/javaagent.jar\"",
        require => File['tomcat_controller-info_xml'],
        notify  => Service['tomcat7'],
      }
    }
  }
  else
  {
    if $appdynamics::agent::tomcat_version == 6
    {
      file_line { 'disable_catalina_tomcat6':
        ensure            => absent,
        path              => '/etc/default/tomcat6',
        line              => "JAVA_OPTS=\"\$JAVA_OPTS -javaagent:${agent_runtime_directory}/javaagent.jar\"",
        match             => ".*${agent_runtime_directory}.*",
        match_for_absence => true,
        require           => File['tomcat_controller-info_xml'],
        notify            => Service['tomcat6'],
      }
    }
    elsif $appdynamics::agent::tomcat_version == 7
    {
      file_line { 'disable_catalina_tomcat7':
        ensure            => absent,
        path              => '/etc/default/tomcat7',
        line              => "JAVA_OPTS=\"\$JAVA_OPTS -javaagent:${agent_runtime_directory}/javaagent.jar\"",
        match             => ".*${agent_runtime_directory}.*",
        match_for_absence => true,
        require           => File['tomcat_controller-info_xml'],
        notify            => Service['tomcat7'],
      }
    }
  }
}