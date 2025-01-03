class TaxesController < ApplicationController
    def edit
        @tax_rate = TaxRate.find(params[:id])  # Assuming you have a model called `TaxRate` to store the rates
    end

    def update
        @tax_rate = TaxRate.find(params[:id])

        if @tax_rate.update(tax_rate_params)
            redirect_to tax_path, notice: 'Tax rate updated successfully.'
        else
            render :edit
        end
    end

    private

    def tax_rate_params
        params.require(:tax_rate).permit(:province, :rate)
    end
end
