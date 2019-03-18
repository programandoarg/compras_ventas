module ComprasVentas
  class Venta < Comprobante
    def campos_comprobante
      [
      :fecha,
      :tipo_cbte,
      :punto_de_venta,
      :numero,
      :numero,
      :doc_tipo,
      :doc_nro,
      :nombre_o_razon_social,
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
      :cant_alicuotas,
      :cod_operacion,
      :otros_tributos,
      :fecha_venc_pago,
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
