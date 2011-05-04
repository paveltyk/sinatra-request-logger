recipes('mongodb_sharding')

mongo_version("1.8.1")
mongo_package_name("mongodb-linux-#{@attribute["kernel"]["machine"]}-#{@attribute["mongo_version"]}")
mongo_path("/opt/#{@attribute[:mongo_package_name]}")
mongo_utility_instances(@attribute["utility_instances"].select { |ui| ui["name"].match(/mongodb/) })

