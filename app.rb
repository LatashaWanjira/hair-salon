require('sinatra')
require('sinatra/reloader')
require('./lib/stylists')
require('./lib/clients')
also_reload('lib/**/*.rb')
require("pg")

DB = PG.connect({:dbname => "hair_salon_test"})

get("/") do
  @stylists = Stylist.all()
  erb(:index)
end

get('/stylists') do
  @stylists = Stylist.all()
  erb(:stylists)
end

post("/stylists") do
  name = params.fetch("stylist_name")
  stylist = Stylist.new({:name => name, :id => nil})
  stylist.save()
  @stylists = Stylist.all()
  erb(:stylist_success)
end

get('/stylists/new') do
  erb(:stylist_form)
end

get '/clients/new' do
  erb(:client_form)
end

get('/stylists/:id') do
  @stylist = Stylist.find(params.fetch("id").to_i())
  erb(:stylist)
end

post("/clients") do
  name = params.fetch("client_name")
  stylist_id = params.fetch("stylist_id").to_i()
  client = Client.new({:name => name, :stylist_id => stylist_id})
  client.save()
  # @clients = Client.all()
  @stylist = Stylist.find(stylist_id)
  erb(:client_success)
end
