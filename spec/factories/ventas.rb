FactoryBot.define do
  factory :compras_ventas_venta, class: 'ComprasVentas::Venta' do
    fecha { Time.now }
  end
end
