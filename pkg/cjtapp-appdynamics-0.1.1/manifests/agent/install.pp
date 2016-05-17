# == Class::appdynamics::agent::install
#
class appdynamics::agent::install
(
  $agent_types,
  $package_ensure,
)
inherits appdynamics::params
{
  $d_packages = $agent_types.map |$x|
  {
    case $x
    {
      'db': { 'db' }
      'jboss': { 'java' }
      'machine': { 'machine' }
      'php': { 'php' }
      'tomcat': { 'java' }
      default:
      {
        notify { "Unknown agent type specified: ${x}": }
      }
    }
  }

  $u_packages = unique($d_packages)

  $u_packages.each |$package|
  {
    package { "appdynamics-${package}-agent":
      provider                          =>  $package_provider,
      ensure                            =>  $package_ensure,
    }
  }
}