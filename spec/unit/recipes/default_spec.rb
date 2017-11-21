#
# Cookbook:: adaptec_storman
# Spec:: default
#
# Copyright:: 2017, Justin Spies, All Rights Reserved.
require 'spec_helper'

describe 'adaptec_storman::default' do
  let(:recipes) do
    %w[adaptec_storman::manager adaptec_storman::cmdline]
  end

  platforms.each do |platform, details|
    versions = details['versions']
    versions.each do |version|
      context "On #{platform} #{version}" do
        before do
          recipes.each do |recipe|
            allow_any_instance_of(Chef::Recipe).to receive(:include_recipe).with(recipe)
          end
        end

        let(:chef_run) do
          runner = ChefSpec::SoloRunner.new(platform: platform, version: version)
          runner.node.override['environment'] = 'dev'
          runner.converge(described_recipe)
        end
        it 'should require the other recipes' do
          recipes.each do |recipe|
            expect_any_instance_of(Chef::Recipe).to receive(:include_recipe).with(recipe)
          end
          chef_run
        end
      end
    end
  end
end
