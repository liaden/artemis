require 'rails_helper'

RSpec.describe 'pages/show', type: :view do
  let(:page) { create(:page) }
  before(:each) { @page = assign(:page, page) }

  it 'renders attributes' do
    render

    expect(rendered).to match(/#{page.content}/)
    expect(rendered).to match(/#{page.name}/)
    expect(rendered).to match(/#{page.publication_status.name}/)
  end
end
