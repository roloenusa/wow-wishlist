require 'net/http'
require 'rexml/document'
require 'json'

module BattleNet
  
  def self.getCharacterInfo(region, realm, name, options =[])
    query = BuildGenericString(region, realm, name, options)
    test = JSON.parse(BattleNetCall(query))
    result = {}
    test.each do |k, v|
      k = "klass" if k == "class"
      result[k.parameterize.underscore.to_sym] = v
    end
    result
  end
  
private 

  def self.BuildGenericString(region, realm, name,options=[] )
    query = options.nil? ? "" : "?fields=#{options.join(',')}"
    query = "http://#{region}.battle.net/api/wow/character/#{realm}/#{name}#{query}"
  end
  
  def self.BattleNetCall(query)
    url = URI.parse(query)
    query = url.path + (url.query.nil? ? "" : "?#{url.query}")
    request = Net::HTTP::Get.new(query)
    response = Net::HTTP.start(url.host, url.port) {|http| http.request(request)}
    response.body
  end
  
end