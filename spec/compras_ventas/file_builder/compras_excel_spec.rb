describe ComprasVentas::FileBuilder::ComprasExcel do
  let(:comprobantes) { build_list :comprobante, 10 }
  let(:instancia) { described_class.new(comprobantes) }

  describe '#generate' do
    subject { instancia.generate }

    it 'runs' do
      subject
    end
  end

  describe '#multiplicador' do
    subject { instancia.multiplicador(comprobante) }

    context 'si es factura' do
      let(:comprobante) { build :comprobante, tipo_cbte: :factura_e }

      it { is_expected.to eq 1 }
    end

    context 'si es nc' do
      let(:comprobante) { build :comprobante, tipo_cbte: :nota_de_credito_e }

      it { is_expected.to eq -1 }
    end
  end
end
