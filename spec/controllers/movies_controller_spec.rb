require 'spec_helper'

describe MoviesController do
  describe "find movies with same director and display them" do
    #assert_routing({ :path => "invoices", :method => :post },   { :controller => "invoices", :action => "create" })
    it 'should redirect if director is unavailable' do
      test_movie = double('Movie', :title => "Test", :director=>"")
      Movie.should_receive(:similar_movies).with(0).and_return([])
      Movie.should_receive(:find).with(0).and_return(test_movie)    
      get :similar, {:id => 0}
      response.should be_redirect
      response.should redirect_to(movies_path)
      flash[:warning].should_not be_nil
      flash[:warning].should =~ /\'Test\' has no director info/
    end
    it 'should choose to render the Same Director Movies template' do 
      test_movie = double('Movie', :title => "Test", :director=>"Bruce Willis")
      resp_movie = double('Movie', :title => "TestING", :director=>"Bruce Willis")
      Movie.should_receive(:similar_movies).with(0).and_return([resp_movie])
      Movie.should_receive(:find).with(0).and_return(test_movie)
      get :similar, {:id => 0}
      response.should_not be_redirect
      flash[:warning].should be_nil
      response.should render_template('similar')
    end
  end
end
