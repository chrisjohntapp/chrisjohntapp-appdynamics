# == Class: appdynamics::agent::config::jboss
#
class appdynamics::agent::config::jboss
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
    before                              =>  Service['appdynamics-jboss'],
    require                             =>  Class['appdynamics::agent::install'],
  } ->

  exec { 'copy_java_agent_jboss':
    path                                =>  '/bin:/usr/bin',
    command                             =>  "cp -ar ${java_agent_install_dir}/* ${agent_runtime_directory}/",
    onlyif                              =>  "test $(find $agent_runtime_directory -type f | wc -l) -eq 0",
  } ->

  file { 'jboss_controller-info_xml':
    path                                =>  "${agent_runtime_directory}/conf/controller-info.xml",
    content                             =>  template('appdynamics/agent/jboss/controller-info_xml.erb'),
    group                               =>  $group,
    owner                               =>  $user,
    mode                                =>  '0644',
  } ->

  file { 'jboss_run_conf':
    path                                =>  "${application_home}/bin/run.conf",
    content                             =>  template("appdynamics/agent/jboss/run_conf.erb"),
    group                               =>  $group,
    owner                               =>  $user,
    mode                                =>  '0644',
    notify                              =>  Service['appdynamics-jboss'],
  }
}