console.log('hello cercanias');
//Define the LungoJS Application Instance
Lungo.init({
    name: "Cercanias",
    version: "0.1"
});

Lungo.ready(function() {
	Lungo.Service.get('http://renfeapi.herokuapp.com/zones', {}, function (data) {
		console.log(data);
	});
});

window.App = {};