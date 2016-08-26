require 'spec_helper'

RSpec.describe 'Fish0::Base' do
  let(:dummy) { create(:article) }
  let(:yolo) { create(:article) }

  describe '.find_one' do
    subject { Article.find_one(query) }

    context 'search is successful' do
      let(:query) { { headline: dummy.headline } }
      it { is_expected.to eq(dummy) }
    end

    context 'nothing is found' do
      let(:query) { { headline: 'кирриллица' } }
      it { is_expected.to be_nil }
    end
  end

  describe '.find_one!' do
    subject { Article.find_one!(query) }

    context 'search is successful' do
      let(:query) { { headline: dummy.headline } }
      it { is_expected.to eq(dummy) }
    end

    context 'nothing is found' do
      let(:query) { { headline: 'кирриллица' } }
      it 'raises exception' do
        expect { subject }.to raise_error(Fish0::RecordNotFound)
      end
    end
  end
end
