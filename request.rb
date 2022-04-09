require "uri"
require "net/http"
require "json"

# . Crear el método request que reciba una url y el api_key y devuelva el hash con los resultados.
#Concatenar la API Key en la siguiente url https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=DEMO_KEY

# api_key YYNx842FDVtBVAAiWjBviNKaNjwuD969Xn4h6bMl


def request(url)
    url = URI(url)

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)

    response = https.request(request)
    results = JSON.parse(response.read_body) 
end
puts request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=YYNx842FDVtBVAAiWjBviNKaNjwuD969Xn4h6bMl")


