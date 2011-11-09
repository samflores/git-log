require 'pp'
require 'date'
require 'models/article'

module Grit
  class Repo
  end
end

describe Article do
  before do
    @repo = double
    first_article = <<-EOF
%{
  title: 'First Article',
  tags: %w(lorem ipsum)
}%
Lorem ipsum dolor sit amet
EOF
    second_article = <<-EOF
%{
  title: 'Second Article',
  tags: %w(foo bar)
}%
Donec ullamcorper nulla non metus auctor fringilla
EOF
    @repo.stub(
      :commits => [
        double(
          :id => 'foo',
          :committed_date => Date.new(2011, 11, 8),
          :author => double(:name => 'John Doe'),
          :tree => double(
            :/ => double(
              :contents => [
                double(
                  :id => 'ftw',
                  :name => 'first-article',
                  :data => first_article)]))),
        double(
          :id => 'bar',
          :committed_date => Date.new(2011, 11, 8),
          :author => double(:name => 'John Doe'),
          :tree => double(
            :/ => double(
              :contents => [
                double(
                  :id => 'wtf',
                  :name => 'second-article',
                  :data => second_article)])))

      ]
    )
    Grit::Repo.stub(:new => @repo)
  end

  it 'should be able to list all articles' do
    Article.all.count.should == 2
    first_article = Article.all['first-article'][0]
    first_article.title.should == 'First Article'
    first_article.tags.should include('lorem')
    first_article.tags.should include('ipsum')
    first_article.body.should == 'Lorem ipsum dolor sit amet'
    last_article = Article.all['second-article'][0]
    last_article.title.should == 'Second Article'
    last_article.tags.should include('foo')
    last_article.tags.should include('bar')
    last_article.body.should == 'Donec ullamcorper nulla non metus auctor fringilla'
  end
end
