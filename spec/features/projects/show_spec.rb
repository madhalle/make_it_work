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

  it "can add contestant to project" do
    visit "/projects/#{@news_chic.id}"

    click_link "Add Contestant To Project"
    expect(current_path).to eq("/projects/#{@news_chic.id}/new_contestant")
    fill_in :name, with: "Meg"
    fill_in :age, with: 22
    fill_in :hometown, with: "Denver"
    fill_in :years_of_experience, with: 7

    click_on "Submit"

    contestant_new = Contestant.last

    expect(current_path).to eq("/projects/#{@news_chic.id}")
    expect(@news_chic.contestant_projects.length).to eq(3)

    visit "/contestants"
    expect(page).to have_content(contestant_new.name)
    expect(page).to have_content(contestant_new.projects.first.name)

    
  end
end
# ```
# User Story Extension 2 - Adding a contestant to a project
#
# As a visitor,
# When I visit a project's show page
# I see a form to add a contestant to this project
# When I fill out a field with an existing contestants id
# And hit "Add Contestant To Project"
# I'm taken back to the project's show page
# And I see that the number of contestants has increased by 1
# And when I visit the contestants index page
# I see that project listed under that contestant's name
# ```
