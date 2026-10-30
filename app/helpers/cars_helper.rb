module CarsHelper
  def car_url_image(car)
    car_image = car.url_image
    !car_image.empty? ? car_image : "default_car.jpg"
  end
end
