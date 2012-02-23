require 'spec_helper'

describe Movie do
  describe "Find all of the movies with the same director as given movie" do
    it "should return an empty list if no other such movie by the director exists" do
      Movie.create :title => "Alien",
                   :rating => "PG-13",
                   :release_date => "01-01-01",
                   :director => "Syl"
      temp=Movie.similar_movies(1)
      temp.size.should == 0
      temp.should == []
    end
    it "should return an empty list if the director is not listed" do
      Movie.create :title => "Alien",
                   :rating => "PG-13",
                   :release_date => "01-01-01"
      Movie.create :title => "Alien2222",
                   :rating => "PG-13",
                   :release_date => "02-01-02",
                   :director => "Syl"
      temp=Movie.similar_movies(1)
      temp.size.should == 0
      temp.should == []
    end
    it "should return return all movies with the same director" do
      Movie.create :title => "Alien",
                   :rating => "PG-13",
                   :release_date => "01-01-01",
                   :director => "Syl"
      Movie.create :title => "Alien22",
                   :rating => "PG-13",
                   :release_date => "02-02-02",
                   :director => "Syl"
      Movie.create :title => "Alien33",
                   :rating => "PG-13",
                   :release_date => "03-03-03",
                   :director => "Syl"
      Movie.create :title => "Alien44",
                   :rating => "PG-13",
                   :release_date => "04-03-04",
                   :director => "Sal"
      temp=Movie.similar_movies(1)
      temp.size.should == 2
      temp.each {|movie| movie.director.should =~ /Syl/}
    end
  end
end
