require 'rails_helper'

RSpec.describe "boards/new", type: :view do
  before(:each) do
    assign(:board, Board.new(
      title: "MyString",
      text: "MyString"
    ))
  end

  it "renders new board form" do
    render

    assert_select "form[action=?][method=?]", boards_path, "post" do

      assert_select "input[name=?]", "board[title]"

      assert_select "input[name=?]", "board[text]"
    end
  end
end
