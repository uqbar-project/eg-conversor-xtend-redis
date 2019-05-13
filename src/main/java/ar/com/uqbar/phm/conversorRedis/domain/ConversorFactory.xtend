package ar.com.uqbar.phm.conversorRedis.domain

import java.math.BigDecimal
import org.uqbar.commons.model.exceptions.UserException
import redis.clients.jedis.Jedis
import redis.clients.jedis.JedisPool
import redis.clients.jedis.JedisPoolConfig
import redis.clients.jedis.exceptions.JedisConnectionException

class ConversorFactory {
	var JedisPool jedisPool
	static ConversorFactory instance = null

	private new() {
		jedisPool = new JedisPool(new JedisPoolConfig, Constants.LOCALHOST)
	}

	static def getInstance() {
		if (instance === null) {
			instance = new ConversorFactory
		}
		instance
	}

	def Conversor conversorDolares() {
		new Conversor => [
			cotizacionDeMoneda = applyOnJedis(traerValorDeLista(Constants.DOLAR, 1))
		]
	}

	def Conversor conversorEuros() {
		new Conversor => [
			cotizacionDeMoneda = applyOnJedis(traerValor(Constants.EURO))
		]
	}

	def conversorDolaresPrevio() {
		new Conversor => [
			cotizacionDeMoneda = applyOnJedis(traerValorDeLista(Constants.DOLAR, 0))
		]
	}

	def conversorReales() {
		new Conversor => [
			cotizacionDeMoneda = applyOnJedis(traerValor(Constants.REAL))
		]
	}

	private def applyOnJedis((Jedis)=>String aBlock) {
		try {
			val jedis = jedisPool.resource
			val value = aBlock.apply(jedis)
			if (value === null) {
				throw new UserException("No hay datos de las monedas solicitadas")
			}
			val returnValue = new BigDecimal(value)
			jedis.close()
			returnValue
		} catch (JedisConnectionException e) {
			throw new UserException("Error de conexión a Redis")			
		}
	}

	private def traerValorDeLista(String key, int position) {
		return [ Jedis jedis|jedis.lindex(key, position)]
	}

	private def traerValor(String key) {
		return [Jedis jedis|jedis.get(key)]
	}
}
