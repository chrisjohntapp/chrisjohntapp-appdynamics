class { 'appdynamics::agent::service':
  agent_types                             =>  [
                                          'db',
                                          'jboss',
                                          'machine',
                                          'php',
                                          'tomcat'
                                          ]
}