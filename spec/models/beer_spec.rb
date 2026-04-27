require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "has the name, style and brewery set correctly" do
    brewery = Brewery.create name: "test_brewery", year: 2000
    style = Style.create name: "test_style"
    beer = Beer.create name: "test_beer", style: style, brewery: brewery

    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  it "is not saved without a name" do
    brewery = Brewery.create name: "test_brewery", year: 2000
    style = Style.create name: "test_style"
    beer = Beer.create style: style, brewery: brewery

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not saved without a style" do
    beer = Beer.create name: "test_beer"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end  
end
