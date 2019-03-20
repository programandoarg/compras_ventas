module ComprasVentas
  class TipoCbte
    class << self
      def hash
        {
          factura_a: { codigo_cbte_afip: 1 },
          factura_b: { codigo_cbte_afip: 6 },
          factura_c: { codigo_cbte_afip: 11 },
          nota_de_credito_a: { codigo_cbte_afip: 3  },
          nota_de_credito_b: { codigo_cbte_afip: 8  },
          nota_de_credito_c: { codigo_cbte_afip: 13 },
        }
      end

      def all
        hash.keys
      end

      def tipos_a
        [:factura_a, :nota_de_credito_a]
      end
    end
  end
end
