require 'rails_helper'

RSpec.describe Api::ApplicationController, type: :controller do
  describe 'is base API controller' do
    Api.constants.grep(/Controller$/).each do |api_controller|
      it { expect(api_controller).is_a?(Api::ApplicationController) }
    end
  end
end
