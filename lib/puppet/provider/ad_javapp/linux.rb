Puppet::Type.type(:ad_javapp).provide(:linux) do

  desc "Creates a copy of the installed java application agent
    alongside it, based on an agent installed from a package.
    Also removes the copy when requried."

  has_feature :clone :delete

  commands :cpr => "/usr/bin/cp -r"
  commands :rmr => "/usr/bin/rm -rf"

  confine :kernel => :Linux
  default_for :kernel => :Linux

  def create
    :cpr resource[:agent_source_dir] resource[:agent_target_dir]
  end

  def destroy
    :rmr resource[:agent_target_dir]
  end

  def exists?
    # Check if target dir exists.
  end

  def group
    # Return group owner of target directory.
  end

  def group=(value)
    # Chown -R :group target directory.
  end

  def owner
    # Return owner of target directory.
  end

  def owner=(value)
    # Chown -R owner: of target directory
  end

  def mode
    # Return current mode of target directory.
  end

  def mode=(value)
    # Chmod -R target directory.
  end

end
