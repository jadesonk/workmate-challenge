import { Controller } from "stimulus";
import { fetchWithToken } from "../utils/fetch_with_token";

export default class extends Controller {
  static targets = ['startTime', 'endTime', 'btnClockIn', 'btnClockOut', 'error'];

  connect() {}

  clockIn(e) {
    const url = "/jobs/1/clock_in"; // hardcoded job id

    this.errorTarget.classList.add('hidden');
    this.btnClockInTarget.classList.add('btn-loading');
    this.btnClockInTarget.innerHTML = "Loading...";

    fetchWithToken(url, {
      method: "POST",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
      body: JSON.stringify({ shift: { user_id: 1, job_id: 1 } })
    })
      .then(response => response.json())
      .then((data) => {
        this.startTimeTarget.innerHTML = data.start_time;
        this.endTimeTarget.innerHTML = "-";
        this.btnClockInTarget.classList.add('hidden');
        this.btnClockInTarget.classList.remove('btn-loading');
        this.btnClockInTarget.innerHTML = "Clock In";
        this.btnClockOutTarget.classList.remove('hidden');
        // pass in shift id from created shift to clockout button
        this.btnClockOutTarget.dataset.shiftId = data.shift;
      })
      .catch((error) => {
        this.errorTarget.innerHTML = "An error occured. Please try again.";
        this.errorTarget.classList.remove('hidden');
        this.btnClockInTarget.classList.remove('btn-loading');
        this.btnClockInTarget.innerHTML = "Clock in";
      })
  }

  clockOut(e) {
    const url = "/jobs/1/clock_out"; // hardcoded job id
    // get shift id to determine which shift to end from clockout button
    const shiftId = this.btnClockOutTarget.dataset.shiftId

    this.errorTarget.classList.add('hidden');
    this.btnClockOutTarget.classList.add('btn-loading');
    this.btnClockOutTarget.innerHTML = "Loading...";

    fetchWithToken(url, {
      method: "POST",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
      body: JSON.stringify({ shift: { shift_id: shiftId } })
    })
      .then(response => response.json())
      .then((data) => {
        this.endTimeTarget.innerHTML = data.end_time;
        this.btnClockOutTarget.classList.add('hidden');
        this.btnClockOutTarget.classList.remove('btn-loading');
        this.btnClockOutTarget.innerHTML = "Clock out";
        this.btnClockInTarget.classList.remove('hidden');
      })
      .catch((error) => {
        this.errorTarget.innerHTML = "An error occured. Please try again.";
        this.errorTarget.classList.remove('hidden');
        this.btnClockOutTarget.classList.remove('btn-loading');
        this.btnClockOutTarget.innerHTML = "Clock out";
      })
  }
}
