require 'rubygems'
require 'sinatra'
require 'mongo_mapper'
require 'haml'

require 'models/item'

before do
  MONGO_URL = ENV['MONGOHQ_URL'] || YAML::load(File.read("config/mongo.yml"))[:mongohq_url]
  env = {}
  MongoMapper.config = { env => {'uri' => MONGO_URL} }
  MongoMapper.connect(env)
end

helpers do
  include Rack::Utils
  
end

get '/' do
  @q = params[:q]
  
  # @item = Item.first(:order => :title.desc)
  @items = Item.all
  
  haml :index
end

get '/calendar.ics' do
  content_type 'text/calendar'
end

get "/:house.ics" do
  #content_type 'text/calendar'
  house = params[:house]
  @items = Item.find_all_by_house(house, :order => "date DESC, start_time")
end

get "/:house/" do
end