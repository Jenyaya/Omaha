require 'spec_helper'

describe "Pages" do

  describe "Root user's page'" do

    it "should have Search Users text" do
      visit root_path
      page.should have_content('Search Users')
    end


  end

  describe "Search user's page'" do
    it "should have Search Users text" do
      visit "/pages/searchusers"
      page.should have_content('Search Users')
    end

    it "should have correct title" do
      visit "/pages/searchusers"
      page.should have_selector('title',
                                :text => "Omaha | Search Users")
    end

      it "should have Search Users text" do
      visit search_path
      page.should have_selector('h2',
                                :text => "Search Users")
    end

  end


  describe "Found user's page'" do

    it "should have Search Users text" do
      visit "/pages/foundusers"
      page.should have_content('Found Users')
    end

    it "should have correct title" do
      visit "/pages/foundusers"
      page.should have_selector('title',
                                :text => "Omaha | Found Users")
    end

    it "should have Found Users text" do
      visit found_path
      page.should have_selector('h1',
                                :text => "Found Users")

  end


end

  describe "Run query page" do

    it "should have query text field" do
      visit runquery_path
      page.should have_content("Type your query")

    end

  end

end
