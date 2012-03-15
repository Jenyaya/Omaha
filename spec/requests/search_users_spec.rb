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
     page.should have_selector( 'table.datagrid')
    # page.should have_selector('p',
    #                             :text => "appSkyGo")

  end
end