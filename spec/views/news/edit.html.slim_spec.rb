require 'rails_helper'

RSpec.describe "news/edit", type: :view do
  before(:each) do
    @news = assign(:news, News.create!(
      title: "MyString",
      content: "MyText",
      index: "MyString",
      show: "MyString"
    ))
  end

  it "renders the edit news form" do
    render

    assert_select "form[action=?][method=?]", news_path(@news), "post" do

      assert_select "input[name=?]", "news[title]"

      assert_select "textarea[name=?]", "news[content]"

      assert_select "input[name=?]", "news[index]"

      assert_select "input[name=?]", "news[show]"
    end
  end
end
