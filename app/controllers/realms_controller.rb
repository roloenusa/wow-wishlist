class RealmsController < ApplicationController

  def index
        
    @title = "Realms"
    @realms = Realms.all
  end

end
