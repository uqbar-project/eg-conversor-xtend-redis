package ar.com.uqbar.phm.conversorRedis.ui

import java.math.BigDecimal
import org.uqbar.arena.bindings.ValueTransformer
import org.uqbar.commons.model.exceptions.UserException

class BigDecimalTransformer implements ValueTransformer<BigDecimal, String> {

	override getModelType() {
		BigDecimal
	}

	override getViewType() {
		String
	}

	override modelToView(BigDecimal valueFromModel) {
		convertirBigDecimalATexto(valueFromModel)
	}

	def convertirBigDecimalATexto(BigDecimal aValue){
		aValue.setScale(3,BigDecimal.ROUND_HALF_UP).toString
	}
	
	override viewToModel(String valueFromView) {
		if (valueFromView == "")
			new BigDecimal(0)
		else
			try
				new BigDecimal(valueFromView)
			catch (NumberFormatException e)
				throw new UserException("El valor ingresado debe ser un número", e)

	}
}
