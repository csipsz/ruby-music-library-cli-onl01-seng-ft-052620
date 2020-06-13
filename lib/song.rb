class Song 
    attr_accessor :name, :artist, :song_with_artist, :genre
    @@all = []

    def initialize(name, artist=nil, genre=nil)
        @name = name 
        @song_with_artist = artist
        @song_with_genre = genre
        if @song_with_artist
            self.artist = artist 
        end 
        if @song_with_genre 
            self.genre = genre 
        end 
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
        song = Song.new(name)
        song.save 
        song
    end 

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end 

    def genre 
        @genre
    end 

    def genre=(genre)
        @genre = genre 
        if !genre.songs.include?(self)
        genre.songs << self 
        end 
    end 

    def self.find_by_name(name)
        self.all.detect{|i| i.name == name}
    end 

    def self.find_or_create_by_name(name)
        if !self.find_by_name(name)
            Song.create(name)
        else 
            self.find_by_name(name)
        end
    end 

    def self.new_from_filename(file)
        artistname = file.split(' - ')[0]
        songname = file.split(' - ')[1]
        genrename = file.split(' - ')[2].gsub(".mp3", "")
        song = self.find_or_create_by_name(songname)
        song.artist = Artist.find_or_create_by_name(artistname)
        song.genre = Genre.find_or_create_by_name(genrename)
        song
  
    end 

    def self.create_from_filename(filename)
        song = self.new_from_filename(filename)
    end 
    
end 