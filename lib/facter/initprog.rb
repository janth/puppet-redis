# vim:expandtab,sw=2

# check syntax:
# /opt/puppetlabs/puppet/bin/ruby -c lib/facter/initprog.rb

require 'facter'

Facter.add(:initsystem) do
  #confine = :osfamily => :windows
  confine kernel: %w[Linux]
  
  # Do not assume anything based on ::operatingsystemmajrelease
  # as for instance https://github.com/hfm/puppet-initsystem/blob/master/lib/facter/initsystem.rb does...
  # but rather check the name of the executable for pid 1
  setcode do
    begin
      f = nil
      f = File.readlink("/proc/1/exe")
      f = File.basename(f)
      f
    rescue
      nil
    end
  end
end

Facter.add(:initdaemon) do
  setcode do
    Facter.value(:initsystem)
  end
end
