require "uri"
require "net/http"
require "json"

# Crear un método llamado buid_web_page que reciba el hash de respuesta con todos los datos y construya una página web. 


def buid_web_page(url)
    url = URI(url)

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)

    response = https.request(request)
    results = JSON.parse(response.read_body) 
end

data = buid_web_page("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=YYNx842FDVtBVAAiWjBviNKaNjwuD969Xn4h6bMl")
#recorremos la respuesta
photos = data.map do |photo|
    photo["camera"] 

end
html = ""
photos.each do |photo|
        html += "<img src=#{photo}>\n"
end

    File.write('index.html', html) 
    