module ComprasVentas::FileBuilder
  class FieldPrinter
    class ComprobanteInvalido < StandardError
      attr_reader :comprobante

      def initialize(comprobante)
        @comprobante = comprobante
        super(@comprobante.errors.full_messages.join(', '))
      end
    end

    include ActionView::Helpers::NumberHelper

    def initialize(comprobante, alicuota = nil)
      @comprobante = comprobante
      @alicuota = alicuota
    end

    def print(field)
      unless @comprobante.valid?
        raise ComprobanteInvalido.new(@comprobante)
      end
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

    def emisor_doc_tipo
      pad(@comprobante.emisor_doc_tipo, 2)
    end

    def emisor_doc_nro
      pad(@comprobante.emisor_doc_nro, 20)
    end

    def receptor_doc_tipo
      pad(@comprobante.receptor_doc_tipo, 2)
    end

    def receptor_doc_nro
      pad(@comprobante.receptor_doc_nro, 20)
    end

    def moneda
      if @comprobante.moneda == :dolares
        'DOL'
      else
        'PES'
      end
    end

    def tipo_cambio
      npad(@comprobante.moneda_cotizacion, 10, 6)
    end

    def fecha_venc_pago
      '00000000'
    end

    def base_imponible_alicuota
      npad(@alicuota[:base_imponible], 15)
    end

    def importe_alicuota
      npad(@alicuota[:importe], 15)
    end

    def codigo_alicuota_afip
      pad(@alicuota[:codigo_alicuota_afip], 4)
    end

    # Compras

    def tipo_cbte
      pad(ComprasVentas::TipoCbte.hash[@comprobante.tipo_cbte][:codigo_cbte_afip], 3)
    end

    def despacho_importacion
      '                '
    end

    def receptor_razon_social
      lpad(::Ascii.process(@comprobante.receptor_razon_social), 30).upcase
    end

    def emisor_razon_social
      lpad(::Ascii.process(@comprobante.emisor_razon_social), 30).upcase
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
      npad((@comprobante.percepcion_iva || 0), 15)
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


    def cant_alicuotas_ventas
      ComprasVentas::Alicuotas.get_ventas(@comprobante).count.to_s
    end

    def cant_alicuotas_compras
      ComprasVentas::Alicuotas.get_compras(@comprobante).count.to_s
      # if @comprobante.es_tipo_a?
      #   cantidad = ComprasVentas::Alicuotas.get(@comprobante).count
      #   return '1' unless cantidad > 0
      #   cantidad.to_s
      # else
      #   '0'
      # end
    end

    def cod_operacion
      return '0' if calcular_credito_fiscal > 0
      return 'E' if (@comprobante.exento || 0) > 0
      return 'N' if (@comprobante.no_gravado || 0) > 0
      '0'
    end

    def credito_fiscal_computable
      npad(calcular_credito_fiscal, 15)
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

    # def tipo_cbte
    #   pad(@comprobante.tipo_cbte, 3)
    # end

    # def nombre_o_razon_social
    #   lpad(::Ascii.process(@comprobante.nombre_o_razon_social), 30).upcase
    # end

    # def total
    #   npad(@comprobante.total, 15)
    # end

    # def fe_imp_tot_conc
    #   npad(@comprobante.fe_imp_tot_conc, 15)
    # end

    def perc_a_no_categorizados
      npad(0, 15)
    end

    # def fe_imp_op_ex
    #   npad(@comprobante.fe_imp_op_ex, 15)
    # end

    def impuestos_nacionales
      npad(0, 15)
    end

    # def ingresos_brutos
    #   npad(0, 15)
    # end

    def impuestos_municipales
      npad(0, 15)
    end

    # def impuestos_internos
    #   npad(0, 15)
    # end

    def otros_tributos
      '000000000000000'
    end

    private

      def calcular_credito_fiscal
        ((@comprobante.gravado_21 || 0) * 0.21).round(2) +
        ((@comprobante.gravado_105 || 0) * 0.105).round(2) +
        ((@comprobante.gravado_5 || 0) * 0.05).round(2) +
        ((@comprobante.gravado_27 || 0) * 0.27).round(2)
      end

      def inferir_doc_tipo
        return 99 if @comprobante.receptor_doc_nro.blank?
        raise 'doc_tipo no puede estar en blanco'
      end

      def lpad(value, length)
        value.to_s.truncate(length, omission: '').gsub(/\t/, ' ').ljust(length)
      end

      def pad(value, length)
        value.to_s.rjust(length, '0')
      end

      def npad(value, length, precision = 2)
        pad(number_with_precision(value, delimiter: "", separator: "", precision: precision), length)
      end

      # def cnpad(value, length)
      #   pad(number_with_precision(value, delimiter: "", separator: ",", precision: 2), length)
      # end

      def space(number = 1)
        ' ' * number
      end
  end
end
