# frozen_string_literal: true

require "sinatra/base"
require "pathname"
require "json"

ROOT = Pathname.new(__dir__).realdirpath
DATA = ROOT + "spec" + "data"
FAKEDATA = JSON.parse(File.read(DATA + "alzheimers.json"))

# Screwed up and forgot facet = arrarr

fd_facets = FAKEDATA["facet_counts"]["facet_fields"]
fd_facets.each_pair do |category, values|
  arrarr = []
  while values.any?
    term = values.shift
    count = values.shift
    arrarr.push [term, count]
  end
  fd_facets[category] = arrarr.take(10)
end

FAKEDATA["facet_counts"]["facet_fields"] = fd_facets




Tilt.register Tilt[:erb], :"html.erb"

Rec = Struct.new(:title)
module Opachyderm
  class App < Sinatra::Base
    here = Pathname.new(__dir__).realdirpath
    set :logging, true
    set :views, here + "views"

    get "/" do
      erb :index, layout: :layout
    end

    get "/search/:search" do |search|
      erb "", layout: :layout, 
      locals: {
        search_terms: search, 
        documents: FAKEDATA["response"]["docs"],
        facets: FAKEDATA["facet_counts"]["facet_fields"],
        fake_data: FAKEDATA
      }
    end



  end
end

