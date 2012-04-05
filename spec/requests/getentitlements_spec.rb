require 'spec_helper'

describe "Get entitlements" do

  it "should fill PartyIds" do
    visit partyid_path
    fill_in 'Enter PartyIDs', with: '13232530212841031374657'
    click_button "Get Entitlements"

    page.should have_selector('h2', content: 'USERS ENTITLEMENTS')
  end
end


describe "Entitlements from file page" do

  it "should exist" do
    visit entitlementsfile_path

    page.should have_selector('h2', content: 'USERS ENTITLEMENTS')
  end
end