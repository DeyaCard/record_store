require 'spec_helper'
require 'rspec'
require 'album'

describe '#Album' do


  describe('.all') do
    it("returns an empty array when there are no albums") do
      expect(Album.all).to(eq([]))
    end
  end
  
  describe('#save') do
    it("saves an album") do
      album = Album.new("Giant Steps", nil)
      album.save()
      album2 = Album.new("Blue", nil)
      album2.save()
      expect(Album.all).to(eq([album, album2]))
    end
  end

  describe('.clear') do
    it("clears all albums") do
      album = Album.new("Giant Steps", nil)
      album.save()
      album2 = Album.new("Blue", nil)
      album2.save()
      Album.clear()
      expect(Album.all).to(eq([]))
    end
  end

  describe('#==') do
    it("is the same album if it has the same attributes as another album") do
      album = Album.new("Blue", nil)
      album2 = Album.new("Blue", nil)
      expect(album).to(eq(album2))
    end
  end

  describe('.find') do
    it("finds an album by id") do
      album = Album.new("Giant Steps", nil)
      album.save()
      album2 = Album.new("Blue", nil)
      album2.save()
      expect(Album.find(album.id)).to(eq(album))
    end
  end

  describe('#update') do
    it("updates an album by id") do
      album = Album.new("Giant Steps", nil)
      album.save()
      album.update("A Love Supreme")
      expect(album.name).to(eq("A Love Supreme"))
    end
  end

  describe('#delete') do
    it("deletes all songs belonging to a deleted album") do
      album = Album.new({:name => "A Love Supreme", :id => nil})
      album.save()
      song = Song.new({:name => "Naima", :album_id => album.id, :id => nil})
      song.save()
      album.delete()
      expect(Song.find(song.id)).to(eq(nil))
    end
  end

  describe('#songs') do
    it("returns an album's songs") do
      Album.clear()
      album = Album.new({:name => "Giant Steps", :id => nil})
      album.save()
      song = Song.new({:name => "Naima", :album_id => album.id, :id => nil})
      song.save()
      song2 = Song.new({:name => "Cousin Mary", :album_id => album.id, :id => nil})
      song2.save()
      expect(album.songs).to(eq([song, song2]))
    end
  end    
end

