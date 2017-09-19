require 'rest-client'
require 'json'
require 'pry'

def all_characters_array
  char_array = []
  next_url = 'http://www.swapi.co/api/people/'
   while next_url != nil
     all_characters = RestClient.get(next_url)
     page_hash = JSON.parse(all_characters)
     array_of_hashes = page_hash["results"]

     array_of_hashes.each { |e|
       char_array << e }

     next_url = page_hash["next"]
   end
   char_array
end

def get_character(character)
  all_characters_array.find { |hash| hash["name"].downcase == character }
end

def get_character_movies_from_api(character)
  films_list = get_character(character)["films"]
  films_list.map do |link|
    links = RestClient.get(link)
    JSON.parse(links)
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

def parse_character_movies(films_hash)
  films_hash.each_with_index do |film, i|
    puts "#{i + 1} #{film["title"]}"
  end
end












  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
# end
#
# def parse_character_movies(films_hash)
#   # some iteration magic and puts out the movies in a nice list
# end
#

# get_character_movies_from_api("Luke Skywalker")
#
# ## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
