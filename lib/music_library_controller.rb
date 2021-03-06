require 'pry'

class MusicLibraryController
    extend Concerns::Findable
    def initialize(path='./db/mp3s')
        @path = path
        importer = MusicImporter.new(path)
        importer.import
    end 

    def call 
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"
        userinput = gets.chomp

        case userinput
        when "list songs"
          list_songs
        when "list artists"
          list_artists
        when "list genres"
          list_genres
        when "list artist"
          list_songs_by_artist
        when "list genre"
          list_songs_by_genre
        when "play song"
          play_song
        end
        
        if userinput != 'exit'
            call 
        end 


    end 

    def list_songs
       sorted = Song.all.sort{|a, b | a.name <=> b.name}.each_with_index do |song, index|
        puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
       end 
    end 

    def list_artists
        Artist.all.sort{|a, b| a.name <=> b.name}.each_with_index do |artist, index|
         puts "#{index+1}. #{artist.name}"
        end 
     end 

     def list_genres 
        Genre.all.sort{|a, b | a.name <=> b.name}.each_with_index do |genre, index|
            puts "#{index+1}. #{genre.name}"
           end 
     end 

     def list_songs_by_artist
      puts "Please enter the name of an artist:"
      input = gets.strip
  
      if artist = Artist.find_by_name(input)
        artist.songs.sort{ |a, b| a.name <=> b.name }.each.with_index(1) do |s, i|
          puts "#{i}. #{s.name} - #{s.genre.name}"
        end
      end
    end
  

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets.chomp
    
        genre_instance = Genre.find_by_name(input)
        if genre_instance
          genre_instance.songs.sort{|a, b| a.name <=> b.name}.each_with_index do |song, index|
            puts "#{index+1}. #{song.artist.name} - #{song.name}"
          end
        end
      end

      def play_song 
        puts "Which song number would you like to play?"
        input = gets.chomp.to_i
        if 0 < input && input <= Song.all.length 
          #binding.pry
            Song.all.sort{|a, b | a.name <=> b.name}.each_with_index do |song, index| 
            if index == (input - 1)
            puts "Playing #{song.name} by #{song.artist.name}"
            end 
        end
        end
      end 

     
end 