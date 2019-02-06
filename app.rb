# index.rb
require 'sinatra'
require 'yaml/store'


Choices = {
  'HAM' => 'Hamburger',
  'PIZ' => 'Pizza',
  'CUR' => 'Curry',
  'NOO' => 'Noodles',
}

get '/' do
  @title = 'Welcome to the FoodVote!'
  erb :index
end


# post '/cast' do
#   @title = 'Thanks for casting your vote!'
#   @vote  = params['vote']
#   erb :cast
# end

# get '/results' do
#   @votes = { 'HAM' => 7, 'PIZ' => 5, 'CUR' => 3 }
#   erb :results
# end

post '/cast' do
  @title = 'Thanks for casting your vote!'
  @vote  = params['vote']
  @store = YAML::Store.new 'votes.yml'
  @store.transaction do
    @store['votes'] ||= {}
    @store['votes'][@vote] ||= 0
    @store['votes'][@vote] += 1
  end
  erb :cast
end

get '/results' do
  @title = 'Results so far:'
  @store = YAML::Store.new 'votes.yml'
  @votes = @store.transaction { @store['votes'] }
  erb :results
end