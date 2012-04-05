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

      # puts "PARTYID #{partyid} has next entitlements: #{response['entitlements']}"
      # print "#{response['partyId']}   "

      response['entitlements'].each { |ent|
        user_entitlement = user_entitlement + "<item>"+ent+"</item>"
      }

    end


    result = {response['partyId'] => user_entitlement}

    #if result has status then check error code
    if response.has_key? 'status'
      case result['status']['code']
        when code = '2008' then
          puts "[CODE=#{code}] Customer\'s subscription status with PartyID = #{partyid} is blocked"
        when code = '2018' then
          puts "[CODE=#{code}] Customer with PartyID = #{partyid} has no entitlements but is otherwise legitimate"
        when code = '2001' then
          puts "[CODE=#{code}] Customer with PartyID = #{partyid} was not recognised"
      end
    end


    # if the hash has 'Error' as a key, we raise an error
    if response.has_key? 'Error'
      raise "web service error"
    end
    # return response['partyId'], user_entitlement

    return result
  end

  def self.read_partyid

    CSV.read('partyid.txt').flatten!

  end


end

#puts Entitlements.get_entitlements(13232530212841031374657)

puts Entitlements.read_partyid
