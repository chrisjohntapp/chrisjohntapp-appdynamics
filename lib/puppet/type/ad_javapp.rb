Puppet::Type.newtype(:ad_javapp) do

  @doc = %q{Creates an agent for a specific java application
    server, based on the generic installed java agent.
  }

  feature :clone, "The provider can create all required
    directories, files etc. for the new java application agent
    from the basic installed java agent package."

  feature :delete, "The provider can delete all directories,
    files etc. from the managed clone."

  ensurable

  newproperty(:group) do
    desc "Group owner of the clone."
    validate do |value|
      unless value =~ /^\w+/
        raise ArgumentError, "%s is not a valid group name" % value
      end
    end
  end

  newproperty(:owner) do
    desc "User owner of the clone."
    validate do |value|
      unless value =~ /^\w+/
        raise ArgumentError, "%s is not a valid user name" % value
      end
    end
  end

  newproperty(:mode) do
    desc "Mode for the cloned directory tree."
    # Check it's an int.
    defaultto "0755"
  end

  newparam(:name) do
    desc "The name of the application."
    newvalues(:tomcat :jboss)
  end

  newparam(:agent_source_dir) do
    desc "Directory location of the installed java agent."
  end

  newparam(:agent_target_dir) do
    desc "Directory location of the clone."
  end

end
