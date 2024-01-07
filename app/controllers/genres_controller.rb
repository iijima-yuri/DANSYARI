class GenresController < ApplicationController
  def new
    @genre = Genre.new
  end

  def index
    @genres = Genre.all
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to genres_path, info: 'ジャンルが正常に作成されました。'
    else
      render :new, error: 'ジャンルが正常に作成されませんでした。'
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name, :genre_id)
  end
end
