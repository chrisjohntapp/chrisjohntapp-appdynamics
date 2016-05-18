# == Class appdynamics::agent::service::php
#
class appdynamics::agent::service::php
(
  $agent_enable,
)
{
  if $agent_enable
  {
    service { 'appdynamics-php':
      ensure    =>  running,
      enable    =>  true,
      hasstatus =>  false,
      status    =>  'pgrep -f appdynamics-php5',
      provider  =>  base,
      stop      =>  "find /etc/init.d/ -type f -name ${appdynamics::params::apache_init_script}* -exec {} stop \;",
      start     =>  "find /etc/init.d/ -type f -name ${appdynamics::params::apache_init_script}* -exec {} start \;",
    }
  }
}