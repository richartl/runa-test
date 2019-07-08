Rails.application.routes.draw do
  def draw(routes_name)
      instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end

  root :to => redirect('/swagger/dist/index.html?url=/api/v1/docs')
  draw 'api_v1'
end
