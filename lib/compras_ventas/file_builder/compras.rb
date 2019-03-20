module ComprasVentas::FileBuilder
  class Compras < AbstractFileBuilder
    def lineas(comprobante)
      [linea(comprobante)]
    end

    def linea(comprobante)
      output = ''
      campos.each do |campo|
        output << FieldPrinter.new(comprobante).print(campo)
      end
      output
    end

    private

      def campos
        [
          :fecha,
          :tipo_cbte,
          :punto_de_venta,
          :numero,
          :despacho_importacion,
          :emisor_doc_tipo,
          :emisor_doc_nro,
          :emisor_razon_social,
          :total,
          :fe_imp_tot_conc,
          :fe_imp_op_ex,
          :percepciones_iva,
          :impuestos_nacionales,
          :ingresos_brutos,
          :impuestos_municipales,
          :impuestos_internos,
          :moneda,
          :tipo_cambio,
          :cant_alicuotas,
          :cod_operacion,
          :credito_fiscal_computable,
          :otros_tributos,
          :cuit_corredor,
          :denominacion_corredor,
          :iva_comision,
        ]
      end
  end
end
