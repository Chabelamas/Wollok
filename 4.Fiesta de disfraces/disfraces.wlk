import fiestas.*

class Disfraz {
	const property fechaConfeccion
	const nombre
	const property caracteristicas = #{}
	method puntuacion (persona, fiesta) = caracteristicas.map{caract => caract.puntuacion (persona, fiesta)}.sum()
	method nombrePar () = nombre.size().even()
}

class Gracioso {	
	const nivelGracia
	method puntuacion (persona, fiesta) {
		if (persona.edad() > 50) return nivelGracia * 3
		else return nivelGracia
	}
}

class Tobara {
	const diaComprado
	method puntuacion (persona, fiesta) {
		if (fiesta.fecha() - diaComprado > 1) return 5
		else return 3
	}
}

class Sexy {
	method puntuacion (persona, fiesta) {
		if (persona.esSexy()) return 15
		else return 2
	}
}

class Careta {
	const property personajeQueSimula
	method puntuacion (persona, fiesta) = personajeQueSimula.valor()
}

object mickeyMouse {
	const property valor = 8
}

object osoCarolina {
	const property valor = 6
}