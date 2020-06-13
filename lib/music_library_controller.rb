require 'pry'

class MusicLibraryController
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
        Song.all.sort{|a, b | a.artist.name <=> b.artist.name}.each_with_index do |song, index|
         puts "#{index+1}. #{song.artist.name}"
        end 
     end 

     def list_genres 
        Song.all.sort{|a, b | a.genre.name <=> b.genre.name}.each_with_index do |song, index|
            puts "#{index+1}. #{song.genre.name}"
           end 
     end 
end 