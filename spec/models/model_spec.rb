require 'spec_helper'

RSpec.describe 'Fish0 Models' do
  it 'has default primary key' do
    expect(Article.primary_key).to eq(:slug)
  end

  it 'can override primary key' do
    expect(ArticleId.primary_key).to eq(:id)
  end

  it 'has cache key'
end
