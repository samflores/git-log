require 'sinatra'
require 'grit'
require 'models/article'
require 'presenters/articles_listing'

class GitLogApplication < Sinatra::Application

  get '/' do
    @articles = ArticlesListPresenter.new(Article.all)
    erb :'articles/index'
  end

end
