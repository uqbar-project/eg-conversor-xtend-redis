package ar.com.uqbar.phm.conversorRedis.viewModel

import ar.com.uqbar.phm.conversorRedis.domain.ConversorFactory
import java.math.BigDecimal
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class ConversorModel {
	BigDecimal valor
	BigDecimal dolarActual
	BigDecimal cotizacionDolarActual
	BigDecimal dolarPrevio
	BigDecimal cotizacionDolarPrevio
	BigDecimal euro
	BigDecimal cotizacionEuro
	BigDecimal real
	BigDecimal cotizacionReal

	def void buscarCotizacion() {
		dolarActual = ConversorFactory.instance.conversorDolares.convertir(valor)
		cotizacionDolarActual = ConversorFactory.instance.conversorDolares.cotizacionDeMoneda
		dolarPrevio = ConversorFactory.instance.conversorDolaresPrevio.convertir(valor)
		cotizacionDolarPrevio = ConversorFactory.instance.conversorDolaresPrevio.cotizacionDeMoneda
		euro = ConversorFactory.instance.conversorEuros.convertir(valor)
		cotizacionEuro = ConversorFactory.instance.conversorEuros.cotizacionDeMoneda
		real = ConversorFactory.instance.conversorReales.convertir(valor)
		cotizacionReal = ConversorFactory.instance.conversorReales.cotizacionDeMoneda
	}
	
	@Dependencies("valor")
	def getHabilitarCotizacion() {
		valor !== null
	}

}
