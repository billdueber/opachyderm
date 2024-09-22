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
  fd_facets[category] = values.flatten(2).each_slice(2).to_a.take(10)
end


fd2 = FAKEDATA["facet_counts"]["facet_fields"].dup
fd2.each_pair do |category, values|
  fd2[category] = values.flatten(2).each_slice(2).to_a.last(2)
end

FD1 = fd_facets
FD2 = fd2

Tilt.register Tilt[:erb], :"html.erb"

Rec = Struct.new(:title)
module Opachyderm
  class App < Sinatra::Base
    here = Pathname.new(__dir__).realdirpath
    set :logging, true
    set :views, here + "views"

    get "/" do
      erb :index, layout: :layout, locals: { search_terms: "" }
    end

    get "/search/:search" do |search|
      erb :index, layout: :layout,
          locals: {
            search_terms: search,
            documents: FAKEDATA["response"]["docs"],
            facets: FD1,
            fake_data: FAKEDATA
          }
    end

    get "/update/facets" do
      erb :fd2,
          layout: false,
          locals: { facets: FD2 }
    end

  end
end

