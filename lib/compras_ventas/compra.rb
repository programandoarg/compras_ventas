module ComprasVentas
  class Compra < Comprobante
    # tipo_cbte
    # gravado_21
    # gravado_105
    # gravado_5
    # gravado_27
    # exento
    # no_gravado

    def campos_comprobante
      [
      :fecha,
      :tipo_cbte,
      :punto_de_venta,
      :numero,
      :despacho_importacion,
      :doc_tipo,
      :doc_nro,
      :nombre_o_razon_social,
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

    def campos_alicuotas
      [
        :tipo_cbte,
        :punto_de_venta,
        :numero,
        :doc_tipo,
        :doc_nro,
        :base_imponible_alicuota,
        :tipo_alicuota,
        :importe_alicuota,
      ]
    end
  end
end
