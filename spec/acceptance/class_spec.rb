require 'spec_helper_acceptance'

describe 'yum_cron class:', unless: UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  context 'with yum_cron' do
    let(:pp) { "class { 'yum_cron': }" }

    it 'runs successfully - not_to match' do
      apply_manifest(pp, catch_failures: true) do |r|
        expect(r.stderr).not_to match(%r{error}i)
      end
    end

    it 'runs successfully - not_to eq' do
      apply_manifest(pp, catch_failures: true) do |r|
        expect(r.stderr).not_to eq(%r{error}i)
      end
    end

    it 'runs successfully - to be_zero' do
      apply_manifest(pp, catch_failures: true) do |r|
        expect(r.exit_code).to be_zero
      end
    end
  end

  context 'when service_ensure => stopped:' do
    let(:pp) { "class { 'yum_cron': service_ensure => stopped }" }

    it 'runs successfully - not_to match' do
      apply_manifest(pp, catch_failures: true) do |r|
        expect(r.stderr).not_to match(%r{error}i)
      end
    end
  end

  context 'when service_ensure => running:' do
    it 'runs successfully - not_to match' do
      pp = "class { 'yum_cron': service_ensure => running }"

      apply_manifest(pp, catch_failures: true) do |r|
        expect(r.stderr).not_to match(%r{error}i)
      end
    end
  end
end
