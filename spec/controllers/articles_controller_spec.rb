require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  include ResponseHelper

  login_admin

  let!(:valid_article) {
    FactoryGirl.create(:article)
  }

  let(:invalid_attributes) {
    { title: '' }
  }

  let(:valid_attributes) {
    FactoryGirl.attributes_for(:article)
  }

  describe "GET #index" do
    it "assigns all articles as @articles" do
      get :index, {}
      expect(assigns(:articles)).to eq([valid_article])
    end

    it "responds with jsonp" do
      callback = 'testFunc'
      articles = { articles: [valid_article] }
      expected = jsonp_response(articles, callback)

      get :index, format: :js, callback: callback
      expect(response.body).to eq(expected)
    end
  end

  describe "GET #new" do
    it "assigns a new article as @article" do
      get :new, {}
      expect(assigns(:article)).to be_a_new(Article)
    end
  end

  describe "GET #edit" do
    it "assigns the requested article as @article" do
      get :edit, {:id => valid_article.to_param}
      expect(assigns(:article)).to eq(valid_article)
    end
  end

  describe "article #create" do
    context "with valid params" do
      it "creates a new Article" do
        expect {
          post :create, {:article => valid_attributes}
        }.to change(Article, :count).by(1)
      end

      it "assigns a newly created article as @article" do
        post :create, {:article => valid_attributes}
        expect(assigns(:article)).to be_a(Article)
        expect(assigns(:article)).to be_persisted
      end

      it "redirects to the created article" do
        post :create, {:article => valid_attributes}
        expect(response).to redirect_to articles_path
      end
    end

    let(:invalid_attributes) {
      { not_valid: 'test' }
    }

    context "with invalid params" do
      it "assigns a newly created but unsaved article as @article" do
        post :create, {:article => invalid_attributes}
        expect(assigns(:article)).to be_a_new(Article)
      end

      it "re-renders the 'new' template" do
        post :create, {:article => invalid_attributes}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { title: 'new title' }
      }

      it "updates the requested article" do
        put :update, {:id => valid_article.to_param, :article => new_attributes}
        valid_article.reload
        expect(valid_article.title).to eq(new_attributes[:title])
      end

      it "assigns the requested article as @article" do

        put :update, {:id => valid_article.to_param, :article => valid_attributes}
        expect(assigns(:article)).to eq(valid_article)
      end

      it "redirects to the article" do
        put :update, {:id => valid_article.to_param, :article => valid_attributes}
        expect(response).to redirect_to articles_path
      end
    end

    context "with invalid params" do
      it "assigns the article as @article" do
        put :update, {:id => valid_article.to_param, :article => invalid_attributes}
        expect(assigns(:article)).to eq(valid_article)
      end

      it "re-renders the 'edit' template" do
        put :update, {:id => valid_article.to_param, :article => invalid_attributes}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested article" do
      expect {
        delete :destroy, {:id => valid_article.to_param}
      }.to change(Article, :count).by(-1)
    end

    it "redirects to the articles list" do
      delete :destroy, {:id => valid_article.to_param}
      expect(response).to redirect_to(articles_url)
    end
  end

end
