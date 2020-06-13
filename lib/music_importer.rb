class MusicImporter 
    attr_accessor :path
    @@all = []
    
    def initialize(path)
        @path = path 
    end 

    def files
        Dir.glob("#{@path}/*.mp3").map do |file|
        file.split("/")[-1]
        
    end
    end 

    def import 
        files.each{|file| Song.create_from_filename(file)}
    end 

    def self.new_from_filename(filename)
    end 

    def self.create_from_filename
    end
end 

