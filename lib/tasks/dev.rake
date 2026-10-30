if defined?(Rails)
  I18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
  I18n.backend.load_translations

  requested = ENV['LOCALE'].to_s
  matched_locale = I18n.available_locales.find { |l| l.to_s.casecmp?(requested) }

  I18n.locale = matched_locale || :en
end

namespace :dev do
  desc I18n.t('rake_tasks.dev.setup.desc') # Sets up the development environment
  task setup: :environment do
    if Rails.env.development?
      show_spinner(I18n.t('rake_tasks.dev.setup.dropping')) { %x(rails db:drop) } # Dropping DB...
      show_spinner(I18n.t('rake_tasks.dev.setup.creating')) { %x(rails db:create) } # Creating DB...
      show_spinner(I18n.t('rake_tasks.dev.setup.migrating')) { %x(rails db:migrate) } # Migrating DB...
      %x(rails dev:add_brands)
      %x(rails dev:add_cars)
    else
      puts I18n.t('rake_tasks.dev.setup.not_dev_env')
    end
  end

  desc I18n.t('rake_tasks.dev.add_cars.desc') # Registers cars
  task add_cars: :environment do
    show_spinner(I18n.t('rake_tasks.dev.add_cars.registering')) do
      cars = [
              { 
                description: "Volkswagen Santana 2000 Mi",
                year: 1999,
                url_image: "https://res.cloudinary.com/dgmtq7tqr/image/upload/1999-volkswagen-santana-2000-mi-001_nbu3lo.jpg",
                brand: Brand.find_by(brand_name: 'Volkswagen')
              },
              {
                description: "Fiat Uno 1.6 mpi",
                year: 1994,
                url_image: "https://res.cloudinary.com/dgmtq7tqr/image/upload/1994-fiat-uno-1-6-mpi-001_ggkqkv.jpg",
                brand: Brand.find_by(brand_name: 'Fiat')
              },
              {
                description: "Honda Civic Si",
                year: 2005,
                url_image: "https://res.cloudinary.com/dgmtq7tqr/image/upload/2005-honda-civic-si-001_xc9aez.jpg",
                brand: Brand.find_by(brand_name: 'Honda')
              },
              {
                description: "Toyota Hilux Double Cab 4x4 5-Speed",
                year: 1998,
                url_image: "https://res.cloudinary.com/dgmtq7tqr/image/upload/1998-toyota-hilux-double-cab-4x4-5-speed-001_ac19yp.jpg",
                brand: Brand.find_by(brand_name: 'Toyota')
              },
              {
                description: "Ford Ka",
                year: 1999,
                url_image: "https://res.cloudinary.com/dgmtq7tqr/image/upload/1999-ford-ka-001_zfqis5.jpg",
                brand: Brand.find_by(brand_name: 'Ford')
              },
              {
                description: "Chevrolet Kadett GSi 2.0",
                year: 1993,
                url_image: "https://res.cloudinary.com/dgmtq7tqr/image/upload/1993-chevrolet-kadett-gsi-2-0-001_fqy2bu.jpg",
                brand: Brand.find_by(brand_name: 'Chevrolet')
              },
              {
                description: "Volkswagen New Beetle A4",
                year: 2007,
                url_image: "https://res.cloudinary.com/dgmtq7tqr/image/upload/2007-volkswagen-new-beetle-a4-001_vacxg6.jpg",
                brand: Brand.find_by(brand_name: 'Volkswagen')
              }
            ]

      cars.each do |car|
        Car.find_or_create_by!(car)
      end
    end
  end

  desc I18n.t('rake_tasks.dev.add_brands.desc') # Registers brands
  task add_brands: :environment do
    show_spinner(I18n.t('rake_tasks.dev.add_brands.registering')) do
      brands = [
        {brand_name: "Volkswagen"},
        {brand_name: "Fiat"},
        {brand_name: "Honda"},
        {brand_name: "Toyota"},
        {brand_name: "Ford"},
        {brand_name: "Chevrolet"}
      ]

      brands.each do |brand|
        Brand.find_or_create_by!(brand)
      end
    end
  end

  private

  def show_spinner(msg_start, msg_end = I18n.t('rake_tasks.dev.spinner.success')) # Done
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end
end
