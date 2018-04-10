class LandingController < ApplicationController
  def index
    @groups = Group.all
  end
end
