require 'rails_helper'

RSpec.describe "boards/index", type: :view do
  before(:each) do
    assign(:boards, [
      Board.create!(
        title: "Title",
        text: "Text"
      ),
      Board.create!(
        title: "Title",
        text: "Text"
      )
    ])
  end

  it "renders a list of boards" do
    render
    assert_select "tr>td", text: "Title".to_s, count: 2
    assert_select "tr>td", text: "Text".to_s, count: 2
  end
end
