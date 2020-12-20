class UsersController < ApplicationController
  def index
    @users = [
      User.new(
        id:1,
        name: 'Jamesss',
        username: 'DB7Carr',
        avatar_url: 'https://screenshots.gamebanana.com/img/ico/sprays/james_bond_-_007_-_256.png'
      ),
      User.new(
        id:2,
        name: 'Banana',
        username: 'OtherUsername',
        avatar_url: 'https://www.awicons.com/free-icons/download/art-icons/playground-icons-by-klukeart/ico/Banana.ico'
      )
    ]
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
    @questions = [
      Question.new(text:'How are you?', created_at: Date.parse('17.12.2020')),
      Question.new(text:'Second questionnnnn', created_at: Date.parse('17.12.2020')),
    ]

    @new_question = Question.new

  end
end
