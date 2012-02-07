# encoding: utf-8

require 'mongo_mapper'

class Item
  include MongoMapper::Document
  many :revisions
  
  key :event_id, String
  key :source_file, String
  
  key :date, String
  key :title, String
  key :house, String
  key :location, String
  key :sponsor, String
  key :start_time, String
  key :end_time, String
  
  key :link, String
  key :item_type, String
  
  key :notes, String
  
  key :created_at, Date
  key :updated_at, Date
end

class Revision
  include MongoMapper::EmbeddedDocument
  one :item
  
  key :date, Date
  key :diff, Hash
end