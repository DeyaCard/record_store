require 'spec_helper'

describe ('Song') do

  describe('#==') do
    it("is the same song if it has the same attributes as another song") do
      album = Album.new({:name => "Giant Steps", :id => nil})
      album.save()
      song = Song.new(:name =>"Naima", :album_id => album.id, :id => nil)
      song2 = Song.new(:name =>"Naima", :album_id => album.id, :id =>nil)
      expect(song).to(eq(song2))
    end
  end

  describe('.all') do
    it("returns a list of all songs") do
      album = Album.new({:name => "Giant Steps", :id => nil})
      album.save()
      song = Song.new(:name =>"Giant Steps", :album_id => album.id, :id =>nil)
      song.save()
      song2 = Song.new(:name =>"Naima", :album_id => album.id, :id =>nil)
      song2.save()
      expect(Song.all).to(eq([song, song2]))
    end
  end

  describe('.clear') do
    it("clears all songs") do
      album = Album.new({:name => "Giant Steps", :id => nil})
      album.save()
      song = Song.new(:name =>"Giant Steps", :album_id => album.id, :id =>nil)
      song.save()
      song2 = Song.new(:name =>"Naima", :album_id => album.id, :id =>nil)
      song2.save()
      Song.clear()
      expect(Song.all).to(eq([]))
    end
  end

  describe('#save') do
    it("saves a song") do
      album = Album.new({:name => "Giant Steps", :id => nil})
      album.save()
      song = Song.new(:name =>"Naima", :album_id => album.id, :id =>nil)
      song.save()
      expect(Song.all).to(eq([song]))
    end
  end

  describe('.find') do
    it("finds a song by id") do
      album = Album.new({:name => "Giant Steps", :id => nil})
      album.save()
      song = Song.new(:name =>"Giant Steps", :album_id => album.id, :id =>nil)
      song.save()
      song2 = Song.new(:name =>"Naima", :album_id => album.id, :id =>nil)
      song2.save()
      expect(Song.find(song.id)).to(eq(song))
    end
  end

  describe('#update') do
    it("updates an song by id") do
      album = Album.new({:name => "Giant Steps", :id => nil})
      album.save()
      song = Song.new(:name =>"Naima", :album_id => album.id, :id =>nil)
      song.save()
      song.update("Mr. P.C.", album.id)
      expect(song.name).to(eq("Mr. P.C."))
    end
  end

  describe('#delete') do
    it("deletes an song by id") do
      album = Album.new({:name => "Giant Steps", :id => nil})
      album.save()
      song = Song.new(:name =>"Giant Steps", :album_id => album.id,:id =>nil)
      song.save()
      song2 = Song.new(:name =>"Naima", :album_id => album.id, :id =>nil)
      song2.save()
      song.delete()
      expect(Song.all).to(eq([song2]))
    end
  end

  describe('.find_by_album') do
    it("finds songs for an album") do
      album = Album.new({:name => "Giant Steps", :id => nil})
      album.save()
      album2 = Album.new(:name =>"Blue", :id =>nil)
      album2.save
      song = Song.new(:name =>"Naima", :album_id => album.id, :id =>nil)
      song.save()
      song2 = Song.new(:name =>"California", :album_id => album2.id , :id =>nil)
      song2.save()
      expect(Song.find_by_album(album2.id)).to(eq([song2]))
    end
  end

  describe('#album') do
    it("finds the album a song belongs to") do
      album = Album.new({:name => "Blue", :id => nil})
      album.save()
      song = Song.new(:name =>"Naima", :album_id => album.id, :id =>nil)
      song.save()
      expect(song.album()).to(eq(album))
    end
  end
end

