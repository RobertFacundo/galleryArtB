class SessionsController < ApplicationController
  skip_before_action :authenticate_request!, only: [:create] 

  def create
    puts "PARAMS RECEIVED: #{params.inspect}"
    # Si tus params son nested (como { user: { username: "...", password: "..." } }),
    # querrás acceder a params[:user][:username]
    puts "Attempting to find user with username: #{params[:user][:username]}" 

    user = User.find_by(username: params[:user][:username])

    if user
      puts "User found: #{user.username}"
    else
      puts "User NOT found for username: #{params[:user][:username]}"
    end

    if user && user.authenticate(params[:user][:password])
      puts "User authenticated successfully!"
      token = JsonWebToken.encode(user_id: user.id)
      puts "Generated Token: #{token}"

      personal_gallery = user.personal_gallery || user.galleries.find_or_create_by(name: 'My Personal Gallery')
      puts "Personal Gallery: #{personal_gallery.name}"

      render json: {
        token: token, 
        user: user.as_json(
          only: [:id, :username, :coins, :hasSeenWelcomeModal],
          include: {
            personal_gallery: {
              include: {
                artworks: {
                  except: [:gallery_id, :created_at, :updated_at]
                }
              },
              except: [:user_id, :created_art, :updated_at]
            }
          }
        )
      }, status: :ok
    else
      puts "Authentication FAILED for username: #{params[:user][:username]}"
      render json: { error: "Invalid username or password"}, status: :unauthorized
    end
  end

  def destroy
    render json: { message: "Successfull logOut"}, status: :no_content
  end
end
