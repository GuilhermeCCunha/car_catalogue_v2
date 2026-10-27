json.extract! car, :id, :description, :year, :url_image, :created_at, :updated_at
json.url car_url(car, format: :json)
