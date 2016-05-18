# == Class appdynamics::agent::service::jboss
#
class appdynamics::agent::service::jboss
(
  $agent_enable,
)
{
  if $agent_enable
  {
    service { 'appdynamics-jboss':
      ensure    =>  running,
      enable    =>  true,
      hasstatus =>  false,
      status    =>  'pgrep -f javaagent.jar',
      provider  =>  base,
      stop      =>  '/etc/init.d/jboss stop',
      start     =>  '/etc/init.d/jboss start',
    }
  }
}