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

  #  before {
  #
  #    db = "IDMAN6T"
  #    username = "TESTUSER2"
  #    date = "15-MAR-2012"
  #    entitlement = "appSkyGo"
  #    @request = Page.get_objects(db, username, date, entitlement)
  #  }
  #
  #  subject { @request }

    it "should have Search Users text" do
      visit "/pages/foundusers?database=IDMAN6T&username=TESTUSER2&date=15-MAR-2012&entitlement=appSkyGo&commit=Run+Query"
      page.should have_content('Found Users')
    end

    it "should have correct title" do
      visit "/pages/foundusers"
      page.should have_selector('title',
                                :text => "Omaha | Found Users")
    end

    it "should have Found Users text" do
      visit found_path
      page.should have_selector('h2',
                                :content => "USERS FOUND")

    end


  end

  describe "Run query page" do

    it "should have query text field" do
      visit runquery_path

      page.should have_content("Type your query")
      page.should have_selector('textarea',
                                :name => "query")
      page.should have_selector('select',
                                :content => "Select database")


    end

  end

  describe "Get Entitlements by PartyID page" do
    it "should have title" do
      visit partyid_path

      page.should have_content('Get user entitlements')
      page.should have_selector('title',
                                :text => "Omaha | Get Entitlements")
    end


    it "should have PartyId text area and button" do
      visit partyid_path
      # puts page.body
      page.should have_selector('input#partyid')
      page.should have_selector('input.get_ent')
      page.should have_selector('input.get_ent_file')
    end

    it "should have upload file button and field" do
       visit partyid_path
       page.should have_selector('input#upload_file')
    end


  end






end
