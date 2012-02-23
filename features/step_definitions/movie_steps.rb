# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create :title => movie["title"],
                 :rating => movie["rating"],
                 :release_date => movie["release_date"],
                 :director => movie['director']
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
  #assert false, "Unimplmemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  
  temp = rating_list.split(%r{,\s*})
  
  temp.each do |rating|
    r = rating.strip
    if uncheck
      step %Q{I uncheck "ratings[#{r}]"}
    else 
      step %Q{I check "ratings[#{r}]"}   
    end   
  end  
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |arg1, arg2|
  #temp2 = arg1 + " was successfully updated."
  temp = "Director: "+arg2
  #page.find('#notice').should have_content(temp2)
  page.find('#details').should have_content(temp)
  Movie.find_by_title(arg1).director.should==arg2 
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  body = page.body
  exp1 = /#{e1}/
  exp2 = /#{e2}/
  temp = (body =~ exp1),
  temp2 = (body =~ exp2)
  if page.respond_to? :should
    (body =~ exp1).should < (body =~ exp2)
  else
    assert (body =~ exp1) < (body =~ exp2)
  end
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  #assert false, "Unimplmemented"
end

Then /I should see following movies in order: (.*)/ do |movie_list|
  temp = movie_list.split(%r{,\s*})
  prev = nil
  temp.each do |movie|
    unless prev
      step %Q{Then I should see "#{prev}" before "#{movie}"}
      prev = movie
    else
      prev = movie
    end
  end
end

Then /I should not see any of the movies/ do 
  rows = page.all(:xpath, '//table[@id="movies"]/tbody/tr').size
  rows.should==0
end

Then /I should see all of the movies/ do
  rows = page.all(:xpath, '//table[@id="movies"]/tbody/tr').size
  rows.should==Movie.count
end

