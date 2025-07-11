class ApplicationController < ActionController::API
    attr_reader :current_user

    private

    def authenticate_request!
      header = request.headers['Authorization']
      puts "Authorization Header: #{header}" # DEBUG
      token = header.split(' ').last if header
      puts "Extracted Token: #{token}" # DEBUG

      begin
        @decoded_token = JsonWebToken.decode(token)
        puts "Decoded Token: #{@decoded_token.inspect}" # DEBUG

        if @decoded_token && @decoded_token[:user_id]
          @current_user = User.find(@decoded_token[:user_id])
          puts "Current User: #{@current_user.username}" # DEBUG
        else
          puts "Authentication failed: decoded_token or user_id missing" # DEBUG
          render json: { errors: ['Not Authenticated'] }, status: :unauthorized
          return
        end

      rescue ActiveRecord::RecordNotFound => e
        puts "User not found: #{e.message}" # DEBUG
        render json: { errors: [e.message] }, status: :unauthorized
      rescue JWT::DecodeError => e
        puts "JWT Decode Error caught: #{e.message}" # DEBUG
        render json: { errors: [e.message] }, status: :unauthorized
      rescue StandardError => e
        puts "Standard Error caught: #{e.message}" # DEBUG
        render json: { errors: [e.message] }, status: :internal_server_error
      end
    end
end
