class { 'appdynamics::agent::install':
  agent_types                             =>  [
                                          'db',
                                          'jboss',
                                          'machine',
                                          'php',
                                          'tomcat'
                                          ]
}