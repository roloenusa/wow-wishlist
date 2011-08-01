require 'net/http'
require 'rexml/document'
require 'json'

module BattleNet

  def self.regions
    [:us]
  end
	  
  def self.getCharacterInfo(region, realm, name, options =[])
    query = buildGenericString(region, realm, name, options)
    test = JSON.parse(BattleNetCall(query))
    result = {}
    test.each do |k, v|
      k = "klass" if k == "class"
      result[k.parameterize.underscore.to_sym] = v
    end
    result
  end
  
  
  # Generic call to battle.net
  def self.callBattleNet(params = {})
    
    # Fix the :region to default to :us
    params[:region] = :us if params[:region].nil?
    
    if params[:type] == :realm
      getRealmInfo params
    else
      return {:status => "nok", :reason => "Type of call not found"}
    end
  end
  
  def self.getRealmInfo(info = {})
    info[:region] = :us if info[:region].nil?
    info[:type] = 'realm/status' if (info[:type].nil? || info[:type] == :realm)
    
    query = info[:options].nil? ? "" : "?realms=#{info[:options].join(',')}"
    query = "http://#{info[:region]}.battle.net/api/wow/#{info[:type]}/#{query}"
    
    test = BattleNetCall(query)
    
    result = {}
    test.each do |k, v|
      k = "klass" if k == "class"
      result[k.parameterize.underscore.to_sym] = v
    end
    result
  end
  
private 

  def self.buildGenericString(region, realm, name,options=[] )
    query = options.nil? ? "" : "?fields=#{options.join(',')}"
    query = "http://#{region}.battle.net/api/wow/character/#{realm}/#{name}#{query}"
  end
  
  def self.BattleNetCall(query)
    url = URI.parse(query)
    query = url.path + (url.query.nil? ? "" : "?#{url.query}")
    request = Net::HTTP::Get.new(query)
    response = Net::HTTP.start(url.host, url.port) {|http| http.request(request)}
    
    if response.code != "200"
      response.body = '{"status":"nok", "reason":"Blizzard didn\'t like this request! :("}'
    end
    
    JSON.parse(response.body)
  end
  
end