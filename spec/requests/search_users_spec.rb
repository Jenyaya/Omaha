require 'spec_helper'

describe "Search users form" do

  it "should fill in search form" do

    visit root_path

    select "SAM E04", :from=> "Select database"
    fill_in "Username like", with: "TESTUSER"
    fill_in "Date created", with: "11-MAR-2012"
    fill_in "Entitlement", with: "appSkyGo"
    click_button "Run Query"

    page.should have_selector('h4',
                              :text => "records found")
    page.should have_selector('table.datagrid')
    # page.should have_selector('p',
    #                             :text => "appSkyGo")

  end
end


describe "Run query form" do

  it "should fill and run query" do

    visit runquery_path

    select "SAM E04", :from=> "Select database"
    fill_in "Type your query", with: "SELECT USERNAME, EMAILADDRESS FROM samprofiledata.samprofile WHERE ROWNUM < 10"
    click_button "Run Query"

    page.should have_selector('h4',:text => "records found")
    page.should have_selector('table.datagrid')
  end


end