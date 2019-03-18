module ComprasVentas
  if defined?(Rails)
    require 'compras_ventas/engine'
  else
    require 'compras_ventas/hola_mundo'
  end
end
