class ApplicationController < ActionController::API
  SECRET = "yoursecretword"

  def authentication
    decode_data = decode_user_data(request.headers["token"])
    puts decode_data.inspect

    user_data = decode_data[0]["data"]["user_data"] unless !decode_data

    user = User.find(user_data) unless !decode_data

    if user
      return true
    else
      render json: { message: "invalid credentials" }, status: :unauthorized
    end
  end

  def encode_user_data(payload)
    exp = Time.now.to_i + 45
    exp_payload = { data: payload, exp: exp }

    token = JWT.encode exp_payload, SECRET, "HS256"
    return token
  end

  def decode_user_data(token)
    begin
      data = JWT.decode token, SECRET, true, { algorithm: "HS256" }
      return data
    rescue => e
      puts e
    end
  end

end
