class Api::V1::SessionsController < ApplicationController
  def signup
    user = User.new(email: user_params[:email], password: user_params[:password])
    
    if user.save
      token = encode_user_data({ user_data: user.id })

      render json: { token: token }
    else
      render json: { message: "Invalid credentials", data: user.errors }, status: :unauthorized
    end
  end

  def login
    user = User.find_by(email: params[:email])

    # you can use bcrypt to password authentication
    if user && user.password == params[:password]

      # we encrypt user info using the pre-define methods in application controller
      token = encode_user_data({ user_data: user.id })

      # return to user
      render json: { token: token }
    else
      render json: { message: "invalid credentials" }
    end
  end

  private
    def user_params
      params.require(:session).permit([
        :email,
        :password
      ])
    end
end
