require 'spec_helper'

describe Nanoc::Toolkit::Helpers::Utils, helper: true do
  describe '#split_ext' do
    subject { helper.split_ext(extension, default: default) }

    let(:default) { nil }

    context 'with double extension html.md' do
      let(:extension) { 'html.md' }
      it { is_expected.to eq %w(html md) }
    end

    context 'with single extension .md' do
      let(:extension) { 'md' }
      it { is_expected.to eq [nil, 'md'] }
    end

    context 'with single extension .md and default: html' do
      let(:extension) { 'md' }
      let(:default) { 'html' }
      it { is_expected.to eq %w(html md) }
    end
  end
end
