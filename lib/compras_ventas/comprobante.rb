module ComprasVentas
  class Comprobante
    include ActiveModel::Validations

    attr_accessor :fuente, :fecha, :tipo_cbte, :punto_de_venta, :numero,
      :emisor_doc_tipo, :emisor_doc_nro, :emisor_razon_social, :detalles,
      :receptor_doc_tipo, :receptor_doc_nro, :receptor_razon_social,
      :gravado_21,
      :gravado_105,
      :gravado_5,
      :gravado_27,
      :gravado_25,
      :gravado_0,
      :exento,
      :no_gravado,
      :iibb_ba,
      :gas_oil,
      :percepcion_iva,
      :otros_impuestos,
      :moneda, :moneda_cotizacion

    # :emisor_iibb, :emisor_inicio_actividades, :emisor_condicion_iva, :condicion_venta, :concepto,  :receptor_condicion_iva,
    # :fecha_servicio_desde, :fecha_servicio_hasta, :fecha_vencimiento_pago, :cae, :vencimiento_cae,

    validates :fecha, :tipo_cbte, :punto_de_venta, :numero, :emisor_doc_tipo, :emisor_doc_nro,
      :emisor_razon_social, :receptor_doc_tipo, :receptor_doc_nro, :receptor_razon_social, presence: true

    validates :tipo_cbte, inclusion: TipoCbte.all
    validates :moneda, inclusion: [:pesos, :dolares]
    validates :numero, :punto_de_venta, numericality: { greater_than: 0 }
    validates :emisor_doc_nro, length: { is: 11 }, if: Proc.new { |a| a.emisor_doc_tipo == 80 }
    validates :receptor_doc_nro, length: { is: 11 }, if: Proc.new { |a| a.receptor_doc_tipo == 80 }
    validate :total_mayor_a_cero
    # validate :no_gravado_cero

    def total_mayor_a_cero
      return if total > 0
      errors.add(:total, 'debe ser mayor a cero')
    end

    # def no_gravado_cero
    #   return if es_tipo_a? || no_gravado == 0
    #   errors.add(:base, 'para comprobantes B o C el Total No Gravado debe ser igual a cero')
    # end

    def initialize
      self.moneda_cotizacion = 1
      self.moneda = :pesos
      self.receptor_doc_nro = 99999999999
      self.receptor_doc_tipo = 99
    end

    def es_tipo_a?
      ComprasVentas::TipoCbte.tipos_a.include? tipo_cbte.to_sym
    end

    def total
      (iibb_ba || 0) +
      (gas_oil || 0) +
      (no_gravado || 0) +
      (exento || 0) +
      (percepcion_iva || 0) +
      (gravado_21 || 0) +
      (gravado_105 || 0) +
      (gravado_27 || 0) +
      (gravado_5 || 0) +
      (gravado_21 || 0) * 0.21 +
      (gravado_105 || 0) * 0.105 +
      (gravado_27 || 0) * 0.27 +
      (gravado_5 || 0) * 0.05
    end

    def total_excel
      total +
      (otros_impuestos || 0)
    end
  end
end