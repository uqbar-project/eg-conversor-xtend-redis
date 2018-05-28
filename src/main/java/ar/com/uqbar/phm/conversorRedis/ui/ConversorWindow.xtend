package ar.com.uqbar.phm.conversorRedis.ui

import ar.com.uqbar.phm.conversorRedis.viewModel.ConversorModel
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class ConversorWindow extends SimpleWindow<ConversorModel> {

	new(WindowOwner parent, ConversorModel model) {
		super(parent, model)
	}

	new(WindowOwner parent) {
		super(parent, new ConversorModel())
		title = "Conversor de monedas"
	}

	override protected addActions(Panel actionsPanel) {
		new Button(actionsPanel) => [
			caption = "Cerrar"
			onClick([|this.close])
			setAsDefault
		]
	}

	override protected createFormPanel(Panel mainPanel) {

		val panelPrincipal = new Panel(mainPanel).layout = new ColumnLayout(2)
		new Panel(panelPrincipal) => [
			layout = new ColumnLayout(2)
			new Label(it) => [
				text = "Monto en pesos"
				width = 110
			]
			new TextBox(it) => [
				width = 130
				(value <=> "valor").transformer = new BigDecimalTransformer()
			]
			new Button(it) => [
				caption = "convertir"
				onClick [ | modelObject.buscarCotizacion ]
				enabled <=> "habilitarCotizacion"
			]
		]
		new Panel(panelPrincipal) => [
			layout = new ColumnLayout(3)
			createConversionPanel(it, "Dolares", "dolarActual")
			createConversionPanel(it, "Dolares (anterior)", "dolarPrevio")
			createConversionPanel(it, "Euros", "euro")
			createConversionPanel(it, "Reales", "real")
		]

	}

	def createConversionPanel(Panel parentPanel, String label, String property) {
		new Label(parentPanel) => [
			minWidth = 130
			alignLeft()
			text = label
		]
		new Label(parentPanel) => [
			minWidth = 60
			(value <=> property).transformer = new BigDecimalTransformer()
		]
		new Label(parentPanel) => [
			width = 150	
			(value <=> "cotizacion".concat(property.toFirstUpper)).transformer = new CotizacionTransformer()
		]
		
	}
}
