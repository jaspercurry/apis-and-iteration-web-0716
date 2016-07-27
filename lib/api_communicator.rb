require 'rest-client'
require 'json'
require 'pry'


def consolodate_pages
end



def get_character_movies_from_api(character)
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  while character_hash["next"] != nil 
    all_characters = RestClient.get(character_hash["next"])
    var = JSON.parse(all_characters)
      var["results"].each do |thing|
      character_hash["results"] << thing
      end
    character_hash["next"] = var["next"]
  end
  collection_films = []
    character_hash["results"].each do |hash|
      if hash["name"].downcase == character.downcase
      collection_films = hash["films"]
    end
  end
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
