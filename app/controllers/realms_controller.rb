class RealmsController < ApplicationController

  def index
        
    @title = "Realms"
    @realms = Realm.all
  end

end
