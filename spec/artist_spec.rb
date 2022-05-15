require 'spec_helper'

describe '#Artist' do
  
  before(:each) do
    # Album.clear()
    # Song.clear()
    @album = Album.new({:name => "Giant Steps", :id => nil})
    @album.save()
  end


  describe('.all') do
    it("returns an empty array when there are no artists") do
      expect(Artist.all).to(eq([]))
    end
  end

  describe('#save') do
    it("saves an artist") do
      artist = Artist.new({:name => "King Gizzard & The Lizard Wizard", :id => nil}) # nil added as second argument
      artist.save()
      artist2 = Artist.new({:name => "The Drums", :id=> nil}) # nil added as second argument
      artist2.save()
      expect(Artist.all).to(eq([artist, artist2]))
    end
  end

  describe('#==') do
    it("is the same artist if it has the same attributes as another artist") do
      artist = Artist.new({:name => "King Gizzard & The Lizard Wizard", :id => nil})
      artist2 = Artist.new({:name => "King Gizzard & The Lizard Wizard", :id => nil})
      expect(artist).to(eq(artist2))
    end
  end
  describe('.clear') do
    it("clears all artists") do
      artist = Artist.new({:name => "King Gizzard & The Lizard Wizard", :id => nil})
      artist.save()
      artist2 = Artist.new({:name => "The Drums", :id => nil})
      artist2.save()
      Artist.clear()
      expect(Artist.all).to(eq([]))
    end
  end
  describe('.find') do
    it("finds an artist by id") do
      artist = Artist.new({:name => "King Gizzard & The Lizard Wizard", :id => nil})
      artist.save()
      artist2 = Artist.new({:name => "The Drums", :id => nil})
      artist2.save()
      expect(Artist.find(artist.id)).to(eq(artist))
    end
  end
  describe('#update') do
    it("updates an artist by id") do
      artist = Artist.new({:name => "King Gizzard & The Lizard Wizard", :id => nil})
      artist.save()
      artist.update({:name => "The Growlers"})
    expect(artist.name).to(eq("The Growlers"))
    end
  end
  describe('#delete') do
    it("deletes an artist by id") do
      artist = Artist.new({:name => "King Gizzard & The Lizard Wizard", :id => nil})
      artist.save()
      artist2 = Artist.new({:name => "The Drums", :id=> nil})
      artist2.save()
      artist.delete()
      expect(Artist.all).to(eq([artist2]))
    end
  end

  describe('#delete') do
  it("deletes all songs belonging to a deleted artist") do
    artist = Artist.new({:name => "A Love Supreme", :id => nil})
    artist.save()
    song = Song.new({:name => "Naima", :album_id => @album.id, :id => nil})
    song.save()
    artist.delete()
    expect(Song.find(song.id)).to(eq(nil))
  end
end

  describe('#songs') do
    it("returns an album's songs") do
      Artist.clear()
      artist = Artist.new({:name => "A Love Supreme", :id => nil})
      artist.save()
      song = Song.new({:name => "Naima", :album_id => @album.id, :id => nil})
      song.save()
      song2 = Song.new({:name => "Cousin Mary", :album_id => @album.id, :id => nil})
      song2.save()
      expect(@album.songs).to(eq([song, song2]))
    end
  end

  describe('#update') do
    it("adds an album to an artist") do
      artist = Artist.new({:name => "John Coltrane", :id => nil})
      artist.save()
      album = Album.new({:name => "A Love Supreme", :id => nil})
      album.save()
      artist.update({:album_name => "A Love Supreme"})
      expect(artist.albums).to(eq([album]))
    end
  end
end