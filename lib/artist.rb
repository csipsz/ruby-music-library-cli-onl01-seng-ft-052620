

class Artist 
    extend Concerns::Findable
    attr_accessor :name 
    @@all = []

    def initialize(name)
        @name = name 
        @songs = []
    end 

    def self.all 
        @@all 
    end 

    def self.destroy_all 
        self.all.clear
    end 

    def save 
        @@all << self
    end 

    def self.create(name)
        artist = Artist.new(name)
        artist.save 
        artist
    end 

    def songs
        Song.all
    end 

    def add_song(song)
        if !song.artist 
            song.artist = self 
            songs << song
        end 
    end 

    def genres 
        songs.collect do |song| song.artist == self
            song.genre
        end 
        .uniq
    end 

end 