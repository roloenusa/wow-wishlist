require 'net/http'
require 'rexml/document'
require 'json'

module BattleNet

  def self.getRegions
    [:us]
  end
	  
  def self.getCharacter(params = {})
    params[:region] = :us if params[:region].nil?
    params[:type] = "character/#{params[:realm]}/#{params[:name]}"
    params[:query] = params[:options].nil? ? "" : "?fields=#{params[:fields].join(',')}"

    character_hash = BattleNetCall(params)
    character_hash = cleanHash(character_hash)
    character_hash.merge(:region => params[:region])
  end

  def self.getRealms(params = {})
    params[:region] = :us if params[:region].nil?
    params[:type] = 'realm/status'
    params[:query] = params[:options].nil? ? "" : "?realms=#{params[:realms].join(',')}"

    realm_hash = BattleNetCall(params)
    realm_hash = cleanHash(realm_hash)
    realm_hash.merge(:region => params[:region])
  end
  
private

  def self.buildGenericString(params = {})
    "http://#{params[:region]}.battle.net/api/wow/#{params[:type]}#{params[:query]}"
  end
  
  def self.BattleNetCall(params = {})
    query = buildGenericString(params)
    response = callAPI(query)
    parseResponse(response)
  end
  
  def self.callAPI(query)
    
    url = URI.parse(query)
    query = url.path + (url.query.nil? ? "" : "?#{url.query}")
    request = Net::HTTP::Get.new(query)
    response = Net::HTTP.start(url.host, url.port) {|http| http.request(request)}
  end
  
  def self.parseResponse(response)
    
    if response.code != "200"
    
      # When the API from blizzard fails to find a character, it sends a similar hash. 
      # This makes it so I can catch the errors without worrying about coding for each response.
      response.body = '{"status":"nok", "reason":"Blizzard didn\'t like this request!"}'
    end
    
    JSON.parse(response.body)
  end
  
  def self.cleanHash(test)
  
    result = {}
    test.each do |k, v|
      
      if v.is_a?(Array)
        a = []
        v.each do |t| a << cleanHash(t) end
        v = a
      end
      k = "klass" if k == "class"
      k = "tipe"  if k == "type"
      result[k.parameterize.underscore.to_sym] = v
    end        
    result
  end
end