require 'spec_helper'
require 'git_log_application'

# class Article; end

feature GitLogApplication do
  scenario "there's no article" do
    Article.stub(:all => {})
    visit '/'
    page.should have_content('No articles published yet')
  end

  scenario "there's some articles" do
    Article.stub(:all => { 
      'foo' => [stub(:title => 'Foo')], 
      'bar' => [stub(:title => 'Bar')] 
    })
    visit '/'
    page.should have_content('Foo')
    page.should have_content('Bar')
  end
end
