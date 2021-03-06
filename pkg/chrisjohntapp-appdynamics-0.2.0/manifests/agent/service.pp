# == Class: appdynamics::agent::service
#
class appdynamics::agent::service
(
  $agent_types,
)
inherits appdynamics::params
{
  $agent_types.each |$agent_type|
  {
    case $agent_type
    {
      'db':
      {
        service { 'appdynamics-db':
          ensure    =>  running,
          enable    =>  true,
          hasstatus =>  false,
          status    =>  'pgrep -f db-agent.jar',
          provider  =>  init,
          name      =>  'appd-dbagent',
        }
      }

      'jboss':
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

      'machine':
      {
        service { 'appdynamics-machine':
          ensure    =>  running,
          enable    =>  true,
          hasstatus =>  false,
          status    =>  'pgrep -f machineagent.jar',
          provider  =>  init,
          name      =>  'appd-machineagent',
        }
      }

      'php':
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

      'tomcat':
      {
        service { 'appdynamics-tomcat':
          ensure    =>  running,
          enable    =>  true,
          hasstatus =>  false,
          status    =>  'pgrep -f javaagent.jar',
          provider  =>  base,
          stop      =>  'find /etc/init.d/ -type f -name tomcat* -exec {} stop \;',
          start     =>  'find /etc/init.d/ -type f -name tomcat* -exec {} start \;',
        }
      }

      default:
      {
        # Do nowt.
      }
    }
  }
}
