FactoryBot.define do
  factory :compra, class: 'ComprasVentas::Compra' do
    fecha { Time.now }
    tipo_cbte { %w(factura_a factura_b factura_c nota_de_credito_a nota_de_credito_b nota_de_credito_c).sample.to_sym }
    trait :tipo_a do
      tipo_cbte { %w(factura_a nota_de_credito_a).sample.to_sym }
    end
  end
end
