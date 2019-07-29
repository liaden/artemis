require 'rails_helper'

RSpec.describe Page, type: :model do
  let(:page)        { build(:page, *page_traits, page_attrs) }
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
end
