# == Class: appdynamics::agent::config::tomcat
#
class appdynamics::agent::config::tomcat
(
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
inherits appdynamics::params
{
  $agent_runtime_directory              =  "${agent_base}/${agent_home}"

  file { "$agent_home":
    path                                =>  $agent_runtime_directory,
    ensure                              =>  directory,
    group                               =>  $group,
    owner                               =>  $user,
    mode                                =>  '0755',
    before                              =>  Service['appdynamics-tomcat'],
  } ->

  exec { 'copy_java_agent_tomcat':
    path                                =>  '/bin:/usr/bin',
    command                             =>  "cp -ar ${java_agent_install_dir}/* ${agent_runtime_directory}/",
    onlyif                              =>  "test $(find $agent_runtime_directory -type f | wc -l) -eq 0",
  } ->

  file { 'tomcat_controller-info_xml':
    path                                =>  "${agent_runtime_directory}/conf/controller-info.xml",
    content                             =>  template('appdynamics/agent/tomcat/controller-info_xml.erb'),
    group                               =>  $group,
    owner                               =>  $user,
    mode                                =>  '0644',
  } ->

  # Targets tomcat6.
  exec { 'edit_catalina_tomcat6':
    path                                =>  '/bin:/usr/bin',
    command                             =>  "echo 'JAVA_OPTS=\"\$JAVA_OPTS -javaagent:${agent_runtime_directory}/javaagent.jar\"' >> /etc/default/tomcat6 ; /etc/init.d/tomcat6 restart",
    onlyif                              =>  "test -f /etc/default/tomcat6",
    unless                              =>  "grep -ic appdynamics /etc/default/tomcat6",
  }

  # Targets tomcat7.
  exec { 'edit_catalina_tomcat7':
    path                                =>  '/bin:/usr/bin',
    command                             =>  "echo 'JAVA_OPTS=\"\$JAVA_OPTS -javaagent:${agent_runtime_directory}/javaagent.jar\"' >> /etc/default/tomcat7 ; /etc/init.d/tomcat7 restart",
    onlyif                              =>  "test -f /etc/default/tomcat7",
    unless                              =>  "grep -ic appdynamics /etc/default/tomcat7",
  }

  # Correct file permissions, if required.
  exec { 'tomcat_java_agent_file_permissions':
    path                                =>  '/bin:/usr/bin',
    command                             =>  "chown -R tomcat: $agent_runtime_directory",
    onlyif                              =>  "test $(find $agent_runtime_directory ! -user tomcat | wc -l) -ne 0",
    subscribe                           =>  Class['appdynamics::agent::install'],
  }
}