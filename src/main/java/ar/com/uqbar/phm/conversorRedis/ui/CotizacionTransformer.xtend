package ar.com.uqbar.phm.conversorRedis.ui

import java.math.BigDecimal

class CotizacionTransformer extends BigDecimalTransformer{

	override modelToView(BigDecimal valueFromModel) {
		return "(cotizando a $ " + convertirBigDecimalATexto(valueFromModel) + ")"
	}

}