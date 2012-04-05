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
    #puts "Date = #{params[:date]} "
    #puts "Entitlement = #{params[:entitlement]} "
    @time, @response, @query = Page.get_objects(@db, username, date, entitlement)

  end

  def runquery
    @title = 'Run Query'
  end

  def foundbyquery
    @title = 'From query'
    query = params[:query]
    @db = params[:database]

    @time, @response, @query = Page.run_query(@db, query)
  end


  def partyid
    @title = 'Get Entitlements'
  end

  def entitlements
    @title = 'Entitlements'
    if  !params[:partyid].empty?
       @user_ent = Entitlements.get_entitlements( params[:partyid])
    else

       render 'partyid'
    end



  end

  def entitlementsfile
    @title = 'Entitlements'

    partyids = ['13232530212841031374657', '13232414127841031368648', '13232415347021031368669']
    partyids = Entitlements.read_partyid

    @user_ent = []
    partyids.each { |p|
      @user_ent << Entitlements.get_entitlements(p)
    }



  end

end
