#
# Cookbook:: adaptec_storman
# Spec:: cmdline
#
# Copyright:: 2017, Justin Spies, All Rights Reserved.
require 'spec_helper'

describe 'adaptec_storman::cmdline' do
  platforms.each do |platform, details|
    versions = details['versions']
    versions.each do |version|
      cpus = details['cpus']
      cpus.each do |cpu|
        context "On #{platform} #{version} with a #{cpu} CPU" do
          let(:chef_run) do
            runner = ChefSpec::SoloRunner.new(platform: platform, version: version)
            runner.node.override['cpu']['0']['vendor_id'] = cpu
            runner.node.override['adaptec_storman']['card_type'] = 'chefspec'
            runner.node.override['adaptec_storman']['source_files'] = details['source_files']
            runner.converge(described_recipe)
          end

          source_prefix = case details['platform_family']
                          when 'debian'
                            'debian'
                          when 'rhel'
                            'redhat'
                          else
                            'other'
                          end

          source_suffix = case cpu
                          when 'GenuineIntel'
                            'x86_64'
                          else
                            'ppc64'
                          end

          source_key = "#{source_prefix}-#{source_suffix}"

          if details['source_files']['chefspec'].key?('cmdline') && details['source_files']['chefspec']['cmdline'].key?(source_key)
            it 'should download and unarchive the selected files when they are available' do
              expect(chef_run).to cherry_pick_ark('adaptec_storman')
            end

            source_file = details['source_files']['chefspec']['cmdline'][source_key]
            if source_file =~ /\.(deb|rpm)$/
              it 'should install the appropriate package when run on a supported system' do
                expect(chef_run).to install_package("/tmp/#{source_file}")
              end
            else
              it 'should output an error message when an installation package is NOT available' do
                expect(chef_run).to write_log('This platform does not provide a supported installation package for the command line utilities')
              end
            end
          else
            it "should output an error log message when the installation files are NOT available for #{source_key}" do
              expect(chef_run).to write_log("Installation file #{source_key} does not exist, the Adaptec Storage Manager will not be installed")
            end
          end
        end
      end
    end
  end
end
