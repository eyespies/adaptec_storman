# This needs to be kept in sync with .kitchen.yml attributes list.
control 'adaptec_storman' do
  impact 1.0
  title 'Verifies that the Adaptec Storage manager utilities are installed and working properly'
  desc 'Provides controls to ensure that the NFS server is running and properly limiting access to the system resources'

  describe port(2049) do
    its(:protocols) { should include('tcp') }
    its(:addresses) { should include('0.0.0.0') }
  end

  # This changes from RHEL 6
  if os[:release] =~ /^6/
    service_name = 'nfs'

    # This only exists for EL6 platforms
    describe service(service_name).runlevels do
      its('keys') { should include(3) }
    end

  elsif os[:release] =~ /^7/
    service_name = 'nfs-server'
  end

  describe service(service_name) do
    it { should be_enabled }
    it { should be_running }
  end

  describe processes('\[nfsd\]') do
    # Not using state matching because it is tempramental. It switches between 'S' and 'Ss' and 'S<s' and others.
    its('entries.length') { should > 4 }
  end

  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html
  exports.each do |_exp_key, exp_val|
    match_to = Regexp.new("#{exp_val[:source_path]}.*#{exp_val[:network]}", Regexp::MULTILINE | Regexp::EXTENDED)
    describe command('exportfs') do
      # This needs to match what is set
      its(:stdout) { should match match_to }
    end
  end
end
