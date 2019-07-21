require 'rails_helper'

RSpec.describe PublicationStatus, type: :model do
  let(:publication_status) { create(:publication_status) }

  describe 'validations' do
    it { expect(publication_status).to be_valid }

    context 'name must be unique' do
      before { publication_status }

      it { expect(build(:publication_status, name: publication_status.name)).to be_invalid }
    end

    context 'name must not be blank' do
      it { expect(build(:publication_status, name: '')).to be_invalid }
      it { expect(build(:publication_status, name: nil)).to be_invalid }
    end
  end
end
