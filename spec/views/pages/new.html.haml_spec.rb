require 'rails_helper'

RSpec.describe 'pages/new', type: :view do
  let(:page) { build(:page, :draft) }

  before { assign(:page, page) }

  it 'renders new page form' do
    render

    assert_select 'form[action=?][method=?]', pages_path, 'post' do
      assert_select 'input[name=?]', 'page[name]'
      assert_select 'input[name=?]', 'page[content]'
    end

    expect(rendered).to_not include('draft')
  end

  context 'with errors' do
    let(:page) { build(:page, :draft, content: nil, name: nil) }

    it 'shows errors' do
      render

      assert_select 'div#error_explanation>ul>li', count: 2
    end
  end
end
