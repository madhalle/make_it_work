require 'rails_helper'
RSpec.describe "when a user visits the project show page" do
  before :each do
    @recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
    @news_chic = @recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
  end
  it "can view projects name, material and challenge theme" do
    visit "projects/#{@news_chic.id}"

    # expect(page).to have_content(@news_chic.name)
    # expect(page).to have_content(@news_chic.material)
    expect(page).to have_content(@news_chic.challenge.theme)
    expect(page).to have_content(@news_chic.name)
    expect(page).to have_content(@news_chic.material)
  end
end
# ```
# User Story 1 of 3
#
# As a visitor,
# When I visit a project's show page ("/projects/:id"),
# I see that project's name and material
# And I also see the theme of the challenge that this project belongs to.
# (e.g.    Litfit
#     Material: Lamp Shade
#   Challenge Theme: Apartment Furnishings)
#
#
# ```
