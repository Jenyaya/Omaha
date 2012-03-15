class Page

  def self.get_objects(db='IDMAN6T', username, date, ent)

    connect_to_db(db)

    query = "select distinct  sam.samprofileid, sam.username, crm.partyid, sam.registrationdate, ent.STARTDATE,
              ent.EXPIRYDATE, service.SERVICEENTMNTNAME

              from samprofiledata.samprofile sam, samprofiledata.crmprofile crm,
              samprofiledata.samprofile_service_entmnt ent, samprofiledata.service_entitlement service
              where sam.samprofileid = crm.samprofileid
              and sam.SAMPROFILEID = ent.SAMPROFILEID
              and ent.SERVICEENTMNTID = service.SERVICEENTMNTID

              and sam.registrationdate > '#{date}'
              and service.serviceentmntname like '#{ent}'
              and sam.username like upper('#{username}%')
              order by sam.registrationdate"


    started_seconds = Time.now.tv_sec

    resp = ActiveRecord::Base.connection.execute(query)

    time = Time.now.tv_sec-started_seconds

    return time, cursor_to_array(resp, true), query

  end


  def self.run_query (db='IDMAN6T', query)

    connect_to_db(db)

    started_seconds = Time.now.tv_sec

    resp = ActiveRecord::Base.connection.execute(query)

    time = Time.now.tv_sec-started_seconds

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

end


