require 'rails_helper'

RSpec.describe 'pages/index', type: :view do
  let(:page1) { create(:page, :draft) }
  let(:page2) { create(:page, :published) }

  before(:each) { assign(:pages, [page1, page2]) }

  it 'renders a list of pages' do
    render
    assert_select 'tbody>tr', count: 2
    assert_select 'tr>td>a',  text: page1.name,  count: 1
    assert_select 'tr>td>a',  text: page2.name,  count: 1
    assert_select 'tr>td',    text: 'draft',     count: 1
    assert_select 'tr>td',    text: 'published', count: 1
  end
end
