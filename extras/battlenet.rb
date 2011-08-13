require 'net/http'
require 'rexml/document'
require 'json'

module Battlenet

  def self.get_regions
    [:us]
  end
  
  def self.get_item(id)
    params = {
      :region => :us,
      :type => 'item',
      :query => id.to_i
    }
    
    item_hash = call_battlenet(params)
    item_hash = clean_hash(item_hash)
  end
	  
  def self.get_character(params = {})
    params[:region] = :us if params[:region].nil?
    params[:type] = "character"
    params[:query] = "#{params[:realm]}/#{params[:name]}" + (params[:options].nil? ? "" : "?fields=#{params[:fields].join(',')}")

    character_hash = call_battlenet(params)
    character_hash = clean_hash(character_hash)
  end

  def self.get_realms(params = {})
    params[:region] = :us if params[:region].nil?
    params[:type] = 'realm/status'
    params[:query] = params[:options].nil? ? "" : "?realms=#{params[:realms].join(',')}"

    realm_hash = call_battlenet(params)
    realm_hash = clean_hash(realm_hash)
    realm_hash.merge(:region => params[:region])
  end
  
private

  def self.build_generic_string(params = {})
    "http://#{params[:region]}.battle.net/api/wow/#{params[:type]}/#{params[:query]}"
  end
  
  def self.call_battlenet(params = {})
    query = build_generic_string(params)
    response = call_api(query)
    parse_response(response)
  end
  
  def self.call_api(query)
    
    url = URI.parse(query)
    query = url.path + (url.query.nil? ? "" : "?#{url.query}")
    request = Net::HTTP::Get.new(query)
    response = Net::HTTP.start(url.host, url.port) {|http| http.request(request)}
  end
  
  def self.parse_response(response)
    
    if response.code != "200"
    
      # When the API from blizzard fails to find a character, it sends a similar hash. 
      # This makes it so I can catch the errors without worrying about coding for each response.
      response.body = '{"status":"nok", "reason":"Blizzard didn\'t like this request!"}'
    end
    
    JSON.parse(response.body)
  end
  
  def self.clean_hash(test)
  
    result = {}
    test.each do |k, v|
      
      if v.is_a?(Array)
        a = []
        v.each do |t| a << clean_hash(t) end
        v = a
      end
      
      if v.is_a?(Hash)
        v = clean_hash(v)
      end
      
      k = "klass" if k == "class"
      k = "tipe"  if k == "type"
      result[k.parameterize.underscore.to_sym] = v
    end        
    result
  end
end