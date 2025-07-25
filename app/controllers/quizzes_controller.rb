class QuizzesController < ApplicationController
    before_action :authenticate_request!, only: [:generate_question, :submit_answer]

    def generate_question
      if Artwork.count < 4
        render json: { error: "Not enough artworks in the database to generate a meaningful quiz." }, status: :unprocessable_entity and return
      end

      correct_artwork = Artwork.order("RANDOM()").first

      unless correct_artwork.artist_name.present? && correct_artwork.title.present?
        render json: { error: "Selected artwork has no artist name. Cannot generate question." }, status: :unprocessable_entity and return
      end

      question_type = rand(2)

      question_text = ""
      all_options = []
      correct_answer_value = ""

      if question_type == 0
        question_text = "Who is the author of \"#{correct_artwork.title}\"?"
        correct_answer_value = correct_artwork.artist_name

        incorrect_options = Artwork.where.not(id: correct_artwork.id)
                                   .where.not(artist_name: [nil, '', correct_artwork.artist_name])
                                   .pluck(:artist_name)
                                   .uniq
                                   .sample(3)

        all_options = (incorrect_options + [correct_answer_value]).shuffle
      
      else 
        question_text = "What is the title of the artwork by \"#{correct_artwork.artist_name}\"?"
        correct_answer_value = correct_artwork.title

        incorrect_options = Artwork.where.not(id: correct_artwork.id)
                                   .where.not(title: [nil, '', correct_artwork.title])
                                   .pluck(:title)
                                   .uniq
                                   .sample(3)
        
        all_options = (incorrect_options + [correct_answer_value]).shuffle
      end

      generated_reward = ((rand * (6.0 - 3.0)) + 3.0).round(2)

      question = {
        artwork_id: correct_artwork.id,
        question_text: question_text,
        options: all_options,
        reward: generated_reward,
        correct_field: (question_type == 0 ? 'artist_name' : "title"),
        artwork_image_url: correct_artwork.image_url
      }
      
      render json: question, status: :ok
    rescue => e
      render json: { error: "Failed to generate quiz question: #{e.message}" }, status: :internal_server_error
    end

    def submit_answer
      artwork_id = params[:artwork_id]
      submitted_answer = params[:answer]
      correct_field = params[:correct_field]

      unless artwork_id.present? && submitted_answer.present?
        render json: { error: "Artwork ID and answer are required." }, status: :bad_request and return
      end

      correct_artwork = Artwork.find_by(id: artwork_id)

      unless correct_artwork
        render json: { error: "Artwork not found for this question." }, status: :not_found and return
      end

      allowed_fields = ['title', 'artist_name']

      unless allowed_fields.include?(correct_field.to_s)
        render json: {error: 'Invalid correct_field specified'}, status: :bad_request and return
      end

      correct_value = case correct_field.to_s
                      when 'title'
                        correct_artwork.title
                      when 'artist_name'
                        correct_artwork.artist_name
                      else
                        render json: { error: "Unexpected correct_field value"}, status: :internal_server_error and return
                      end

      if submitted_answer.downcase == correct_value.downcase
        reward = ((rand * (6.0 - 3.0)) + 3.0).round(2)
        @current_user.coins += reward
        @current_user.save!

        render json: {
            success: true,
            message: "Correct answer! You earned #{reward} coins.",
            new_coins: @current_user.coins
        }, status: :ok
      else
        render json: {
          success: false,
          message: "Incorrect answer. Try Again!",
          new_coins: @current_user.coins
        }, status: :ok
      end
    rescue ActiveRecord::RecordInvalid => e
      render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    rescue => e
      render json: { error: "Failed to submit answer: #{e.message}" }, status: :internal_server_error
    end
end
