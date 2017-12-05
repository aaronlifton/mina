require 'spec_helper'

describe Mina::Helpers::Format do
  class DummyFormatHelper
    include Mina::DSL
    include Mina::Helpers::Format
  end

  let(:helper) { DummyFormatHelper.new }

  describe '#echo_cmd' do
    context 'when not verbose' do
      it 'reuturns unedited code' do
        expect(helper.echo_cmd('ls -al')).to eq('ls -al')
      end
    end

    context 'when verbose' do
      before { Mina::Configuration.instance.set(:verbose, true) }
      after { Mina::Configuration.instance.remove(:verbose) }

      it 'modifies code' do
        expect(helper.echo_cmd('ls -al')).to eq("echo \\$\\ ls\\ -al &&\nls -al")
      end

      it 'does not modify code if ignore_verbose is true' do
        expect(helper.echo_cmd('ls -al', ignore_verbose: true)).to eq('ls -al')
      end
    end
  end

  describe '#indent' do
    it 'indents code' do
      expect(helper.indent(4, 'ls -al')).to eq('    ls -al')
    end
  end

  describe '#unindent' do
    it 'unindents code' do
      expect(helper.unindent('    ls -al')).to eq('ls -al')
    end
  end

  describe '#format_code' do
    it 'formats commands ending in &' do
      expect(helper.format_code("echo '' &")).to eq("(echo '' &)")
    end
  end
end
