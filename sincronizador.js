var redis = require('redis');

var client = redis.createClient(); 

client.on('connect', function() {
    console.log('connected');
    client.lpop("dolar", redis.print);
    client.rpush("dolar","24.0", redis.print);
    client.set("euro","25.2", redis.print);
    client.set("real","3.45", redis.print);
    client.quit();
    console.log("valores actualizados..");
});
client.on("error", function (err) {
    console.log("Error " + err);
});

