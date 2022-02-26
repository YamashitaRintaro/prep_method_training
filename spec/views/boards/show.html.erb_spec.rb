require 'rails_helper'

RSpec.describe "boards/show", type: :view do
  before(:each) do
    @board = assign(:board, Board.create!(
      title: "Title",
      text: "Text"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Text/)
  end
end
