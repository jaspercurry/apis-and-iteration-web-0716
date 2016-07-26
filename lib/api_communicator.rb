require 'rest-client'
require 'json'
require 'pry'


def get_character_movies_from_api(character)
  #make the web request
  all_characters = []
  next_page = []
  character_hash = []
  initial_page = RestClient.get('http://www.swapi.co/api/people/')
  init_character_hash = JSON.parse(initial_page)
  until init_character_hash["next"] == nil
    next_page = init_character_hash["next"]
    all_characters = RestClient.get(next_page)
    character_hash << JSON.parse(all_characters)
    init_character_hash = next_page
    binding.pry
  end

  collection_films = []
    character_hash["results"].each do |hash|
      if hash['name'] == character
      collection_films = hash['films']
    end
  end
  film_data = {}
  collection_films.each do |film|
    film_data = RestClient.get(film)
    
  end



  # iterate ove the character hash to find the collection of `films` for the given
  #   `character`
  collection_films = []  
    character_hash['results'].each do |character_hash|
      if character_hash['name'].downcase == character.downcase
        collection_films = character_hash['films']
      end
    end

  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
    # return value of this method should be collection of info about each film. 
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list 
  #  of movies by title. play around with puts out other info about a given film.
  film_data = []
  film_restclient = []
  collection_films.each do |film|
    film_restclient = RestClient.get(film)
    film_data << JSON.parse(film_restclient)
  end
film_data
end


def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.each do |key|
    key.each do |title, film|
      if title == "title"
        puts film
      end
    end
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
get_character_movies_from_api("Luke Skywalker")