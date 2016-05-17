# == Class appdynamics::params
#
class appdynamics::params
{
  $agent_types                          =  []
  $package_ensure                       =  'latest'
  $java_agent_install_dir               =  '/opt/AppDynamicsPro/JavaAppServerAgent'

  $db_agent_base                        =  '/opt/AppDynamicsPro'
  $db_agent_home                        =  '/DBAgent'
  $db_group                             =  'appdynamics'
  $db_user                              =  'appdynamics'
  $db_app                               =  undef
  $db_tier                              =  undef
  $db_controller_host                   =  undef
  $db_controller_port                   =  80
  $db_controller_ssl_enabled            =  false
  $db_enable_orchestration              =  false
  $db_account_name                      =  undef
  $db_account_access_key                =  undef
  $db_force_agent_registration          =  false
  $db_node_name                         =  undef
  $db_agent_options                     =  undef
  $db_application_home                  =  undef

  $jboss_agent_base                     =  '/opt/AppDynamicsPro'
  $jboss_agent_home                     =  '/JavaAppServerAgent-JBoss'
  $jboss_group                          =  'appdynamics'
  $jboss_user                           =  'appdynamics'
  $jboss_app                            =  undef
  $jboss_tier                           =  undef
  $jboss_controller_host                =  undef
  $jboss_controller_port                =  80
  $jboss_controller_ssl_enabled         =  false
  $jboss_enable_orchestration           =  false
  $jboss_account_name                   =  undef
  $jboss_account_access_key             =  undef
  $jboss_force_agent_registration       =  false
  $jboss_node_name                      =  undef
  $jboss_agent_options                  =  undef
  $jboss_application_home               =  undef

  $machine_agent_base                   =  '/opt/AppDynamicsPro'
  $machine_agent_home                   =  '/MachineAgent'
  $machine_group                        =  'appdynamics'
  $machine_user                         =  'appdynamics'
  $machine_app                          =  undef
  $machine_tier                         =  undef
  $machine_controller_host              =  undef
  $machine_controller_port              =  80
  $machine_controller_ssl_enabled       =  false
  $machine_enable_orchestration         =  false
  $machine_account_name                 =  undef
  $machine_account_access_key           =  undef
  $machine_force_agent_registration     =  false
  $machine_node_name                    =  undef
  $machine_agent_options                =  undef
  $machine_application_home             =  undef

  $php_agent_base                       =  '/opt/AppDynamicsPro'
  $php_agent_home                       =  '/PHPAgent'
  $php_group                            =  'appdynamics'
  $php_user                             =  'appdynamics'
  $php_app                              =  undef
  $php_tier                             =  undef
  $php_controller_host                  =  undef
  $php_controller_port                  =  80
  $php_controller_ssl_enabled           =  false
  $php_enable_orchestration             =  false
  $php_account_name                     =  undef
  $php_account_access_key               =  undef
  $php_force_agent_registration         =  false
  $php_node_name                        =  undef
  $php_agent_options                    =  undef
  $php_application_home                 =  undef

  $tomcat_agent_base                    =  '/opt/AppDynamicsPro'
  $tomcat_agent_home                    =  '/JavaAppServerAgent-Tomcat'
  $tomcat_group                         =  'appdynamics'
  $tomcat_user                          =  'appdynamics'
  $tomcat_app                           =  undef
  $tomcat_tier                          =  undef
  $tomcat_controller_host               =  undef
  $tomcat_controller_port               =  80
  $tomcat_controller_ssl_enabled        =  false
  $tomcat_enable_orchestration          =  false
  $tomcat_account_name                  =  undef
  $tomcat_account_access_key            =  undef
  $tomcat_force_agent_registration      =  false
  $tomcat_node_name                     =  undef
  $tomcat_agent_options                 =  undef
  $tomcat_application_home              =  undef

  $package_provider = $osfamily ?
  {
    'Debian'                            => 'apt',
  }

  $apache_init_script = $osfamily ?
  {
    'Debian'                            => 'apache',
  }
}