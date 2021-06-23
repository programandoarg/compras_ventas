module ComprasVentas::FileBuilder
  class ComprasAlicuotas < AbstractFileBuilder
    def lineas(comprobante)
      ComprasVentas::Alicuotas.get_compras(comprobante).map { |alicuota| linea(comprobante, alicuota) }
    end

    def linea(comprobante, alicuota)
      output = ''
      campos.each do |campo|
        output << FieldPrinter.new(comprobante, alicuota).print(campo)
      end
      output
    end

    private

      def campos
        [
          :tipo_cbte,
          :punto_de_venta,
          :numero,
          :emisor_doc_tipo,
          :emisor_doc_nro,
          :base_imponible_alicuota,
          :codigo_alicuota_afip,
          :importe_alicuota,
        ]
      end
  end
end
