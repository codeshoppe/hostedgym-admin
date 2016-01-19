class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  protect_from_forgery except: :index

  def index
    authorize Article
    @articles = article_collection
    respond_to do |format|
      format.html { render :index }
      format.js { render json: { articles: @articles }, callback: params[:callback] }
    end
  end

  def show
  end

  def new
    @article = article_collection.new
    authorize @article
  end

  def edit
  end

  def create
    @article = article_collection.new(article_params)
    authorize @article

    respond_to do |format|
      if @article.save
        format.html { redirect_to articles_path, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to articles_path, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def article_collection
      @articles ||= policy_scope(Article)
    end

    def set_article
      @article = article_collection.find(params[:id])
      authorize @article
    end

    def article_params
      params.require(:article).permit(:title, :body)
    end
end
