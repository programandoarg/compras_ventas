module ComprasVentas
  require 'ascii'
  if defined?(Rails)
    require 'compras_ventas/engine'
  else
    require 'action_view'
    require 'active_model'
    require 'ostruct'
    require 'spreadsheet'
    require 'compras_ventas/file_builder/abstract_file_builder'
    require 'compras_ventas/file_builder/abstract_excel_builder'
    require 'compras_ventas/file_builder/compras'
    require 'compras_ventas/file_builder/compras_alicuotas'
    require 'compras_ventas/file_builder/compras_excel'
    require 'compras_ventas/file_builder/ventas'
    require 'compras_ventas/file_builder/ventas_alicuotas'
    require 'compras_ventas/file_builder/ventas_excel'
    require 'compras_ventas/file_builder/field_printer'
    require 'compras_ventas/alicuotas'
    require 'compras_ventas/tipo_cbte'
    require 'compras_ventas/comprobante'
  end
end
