module ComprasVentas
  if defined?(Rails)
    require 'compras_ventas/engine'
  else
    require 'action_view'
    require 'ascii'
    require 'ostruct'
    require 'compras_ventas/file_builder'
    require 'compras_ventas/utilidades'
    require 'compras_ventas/comprobante'
    require 'compras_ventas/compra'
    require 'compras_ventas/field_printer'
    require 'compras_ventas/venta'
  end
end
