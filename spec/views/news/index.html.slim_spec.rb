require 'rails_helper'

RSpec.describe "news/index", type: :view do
  before(:each) do
    assign(:news, [
      News.create!(
        title: "Title",
        content: "MyText",
        index: "Index",
        show: "Show"
      ),
      News.create!(
        title: "Title",
        content: "MyText",
        index: "Index",
        show: "Show"
      )
    ])
  end

  it "renders a list of news" do
    render
    assert_select "tr>td", text: "Title".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
    assert_select "tr>td", text: "Index".to_s, count: 2
    assert_select "tr>td", text: "Show".to_s, count: 2
  end
end
