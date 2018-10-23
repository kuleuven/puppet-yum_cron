# To check the correct dependancies are set up for NTP.

require 'spec_helper'
describe 'yum_cron' do
  let(:facts) { { is_virtual: false } }
  let :pre_condition do
    'file { "foo.rb":
      ensure => present,
      path => "/etc/tmp",
      notify => Service["yum_cron"] }'
  end

  on_supported_os.reject { |_, f| f[:os]['family'] == 'Solaris' }.each do |os, f|
    context "on #{os}" do
      let(:facts) do
        f.merge(super())
      end

      it { is_expected.to compile.with_all_deps }
      describe 'Testing the dependancies between the classes' do
        it { is_expected.to contain_class('yum_cron::install') }
        it { is_expected.to contain_class('yum_cron::config') }
        it { is_expected.to contain_class('yum_cron::service') }
        it { is_expected.to contain_class('yum_cron::install').that_comes_before('Class[yum_cron::config]') }
        it { is_expected.to contain_class('yum_cron::service').that_subscribes_to('Class[yum_cron::config]') }
        it { is_expected.to contain_file('foo.rb').that_notifies('Service[yum_cron]') }
      end
    end
  end
end
