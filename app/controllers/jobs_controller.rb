class JobsController < ApplicationController
  def show
    # Finding the user and job directly for now
    @user = User.find(1)
    @job = Job.find(1)
  end
end
