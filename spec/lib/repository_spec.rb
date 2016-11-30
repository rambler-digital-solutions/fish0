require 'spec_helper'

RSpec.describe Fish0::Repository do
  let(:repository) { Fish0::Repository.new('articles') }
  let(:scoped_repository) { Fish0::Repository.new('articles') }

  describe '#scope' do
    before do
      scoped_repository.scope :by_slug, -> (slug) { where(slug: slug) }
    end

    it 'has no scoped method :by_slug for new repository' do
      expect(repository).not_to respond_to(:by_slug)
    end

    it 'has scoped method :by_slug for scoped repository' do
      expect(scoped_repository).to respond_to(:by_slug)
    end

    it 'returns self and therefore supports chaining' do
      expect(scoped_repository.by_slug('news')).to be_an(Fish0::Repository)
    end
  end
end
