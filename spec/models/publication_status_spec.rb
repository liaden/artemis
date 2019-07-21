require 'rails_helper'

RSpec.describe PublicationStatus, type: :model do
  let(:publication_status) { create(:publication_status) }

  describe 'validations' do
    %i[draft published withdrawn].each do |status|
      it { expect { PublicationStatus.create!(name: status) }.to_not raise_error }
    end

    context 'name must be unique' do
      before { create(:publication_status) }

      it { expect(build(:publication_status)).to be_invalid }
    end

    context 'name must not be blank' do
      it { expect(build(:publication_status, name: '')).to be_invalid }
      it { expect(build(:publication_status, name: nil)).to be_invalid }
    end
  end
end
