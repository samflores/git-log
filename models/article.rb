# require 'grit'

class Article
  attr_accessor :id, :title, :tags, :body, :commit, :published_at, :author

  def initialize(attrs)
    attrs.each_pair { |key, value| self.send("#{key}=", value) }
  end

  def self.all
    repo = Grit::Repo.new('~/Projects/Ruby/blog-articles')
    data = repo.commits.inject({}) do |memo, commit|
      articles = commit.tree / 'articles'
      if articles
        articles.contents.map do |blob|
          if blob.data =~ /%(.*)%(.*)/m
            next if memo[blob.name] and memo[blob.name].map(&:id).include?(blob.id)
            meta = eval($1)
            article = Article.new({ :id => blob.id, :commit => commit.id, :published_at => commit.committed_date,
              :author => commit.author.name, :title => meta[:title], :tags => meta[:tags], :body => $2.strip })
              memo[blob.name] ||= []
              memo[blob.name] << article
          end
        end
      end
      memo
    end
  end
end
