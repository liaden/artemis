require 'rails_helper'

RSpec.describe 'Pages', type: :request do
  let(:tenant)  { create(:tenant) }
  let(:headers) { auth_header }
  let(:params)  { {} }

  let(:page) { create(:page, tenant: tenant) }

  describe 'GET /pages' do
    let(:visit_page) { get pages_path, params: {}, headers: headers }

    before do
      page
      visit_page
    end

    context 'without any pages' do
      let(:page) { nil }

      it { expect(response).to have_http_status(200) }
      it { expect(response.body).to include(new_page_path) }
    end

    context 'with other tenants pages' do
      let!(:other_tenants_page) { create(:page, :with_tenant) }

      it { expect(response).to_not include(other_tenants_page.name) }
    end

    context 'with a page' do
      it { expect(response).to have_http_status(200) }
      it { expect(response.body).to include(page.name) }
    end
  end

  describe 'GET /pages/new' do
    let(:visit_page) { get new_page_path, params: {}, headers: headers }

    before { visit_page }

    it { expect(response).to have_http_status(200) }
  end

  describe 'POST /pages' do
    let(:visit_page) { post pages_path, params: { page: params }, headers: headers }

    let(:params) { attributes_for(:page, tenant: nil, publication_status: nil) }

    it { expect { visit_page }.to change { Page.count }.by(1) }

    context 'invalid params' do
      before { params.merge!(name: '') }

      it { expect { visit_page }.to_not change { Page.count } }
    end

    context do
      before { visit_page }

      it { expect(response).to have_http_status(302) }
      it { expect(page.tenant).to eq tenant }
    end
  end

  describe 'GET /pages/:id' do
    let(:visit_page) { get page_path(page), params: {}, headers: headers }

    before { visit_page }

    it { expect(response).to have_http_status(200) }

    context "another tenant's page" do
      let!(:page) { create(:page, :with_tenant) }

      it { expect(response).to have_http_status(401) }
    end
  end

  describe 'PUT /pages/:id' do
    let(:visit_page) { put page_path(page), params: params, headers: headers }
    let(:params) do
      { page: { name: "new #{page.name}" } }
    end

    before { visit_page }

    context "another tenant's page" do
      let!(:page) { create(:page, :with_tenant) }

      it { expect(response).to have_http_status(401) }
      it { expect(page).to eq page.reload }
    end
  end

  describe 'DELETE /pages:id' do
    let(:visit_page) { delete page_path(page), params: {}, headers: headers }

    before { visit_page }

    it { expect(response).to have_http_status(302) }
    it { expect { page.reload }.to raise_error(ActiveRecord::RecordNotFound) }

    context "another tenant's page" do
      let!(:page) { create(:page, :with_tenant) }

      it { expect(response).to have_http_status(401) }
      it { expect { page.reload } .to_not raise_error(ActiveRecord::RecordNotFound) }
    end
  end
end
