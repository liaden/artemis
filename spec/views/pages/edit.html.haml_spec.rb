require 'rails_helper'

RSpec.describe 'pages/edit', type: :view do
  before(:each) { @page = assign(:page, create(:page)) }

  it 'renders the edit page form' do
    render

    assert_select 'form[action=?][method=?]', page_path(@page), 'post' do
      assert_select 'input[name=?]', 'page[publication_status]'
      assert_select 'input[name=?]', 'page[name]'
      assert_select 'input[name=?]', 'page[content]'
    end
  end
end
