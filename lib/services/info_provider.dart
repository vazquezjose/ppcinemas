class InfoProvider {
	static final branches = [ 'Tenochtitlan', 'Tlatelolco', 'Texcoco', 'Tlacopan' ];
	static const adultTicketCost = 90;
	static const childTicketCost = 70;
	static final functionSeats = [
		'AAAWWWWAAAOOAAAWWWWAAA',
		'AAAAAAAAAAAAAAAAAAAAAA',
		'AAAAAAAAAAXXAAAAAAAAAA',
		'AAAAAAAAAAAAAAAAAAAAAA',
		'OOOOOAAAAAAAAAAAAOOOOO',
		'OOOOOAAAAAAAAAAAAOOOOO',
		'OOOOOAAAAAAAAAAAAOOOOO',
		'AAAAAAAAAAAAAAAAAAAAAA',
		'AAAAAAAAAAAAAAAAAAAAAA',
		'AAAAAAAAAAAAAAAAAAAAAA',
		'AAAAAAAAAAAAAAAAAAAAAA'
	];
    static final movies = [
		{
			'id': 'gato-con-botas2',
			'title': 'Gato con botas: El último deseo',
			'synopsis': 'Una nueva aventura en el universo de Shrek en la que el valiente forajido Gato con Botas descubrirá que su pasión por el peligro y su desprecio por la seguridad le han pasado factura. Gato ha gastado ocho de sus nueve vidas, aunque perdió la cuenta en el camino. Recuperar esas vidas llevará al Gato con Botas a su búsqueda más increíble hasta el momento.',
			'duration': 100,
			'director': 'Joel Crawford',
			'genres': [
				'Comedia',
				'Aventuras',
				'Familiar',
				'Fantasía',
				'Suspenso'
			],
			'cast': [
				'Antonio Banderas',
				'Salma Hayek',
				'Harvey Guillén',
				'Florence Pugh',
				'Olivia Colman'
			],
			'poster': 'gato-con-botas2.jpg'
		},
		{
			'id': '1917',
			'title': '1917',
			'synopsis': 'En el apogeo de la Primera Guerra Mundial, dos jóvenes soldados británicos, Schofield y Blake tienen una misión aparentemente imposible. En una carrera contra el tiempo, deberán cruzar el territorio enemigo para entregar un mensaje que evitará un ataque mortal contra cientos de soldados, incluyendo al hermano de Blake entre ellos.',
			'duration': 119,
			'director': 'Sam Mendes',
			'genres': [
				'Bélica',
				'Épica',
				'Drama'
			],
			'cast': [
				'George MacKay',
				'Dean-Charles Chapman',
				'Benedict Cumberbatch',
				'Colin Firth',
				'Mark Strong'
			],
			'poster': '1917.jpg'
		},
		{
			'id': 'ambulancia',
			'title': 'Ambulancia',
			'synopsis': 'El veterano condecorado Will Sharp, desesperado por conseguir dinero para pagar las facturas médicas de su esposa, pide ayuda a la única persona que sabe que no debería: su hermano adoptivo Danny. Danny, un carismático criminal de profesión, le ofrece dar un gran golpe: el mayor atraco a un banco en la historia de Los Ángeles: 32 millones de dólares. Con la supervivencia de su esposa en juego, Will no puede negarse.',
			'duration': 136,
			'director': 'Michael Bay',
			'genres': [
				'Thriller',
				'Acción'
			],
			'cast': [
				'Jake Gyllenhaal',
				'Yahya Abdul-Mateen II',
				'Eiza González'
			],
			'poster': 'ambulancia.jpg'
		},
		{
			'id': 'dolittle',
			'title': 'Dolittle',
			'synopsis': 'Después de perder a su esposa siete años antes, el excéntrico Dr. John Dolittle, famoso médico y veterinario de la Inglaterra de la Reina Victoria, se refugia detrás de los altos muros de Dolittle Manor con su colección de animales exóticos como única compañía.',
			'duration': 102,
			'director': 'Stephen Gaghan',
			'genres': [
				'Aventuras',
				'Fantasía',
				'Comedia',
				'Familiar'
			],
			'cast': [
				'Robert Downey Jr.',
				'Antonio Banderas',
				'Michael Sheen',
				'Jim Broadbent'
			],
			'poster': 'dolittle.jpg'
		},
		{
			'id': 'grinch',
			'title': 'El Grinch',
			'synopsis': 'El Grinch cuenta la historia de un personaje cínico y gruñón que pone en marcha una misión para robarse la Navidad, pero solo consigue que su corazón cambie gracias al generoso espíritu navideño de una pequeña niña.',
			'duration': 85,
			'director': 'Scott Mosier',
			'genres': [
				'Cine navideño',
				'Comedia'
			],
			'cast': [
				'Benedict Cumberbatch',
				'Cameron Seely',
				'Rashida Jones',
				'Kenan Thompson',
				'Angela Lansbury'
			],
			'poster': 'grinch.jpg'
		},
		{
			'id': 'hobbsshaw',
			'title': 'Hobbs y Shaw',
			'synopsis': 'Desde que el corpulento hombre de leyes Hobbs (Johnson), un leal agente del Servicio de Seguridad Diplomática de América, y el forajido Shaw (Statham), un ex militar operativo británico, se enfrentaron por primera vez en Rápidos & Furiosos 7, el dúo ha intercambiado confrontaciones verbales y físicas al intentar derrotarse.',
			'duration': 135,
			'director': 'David Leitch',
			'genres': [
				'Acción',
				'Aventura'
			],
			'cast': [
				'Dwayne Johnson',
				'Jason Statham',
				'Vanessa Kirby',
				'Idris Elba',
				'Eiza González',
				'Helen Mirren'
			],
			'poster': 'hobbsshaw.jpg'
		}
	];
	static final products = [
		{
			'id': 'popcorn-small',
			'name': 'Palomitas pequeñas',
			'image': 'popcorn-small.png',
			'price': 75
		},
		{
			'id': 'popcorn-large',
			'name': 'Palomitas grandes',
			'image': 'popcorn-large.png',
			'price': 85
		},
		{
			'id': 'drink',
			'name': 'Refresco',
			'image': 'drink.png',
			'price': 60
		},
		{
			'id': 'combo',
			'name': 'Combo',
			'image': 'combo.png',
			'price': 140
		}
	];
}