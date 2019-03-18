module ComprasVentas
  RSpec.describe Venta do
    describe 'cuando genero una linea para un comprobante' do
      let(:venta) { create :venta }
      let(:field_printer) { FieldPrinter.new(comprobante) }

      context 'la linea ocupa 266 caracteres' do
        it do
          expect(venta.linea_comprobantes.size).to eq 266
        end
      end

      shared_examples 'alicuotas' do |fields|
        let(:venta) { create :venta, :tipo_a, fields }
      end

      context 'cuando las alicuotas' do
        include_examples 'alicuotas', {gravado_21: 100, gravado_105: 50}
        it do
          # binding.pry
          expect(venta.lineas_alicuotas.size).to eq 2
        end
      end
      context 'cuando las alicuotas' do
        include_examples 'alicuotas', {exento: 100 }
        it { expect(venta.lineas_alicuotas.size).to eq 1 }
      end

      shared_examples 'abstract' do |field, value, method_name, expected_return|
        let(:venta) { create :venta, field => value }
        it 'is ok' do
          expect(FieldPrinter.new(venta).send(method_name)).to eq expected_return
        end
      end

      context 'fecha' do
        it_behaves_like 'abstract', 'fecha', Date.parse('2005/11/12'), 'fecha', '20051112'
        it_behaves_like 'abstract', 'fecha', Date.parse('2013/12/31'), 'fecha', '20131231'
      end

      context 'tipo_cbte' do
        it_behaves_like 'abstract', 'tipo_cbte', :factura_b, 'tipo_cbte', '006'
        it_behaves_like 'abstract', 'tipo_cbte', :factura_a, 'tipo_cbte', '001'
        it_behaves_like 'abstract', 'tipo_cbte', :nota_de_credito_a, 'tipo_cbte', '003'
      end

      context 'punto_de_venta' do
        it_behaves_like 'abstract', 'punto_de_venta', 5, 'punto_de_venta', '00005'
        it_behaves_like 'abstract', 'punto_de_venta', 99999, 'punto_de_venta', '99999'
      end

      context 'numero' do
        it_behaves_like 'abstract', 'numero', 5, 'numero', '00000000000000000005'
        it_behaves_like 'abstract', 'numero', 99999, 'numero', '00000000000000099999'
        it_behaves_like 'abstract', 'numero', 99999999, 'numero', '00000000000099999999'
      end

      # shared_examples 'cliente' do |cliente_field, cliente_value, method_name, expected_return|
      #   let(:cliente) { create :cliente, cliente_field => cliente_value }
      #   let(:comprobante) { create :comprobante_con_items, cliente: cliente, consumidor_final: false }
      #   it 'is ok' do
      #     expect(subject.send(method_name)).to eq expected_return
      #   end
      # end

      context 'doc_tipo' do
        # it_behaves_like 'abstract', 'doc_nro', '12345678901', 'doc_tipo', '80'
        it_behaves_like 'abstract', 'doc_nro', nil, 'doc_tipo', '99'
      end

      context 'doc_nro' do
        it_behaves_like 'abstract', 'doc_nro', '12345678901', 'doc_nro', '00000000012345678901'
        it_behaves_like 'abstract', 'doc_nro', nil, 'doc_nro', '00000000099999999999'
      end

      context 'nombre_o_razon_social' do
        it_behaves_like 'abstract', 'nombre_o_razon_social', 'HOLA', 'nombre_o_razon_social', 'HOLA                          '
        it_behaves_like 'abstract', 'nombre_o_razon_social', 'JUAN Roberto Carlos JUAN Roberto Carlos JUAN Roberto Carlos', 'nombre_o_razon_social', 'JUAN ROBERTO CARLOS JUAN ROBER'
      end

      shared_examples 'items' do |fields, method_name, expected_return|
        let(:venta) { create :venta, fields }
        it 'is ok' do
          expect(FieldPrinter.new(venta).send(method_name)).to eq expected_return
        end
      end

      context 'total' do
        it_behaves_like 'items', { no_gravado: 100}, 'total', '000000000010000'
        it_behaves_like 'items', { no_gravado: 100, gravado_21: 1000}, 'total', '000000000131000'
      end

      context 'fe_imp_tot_conc' do
        it_behaves_like 'items', { gravado_21: 100}, 'fe_imp_tot_conc', '000000000000000'
      end

      context 'perc_a_no_categorizados' do
        it_behaves_like 'items', { gravado_21: 100}, 'perc_a_no_categorizados', '000000000000000'
      end

      context 'fe_imp_op_ex' do
        it_behaves_like 'items', { gravado_21: 100 }, 'fe_imp_op_ex', '000000000000000'
        it_behaves_like 'items', { exento: 100 }, 'fe_imp_op_ex', '000000000010000'
      end

      context 'impuestos_nacionales' do
        it_behaves_like 'items', {gravado_21: 100}, 'impuestos_nacionales', '000000000000000'
      end

      context 'impuestos_internos' do
        it_behaves_like 'items', {gravado_21: 100}, 'impuestos_internos', '000000000000000'
      end

      context 'moneda' do
        it_behaves_like 'items', {gravado_21: 100}, 'moneda', 'PES'
        it_behaves_like 'items', {gravado_21: 100, moneda: :dolares}, 'moneda', 'DOL'
      end

      context 'tipo_cambio' do
        it_behaves_like 'items', {moneda_cotizacion: 1}, 'tipo_cambio', '0001000000'
        it_behaves_like 'items', {moneda_cotizacion: 42.1235}, 'tipo_cambio', '0042123500'
      end

      context 'cant_alicuotas' do
        it_behaves_like 'items', {exento: 7}, 'cant_alicuotas', '1'
        it_behaves_like 'items', {gravado_21: 100}, 'cant_alicuotas', '1'
        it_behaves_like 'items', {gravado_5: 100}, 'cant_alicuotas', '1'
        it_behaves_like 'items', {gravado_21: 100, gravado_27: 10}, 'cant_alicuotas', '2'
        it_behaves_like 'items', {gravado_21: 100, gravado_105: 40, exento: 100}, 'cant_alicuotas', '2'
      end

      context 'cod_operacion' do
        it_behaves_like 'items', {gravado_21: 0, exento: 70}, 'cod_operacion', 'E'
        # it_behaves_like 'items', {importe: 100}, 'cod_operacion', 'A'
        it_behaves_like 'items', {gravado_21: 50}, 'cod_operacion', '0'
        it_behaves_like 'items', {gravado_21: 0, no_gravado: 100}, 'cod_operacion', 'N'
      end
    end
  end
end
