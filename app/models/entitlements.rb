require 'json'
require 'net/http'
require 'csv'

class Entitlements

  def self.get_entitlements(partyid)

    base_url = "http://e04-identity.mcs.bskyb.com/mcs-identity/jersey/entitlements/"
    url = URI("#{base_url}#{partyid}")
    resp = Net::HTTP.get_response(url)
    data = resp.body

    # we convert the returned JSON data to native Ruby
    # data structure - a hash
    response = JSON.parse(data)

    user_entitlement = ''

    if !response['entitlements'].empty?
      response['entitlements'].each { |ent|
        user_entitlement = user_entitlement + "<item>"+ent+"</item>"
      }
      result = {response['partyId'] => user_entitlement}
    end


    #if result has status then check error code
    if response.has_key? 'status'
      case response['status']['code']
        when code = '2008' then
          result = {response['partyId'] => "[CODE=#{code}] Customer\'s subscription status with PartyID = #{partyid} is blocked"}
        when code = '2018' then
          result = {response['partyId'] => "[CODE=#{code}] Customer with PartyID = #{partyid} has no entitlements but is otherwise legitimate"}
        when code = '2001' then
          result = {response['partyId'] => "[CODE=#{code}] Customer with PartyID = #{partyid} was not recognised"}
      end
    end


    # if the hash has 'Error' as a key, we raise an error
    if response.has_key? 'Error'
      raise "web service error"
    end

    return result

  end

  def self.read_partyid
    CSV.read('partyid.txt').flatten!
  end

  def self.partyids_from_file(uploaded_file)
    # read PartyIds from uploaded file
    partyids = []
    uploaded_file.read.each_line { |line| partyids << line.gsub(/\n\r/, '') }

    # partyids.each { |e| e.gsub!(/\n\r/, '') }

    #just save uploaded file
    File.open(Rails.root.join('public', 'uploads', uploaded_file.original_filename), 'w') do |file|
      file.write(uploaded_file.read)
    end

    user_ent = []
    partyids.each { |p|
      user_ent << Entitlements.get_entitlements(p)
    }

    return user_ent
  end

end

#puts Entitlements.get_entitlements(13232530212841031374657)

#puts Entitlements.read_partyid
