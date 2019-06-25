require 'rest-client'
require 'json'
require 'pry'

def get_api_hash(string=nil)
  if string == nil
    response_string = RestClient.get('http://www.swapi.co/api/people/')
    response_hash = JSON.parse(response_string)
    response_hash
  else
    response_string = RestClient.get(string)
    response_hash = JSON.parse(response_string)
    response_hash
  end
end

def get_character_movies_from_api(character_name)
    
  film_array = []
  get_api_hash["results"].each do |x|
    if x["name"].downcase == character_name.downcase
      x["films"].collect do |film|
        film_response_hash = get_api_hash(film)
        film_array << film_response_hash["title"]
      end
    end
  end
  return film_array
end

def print_movies(films)
  counter = 1
  films.each do |film|
    puts "#{counter}. #{film}"
    counter += 1
  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
