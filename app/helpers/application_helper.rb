module ApplicationHelper

  def title 
    base_title = "WoW Wishlist"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
  def character_image(img, options = {})
    image_tag("#{Battlenet::character_url}#{img}", options)
  end
  
  def icon_image(img, options = {})      
    image_tag("#{Battlenet::icon_url}#{img}.png", options)
  end
end
