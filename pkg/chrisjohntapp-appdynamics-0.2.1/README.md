# puppet-appdynamics

## Overview

Module to manage AppDynamics agents from locally-built .deb packages

## Module Description

This module installs and configures AppDynamics agents and allows their management
(running / stopped) from hiera. Currently only Ubuntu 14.04 is tested, though other
version will probably work as well, and possibly Debian too.

It provides many parameters as the design goal is to provide users with a high
level of configurability via hiera.

The module uses the concept of an 'agent_type'.  This does not refer to the
AppDynamics agent type, but a higher-level object which may or may not map
directly to an AppDynamics agent type.  For example the 'db' agent_type maps
directly to the AppDynamics database agent, but the 'jboss' and 'tomcat'
agent_types both utilise the AppDynamics Java appserver agent.

### Beginning with AppDynamics

This module requires the AppDynamics agents to be packaged into .deb packages,
available in an enabled repository. Packages must obey the naming convention
appdynamics-${package_type}-agent.deb.  Package types are 'db', 'java', 'machine',
and 'php'.

The packages should contain only what is bundled by AppDynamics, installed to
whichever directory you set "${agent_base}/${agent_home}" to. Additional files
such as init scripts are handled by this module.

The module assumes that the node will have a top-scope array set ($agent_types)
which defines zero or more agent_types.  Currently supported options are 'db',
'jboss', 'machine', 'php', 'tomcat'.  More options will likely be added in
future.  This array could be set in hiera or in an ENC.

aco-tomcat and puppetlabs-apache are listed as dependencies, but these are only
required if a tomcat or php agent, respectively, is required, and even then any
other module providing suitable services (ie. 'tomcat6', 'tomcat7', and 'httpd')
will suffice.

### Usage

Make the following class declaration to install agent(s) using default settings,
and leaving then disabled (not running):

```puppet
class { 'appdynamics::agent': }
```

To enable (set running) a tomcat 7 agent:

```puppet
  class { 'appdynamics::agent':
    tomcat_agent_enable => true,
    tomcat_version      => 7,
  }
```

To specify the install/runtime directories for the db agent:
```puppet
  class { 'appdynamics::agent':
    db_agent_base => '/usr/local/',
    db_agent_home => 'appd_dbagent',
  }
```

To specify controller settings for a machine agent:
```puppet
  class { 'appdynamics::agent':
    machine_app                => 'Web',
    machine_tier               => 'Frontend',
    machine_controller_host    => 'ad.controller.example.com',
    machine_controller_port    => 8080,
    machine_account_name       => 'abc',
    machine_account_access_key => 'abc123abc123',
  }
```

All configurables are visible in params.pp and should be self-explanatory, so
will not be repeated here.

### Supported Operating Systems

Currently this module only supports Ubuntu 14.04 but will likely work on other
Ubuntu versions and possibly Debian too.

### Limitations

This module is very young and in active development.  PHP agent functionality is
currently least tested.

If using tomcat, this module only supports one tomcat instance.  This is
unlikely to be changed.

TODO: Requires better tests. Currently only basic smoke tests are included.

TODO: enable installation of specific package versions. Just one
parameter is used to specify package version for all packages, so this is not
currently possible.

TODO: Currently only supports tomcat versions 6 and 7. Version must be specified.
