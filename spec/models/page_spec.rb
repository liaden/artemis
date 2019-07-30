require 'rails_helper'

RSpec.describe Page, type: :model do
  let(:page)       { build(:page, *page_traits, page_attrs) }
  let(:page_attrs)  { {} }
  let(:page_traits) { [] }

  it { expect(page).to be_valid }

  context 'invalid when' do
    after { expect(page).to be_invalid }

    %i[publication_status tenant name content].each do |attr|
      it "missing a #{attr}" do
        page_attrs.merge!(attr => nil)
      end
    end

    %i[name content].each do |attr|
      it "#{attr} is blank" do
        page_attrs.merge!(attr => '')
      end
    end
  end

  describe '.owned_by' do
    subject { Page.owned_by(tenant) }
    let(:tenant) { create(:tenant) }

    context 'tenant has no pages' do
      it { is_expected.to be_empty }
    end

    context 'with a page' do
      let!(:page) { create(:page, tenant: tenant) }

      it { is_expected.to contain_exactly(page) }
      it { expect(Page.owned_by(tenant.id)).to contain_exactly(page) }
    end
  end

  describe 'papertrail versioning' do
    let(:page_attrs) { { name: 'version1 name', content: 'version1 content' } }

    describe 'Untouchable' do
      describe 'persisting new record makes one version' do
        let(:page_attrs) { attributes_for(:page) }

        it '.create!' do
          p = Page.create!(page_attrs)
          expect(p.versions.size).to eq 1
        end

        it '.create' do
          p = Page.create(page_attrs)
          expect(p.versions.size).to eq 1
        end

        it '#save!' do
          p = Page.new(page_attrs).tap(&:save!)
          expect(p.versions.size).to eq 1
        end

        it '#save' do
          p = Page.new(page_attrs).tap(&:save)
          expect(p.versions.size).to eq 1
        end
      end

      describe 'persisted record' do
        it 'updating associated creates additional version' do
          p = Page.create!(attributes_for(:page))
          p.content.update!(body: 'something newish')
          expect(p.reload.versions.size).to eq 2
        end

        it 'updating self and associated creates two additional versions' do
          p = Page.create!(attributes_for(:page))
          p.update!(page_attrs)
          expect(p.reload.versions.size).to eq 3
        end
      end
    end

    it 'reverts name change' do
      page.save!
      page.update!(name: 'new name')
      expect(page.reload.name).to eq('new name')
      page.revert!
      expect(page.reload.name).to eq 'version1 name'
    end

    it 'reverts content association' do
      page.save!
      page.update!(content: 'new content')
      expect(page.reload.content.to_s).to include('new content')
      page.revert_content!
      expect(page.reload.content.to_s).to include('version1 content')
    end
  end
end
