require 'etc'
require 'fileutils'

Puppet::Type.type(:ad_javapp).provide(:linux) do
  desc "Creates a copy of the installed java application agent
    alongside it, based on an agent installed from a package.
    Also removes the copy when requried."

  has_feature :clone :delete
  confine :kernel => :Linux
  default_for :kernel => :Linux

  def create
    FileUtils.mkdir(resource[:agent_target_dir])
    FileUtils.cp_r("#{resource[:agent_source_dir]}/.", resource[:agent_target_dir])
  end
  def destroy
    FileUtils.rm_r(resource[:agent_target_dir])
  end
  def exists?
    File.directory?(resource[:agent_target_dir])
  end

  def group
    gid = File.stat(resource[:agent_target_dir]).gid
    Etc.getgrgid(gid).name
  end
  def group=(value)
    FileUtils.chown_R(nil, value, resource[:agent_target_dir])
  end

  def owner
    uid = File.stat(resource[:agent_target_dir]).uid
    Etc.getpwuid(resource[uid]).name
  end
  def owner=(value)
    FileUtils.chown_R(value, nil, resource[:agent_target_dir])
  end

  def mode
    stat = File.stat(resource[:agent_target_dir])
    stat.mode.to_s(8)[2..5]
  end
  def mode=(value)
    FileUtils.chmod_R(value.to_i, resource[:agent_target_dir])
  end
end
