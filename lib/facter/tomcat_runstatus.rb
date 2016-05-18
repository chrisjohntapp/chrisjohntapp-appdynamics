Facter.add(:tomcat_runstatus) do
  has_weight 100
  setcode do
    if File.exist? '/var/run/tomcat6.pid'
      'running'
    else
      'stopped'
    end
  end
end

Facter.add(:tomcat_runstatus) do
  has_weight 99
  setcode do
    if File.exist? '/var/run/tomcat7.pid'
      'running'
    else
      'stopped'
    end
  end
end

Facter.add(:tomcat_runstatus) do
  has_weight 80
#  confine :profiles == 'tomcat'
  setcode do
    if Facter::Core::Execution.execute("/usr/bin/find /etc/init.d/ -type f -name tomcat* -exec {} status \; | /bin/grep -q 'is running'")
      'running'
    else
      'stopped'
    end
  end
end
