module ComprasVentas
  class FieldPrinter
    include Utilidades

    def initialize(comprobante, alicuota = nil)
      @comprobante = comprobante
      @alicuota = alicuota
    end

    def field(field)
      send(field)
    end

    # Genéricos

    def fecha
      @comprobante.fecha.strftime('%Y%m%d')
    end

    def punto_de_venta
      pad(@comprobante.punto_de_venta.to_s, 5)
    end

    def numero
      pad(@comprobante.numero.to_s, 20)
    end

    def doc_tipo
      pad(@comprobante.doc_tipo, 2)
    end

    def doc_nro
      pad(@comprobante.doc_nro || 99999999999, 20)
    end

    def moneda
      'PES'
    end

    def tipo_cambio
      '0001000000'
    end

    def fecha_venc_pago
      '00000000'
    end

    # Compras

    def tipo_cbte
      pad(Compra.detalle_tipos[@comprobante.tipo_cbte][:tipo_afip], 3)
    end

    def despacho_importacion
      '                '
    end

    def nombre
      lpad(Ascii.process(@comprobante.provider.nombre), 30).upcase
    end

    def total
      npad(@comprobante.total, 15)
    end

    def fe_imp_tot_conc
      npad(@comprobante.no_gravado, 15)
    end

    def fe_imp_op_ex
      npad(@comprobante.exento, 15)
    end

    def percepciones_iva
      npad((@comprobante.iva_15 || 0) + (@comprobante.iva_3 || 0), 15)
    end

    def impuestos_nacionales
      npad(0, 15)
    end

    def ingresos_brutos
      npad((@comprobante.iibb_ba || 0), 15)
    end

    def impuestos_municipales
      npad(0, 15)
    end

    def impuestos_internos
      npad((@comprobante.gas_oil || 0), 15)
    end

    def cant_alicuotas
      if @comprobante.tipo_cbte == "factura_a"
        count = @comprobante.alicuotas.count
        return '1' unless count > 0
        count.to_s
      else
        '0'
      end
    end

    def cod_operacion
      count = @comprobante.alicuotas.count
      return '0' if count > 0
      return 'E' if (@comprobante.exento || 0) > 0
      return 'N' if (@comprobante.no_gravado || 0) > 0
      '0'
    end

    def credito_fiscal_computable
      npad(
        (@comprobante.gravado_21 || 0) * 0.21 +
        (@comprobante.gravado_105 || 0) * 0.105 +
        (@comprobante.gravado_5 || 0) * 0.05 +
        (@comprobante.gravado_27 || 0) * 0.27 \
      , 15)
    end

    def otros_tributos
      '000000000000000'
    end

    def cuit_corredor
      '00000000000'
    end

    def denominacion_corredor
      '                              '
    end
    
    def iva_comision
      '000000000000000'
    end

    # Ventas

    def tipo_cbte
      pad(@comprobante.tipo_cbte, 3)
    end

    def nombre
      lpad(Ascii.process(@comprobante.cliente), 30).upcase
    end

    def total
      npad(@comprobante.total, 15)
    end

    def fe_imp_tot_conc
      npad(@comprobante.fe_imp_tot_conc, 15)
    end

    def perc_a_no_categorizados
      npad(0, 15)
    end

    def fe_imp_op_ex
      npad(@comprobante.fe_imp_op_ex, 15)
    end

    def impuestos_nacionales
      npad(0, 15)
    end

    def ingresos_brutos
      npad(0, 15)
    end

    def impuestos_municipales
      npad(0, 15)
    end

    def impuestos_internos
      npad(0, 15)
    end

    def cant_alicuotas
      count = @comprobante.alicuotas.count
      return '1' unless count > 0
      count.to_s
    end

    def otros_tributos
      '000000000000000'
    end
  end
end
