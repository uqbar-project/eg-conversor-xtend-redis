package ar.com.uqbar.phm.conversorRedis.domain

import java.math.BigDecimal
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Observable
@Accessors
class Conversor {
	BigDecimal cotizacionDeMoneda
	
	def BigDecimal convertir(BigDecimal unValor) {unValor / cotizacionDeMoneda} 
}
