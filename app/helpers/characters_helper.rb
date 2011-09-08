module CharactersHelper

  
  
  def compare_by_level(iLevel,cLevel)
    if iLevel < cLevel
      return 'below'
    else iLevel > cLevel
      return 'above'
    end
  end  
end