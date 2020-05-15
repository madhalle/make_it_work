require 'rails_helper'
RSpec.describe "when a user visits the project show page" do
  before :each do
    @recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
    @news_chic = @recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
  end
  it "can view projects name, material and challenge theme" do
    visit "projects/#{@news_chic.id}"

    expect(page).to have_content(@news_chic.challenge.theme)
    expect(page).to have_content(@news_chic.name)
    expect(page).to have_content(@news_chic.material)
  end
end
