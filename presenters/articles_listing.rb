require 'nokogiri'

class ArticlesListPresenter
  def initialize(articles)
    @articles = articles
  end

  def article_li(art, html)
    html.li do
      html.article(:id => art.id) do
        html.h1 art.title
        html.footer do
          html.data({:value => art.published_at.strftime('%Y-%m-%d')}, art.published_at.strftime('%d/%m/%Y'))
        end
      end
    end
  end

  def to_list
    return  "No articles published yet" if @articles.empty?
    html = Nokogiri::HTML::Builder.new do |html|
      html.ul do
        @articles.each_pair do |slub, art|
          article_li(art.first, html)
        end
      end
    end.to_html
    Nokogiri::HTML::fragment(html).to_html
  end
end
