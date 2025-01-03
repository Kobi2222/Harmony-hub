class TaxRate < ApplicationRecord
    def self.province_tax_rates
        {
            "Alberta" => { gst: 0.05, pst: 0, hst: 0 },
            "Ontario" => { gst: 0, pst: 0, hst: 0.13 },
            "Manitoba" => { gst: 0.05, pst: 0.07, hst: 0 },
        }
    end
end  