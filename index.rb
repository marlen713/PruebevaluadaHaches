require "uri"
require "net/http"
require "json"

# Crear el método request que reciba una url y el api_key y devuelva el hash con los resultados.
api_url = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key="
api_key = "YYNx842FDVtBVAAiWjBviNKaNjwuD969Xn4h6bMl"

def request(api_url, api_key)
  url = api_url + api_key
  url = URI(url)
  
  https = Net::HTTP.new(url.host, url.port)
  https.use_ssl = true
  request = Net::HTTP::Get.new(url)
  
  response = https.request(request)
  result = JSON.parse(response.read_body)
end
data = request(api_url, api_key)

# Crear un método llamado build_web_page que reciba el hash de respuesta con todos los datos y construya una una página web. 

def build_web_page(data)
  # de acuerdo con lo señalado, sólo se usarán pocas imágenes. Em mi caso son 10.-
  images = data["photos"][0..9].map do |image|
    image["img_src"]
  end
  html = "
  <html>
  <head>
  </head>
  <body>
  <ul>
  "
  images.each do |image|
    html += "<li><img src='#{image}'></li>\n"
  end
  
  html += "
  </ul>
  </body>
  </html>
  "
  File.write('index.html', html)
end

build_web_page(data)

# Pregunta bonus: Crear un método photos_count que reciba el hash de respuesta y devuelva un nuevo hash con el nombre de la cámara y la cantidad de fotos.

def photos_count(data)
 hash = {}
  cameras = data["photos"].each do |camera|
    camera["camera"].each do |key, value|
      if key == "name"
        if hash[value]
          hash[value] += 1
        else
          hash[value] = 1 
        end
      end
    end
  end
print hash
end
photos_count (data)


