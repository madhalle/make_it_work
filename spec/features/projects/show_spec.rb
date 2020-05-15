require 'rails_helper'
RSpec.describe "when a user visits the project show page" do
  before :each do
    @recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
    @news_chic = @recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")

    @jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
    @gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)

    ContestantProject.create(contestant_id: @jay.id, project_id: @news_chic.id)
    ContestantProject.create(contestant_id: @gretchen.id, project_id: @news_chic.id)
  end
  it "can view projects name, material and challenge theme" do
    visit "/projects/#{@news_chic.id}"

    expect(page).to have_content(@news_chic.challenge.theme)
    expect(page).to have_content(@news_chic.name)
    expect(page).to have_content(@news_chic.material)
  end

  it "can see number of contestants on project" do
    visit "/projects/#{@news_chic.id}"

    expect(page).to have_content("Number of Contestants: #{@news_chic.contestant_projects.length}")
  end

  it "can see average years of experience of contestants on project" do
    visit "/projects/#{@news_chic.id}"

    expect(page).to have_content("Average Contestant Experience: 12.5 years")
  end
end
# ```
# User Story Extension 1 - Average years of experience for contestants by project
#
# As a visitor,
# When I visit a project's show page
# I see the average years of experience for the contestants that worked on that project
# (e.g.    Litfit
#     Material: Lamp Shade
#   Challenge Theme: Apartment Furnishings
#   Number of Contestants: 3
#   Average Contestant Experience: 10.25 years)
# ```
