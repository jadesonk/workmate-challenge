class JobsController < ApplicationController
  def show
    @user = User.find(1)
    @job = Job.find(1)
  end
end
