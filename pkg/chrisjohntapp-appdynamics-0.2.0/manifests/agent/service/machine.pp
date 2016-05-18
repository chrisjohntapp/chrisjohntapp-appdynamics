# == Class appdynamics::agent::service::machine
#
class appdynamics::agent::service::machine
(
  $agent_enable,
)
{
  if $agent_enable
  {
    service { 'appdynamics-machine':
      ensure    => running,
      hasstatus => true,
      # status    => 'pgrep -f machineagent.jar',
      name      => 'appd-machineagent',
    }
  }
  else
  {
    service { 'appdynamics-machine':
      ensure    => stopped,
      hasstatus => true,
      # status    => 'pgrep -f machineagent.jar',
      name      => 'appd-machineagent',
    }
  }
}