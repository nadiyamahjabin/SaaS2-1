class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route 
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    conditions = Hash.new
    @all_ratings = Movie.ratings
    @selected_ratings = params[:ratings] || session[:ratings] || {}
    @sort_column = params[:sort_column] || session[:sort_column]

    if @selected_ratings == {}
      @selected_ratings = Hash[@all_ratings.map { |rating| [rating, rating] }]
    end

    unless @sort_column.nil?
      conditions[:order] = "#{@sort_column} ASC"
    end
    conditions[:conditions] = "rating IN (?)", @selected_ratings.keys
    @movies = Movie.find(:all, conditions)

    if params[:sort_column] != session[:sort_column] || params[:ratings] != session[:ratings]
      session[:sort_column] = @sort_column
      session[:ratings] = @selected_ratings
      flash.keep
      redirect_to :sort_column => @sort_column, :ratings => @selected_ratings
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
