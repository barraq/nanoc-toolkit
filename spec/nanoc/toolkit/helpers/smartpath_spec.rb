require 'spec_helper'

describe Nanoc::Toolkit::Helpers::SmartPath, helper: true do
  before do
    ctx.create_item('blah', { id: '123e4567-e89b-12d3-a456-426655440000' }, '/pages/some-page.md')
    ctx.create_item('blah blah', {}, '/pages/some-other-page.md')
    ctx.create_item('i am bob', { id: '223e4567-e89b-12d3-a456-426655440000' }, '/authors/some-author.md')
  end

  describe '#uuid?' do
    it 'matches valid uuid' do
      expect(helper.uuid?('123e4567-e89b-12d3-a456-426655440000')).to be true
    end

    it 'does not match invalid uuid' do
      expect(helper.uuid?('123e4567-z89b-12d3-a456-426655440000')).to be false
    end
  end

  describe '#item_from' do
    subject { helper.item_from(arg) }

    context 'with uuid' do
      context 'with matching item' do
        let(:arg) { '123e4567-e89b-12d3-a456-426655440000' }
        it { is_expected.to satisfy { |i| i[:id] == '123e4567-e89b-12d3-a456-426655440000' } }
      end

      context 'with no matching item' do
        let(:arg) { '023e4567-e89b-12d3-a456-426655440000' }
        it { expect { subject }.to raise_error RuntimeError }
      end
    end

    context 'with absolute filename' do
      context 'with matching item' do
        let(:arg) { '/pages/some-page.md' }
        it { is_expected.to satisfy { |i| i[:id] == '123e4567-e89b-12d3-a456-426655440000' } }
      end

      context 'with no matching item' do
        let(:arg) { '/pages/some-unknown-page.md' }
        it { expect { subject }.to raise_error RuntimeError }
      end
    end

    context 'with volume filename' do
      before do
        ctx.config[:mount] = {
          volumes: {
            pages: 'pages'
          }
        }
      end

      context 'with existing volume' do
        let(:arg) { 'pages/some-page.md' }
        it { is_expected.to satisfy { |i| i[:id] == '123e4567-e89b-12d3-a456-426655440000' } }
      end

      context 'with unknown volume' do
        let(:arg) { 'authors/some-author.md' }
        it { expect { subject }.to raise_error RuntimeError }
      end
    end
  end
end
