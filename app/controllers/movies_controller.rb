class MoviesController < ApplicationController
  before_action :find_movie, only: [:update, :edit, :show]
  before_filter :authenticate_user!, only: [:edit]

  def index
    @movies = Movie.all
  end

  def new
    @movie = Movie.new
  end

  def create
    safe_movie = params.require(:movie).permit(:title, :description, :year_released, :rating)
    @movie = Movie.new safe_movie
    @movie.user_email = current_user.email

    if @movie.save
      redirect_to @movie
    else
      render 'new'
    end
  end

  def edit
    if validate_current_user == false
      redirect_to root_path
    end
  end

  def update
    safe_movie = params.require(:movie).permit(:title, :description, :year_released, :rating)
    if @movie.update(safe_movie)
      redirect_to @movie
    else
      render 'edit'
    end
  end

  def show
    @edit_allowed = validate_current_user
  end

  def search
    query = params[:q]                                                             
    @movies = Movie.search_for query 
  end

  def validate_current_user
    @movie = Movie.find params[:id]
    if @movie.user_email == current_user.email
      true
    else
      false
    end

  end

  private 

  def find_movie
    @movie = Movie.find params[:id]
    
  end
end
