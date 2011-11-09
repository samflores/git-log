require 'date'
require 'presenters/articles_listing'

describe ArticlesListPresenter do
  it 'should display a message is there is no articles' do
    articles = []
    expected = "No articles published yet"
    ArticlesListPresenter.new(articles).to_list.should == expected
  end

  it 'should display a list of articles as an unordered list' do
    articles = { 
      'fisrt-article' => [double(:title => 'first article', 
                                :id => 'some_hash', 
                                :published_at => Date.new(2011, 11, 07))]
    }
    expected = '''
    <ul>
      <li>
      <article id="some_hash">
        <h1>first article</h1>
        <footer>
          <data value="2011-11-07">07/11/2011</data>
        </footer>
      </article>
      </li>
    </ul>
    '''
    ArticlesListPresenter.new(articles).to_list.gsub(/[\s\n\r]/, '').should == expected.gsub(/[\s\n\r]/, '')
  end

end
