class JobsController < ApplicationController
  def show
    # Finding the user and job directly for now
    @user = User.first
    @job = Job.first
  end
end
