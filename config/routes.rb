Rails.application.routes.draw do
  root to: 'jobs#show'

  post "/jobs/:id/clock_in", to: "shifts#create", as: "clock_in"
  post "/jobs/:id/clock_out", to: "shifts#clock_out", as: "clock_out"
end
