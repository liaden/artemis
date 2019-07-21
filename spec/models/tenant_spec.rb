require 'rails_helper'

RSpec.describe Tenant, type: :model do
  describe '#create!' do
    it { expect(create(:tenant)).to be_a(Tenant) }
  end

  describe 'tenant_id' do
    it { expect(:tenant).to_not respond_to(:id) }
    it { expect(Tenant.create!(name: 'x', tenant_id: 1234).tenant_id).to eq(1234) }
  end

  describe 'validations' do
    subject(:tenant) { Tenant.new(tenant_attrs) }
    let(:tenant_attrs) { attributes_for(:tenant) }

    it { is_expected.to be_valid }

    describe 'name' do
      context 'is nil' do
        before { tenant_attrs.merge!(name: nil) }

        it { is_expected.to_not be_valid }
      end
    end

    describe 'tenant_id' do
      context 'is nil' do
        before { tenant_attrs.merge!(tenant_id: nil) }

        it { is_expected.to_not be_valid }
      end

      context 'not unique' do
        let(:other_tenant) { create(:tenant) }

        before { tenant_attrs.merge!(tenant_id: other_tenant.tenant_id) }

        it { is_expected.to_not be_valid }
      end
    end
  end
end
