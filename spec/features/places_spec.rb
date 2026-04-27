require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [Place.new(name: "Oljenkorsi", id: 1)]
    )
    
    visit places_path
    fill_in("city", with: "kumpula")
    click_button("Search")

    expect(page).to have_content "Oljenkorsi"
  end

  it "if multiple are returned by the API, they are shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("helsinki").and_return(
      [Place.new(name: "Kallio Bar", id: 1), Place.new(name: "Bar Loose", id: 2), Place.new(name: "Siltanen", id: 3)]
    )

    visit places_path
    fill_in("city", with: "helsinki")
    click_button("Search")

    expect(page).to have_content "Kallio Bar"
    expect(page).to have_content "Bar Loose"
    expect(page).to have_content "Siltanen"
  end

  it "if none is returned by the API, error message is shown" do
    allow(BeermappingApi).to receive(:places_in).with("unknown").and_return(
      []
    )

    visit places_path
    fill_in("city", with: "unknown")
    click_button("Search")

    expect(page).to have_content "No locations in unknown"
  end
end
