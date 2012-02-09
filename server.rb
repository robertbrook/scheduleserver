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

get "/commons.ics" do
  #content_type 'text/calendar'
  @items = Item.find_all_by_house("Commons", :date => { "$gte" => Time.now.strftime("%Y-%m-%d") }, :order => "date DESC, start_time")
end

get "/lords.ics" do
  #content_type 'text/calendar'
  @items = Item.find_all_by_house("Lords", :date => { "$gte" => Time.now.strftime("%Y-%m-%d") }, :order => "date DESC, start_time")
end

get "/commons_main_chamber.ics" do
  #content_type 'text/calendar'
  @items = Item.find_all_by_house_and_location("Commons", "Main Chamber", :date => { "$gte" => Time.now.strftime("%Y-%m-%d") }, :order => "date DESC, start_time")
end

get "/commons_westminster_hall.ics" do
  #content_type 'text/calendar'
  @items = Item.find_all_by_house_and_location("Commons", "Westminster Hall", :date => { "$gte" => Time.now.strftime("%Y-%m-%d") }, :order => "date DESC, start_time")
end

get "/commons_general_committee.ics" do
  #content_type 'text/calendar'
  @items = Item.find_all_by_house_and_sponsor("Commons", /^General Committee/, :date => { "$gte" => Time.now.strftime("%Y-%m-%d") }, :order => "date DESC, start_time")
end

get "/commons_select_committee.ics" do
  #content_type 'text/calendar'
  @items = Item.find_all_by_house_and_sponsor("Commons", /^Select Committee/, :date => { "$gte" => Time.now.strftime("%Y-%m-%d") }, :order => "date DESC, start_time")
end

get "/lords_main_chamber.ics" do
  #content_type 'text/calendar'
  @items = Item.find_all_by_house_and_location("Lords", "Main Chamber", :date => { "$gte" => Time.now.strftime("%Y-%m-%d") }, :order => "date DESC, start_time")
end

get "/lords_grand_committee.ics" do
  #content_type 'text/calendar'
  @items = Item.find_all_by_house_and_sponsor("Lords", /^Grand Committee/, :date => { "$gte" => Time.now.strftime("%Y-%m-%d") }, :order => "date DESC, start_time")
end

get "/lords_select_committee.ics" do
  #content_type 'text/calendar'
  @items = Item.find_all_by_house_and_sponsor("Lords", /^Select Committee/, :date => { "$gte" => Time.now.strftime("%Y-%m-%d") }, :order => "date DESC, start_time")
end