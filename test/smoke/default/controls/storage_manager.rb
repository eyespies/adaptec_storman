# This needs to be kept in sync with .kitchen.yml attributes list.
control 'adaptec_storman' do
  impact 1.0
  title 'Verifies that the Adaptec Storage manager utilities are installed and working properly'
  desc 'Provides controls to ensure that the Storage Manager service is running and accessible'

  describe port(1311) do
    its(:protocols) { should include('tcp') }
    its(:addresses) { should include('0.0.0.0') }
  end
end
