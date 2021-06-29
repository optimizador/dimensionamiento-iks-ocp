require 'sinatra'
require 'rest-client'

set(:cookie_options) do
    { :expires => Time.now + 30*60 }
end

get '/iks' do
  logger = Logger.new(STDOUT)
  logger.info(request)
  @name = "IKS"
  respuestasizing=[]
  respuestasizingalt=[]
  respuestaprecio=[]
  response.set_cookie("llave", value: "valor")
  erb :iks , :locals => {:respuestasizing => respuestasizing,:respuestasizingalt => respuestasizingalt, :respuestaprecio => respuestaprecio}
end

get '/menu' do
  redirect "https://ui.9sxuen7c9q9.us-south.codeengine.appdomain.cloud//"
end

get '/iks-respuesta' do
  cpu="#{params['cpu']}"
  ram="#{params['ram']}"
  infra_type="#{params['infra_type']}"
  region="#{params['region']}"
  logger = Logger.new(STDOUT)
  logger.info("Recibiendo parametros para dimensionamiento de IKS: CPU: #{cpu} RAM: #{ram} Infra_Type: #{infra_type} Region #{region}")
  @name = "IKS-Dimensionamiento"
  urlapi="https://apis.9sxuen7c9q9.us-south.codeengine.appdomain.cloud"
  
  #parametros recibidos
  respuestasizing = RestClient.get "#{urlapi}/api/v1/ikssizingclusteroptimo?cpu=#{cpu}&ram=#{ram}&infra_type=#{infra_type}&region=#{region}", {:params => {}}
  respuestasizing=JSON.parse(respuestasizing.to_s)
  logger.info(respuestasizing)
  respuestasizingalt = RestClient.get "#{urlapi}/api/v1/ikssizingcluster?cpu=#{cpu}&ram=#{ram}&infra_type=#{infra_type}&region=#{region}", {:params => {}}
  respuestasizingalt=JSON.parse(respuestasizingalt.to_s)
  logger.info(respuestasizingalt)

  respuestaprecio=[]

  #erb :cp4d , :locals => {:respuestasizing => params[:respuestasizing]}
  erb :iks , :locals => {:respuestasizing => respuestasizing,:respuestasizingalt => respuestasizingalt,:respuestaprecio => respuestaprecio}
end

get '/iks-precio' do
  wn="#{params['wn']}"
  flavor="#{params['flavor_wn']}"
  infra_type="#{params['infra_type_wn']}"
  region="#{params['region']}"
  logger = Logger.new(STDOUT)
  logger.info("Recibiendo parametros para dimensionamiento de IKS con Worker Nodes: Worker Nodes: #{wn} Flavor: #{flavor} Infra_Type: #{infra_type} Region: #{region}")
  @name = "CP4D-Dimensionamiento"
  urlapi="https://apis.9sxuen7c9q9.us-south.codeengine.appdomain.cloud"
  
  respuestaprecio = RestClient.get "#{urlapi}/api/v1/ikspreciocluster?wn=#{wn}&flavor=#{flavor}&infra_type=#{infra_type}&region=#{region}", {:params => {}}
  respuestaprecio=JSON.parse(respuestaprecio.to_s)
  logger.info(respuestaprecio)

  respuestasizing=[]
  respuestasizingalt=[]

  #erb :cp4d , :locals => {:respuestasizing => params[:respuestasizing]}
  erb :iks , :locals => {:respuestasizing => respuestasizing,:respuestasizingalt => respuestasizingalt,:respuestaprecio => respuestaprecio}
end

get '/ocp' do
  logger = Logger.new(STDOUT)
  logger.info(request)
  @name = "OCP"
  respuestasizing=[]
  respuestasizingalt=[]
  respuestaprecio=[]
  response.set_cookie("llave", value: "valor")
  erb :ocp , :locals => {:respuestasizing => respuestasizing,:respuestasizingalt => respuestasizingalt, :respuestaprecio => respuestaprecio}
end

get '/ocp-respuesta' do
  cpu="#{params['cpu']}"
  ram_aux="#{params['ram']}".to_i
  ram = ram_aux + 8
  infra_type="#{params['infra_type']}"
  region="#{params['region']}"
  logger = Logger.new(STDOUT)
  logger.info("Recibiendo parametros para dimensionamiento de OCP: CPU: #{cpu} RAM: #{ram} Infra_Type: #{infra_type} Region: #{region}")
  @name = "OCP-Dimensionamiento"
  urlapi="https://apis.9sxuen7c9q9.us-south.codeengine.appdomain.cloud/"
  #urlapi="localhost:8080/"
  
  #parametros recibidos
  respuestasizing = RestClient.get "#{urlapi}/api/v2/sizingclusteroptimo?cpu=#{cpu}&ram=#{ram}&infra_type=#{infra_type}&region=#{region}", {:params => {}}
  respuestasizing=JSON.parse(respuestasizing.to_s)
  logger.info(respuestasizing)
  respuestasizingalt = RestClient.get "#{urlapi}/api/v2/sizingcluster?cpu=#{cpu}&ram=#{ram}&infra_type=#{infra_type}&region=#{region}", {:params => {}}
  respuestasizingalt=JSON.parse(respuestasizingalt.to_s)
  logger.info(respuestasizingalt)

  respuestaprecio=[]

  #erb :cp4d , :locals => {:respuestasizing => params[:respuestasizing]}
  erb :ocp , :locals => {:respuestasizing => respuestasizing,:respuestasizingalt => respuestasizingalt, :respuestaprecio => respuestaprecio}
end

get '/ocp-precio' do
  wn="#{params['wn']}"
  flavor="#{params['flavor_wn']}"
  infra_type="#{params['infra_type_wn']}"
  region="#{params['region']}"
  logger = Logger.new(STDOUT)
  logger.info("Recibiendo parametros para dimensionamiento de IKS con Worker Nodes: Worker Nodes: #{wn} Flavor: #{flavor} Infra_Type: #{infra_type} Region #{region}")
  @name = "CP4D-Dimensionamiento"
  urlapi="https://apis.9sxuen7c9q9.us-south.codeengine.appdomain.cloud/"
  #urlapi="localhost:8080/"
  
  respuestaprecio = RestClient.get "#{urlapi}/api/v1/preciocluster?wn=#{wn}&flavor=#{flavor}&infra_type=#{infra_type}&region=#{region}", {:params => {}}
  respuestaprecio=JSON.parse(respuestaprecio.to_s)
  logger.info(respuestaprecio)

  respuestasizing=[]
  respuestasizingalt=[]

  #erb :cp4d , :locals => {:respuestasizing => params[:respuestasizing]}
  erb :ocp , :locals => {:respuestasizing => respuestasizing,:respuestasizingalt => respuestasizingalt,:respuestaprecio => respuestaprecio}
end

