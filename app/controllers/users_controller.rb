class UsersController < ApplicationController
  def index
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
      name: 'Martins',
      username: 'Martins-Ale'
       )
  end
end
