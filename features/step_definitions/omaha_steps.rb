Given /^opened (.*) page$/ do |page|

  case page
    when 'Omaha' then
      visit root_path
  end

end

Then /^I should see following header items:$/ do |table|
  data= table.raw.flatten
  data.each { |item| page.should have_selector('a', content: item.upcase) }
end

When /^I click "(.*)" link$/ do |link|
  click_link link
end

Then /^I should see "(.*)" page opened$/ do |page_name|

  case page
    when 'Home' then
      page.should have_selector('select', :id => 'database')
      page.should have_selector('input', id: 'username')
      page.should have_selector('input', id: 'date')
      page.should have_selector('input', id: 'entitlement')


    when 'Run Query' then
      page.should have_selector('select', :id => 'database')
      page.should have_selector('textarea', "Type your query")

    when 'Get Entitlements' then
      page.should have_selector('input', id: 'partyid')
      page.should have_selector('input', id: 'upload_file')
      page.should have_selector('input', value: 'Get Entitlements')
      page.should have_selector('input', value: 'Entitlements from file')


    when 'Users Found' then
      page.should have_selector('h2', content: page_name)
      page.should have_selector('h4', "records found")
      page.should have_selector('div', class: 'query')
      page.should have_selector('table', class: 'datagrid')

  end


end


When /^I press "(.*)" button$/ do |button|
  click_button button
end

When /^I fill search fields:$/ do |table|

  data = transform_table(table.raw)

  data.each { |key, value|
    page.find_field(key).set(value)
  }


end