class Api::V1::ArticlesController < ApplicationController
  def index
    articles = Article.all
    render json: articles, status: 200
  end

  def show
    article = Article.find(params[:id])
    if article
      render json: article, status: 200
    else
      render json: { error: 'No se encontró el artículo' }
    end
  end

  def create
    article = Article.new(
      title: arti_params[:title],
      body: arti_params[:body],
      author: arti_params[:author]
    )
    if article.save
      render json: article, status: 200
    else
      render json: { error: 'No se pudo crear el artículo' }
    end
  end

  def update
    article = Article.find(params[:id])
    if article
      article.update(
        title: arti_params[:title],
        body: arti_params[:body],
        author: arti_params[:author]
      )
      render json: "Artículo actualizado", status: 200
    else
      render json: { error: 'No se pudo actualizar el artículo' }
    end
  end

  def destroy
    article = Article.find(params[:id])
    if article
      article.destroy
      render json: "Artículo eliminado", status: 200
    end
  end

  private
  def arti_params
    params.require(:article).permit(:title, :body, :author)
  end
end
