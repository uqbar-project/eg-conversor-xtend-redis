package ar.com.uqbar.phm.conversorRedis.runnable

import ar.com.uqbar.phm.conversorRedis.ui.ConversorWindow
import org.uqbar.arena.Application
import org.uqbar.arena.bootstrap.Bootstrap
import org.uqbar.arena.windows.Window
import redis.clients.jedis.Jedis

class ConversorRedisApplication extends Application{

	static def void main(String[] args) {
		new ConversorRedisApplication(new ConversorRedisBootstrap()).start()
	}

	new(Bootstrap bootstrap) {
		super(bootstrap)
	}
	
	override protected Window<?> createMainWindow() {
		return new ConversorWindow(this)
	}
}

class ConversorRedisBootstrap implements Bootstrap {
	
	Jedis jedis = new Jedis("localhost")
	
	override isPending() {
		jedis.get("euro") === null
	}
	
	override run() {
		println("Running initial script")
		jedis => [
			del("dolar")
			lpush("dolar", "62.36")
			lpush("dolar", "44.48")
			del("euro")
			del("real")
			set("euro", "69.48")
			set("real", "13.6")
		]
	}
	
}
