class MoviesController < ApplicationController
  include Pagy::Backend
  before_action :find_movie, except: [:index]
  
  def index
    if params[:tab].nil? || params[:tab] == "Movie"
      @page_tab = "movies"
      @movies = Movie.includes(:genres, :stars).all
      @pagy, @movies = pagination(@movies)
    elsif params[:tab] == "Genre"
      @page_tab = "genres"
      @pagy, @genres = pagination(Genre.all)
    elsif params[:tab] == "Star"
      @page_tab = "stars"
      @stars = Star.group(:name)
      @pagy, @stars = pagination(Star.all)
    elsif params[:tab] == "Suggest"
      @movies = []
      @page_tab = "suggest"
      return unless Follow.any?
      @movies = recommended_movies
      @pagy, @movies = pagy_array(@movies, page: params[:page], items: 30)
    end
  end

  def follow
    current_user.follow(@object)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def unfollow
    current_user.stop_following(@object)
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def find_movie
    @object = params[:type].constantize.find(params[:id])
  end

  def recommended_movies
    genre_names = fetch_genre_names
    star_names = fetch_star_names
    @movies_by_genres = Movie.joins(:genres).where(genres: {name: genre_names}).uniq
    @movies_by_stars = Movie.joins(:stars).where(stars: {name: star_names}).uniq
    @movies_by_genres | @movies_by_stars
  end

  def fetch_genre_names
    genres_ids = current_user.follows_by_type('Genre').map(&:followable_id)
    genres = Genre.where(id: genres_ids).map(&:name)
    movies_ids = fetch_follow_movies
    genres_name = Movie.includes(:genres).where(id: movies_ids).map(&:genres).flatten.map(&:name)
    genres | genres_name
  end

  def fetch_star_names
    star_ids = current_user.follows_by_type('Star').map(&:followable_id)
    stars = Star.where(id: star_ids).map(&:name)
    movies_ids = fetch_follow_movies
    star_names = Movie.includes(:stars).where(id: movies_ids).map(&:stars).flatten.map(&:name)
    stars | star_names
  end

  def fetch_follow_movies
    @movies_ids ||= current_user.follows_by_type('Movie').map(&:followable_id)
  end

  def pagination(collection)
    pagy(collection, page: params[:page], items: 30)
  end
end
