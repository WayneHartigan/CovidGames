class GamesController < ApplicationController
    before_action :find_game, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, only: [:new, :edit]

    def index
        if params[:category].blank?
            @games = Game.all.order("created_at DESC")
        else
            @category_id = Category.find_by(name: params[:category]).id
            @games = Game.where(:category_id => @category_id).order("created_at DESC")
        end
    end

    def new
        @game = current_user.games.build
        @categories = Category.all.map{ |c| [c.name, c.id] }
    end

    def create 
        @game = current_user.games.build(game_params)
        @game.category_id = params[:category_id]
        if @game.save 
            redirect_to root_path
        else
            render 'new'
        end
    end

    def show
    end

    def edit 
        @categories = Category.all.map{ |c| [c.name, c.id] }
    end

    def update 
        @game.category_id = params[:category_id]
        if @game.update(game_params)
            redirect_to game_path(@game)
        else 
            render 'edit'
        end
    end

    def destroy 
        @game.destroy
        redirect_to root_path
    end


    private 
        def game_params
            params.require(:game).permit(:title, :description, :developer, :category_id, :game_img)
        end

        def find_game
            @game = Game.find(params[:id]) 
        end

end
