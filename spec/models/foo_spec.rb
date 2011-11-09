require 'models/foo'

describe Foo do
  it 'should say hello' do
    Foo.new.say.should == 'Hello'
  end
end
