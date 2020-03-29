class ReviewsController < ApplicationController
    # Runs the find_game function before anything else to get the game from the request
    before_action :find_game
    # Allows the :edit, :update & :destroy methods to gain access to which review is being passed through the request
    before_action :find_review, only: [:edit, :update, :destroy]
    # Authenticate the user be loading the :new and :edit functions
    before_action :authenticate_user!, only: [:new, :edit]

    # Updates the review in the model
    def new
        @review = Review.new
    end

    # Function to handle the user end of creating a review
    def create
        @review = Review.new(review_params)
        @review.game_id = @game.id
        @review.user_id = current_user.id

        # If review successfully save return to that game's show path
        if @review.save 
            redirect_to game_path(@game)
        # If it does not save succesfully return to the new review page
        else 
            render 'new'
        end
    end

    # The function for editing a review
    # This function is handled by the before_action in which it calls the find_reviewfunction
    def edit 
    end

    # This function updates the review in db
    def update 
        

        if @review.update(review_params)
            redirect_to game_path(@game)
        else
            render 'edit'
        end
    end

    # This function destroys the review in db
    def destroy 
        @review.destroy
        redirect_to game_path(@game)
    end

    private
        # Funtion states the required params when creating or updating a review
        def review_params
            params.require(:review).permit(:rating, :comment)
        end

        # Get the game from the request
        def find_game
            @game = Game.find(params[:game_id])
        end

        # Gets the review from the request
        def find_review 
            @review = Review.find(params[:id])
        end
end
