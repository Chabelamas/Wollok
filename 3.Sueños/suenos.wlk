import personas.*

class Sueno {
	method nivelDeFelicidad ()
	method puedeCumplirse (persona)
	method cumplirPara (persona) {
		self.puedeCumplirse (persona)
		persona.anadirSuenoCumplido (self)
		persona.nivelDeFelicidad() += self.nivelDeFelicidad ()
	}

}

class SuenoIndividual inherits Sueno { 
	const nivelDeFelicidad = 0
	override method nivelDeFelicidad  () = nivelDeFelicidad
}

class RecibirseDeCarrera inherits SuenoIndividual {
	const property carrera
	override method puedeCumplirse (persona) {
		if (!persona.quiereEstudiar(carrera)){
			throw new NopuedeCumplirSueno (message = "No quiere estudiar esa carrera")
		}
		if (persona.yaCumplioSueno(self)){
			throw new NopuedeCumplirSueno (message = "Ya se recibio de esa carrera")
		}
	}	
}

class TenerUnHijo inherits SuenoIndividual {
	override method cumplirPara (persona) {
		super (persona)
		persona.anadirHijos (1)
	}
}

class AdoptarHijos inherits SuenoIndividual {
	const cantidad
	override method puedeCumplirse (persona) {
		if (persona.cantHijos() != 0){
			throw new NopuedeCumplirSueno (message = "Ya tiene un hijo, no puede adoptar otro")
		}

	}
	override method cumplirPara (persona) {
		super (persona)
		persona.anadirHijos (cantidad) 
	}
}

class ViajarAUnLugar inherits SuenoIndividual {
	const property lugar
	override method cumplirPara (persona) {
		super (persona)
		persona.anadirViaje (lugar) 
	}
}

class ConseguirTrabajo inherits SuenoIndividual {
	const property cantidadDePlata
	override method puedeCumplirse (persona) {
		if (cantidadDePlata < persona.plataAGanar()){
			throw new NopuedeCumplirSueno (message = "Tiene un sueldo menor del que busca")
		}

	}
}

class SuenoMultiple inherits Sueno{
	const suenos = []
	override method nivelDeFelicidad  () {
		const felicidadPorSueno = suenos.map{sueno => sueno.nivelDeFelicidad()} 
	}
	override method puedeCumplirse (persona) {
		suenos.forEach{sueno => sueno.puedeCumplirse(persona)}
	}
	override method cumplirPara (persona) {
		self.puedeCumplirse (persona)
		suenos.forEach{sueno => persona.anadirSuenoCumplido (sueno) && persona.nivelDeFelicidad() += sueno.nivelDeFelicidad ()}
	}

}

suenoPunto2 = new  SuenoMultiple ( suenos = [viajarACataratas, tenerUnHijo, conseguirTrabajoDe10000])
viajarACataratas = new ViajarAUnLugar (nivelDeFelicidad=90, lugar = "cataratas")
tenerUnHijo = new TenerUnHijo (nivelDeFelicidad=102)
conseguirTrabajoDe10000 = new ConseguirTrabajo (nivelDeFelicidad=101, cantidadDePlata = 10000)

class NopuedeCumplirSueno inherits DomainException {}