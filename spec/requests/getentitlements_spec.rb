require 'spec_helper'

describe "Get entitlements" do

  it "should fill PartyIds" do
    visit partyid_path
    fill_in 'Enter PartyID', with: '1323253021284103137s4657'
    click_button "Get Entitlements"

    page.should have_selector('h2', content: 'USERS ENTITLEMENTS')
  end
end


describe "Entitlements from file page" do

  before :each do
    @file = fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test_partyid.txt'), 'text/txt')
  end

  it "can upload a license" do
    post '/entitlementsfile', :upload_file => @file
    response.should be_success
  end


  it "can upload a file and return entitlements" do
    visit partyid_path
    attach_file "upload_file", Rails.root.join('public', 'uploads', 'partyid.txt')
    click_button "Entitlements from file"
    page.should have_selector('h2', content: 'USERS ENTITLEMENTS FROM FILE')
    page.should have_selector('table.ent_datagrid')
  end


end