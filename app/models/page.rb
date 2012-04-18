class Page

 # attr_accessible :query

  #validates :query, presence: true

  def self.get_objects(db='IDMAN6T', username, date, ent)

    connect_to_db(db)

    query = generate_query(username, date, ent)

    started_seconds = Time.now.tv_sec

    resp = ActiveRecord::Base.connection.execute(query)

    time = Time.now.tv_sec-started_seconds

    return time, cursor_to_array(resp, true), query

  end


  def self.run_query (db='IDMAN6T', query)

    query.empty? ? (return time=0, "", "You don't have query") : query

    connect_to_db(db)

    started = Time.now.tv_sec

    resp = ActiveRecord::Base.connection.execute(query)

    time = Time.now.tv_sec-started

    return time, cursor_to_array(resp, true), query

  end


  def self.connect_to_db(db)
    case db
      when db = 'IDMAN6T' then
        ActiveRecord::Base.establish_connection :oracle_E04
      when db = 'IDMAN3T' then
        ActiveRecord::Base.establish_connection :oracle_E05
    end
  end

  def self.cursor_to_array(cursor, use_keys_as_header = false)
    result = []
    while r = cursor.fetch_hash
      result << r.keys if result.empty? && use_keys_as_header
      result << r.values
    end

    result
  end


  def self.generate_query(username, date, ent)
      # date.nil? ? (raise 'Date is nill!') : (puts date)
    #date.nil? ? ( date = '1-JAN-2012') : (date)

   query = "select distinct  sam.samprofileid, sam.username, crm.partyid, sam.registrationdate, ent.STARTDATE,
              ent.EXPIRYDATE, service.SERVICEENTMNTNAME

              from samprofiledata.samprofile sam, samprofiledata.crmprofile crm,
              samprofiledata.samprofile_service_entmnt ent, samprofiledata.service_entitlement service
              where sam.samprofileid = crm.samprofileid
              and sam.SAMPROFILEID = ent.SAMPROFILEID
              and ent.SERVICEENTMNTID = service.SERVICEENTMNTID

              and sam.registrationdate > '#{date}'
              and service.serviceentmntname like '#{ent}%'
              and sam.username like upper('#{username}%')
              and rownum < 100
              order by sam.registrationdate"



  end

end




