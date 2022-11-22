import producciones.*
import academia.*

const experimentado = new Experimentado ()
const principiante = new Principiante ()

class Principiante {
	method puedePreparar (cocinero, receta) = !receta.esDificil()
	method verificarSuperarNivel (cocinero) {
		const experiencia = cocinero.experiencia ()
		if (experiencia > 100) cocinero.convertirseEnExperto() 
	}
	method calidadComida (cocinero, receta) {
		if (receta.cantidadDeIngredientes() < 4) return normal
		return pobre
	}
}

class Experimentado inherits Principiante {
	override method puedePreparar (cocinero, receta) = super(receta) || cocinero.tieneRecetaSimilarA(receta)
	override method verificarSuperarNivel (cocinero) {
		recetasDificiles = cocinero.recetasPreparadas().filter({receta => receta.esDificil()})
		if (recetasDificiles.size() > 5) cocinero.convertirseEnChef() 
	}
	override method calidadComida (cocinero, receta) {
	if (receta.perfeccionarReceta(cocinero)) {
		return new Superior (plus = cocinero.calcularPlus(receta))
		}
		return normal
	}
}

object chef inherits Experimentado {
	override method puedePreparar (cocinero, receta) = true
	override method verificarSuperarNivel (cocinero) {}
}

class NoPuedePrepararComida inherits DomainException {}