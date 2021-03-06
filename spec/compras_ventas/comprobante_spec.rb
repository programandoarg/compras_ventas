module ComprasVentas
  RSpec.describe Comprobante do
    describe 'cuando genero una linea para una comprobante' do
      let(:comprobante) { build :comprobante }

      it 'es válido' do
        expect(comprobante).to be_valid
      end

      context 'si el total es cero' do
        let(:comprobante) { build :comprobante, :cero }
        it 'no es válido' do
          expect(comprobante).not_to be_valid
        end
      end

      context 'si el tipo es cualquiera' do
        let(:comprobante) { build :comprobante, tipo_cbte: 192837 }
        it 'no es válido' do
          expect(comprobante).not_to be_valid
        end
      end

      context 'si el tipo es nulo' do
        let(:comprobante) { build :comprobante, tipo_cbte: nil }
        it 'no es válido' do
          expect(comprobante).not_to be_valid
        end
      end

      # context 'si el total es cero' do
      #   let(:gravado_21) { rand(1..10000)}
      #   let(:gravado_5) { rand(1..10000)}
      #   let(:comprobante) { build :comprobante, :cero }
      #   it 'no es válido' do
      #     expect(comprobante).not_to be_valid
      #   end
      # end

    #   context 'la linea ocupa 325 caracteres' do
    #     it do
    #       expect(comprobante.linea_comprobantes.size).to eq 325
    #     end
    #   end

    #   shared_examples 'alicuotas' do |attributes|
    #     let(:comprobante) { build :comprobante, :tipo_a, attributes }
    #   end

    #   context 'cuando las alicuotas' do
    #     include_examples 'alicuotas', {gravado_21: 100}
    #     it { expect(comprobante.lineas_alicuotas.size).to eq 1 }
    #   end

    #   context 'cuando las alicuotas' do
    #     include_examples 'alicuotas', {gravado_21: 100, gravado_105: 30 }
    #     it { expect(comprobante.lineas_alicuotas.size).to eq 2 }
    #   end

    #   subject { FieldPrinter.new(comprobante) }

    #   shared_examples 'fields' do |fields, method_name, expected_return|
    #     let(:comprobante) { build :comprobante, :tipo_a, fields }
    #     it 'is ok' do
    #       expect(subject.print(method_name)).to eq expected_return
    #     end
    #   end

    #   context 'fecha' do
    #     it_behaves_like 'fields', { fecha: Date.parse('2005/11/12') }, 'fecha', '20051112'
    #     it_behaves_like 'fields', { fecha: Date.parse('2013/12/31') }, 'fecha', '20131231'
    #   end

    #   context 'tipo_cbte' do
    #     it_behaves_like 'fields', { tipo_cbte: :factura_a }, 'tipo_cbte', '001'
    #     it_behaves_like 'fields', { tipo_cbte: :factura_b }, 'tipo_cbte', '006'
    #     it_behaves_like 'fields', { tipo_cbte: :nota_de_credito_c }, 'tipo_cbte', '013'
    #   end

    #   context 'punto_de_venta' do
    #     it_behaves_like 'fields', { punto_de_venta: 5 }, 'punto_de_venta', '00005'
    #     it_behaves_like 'fields', { punto_de_venta: 9999 }, 'punto_de_venta', '09999'
    #   end

    #   context 'numero' do
    #     it_behaves_like 'fields', { numero: 5 }, 'numero', '00000000000000000005'
    #     it_behaves_like 'fields', { numero: 99999 }, 'numero', '00000000000000099999'
    #     it_behaves_like 'fields', { numero: 99999999 }, 'numero', '00000000000099999999'
    #   end

    #   context 'despacho_importacion' do
    #     it_behaves_like 'fields', {}, 'despacho_importacion', '                '
    #   end

    #   context 'total' do
    #     it_behaves_like 'fields', {gravado_21: 100}, 'total', '000000000012100'
    #     it_behaves_like 'fields', {gravado_21: 100, exento: 200.26}, 'total', '000000000032126'
    #     it_behaves_like 'fields', {gravado_5: 48.12, exento: 200.26}, 'total', '000000000025079'
    #   end

    #   context 'fe_imp_tot_conc' do
    #     it_behaves_like 'fields', {gravado_5: 48.12, exento: 200.26}, 'fe_imp_tot_conc', '000000000000000'
    #     it_behaves_like 'fields', {no_gravado: 48.12, exento: 200.26}, 'fe_imp_tot_conc', '000000000004812'
    #   end

    #   context 'fe_imp_op_ex' do
    #     it_behaves_like 'fields', {no_gravado: 48.12, exento: 200.26}, 'fe_imp_op_ex', '000000000020026'
    #     it_behaves_like 'fields', {no_gravado: 48.12}, 'fe_imp_op_ex', '000000000000000'
    #   end

    #   context 'percepciones_iva' do
    #     it_behaves_like 'fields', {iva_3: 10.26}, 'percepciones_iva', '000000000001026'
    #     it_behaves_like 'fields', {iva_3: 10.26, iva_15: 3.11}, 'percepciones_iva', '000000000001337'
    #   end

    #   context 'impuestos_nacionales' do
    #     it_behaves_like 'fields', {}, 'impuestos_nacionales', '000000000000000'
    #   end
      
    #   context 'ingresos_brutos' do
    #     it_behaves_like 'fields', {}, 'ingresos_brutos', '000000000000000'
    #     it_behaves_like 'fields', {iibb_ba: 123.32}, 'ingresos_brutos', '000000000012332'
    #   end

    #   context 'impuestos_municipales' do
    #     it_behaves_like 'fields', {}, 'impuestos_municipales', '000000000000000'
    #   end

    #   context 'impuestos_internos' do
    #     it_behaves_like 'fields', {}, 'impuestos_internos', '000000000000000'
    #     it_behaves_like 'fields', {gas_oil: 15.19}, 'impuestos_internos', '000000000001519'
    #   end

    #   context 'moneda' do
    #     it_behaves_like 'fields', {}, 'moneda', 'PES'
    #   end

    #   context 'tipo_cambio' do
    #     it_behaves_like 'fields', {}, 'tipo_cambio', '0001000000'
    #   end

    #   context 'cant_alicuotas' do
    #     it_behaves_like 'fields', {gravado_21: 7}, 'cant_alicuotas', '1'
    #     it_behaves_like 'fields', {gravado_21: 7, gravado_105: 12}, 'cant_alicuotas', '2'
    #     it_behaves_like 'fields', {gravado_21: 7, gravado_105: 12, exento: 123, gravado_5: 2.12, no_gravado: 111}, 'cant_alicuotas', '3'
    #     it_behaves_like 'fields', {exento: 12}, 'cant_alicuotas', '1'
    #   end

    #   context 'cod_operacion' do
    #     it_behaves_like 'fields', {}, 'cod_operacion', '0'
    #     it_behaves_like 'fields', {gravado_21: 3, no_gravado: 123}, 'cod_operacion', '0'
    #     it_behaves_like 'fields', {no_gravado: 3}, 'cod_operacion', 'N'
    #     it_behaves_like 'fields', {exento: 3}, 'cod_operacion', 'E'
    #     it_behaves_like 'fields', {exento: 3, no_gravado: 123}, 'cod_operacion', 'E'
    #   end

    #   # shared_examples 'provider' do |provider_field, provider_value, method_name, expected_return|
    #   #   let(:provider) { create :provider, provider_field => provider_value }
    #   #   let(:comprobante) { build :comprobante, provider: provider }
    #   #   it 'is ok' do
    #   #     expect(subject.field(method_name)).to eq expected_return
    #   #   end
    #   # end

    #   context 'receptor_doc_tipo' do
    #     it_behaves_like 'fields', {}, 'receptor_doc_tipo', '99'
    #   end

    #   context 'receptor_doc_nro' do
    #     it_behaves_like 'fields', {receptor_doc_nro: 12345678901}, 'receptor_doc_nro', '00000000012345678901'
    #   end

    #   context 'emisor_razon_social' do
    #     it_behaves_like 'fields', { emisor_razon_social: 'HOLA'}, 'emisor_razon_social', 'HOLA                          '
    #     it_behaves_like 'fields', { emisor_razon_social: 'JUAN Roberto Carlos JUAN Roberto Carlos JUAN Roberto Carlos'}, 'emisor_razon_social', 'JUAN ROBERTO CARLOS JUAN ROBER'
    #   end
    end
  end
end
