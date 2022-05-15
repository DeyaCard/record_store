require('sinatra')
require('sinatra/reloader')
require('./lib/album')
require('./lib/song')
require('pry')
also_reload('lib/**/*.rb')
require("pg")

DB = PG.connect({:dbname => "record_store"})

get('/test')do
  @something = "this is the @something variable"
  erb(:whatever)
end

get('/') do
  @albums = Album.all
  erb(:albums)
end

get('/results') do
  @album = Album.all
  erb(:search_results)
end

post('/results') do
  name = params[:album_name]
  album = Album.new({:name => name,:id => nil})
  album.save()
  @albums = Album.all
  erb(:search_results)
end

get('/albums') do
  @albums = Album.all
  erb(:albums)
end

get('/albums/new') do
  erb(:new_album)
end

get('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  erb(:album)
end

post('/albums') do
  name = params[:album_name]
  album = Album.new({:name => name,:id => nil})
  album.save()
  @albums = Album.all()
  erb(:albums)
end

get('/albums/:id/edit') do
  @album = Album.find(params[:id].to_i())
  erb(:album)
end

patch('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.update(params[:name])
  @albums = Album.all
  erb(:albums)
end

delete('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.delete()
  @albums = Album.all
  erb(:albums)
end

get('/albums/:id/songs/:song_id') do
  @song = Song.find(params[:song_id].to_i())
  erb(:song)
end

post('/albums/:id/songs') do
  @album = Album.find(params[:id].to_i())
  song = Song.new({:name => params[:song_name],:album_id => @album.id,:id => nil})
  song.save()
  erb(:album)
end

patch('/albums/:id/songs/:song_id') do
  @album = Album.find(params[:id].to_i())
  song = Song.find(params[:song_id].to_i())
  song.update(params[:name], @album.id)
  erb(:album)
end

delete('/albums/:id/songs/:song_id') do
  song = Song.find(params[:song_id].to_i())
  song.delete
  @album = Album.find(params[:id].to_i())
  erb(:album)
end


