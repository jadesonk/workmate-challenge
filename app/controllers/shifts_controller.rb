class ShiftsController < ApplicationController
  def create
    user = User.find(shift_params[:user_id])
    job = Job.find(shift_params[:job_id])

    @shift = Shift.new
    @shift.user = user
    @shift.job = job
    @shift.start_time = Time.zone.now

    # check users last shift for an end_time to see if they have an unfinished shift
    # users with unfinished shifts cannot start a new shift and will raise and error
    if !user.shifts.empty? && user.shifts.last.end_time.nil?
      # render json: { success: false, error: "An error occured. Please try again." }, status: :bad_request
      raise ActionController::BadRequest.new(), "An error occured. Please try again."
    elsif @shift.save
      respond_to do |format|
        format.json {
          render json: { success: true, shift: @shift.id, start_time: get_time(@shift.start_time) }
        }
      end
    else
      render json: { success: false, errors: message.errors.messages }, status: :unprocessable_entity
    end
  end

  def clock_out
    @shift = Shift.find(shift_params[:shift_id].to_i)
    @shift.end_time = Time.zone.now

    # Check if current shift has already started, if not raise an error
    if @shift.start_time.nil?
      raise ActionController::BadRequest.new(), "An error occured. Please try again."
    elsif @shift.save
      respond_to do |format|
        format.json {
          render json: { success: true, shift: @shift.id, end_time: get_time(@shift.end_time) }
        }
      end
    else
      render json: { success: false, errors: message.errors.messages }, status: :unprocessable_entity
    end
  end

  private

  def shift_params
    params.require(:shift).permit(:user_id, :job_id, :shift_id)
  end

  def get_time(time)
    # Hardcoded time zone for the time being
    time_zone = "Bangkok"
    time.in_time_zone(time_zone).strftime("%l:%M %p").strip
  end
end
