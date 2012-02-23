class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  def self.similar_movies(id)
    m_temp = Movie.find(id)
    d = m_temp.director
    t = m_temp.title
    m = Movie.where("title != :t AND director == :d AND director != ''", {:d => d, :t=>t})
    return m    
  end
end
