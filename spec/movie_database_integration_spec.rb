require('capybara/rspec')
require('./app')
require('spec_helper')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe("the movie database path", {:type => :feature}) do
  it("visits the index page") do
    visit('/')
    expect(page).to have_content("Welcome")
  end

  it("visits the page to add movies") do
    visit('/movies')
    fill_in('name', :with => 'StarWars')
    click_button('Add movie')
    expect(page).to have_content('StarWars')
  end

  it("visits the page to add actors") do
    visit('/actors')
    fill_in('name', :with => 'Brad Pitt')
    click_button('Add actor')
    expect(page).to have_content('Brad Pitt')
  end

  it("visits the movie page and adds an actor") do
    visit('/movies')
    fill_in('name', :with => 'StarWars')
    click_button('Add movie')
    visit('/actors')
    fill_in('name', :with => 'Brad Pitt')
    click_button('Add actor')
    visit('/movies')
    click_link('StarWars')
    page.check('Brad Pitt')
    click_button('Add actors')
    expect(page).to have_content('Brad Pitt')
  end

  it("visits the actor page and adds a movie") do
    visit('/actors')
    fill_in('name', :with => 'Bradly Cooper')
    click_button('Add actor')
    visit('/movies')
    fill_in('name', :with => 'Toystory')
    click_button('Add movie')
    visit('/actors')
    click_link('Bradley Cooper')
    page.check('Toystory')
    click_button('Add movie')
    expect(page).to have_content('Toystory')
  end


end
