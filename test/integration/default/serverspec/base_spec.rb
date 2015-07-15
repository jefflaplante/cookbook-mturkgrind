require 'spec_helper'

describe 'mturkgrind' do
  context '::default >' do
    app_user = $node['mtg']['app_user']

    describe package('git') do
      it { should be_installed }
    end

    describe package('ntp') do
      it { should be_installed }
    end

    describe package('logrotate') do
      it { should be_installed }
    end

    describe package('postfix') do
      it { should be_installed }
    end

    describe package('chef') do
      it { should be_installed }
    end

    describe process('chef-client') do
      it { should be_running }
    end

    describe package('htop') do
      it { should be_installed }
    end

    describe package('vim') do
      it { should be_installed }
    end

    describe package('curl') do
      it { should be_installed }
    end
  end
end

