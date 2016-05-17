# == Class: appdynamics::agent::config::db
#
class appdynamics::agent::config::db
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
    before                              =>  Service['appdynamics-db'],
    require                             =>  Class['appdynamics::agent::install'],
  } ->

  file { 'db_controller-info_xml':
    path                                =>  "${agent_runtime_directory}/conf/controller-info.xml",
    content                             =>  template('appdynamics/agent/db/controller-info_xml.erb'),
    group                               =>  $group,
    owner                               =>  $user,
    mode                                =>  '0644',
  } ->

  file { 'database_init_script':
    path                                =>  '/etc/init.d/appd-dbagent',
    content                             =>  template('appdynamics/agent/db/appd_dbagent.erb'),
    group                               =>  'root',
    owner                               =>  'root',
    mode                                =>  '0755',
  } ->

  file { 'database_init_link':
    path                                =>  '/etc/rc2.d/S99appddbagent',
    ensure                              =>  link,
    target                              =>  '../init.d/appd-dbagent',
    notify                              =>  Service['appdynamics-db'],
  }
}