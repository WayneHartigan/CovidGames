class GamesController < ApplicationController
    # Allows the :show, :edit, :update & :destroy methods to gain access to which game is being passed through the request
    before_action :find_game, only: [:show, :edit, :update, :destroy]
    # Authenticate the user be loading the :new and :edit functions
    before_action :authenticate_user!, only: [:new, :edit]

    # Fucntion to handle the index page
    def index
        # Statement to filter by genre
        # If genre is blank return all games
        if params[:category].blank?
            @games = Game.all.order("title")
        # Else display all books with that genre
        else
            @category_id = Category.find_by(name: params[:category]).id
            @games = Game.where(:category_id => @category_id).order("title")
        end
    end

    # Fucnction for the search feature
    def search
        # If search params is blank return all games
        if params[:search].blank?
          redirect_to games_path
        # Else if there is a search param try to return all games containing that param
        elsif params[:search]
          @parameter = params[:search].downcase
          @search_results = Game.all.where("lower(title) like ?", "#{@parameter}%")
        # If not then return a nothing found error
        else
          flash.alert = "Nothing found"
        end
    end

    # Function for creating a new game in the db, assigns the category an id based on its name
    def new
        @game = current_user.games.build
        @categories = Category.all.map{ |c| [c.name, c.id] }
    end

    # Function for creating a new game
    def create 
        @game = current_user.games.build(game_params)
        @game.category_id = params[:category_id]
        # If the game saves successfully return to the home page
        if @game.save 
            redirect_to root_path
        # Else return to the new page to try again
        else
            render 'new'
        end
    end

    # The function for the detailed page for each game
    # This function is handled by the before_action in which it calls the find_game function
    def show
    end

    # The function for editing games
    # This function is handled by the before_action in which it calls the find_game function
    def edit 
        # This ensures the category field in the edit form is already populated with the current category (genre)
        @categories = Category.all.map{ |c| [c.name, c.id] }
    end

    # This function updates the game in db
    def update 
        @game.category_id = params[:category_id]
        if @game.update(game_params)
            redirect_to game_path(@game)
        else 
            # If the update fails return to the edit page
            render 'edit'
        end
    end

    # This function deletes a game and returns to the home page
    def destroy 
        @game.destroy
        redirect_to root_path
    end


    private 
        # Funtion states the required params when creating or updating a game
        def game_params
            params.require(:game).permit(:title, :description, :developer, :category_id, :game_img)
        end

        # Function to gain access to which game is being passed through the request
        def find_game
            @game = Game.find(params[:id]) 
        end

end
