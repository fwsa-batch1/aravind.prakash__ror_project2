class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render plain: User.all.map { |user| user.to_pleasent_string }.join("\n")
  end

  def create
    name, email, password = params[:name], params[:email], params[:password]
    if (name != nil and password != nil and email != nil)
      response_text = ""
      if !User.find_by(email: email)
        new_user = User.create!(name: name, email: email, password: password)
        response_text = "User succesfully created with the id #{new_user.id}"
      else
        response_text = "Error! please try with different email account!"
      end
      render plain: response_text
    else
      render plain: "Error! Please fill all columns[name,email,password]!"
    end
  end
end
