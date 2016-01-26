json.array!(@clinics) do |clinic|
  json.extract! clinic, :id, :title, :description, :spots_available, :price, :scheduled_for, :open_for_registration
  json.url clinic_url(clinic, format: :json)
end
