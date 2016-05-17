# == Class appdynamics::agent::config::php
#
class appdynamics::agent::config::php
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
  $agent_runtime_directory              =  "${agent_base}/${agent_home}/appdynamics-php-agent"

  file { 'php_agent_basehome':
    path                                =>  "${agent_base}/${agent_home}",
    ensure                              =>  directory,
    group                               =>  $group,
    owner                               =>  $user,
    mode                                =>  '0755',
  } ->

  file { "$agent_home":
    path                                =>  $agent_runtime_directory,
    ensure                              =>  directory,
    group                               =>  $group,
    owner                               =>  $user,
    mode                                =>  '0755',
    before                              =>  Service['appdynamics-php'],
    require                             =>  Class['appdynamics::agent::install'],
  } ->

  exec {'php_run_agent_install_script':
    path                                =>  '/bin:/usr/bin',
    command                             =>  "${agent_runtime_directory}/install.sh --ignore-permissions -a=${account_name}@${account_access_key} $controller_host $controller_port $app $tier $node_name",
    cwd                                 =>  $agent_runtime_directory,
    user                                =>  'root',
    # TODO: This only fires if both fail; I need multiple, independent 'unless's.
    unless                              =>  [ "test -d ${agent_runtime_directory}/multiAgentInstall",
                                              "test $(find /etc/php* -type f -name appdynamics_agent.ini -exec grep -ic $node_name {} \;) -ge 1" ],
    notify                              =>  Service['appdynamics-php'],
  }
}