require 'rails_helper'

RSpec.describe Api::TenantsController, type: :controller do
  let(:tenant) { create(:tenant) }
  let(:tenant_id) { tenant.tenant_id }

  describe '#index' do
    subject(:get_index) { get(:index) }

    it { is_expected.to have_http_status(:ok) }
    it { expect { get_index }.to_not(change { Tenant.count }) }

    context 'with a tenant' do
      before { tenant }

      it { is_expected.to have_http_status(:ok) }
      it { expect { get_index }.to_not(change { Tenant.count }) }
      it { expect { get_index }.to_not(change { tenant.reload }) }
    end
  end

  describe '#create' do
    subject(:create_tenant) { post(:create, params: { tenant: tenant_attrs }); response }
    let(:tenant_attrs) { attributes_for(:tenant) }

    it { is_expected.to have_http_status(:created) }
    it { expect { create_tenant }.to change { Tenant.count }.by(1) }
  end

  describe '#show' do
    subject(:show_tenant) { get(:show, params: { tenant_id: tenant_id }); response }

    context 'with a tenant' do
      before { tenant }

      it { is_expected.to have_http_status(:ok) }
      it { expect { show_tenant }.to_not(change { Tenant.count }) }
      it { expect { show_tenant }.to_not(change { tenant.reload }) }
      describe 'json' do
        subject(:json_data) { JSON.parse(show_tenant.body)['data'] }

        it { is_expected.to include('attributes' => include('tenant_id' => tenant.tenant_id)) }
        it { is_expected.to include('attributes' => include('name' => tenant.name)) }
      end
    end
  end

  describe '#update' do
    before { tenant }

    subject(:update_tenant) { put(:update, params: { tenant_id: tenant.tenant_id, tenant: { name: 'updated-name' } }); response }

    it 'updates name' do
      update_tenant

      expect(tenant.reload.name).to eq('updated-name')
    end

    it { expect { update_tenant }.to_not(change { Tenant.count }) }
    it { is_expected.to have_http_status(:ok) }
  end

  describe '#destroy' do
    before { tenant }

    subject(:delete_tenant) { delete(:destroy, params: { tenant_id: tenant_id }); response }

    it { expect { delete_tenant }.to change { Tenant.count }.by(-1) }
    it { is_expected.to have_http_status(:ok) }
  end
end
