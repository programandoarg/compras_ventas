FactoryBot.define do
  factory :comprobante, class: 'ComprasVentas::Comprobante' do
    fecha { Time.now }
    punto_de_venta { rand(1..20) }
    numero { rand(1..9999) }
    emisor_doc_tipo { 80 }
    emisor_doc_nro { rand(10000000000..90000000000) }
    emisor_razon_social { Faker::Lorem.sentence }
    receptor_razon_social { Faker::Lorem.sentence }
    tipo_cbte { ComprasVentas::TipoCbte.all.sample }
    gravado_21 { rand(1..20000) }
    gravado_105 { rand(1..20000) }
    gravado_5 { rand(1..20000) }
    gravado_27 { rand(1..20000) }
    exento { rand(1..20000) }
    no_gravado { rand(1..20000) }
    iibb_ba { rand(1..20000) }
    gas_oil { rand(1..20000) }
    percepcion_iva { rand(1..20000) }
    trait :tipo_a do
      tipo_cbte { ComprasVentas::TipoCbte.tipos_a.sample }
    end
    trait :cero do
      gravado_21 { 0 }
      gravado_105 { 0 }
      gravado_5 { 0 }
      gravado_27 { 0 }
      exento { 0 }
      no_gravado { 0 }
      iibb_ba { 0 }
      gas_oil { 0 }
      percepcion_iva { 0 }
    end
  end
end
