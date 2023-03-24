# frozen_string_literal: true

require "sinatra/base"
require "pathname"

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

      erb "The terms are #{search}", layout: :layout
    end



  end
end