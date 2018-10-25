require 'spec_helper'

describe 'yum_cron' do
  on_supported_os.each do |os, _facts|
    context "on #{os}" do
      let(:facts) do
        f.merge(super())
      end

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_class('yum_cron::install').that_comes_before('Class[yum_cron::config]') }
      it { is_expected.to contain_class('yum_cron::config').that_comes_before('Class[yum_cron::service]') }
      it { is_expected.to contain_class('yum_cron::service') }
    end
  end
end
