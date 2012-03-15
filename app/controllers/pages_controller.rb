class PagesController < ApplicationController

  def searchusers
    @title = 'Search Users'
  end

  def foundusers
    @title = 'Found Users'
    username=params[:username]
    date=params[:date]
    entitlement=params[:entitlement]
    @db = params[:database]
    @time, @response, @query = Page.get_objects(@db, username, date, entitlement)

  end

  def runquery
    @title = 'Run Query'
  end

  def foundbyquery
    @title = 'From query'
    query = params[:query]
    @db = params[:database]

    @time, @response, @query =  Page.run_query(@db, query)
  end

end
