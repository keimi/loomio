class RootController < ApplicationController
  def index
    redirect_to explore_path
  end
end
