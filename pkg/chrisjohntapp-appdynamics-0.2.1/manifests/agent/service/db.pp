# == Class appdynamics::agent::service::db
#
class appdynamics::agent::service::db
(
  $agent_enable,
)
{
  if $agent_enable
  {
    service { 'appdynamics-db':
      ensure    =>  running,
      enable    =>  true,
      hasstatus =>  false,
      status    =>  'pgrep -f db-agent.jar',
      name      =>  'appd-dbagent',
    }
  }
  else
  {
    service { 'appdynamics-db':
      ensure    =>  stopped,
      enable    =>  false,
      hasstatus =>  false,
      status    =>  'pgrep -f db-agent.jar',
      name      =>  'appd-dbagent',
    }
  }
}