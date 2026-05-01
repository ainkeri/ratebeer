require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) {FactoryBot.create :brewery, name: "Koff"}
  let!(:beer1) {FactoryBot.create :beer, name: "iso 3", brewery: brewery}
  let!(:beer2) {FactoryBot.create :beer, name: "Karhu", brewery: brewery}
  let!(:user) {FactoryBot.create :user}
  let!(:user2) {FactoryBot.create :user, username: "Matti"}

  before :each do
    sign_in(username: "Pekka", password: "Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select("iso 3", from: "rating[beer_id]")
    fill_in("rating[score]", with: 15)

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  it "shows all ratings listed on the page" do
    FactoryBot.create(:rating, score: 15, user: user, beer: beer1)
    FactoryBot.create(:rating, score: 20, user: user, beer: beer1)
    FactoryBot.create(:rating, score: 10, user: user, beer: beer2)

    visit ratings_path

    expect(page).to have_content("Recent ratings")
    expect(page).to have_content("iso 3 15")
    expect(page).to have_content("iso 3 20")
    expect(page).to have_content("Karhu 10")
  end

  it "shows users ratings on user page" do
    FactoryBot.create(:rating, score: 15, user: user, beer: beer1)
    FactoryBot.create(:rating, score: 20, user: user2, beer: beer2)
    FactoryBot.create(:rating, score: 10, user: user2, beer: beer2)

    visit user_path(user2)

    expect(page).to have_content("ratings")
    expect(page).to have_content("Karhu 20")
    expect(page).to have_content("Karhu 10")
    expect(page).not_to have_content("iso 3 15")
  end

  it "should be deleted by user from the database" do
    FactoryBot.create(:rating, score: 15, user: user, beer: beer1)
    FactoryBot.create(:rating, score: 20, user: user, beer: beer2)

    visit user_path(user)


    expect{
      find("li", text: "iso 3 15").click_button("Delete")
    }.to change{user.ratings.count}.from(2).to(1)
  end

  it "should show users favorite beer and brewery" do
    FactoryBot.create(:rating, score: 15, user: user, beer: beer1)
    FactoryBot.create(:rating, score: 30, user: user, beer: beer2)

    visit user_path(user)

    expect(page).to have_content("favorite beer: Karhu")
    expect(page).to have_content("favorite brewery: Koff")
  end
end