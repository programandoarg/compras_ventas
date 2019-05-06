module ComprasVentas::FileBuilder
  class Ventas < AbstractFileBuilder
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
          :numero,
          :receptor_doc_tipo,
          :receptor_doc_nro,
          :receptor_razon_social,
          :total,
          :fe_imp_tot_conc,
          :perc_a_no_categorizados,
          :fe_imp_op_ex,
          :impuestos_nacionales,
          :ingresos_brutos,
          :impuestos_municipales,
          :impuestos_internos,
          :moneda,
          :tipo_cambio,
          :cant_alicuotas_ventas,
          :cod_operacion,
          :otros_tributos,
          :fecha_venc_pago,
        ]
      end
  end
end
