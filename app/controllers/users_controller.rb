class UsersController < ApplicationController
  
  def new
    @user = User.new
    @title = "Sign up" 
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end
end
