module ComprasVentas
  RSpec.describe Venta do
    describe 'cuando genero una linea para un comprobante' do
      let(:venta) { create :compras_ventas_venta }
      let(:field_printer) { FieldPrinter.new(comprobante) }

      context 'la linea ocupa 266 caracteres' do
        it do
          expect(venta.linea_comprobantes.size).to eq 266
        end
      end

      # shared_examples 'alicuotas' do |items_fields|
      #   let(:items) do
      #     array = []
      #     items_fields.each do |attributes|
      #       array << (build :item, attributes)
      #     end
      #     array
      #   end
      #   let(:comprobante) { create :comprobante, :afip_syncable, items: items }
      # end

      # context 'cuando las alicuotas' do
      #   include_examples 'alicuotas', [{importe: 100}, {importe: 1000, tipo_iva: 0}, {importe: 1000, tipo_iva: 2}]
      #   it do
      #     expect(subject.generate_lines_alicuotas.size).to eq 2
      #   end
      # end
      # context 'cuando las alicuotas' do
      #   include_examples 'alicuotas', [{importe: 100, tipo_iva: 7}]
      #   it { expect(subject.generate_lines_alicuotas.size).to eq 1 }
      # end

      # shared_examples 'abstract' do |field, value, method_name, expected_return|
      #   let(:comprobante) { create :comprobante_con_items, field => value }
      #   it 'is ok' do
      #     expect(subject.send(method_name)).to eq expected_return
      #   end
      # end

      # context 'fecha' do
      #   it_behaves_like 'abstract', 'fecha', Date.parse('2005/11/12'), 'fecha', '20051112'
      #   it_behaves_like 'abstract', 'fecha', Date.parse('2013/12/31'), 'fecha', '20131231'
      # end

      # context 'tipo_cbte' do
      #   it_behaves_like 'abstract', 'type', 'Factura_B', 'tipo_cbte', '006'
      #   it_behaves_like 'abstract', 'type', 'Factura_A', 'tipo_cbte', '001'
      #   it_behaves_like 'abstract', 'type', 'NotaDeCredito', 'tipo_cbte', '003'
      # end

      # context 'punto_de_venta' do
      #   it_behaves_like 'abstract', 'punto_de_venta', 5, 'punto_de_venta', '00005'
      #   it_behaves_like 'abstract', 'punto_de_venta', 99999, 'punto_de_venta', '99999'
      # end

      # context 'numero' do
      #   it_behaves_like 'abstract', 'numero', 5, 'numero', '00000000000000000005'
      #   it_behaves_like 'abstract', 'numero', 99999, 'numero', '00000000000000099999'
      #   it_behaves_like 'abstract', 'numero', 99999999, 'numero', '00000000000099999999'
      # end

      # shared_examples 'cliente' do |cliente_field, cliente_value, method_name, expected_return|
      #   let(:cliente) { create :cliente, cliente_field => cliente_value }
      #   let(:comprobante) { create :comprobante_con_items, cliente: cliente, consumidor_final: false }
      #   it 'is ok' do
      #     expect(subject.send(method_name)).to eq expected_return
      #   end
      # end

      # context 'doc_tipo' do
      #   it_behaves_like 'cliente', 'cuit', '12345678901', 'doc_tipo', '80'
      #   it_behaves_like 'cliente', 'cuit', nil, 'doc_tipo', '99'
      # end

      # context 'doc_nro' do
      #   it_behaves_like 'cliente', 'cuit', '12345678901', 'doc_nro', '00000000012345678901'
      #   it_behaves_like 'cliente', 'cuit', nil, 'doc_nro', '00000000099999999999'
      # end

      # context 'nombre' do
      #   it_behaves_like 'cliente', 'nombre', 'HOLA', 'nombre', 'HOLA                          '
      #   it_behaves_like 'cliente', 'nombre', 'JUAN Roberto Carlos JUAN Roberto Carlos JUAN Roberto Carlos', 'nombre', 'JUAN ROBERTO CARLOS JUAN ROBER'
      # end

      # shared_examples 'items' do |items_fields, method_name, expected_return|
      #   let(:items) do
      #     array = []
      #     items_fields.each do |attributes|
      #       array << (build :item, attributes)
      #     end
      #     array
      #   end
      #   let(:comprobante) { create :comprobante, items: items }
      #   it 'is ok' do
      #     expect(subject.send(method_name)).to eq expected_return
      #   end
      # end

      # context 'total' do
      #   it_behaves_like 'items', [{importe: 100}], 'total', '000000000010000'
      #   it_behaves_like 'items', [{importe: 100}, {importe: 1000, tipo_iva: 0}], 'total', '000000000131000'
      # end

      # context 'fe_imp_tot_conc' do
      #   it_behaves_like 'items', [{importe: 100, tipo_iva: 0}], 'fe_imp_tot_conc', '000000000000000'
      # end

      # context 'perc_a_no_categorizados' do
      #   it_behaves_like 'items', [{importe: 100}], 'perc_a_no_categorizados', '000000000000000'
      # end

      # context 'fe_imp_op_ex' do
      #   it_behaves_like 'items', [{importe: 100}], 'fe_imp_op_ex', '000000000000000'
      #   it_behaves_like 'items', [{importe: 100, tipo_iva: 7}], 'fe_imp_op_ex', '000000000010000'
      # end

      # context 'impuestos_nacionales' do
      #   it_behaves_like 'items', [{importe: 100}], 'impuestos_nacionales', '000000000000000'
      # end

      # context 'impuestos_internos' do
      #   it_behaves_like 'items', [{importe: 100}], 'impuestos_internos', '000000000000000'
      # end

      # context 'moneda' do
      #   it_behaves_like 'items', [{importe: 100}], 'moneda', 'PES'
      # end

      # context 'tipo_cambio' do
      #   it_behaves_like 'items', [{importe: 100}], 'tipo_cambio', '0001000000'
      # end

      # context 'cant_alicuotas' do
      #   it_behaves_like 'items', [{importe: 100, tipo_iva: 7}], 'cant_alicuotas', '1'
      #   it_behaves_like 'items', [{importe: 100}], 'cant_alicuotas', '1'
      #   it_behaves_like 'items', [{importe: 100},{importe: 100, tipo_iva: 3}], 'cant_alicuotas', '1'
      #   it_behaves_like 'items', [{importe: 100, tipo_iva: 1},{importe: 100, tipo_iva: 2}], 'cant_alicuotas', '2'
      #   it_behaves_like 'items', [{importe: 100, tipo_iva: 1},{importe: 100, tipo_iva: 2},{importe: 100, tipo_iva: 7}], 'cant_alicuotas', '2'
      # end

      # context 'cod_operacion' do
      #   it_behaves_like 'items', [{importe: 100, tipo_iva: 7}], 'cod_operacion', 'E'
      #   # it_behaves_like 'items', [{importe: 100}], 'cod_operacion', 'A'
      #   it_behaves_like 'items', [{importe: 100},{importe: 100, tipo_iva: 3}], 'cod_operacion', '0'
      #   it_behaves_like 'items', [{importe: 100, tipo_iva: 1},{importe: 100, tipo_iva: 2}], 'cod_operacion', '0'
      # end
    end
  end
end
