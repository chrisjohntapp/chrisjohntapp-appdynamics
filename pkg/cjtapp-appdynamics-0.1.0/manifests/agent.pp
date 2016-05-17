# == Class: appdynamics::agent
#
class appdynamics::agent
(
  $agent_types                          =  appdynamics::params::agent_types,
  $package_ensure                       =  appdynamics::params::package_ensure,
  $java_agent_install_dir               =  appdynamics::params::java_agent_install_dir,

  $db_agent_base                        =  appdynamics::params::db_agent_base,
  $db_agent_home                        =  appdynamics::params::db_agent_home,
  $db_group                             =  appdynamics::params::db_group,
  $db_user                              =  appdynamics::params::db_user,
  $db_app                               =  appdynamics::params::db_app,
  $db_tier                              =  appdynamics::params::db_tier,
  $db_controller_host                   =  appdynamics::params::db_controller_host,
  $db_controller_port                   =  appdynamics::params::db_controller_port,
  $db_controller_ssl_enabled            =  appdynamics::params::db_controller_ssl_enabled,
  $db_enable_orchestration              =  appdynamics::params::db_enable_orchestration,
  $db_account_name                      =  appdynamics::params::db_account_name,
  $db_account_access_key                =  appdynamics::params::db_account_access_key,
  $db_force_agent_registration          =  appdynamics::params::db_force_agent_registration,
  $db_node_name                         =  appdynamics::params::db_node_name,
  $db_agent_options                     =  appdynamics::params::db_agent_options,
  $db_application_home                  =  appdynamics::params::db_application_home,

  $jboss_agent_base                     =  appdynamics::params::jboss_agent_base,
  $jboss_agent_home                     =  appdynamics::params::jboss_agent_home,
  $jboss_group                          =  appdynamics::params::jboss_group,
  $jboss_user                           =  appdynamics::params::jboss_user,
  $jboss_app                            =  appdynamics::params::jboss_app,
  $jboss_tier                           =  appdynamics::params::jboss_tier,
  $jboss_controller_host                =  appdynamics::params::jboss_controller_host,
  $jboss_controller_port                =  appdynamics::params::jboss_controller_port,
  $jboss_controller_ssl_enabled         =  appdynamics::params::jboss_controller_ssl_enabled,
  $jboss_enable_orchestration           =  appdynamics::params::jboss_enable_orchestration,
  $jboss_account_name                   =  appdynamics::params::jboss_account_name,
  $jboss_account_access_key             =  appdynamics::params::jboss_account_access_key,
  $jboss_force_agent_registration       =  appdynamics::params::jboss_force_agent_registration,
  $jboss_node_name                      =  appdynamics::params::jboss_node_name,
  $jboss_agent_options                  =  appdynamics::params::jboss_agent_options,
  $jboss_application_home               =  appdynamics::params::jboss_application_home,

  $machine_agent_base                   =  appdynamics::params::machine_agent_base,
  $machine_agent_home                   =  appdynamics::params::machine_agent_home,
  $machine_group                        =  appdynamics::params::machine_group,
  $machine_user                         =  appdynamics::params::machine_user,
  $machine_app                          =  appdynamics::params::machine_app,
  $machine_tier                         =  appdynamics::params::machine_tier,
  $machine_controller_host              =  appdynamics::params::machine_controller_host,
  $machine_controller_port              =  appdynamics::params::machine_controller_port,
  $machine_controller_ssl_enabled       =  appdynamics::params::machine_controller_ssl_enabled,
  $machine_enable_orchestration         =  appdynamics::params::machine_enable_orchestration,
  $machine_account_name                 =  appdynamics::params::machine_account_name,
  $machine_account_access_key           =  appdynamics::params::machine_account_access_key,
  $machine_force_agent_registration     =  appdynamics::params::machine_force_agent_registration,
  $machine_node_name                    =  appdynamics::params::machine_node_name,
  $machine_agent_options                =  appdynamics::params::machine_agent_options,
  $machine_application_home             =  appdynamics::params::machine_application_home,

  $php_agent_base                       =  appdynamics::params::php_agent_base,
  $php_agent_home                       =  appdynamics::params::php_agent_home,
  $php_group                            =  appdynamics::params::php_group,
  $php_user                             =  appdynamics::params::php_user,
  $php_app                              =  appdynamics::params::php_app,
  $php_tier                             =  appdynamics::params::php_tier,
  $php_controller_host                  =  appdynamics::params::php_controller_host,
  $php_controller_port                  =  appdynamics::params::php_controller_port,
  $php_controller_ssl_enabled           =  appdynamics::params::php_controller_ssl_enabled,
  $php_enable_orchestration             =  appdynamics::params::php_enable_orchestration,
  $php_account_name                     =  appdynamics::params::php_account_name,
  $php_account_access_key               =  appdynamics::params::php_account_access_key,
  $php_force_agent_registration         =  appdynamics::params::php_force_agent_registration,
  $php_node_name                        =  appdynamics::params::php_node_name,
  $php_agent_options                    =  appdynamics::params::php_agent_options,
  $php_application_home                 =  appdynamics::params::php_application_home,

  $tomcat_agent_base                    =  appdynamics::params::tomcat_agent_base,
  $tomcat_agent_home                    =  appdynamics::params::tomcat_agent_home,
  $tomcat_group                         =  appdynamics::params::tomcat_group,
  $tomcat_user                          =  appdynamics::params::tomcat_user,
  $tomcat_app                           =  appdynamics::params::tomcat_app,
  $tomcat_tier                          =  appdynamics::params::tomcat_tier,
  $tomcat_controller_host               =  appdynamics::params::tomcat_controller_host,
  $tomcat_controller_port               =  appdynamics::params::tomcat_controller_port,
  $tomcat_controller_ssl_enabled        =  appdynamics::params::tomcat_controller_ssl_enabled,
  $tomcat_enable_orchestration          =  appdynamics::params::tomcat_enable_orchestration,
  $tomcat_account_name                  =  appdynamics::params::tomcat_account_name,
  $tomcat_account_access_key            =  appdynamics::params::tomcat_account_access_key,
  $tomcat_force_agent_registration      =  appdynamics::params::tomcat_force_agent_registration,
  $tomcat_node_name                     =  appdynamics::params::tomcat_node_name,
  $tomcat_agent_options                 =  appdynamics::params::tomcat_agent_options,
  $tomcat_application_home              =  appdynamics::params::tomcat_application_home,
)
{
  # Validate hashes and arrays.
  validate_array                        ($agent_types)

  # Validate parameters.
  validate_re                           ($package_ensure, [ 'latest', 'installed' ])
  validate_string                       ($java_agent_install_dir)

  validate_string                       ($db_agent_base)
  validate_string                       ($db_agent_home)
  validate_string                       ($db_group)
  validate_string                       ($db_user)
  validate_string                       ($db_app)
  validate_string                       ($db_tier)
  validate_string                       ($db_controller_host)
  validate_integer                      ($db_controller_port)
  validate_bool                         ($db_controller_ssl_enabled)
  validate_bool                         ($db_enable_orchestration)
  validate_string                       ($db_account_name)
  validate_string                       ($db_account_access_key)
  validate_bool                         ($db_force_agent_registration)
  validate_string                       ($db_node_name)
  validate_string                       ($db_agent_options)
  validate_string                       ($db_application_home)

  validate_string                       ($jboss_agent_base)
  validate_string                       ($jboss_agent_home)
  validate_string                       ($jboss_group)
  validate_string                       ($jboss_user)
  validate_string                       ($jboss_app)
  validate_string                       ($jboss_tier)
  validate_string                       ($jboss_controller_host)
  validate_integer                      ($jboss_controller_port)
  validate_bool                         ($jboss_controller_ssl_enabled)
  validate_bool                         ($jboss_enable_orchestration)
  validate_string                       ($jboss_account_name)
  validate_string                       ($jboss_account_access_key)
  validate_bool                         ($jboss_force_agent_registration)
  validate_string                       ($jboss_node_name)
  validate_string                       ($jboss_agent_options)
  validate_string                       ($jboss_application_home)

  validate_string                       ($machine_agent_base)
  validate_string                       ($machine_agent_home)
  validate_string                       ($machine_group)
  validate_string                       ($machine_app)
  validate_string                       ($machine_tier)
  validate_string                       ($machine_user)
  validate_string                       ($machine_controller_host)
  validate_integer                      ($machine_controller_port)
  validate_bool                         ($machine_controller_ssl_enabled)
  validate_bool                         ($machine_enable_orchestration)
  validate_string                       ($machine_account_name)
  validate_string                       ($machine_account_access_key)
  validate_bool                         ($machine_force_agent_registration)
  validate_string                       ($machine_node_name)
  validate_string                       ($machine_agent_options)
  validate_string                       ($machine_application_home)

  validate_string                       ($php_agent_base)
  validate_string                       ($php_agent_home)
  validate_string                       ($php_group)
  validate_string                       ($php_user)
  validate_string                       ($php_app)
  validate_string                       ($php_tier)
  validate_string                       ($php_controller_host)
  validate_integer                      ($php_controller_port)
  validate_bool                         ($php_controller_ssl_enabled)
  validate_bool                         ($php_enable_orchestration)
  validate_string                       ($php_account_name)
  validate_string                       ($php_account_access_key)
  validate_bool                         ($php_force_agent_registration)
  validate_string                       ($php_node_name)
  validate_string                       ($php_agent_options)
  validate_string                       ($php_application_home)

  validate_string                       ($tomcat_agent_base)
  validate_string                       ($tomcat_agent_home)
  validate_string                       ($tomcat_group)
  validate_string                       ($tomcat_user)
  validate_string                       ($tomcat_app)
  validate_string                       ($tomcat_tier)
  validate_string                       ($tomcat_controller_host)
  validate_integer                      ($tomcat_controller_port)
  validate_bool                         ($tomcat_controller_ssl_enabled)
  validate_bool                         ($tomcat_enable_orchestration)
  validate_string                       ($tomcat_account_name)
  validate_string                       ($tomcat_account_access_key)
  validate_bool                         ($tomcat_force_agent_registration)
  validate_string                       ($tomcat_node_name)
  validate_string                       ($tomcat_agent_options)
  validate_string                       ($tomcat_application_home)

  # Install agent package(s).
  class { 'appdynamics::agent::install':
    agent_types                         =>  $agent_types,
    package_ensure                      =>  $package_ensure,
  }
  contain 'appdynamics::agent::install'

  # Configure agent(s).
  $agent_types.each |$agent_type|
  {
    class { "appdynamics::agent::config::${agent_type}":
      agent_base                        =>  getvar("${agent_type}_agent_base"),
      agent_home                        =>  getvar("${agent_type}_agent_home"),
      group                             =>  getvar("${agent_type}_group"),
      user                              =>  getvar("${agent_type}_user"),
      app                               =>  getvar("${agent_type}_app"),
      tier                              =>  getvar("${agent_type}_tier"),
      controller_host                   =>  getvar("${agent_type}_controller_host"),
      controller_port                   =>  getvar("${agent_type}_controller_port"),
      controller_ssl_enabled            =>  getvar("${agent_type}_controller_ssl_enabled"),
      enable_orchestration              =>  getvar("${agent_type}_enable_orchestration"),
      account_name                      =>  getvar("${agent_type}_account_name"),
      account_access_key                =>  getvar("${agent_type}_account_access_key"),
      force_agent_registration          =>  getvar("${agent_type}_force_agent_registration"),
      node_name                         =>  getvar("${agent_type}_node_name"),
      agent_options                     =>  getvar("${agent_type}_agent_options"),
      application_home                  =>  getvar("${agent_type}_application_home"),
    }
    contain "appdynamics::agent::config::${agent_type}"
  }

  # Manage agent service(s).
  class { 'appdynamics::agent::service':
    agent_types                         =>  $agent_types,
  }
  contain 'appdynamics::agent::service'
}