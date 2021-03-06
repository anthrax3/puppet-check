require_relative '../spec_helper'
require_relative '../../lib/puppet-check/puppet_parser'

describe PuppetParser do
  before(:each) do
    PuppetCheck.settings[:error_files] = []
    PuppetCheck.settings[:warning_files] = []
    PuppetCheck.settings[:clean_files] = []
  end

  context '.manifest' do
    it 'puts a bad syntax Puppet manifest in the error files array' do
      PuppetParser.manifest([fixtures_dir + 'manifests/syntax.pp'], false, false, [])
      # Puppet 5.0-5.2 cannot do multiple errors per line
      if Puppet::PUPPETVERSION.to_f >= 5.0 && Puppet::PUPPETVERSION.to_f < 5.3
        expect(PuppetCheck.settings[:error_files][0]).to match(%r{^#{fixtures_dir}manifests/syntax.pp:\nThis Variable has no effect})
      # puppet < 5 or >= 5.3 can do multiple errors per line
      else
        expect(PuppetCheck.settings[:error_files][0]).to match(%r{^#{fixtures_dir}manifests/syntax.pp:\nThis Variable has no effect.*\nIllegal variable name})
      end
      expect(PuppetCheck.settings[:warning_files]).to eql([])
      expect(PuppetCheck.settings[:clean_files]).to eql([])
    end
    it 'puts a bad parser and lint style Puppet manifest in the warning files array' do
      PuppetParser.manifest([fixtures_dir + 'manifests/style_parser.pp'], false, true, [])
      expect(PuppetCheck.settings[:error_files]).to eql([])
      expect(PuppetCheck.settings[:warning_files][0]).to match(%r{^#{fixtures_dir}manifests/style_parser.pp:\nUnrecognized escape sequence.*\nUnrecognized escape sequence.*\n.*double quoted string containing})
      expect(PuppetCheck.settings[:clean_files]).to eql([])
    end
    it 'puts a bad lint style Puppet manifest in the warning files array' do
      PuppetParser.manifest([fixtures_dir + 'manifests/style_lint.pp'], false, true, [])
      expect(PuppetCheck.settings[:error_files]).to eql([])
      expect(PuppetCheck.settings[:warning_files][0]).to match(%r{^#{fixtures_dir}manifests/style_lint.pp:\n.*double quoted string containing.*\n.*indentation of})
      expect(PuppetCheck.settings[:clean_files]).to eql([])
    end
    it 'puts a bad style Puppet manifest in the clean files array when puppetlint_args ignores its warnings' do
      PuppetParser.manifest([fixtures_dir + 'manifests/style_lint.pp'], false, true, ['--no-double_quoted_strings-check', '--no-arrow_alignment-check'])
      expect(PuppetCheck.settings[:error_files]).to eql([])
      expect(PuppetCheck.settings[:warning_files]).to eql([])
      expect(PuppetCheck.settings[:clean_files]).to eql(["#{fixtures_dir}manifests/style_lint.pp"])
    end
    it 'puts a good Puppet manifest in the clean files array' do
      PuppetParser.manifest([fixtures_dir + 'manifests/good.pp'], false, true, [])
      expect(PuppetCheck.settings[:error_files]).to eql([])
      expect(PuppetCheck.settings[:warning_files]).to eql([])
      expect(PuppetCheck.settings[:clean_files]).to eql(["#{fixtures_dir}manifests/good.pp"])
    end
    it 'throws a well specified error for an invalid PuppetLint argument' do
      expect { PuppetParser.manifest([fixtures_dir + 'manifests/style_lint.pp'], false, true, ['--non-existent', '--does-not-exist']) }.to raise_error(RuntimeError, 'puppet-lint: invalid option supplied among --non-existent --does-not-exist')
    end
  end

  context '.template' do
    it 'puts a bad syntax Puppet template in the error files array' do
      PuppetParser.template([fixtures_dir + 'templates/syntax.epp'])
      expect(PuppetCheck.settings[:error_files][0]).to match(%r{^#{fixtures_dir}templates/syntax.epp:\nThis Name has no effect})
      expect(PuppetCheck.settings[:warning_files]).to eql([])
      expect(PuppetCheck.settings[:clean_files]).to eql([])
    end
    it 'puts a good Puppet template in the clean files array' do
      PuppetParser.template([fixtures_dir + 'templates/good.epp'])
      expect(PuppetCheck.settings[:error_files]).to eql([])
      expect(PuppetCheck.settings[:warning_files]).to eql([])
      expect(PuppetCheck.settings[:clean_files]).to eql(["#{fixtures_dir}templates/good.epp"])
    end
  end
end
