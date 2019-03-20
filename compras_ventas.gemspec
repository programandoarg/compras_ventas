Gem::Specification.new do |s|
  s.name        = 'compras_ventas'
  s.version     = '0.0.1'
  s.date        = '2010-04-28'
  s.summary     = "compras_ventas"
  s.description = "A simple hello world gem"
  s.authors     = ["Martín Rosso"]
  s.email       = 'mrosso10@gmail.com'
  s.files       = ["lib/compras_ventas.rb", "lib/compras_ventas/saludador.rb"]
  s.homepage    =
    'http://rubygems.org/gems/compras_ventas'
  s.license       = 'MIT'

  s.add_dependency "actionview"
  s.add_dependency "activemodel"
  s.add_dependency "ascii"
  s.add_development_dependency "rspec"
  s.add_development_dependency "factory_bot"
  s.add_development_dependency "faker"
end
