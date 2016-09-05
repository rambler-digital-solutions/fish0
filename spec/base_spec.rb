require 'spec_helper'

RSpec.describe 'Fish0::Base' do
  let!(:headline) { FFaker::Lorem.sentence }
  let!(:article) { create(:article, headline: headline) }
  let!(:other_article) { create(:article) }

  describe '.find_one' do
    subject { Article.find_one(query) }

    context 'when article with such headline exists in the database' do
      let(:query) { { headline: headline } }
      it { is_expected.to eq(article) }
    end

    context 'when there is no such article in database' do
      let(:query) { { headline: 'кирриллица' } }
      it { is_expected.to be_nil }
    end
  end

  describe '.find_one!' do
    subject { Article.find_one!(query) }

    context 'when article with such headline exists in the database' do
      let(:query) { { headline: headline } }
      it { is_expected.to eq(article) }
    end

    context 'when there is no such article in database' do
      let(:query) { { headline: 'кирриллица' } }
      it 'raises exception' do
        expect { subject }.to raise_error(Fish0::RecordNotFound)
      end
    end
  end
end
