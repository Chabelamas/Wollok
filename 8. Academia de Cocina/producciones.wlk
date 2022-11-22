import nivelAprendizaje.*
import academia.*

class Recetas {
	const nivelDificultad
	const ingredientes = #{}
	method cantidadDeIngredientes () = ingredientes.size()
 	method experienciaAportada () = self.cantidadDeIngredientes() * nivelDificultad
	method dificultadesSimilares (receta) = (nivelDificultad - otraReceta.nivelDificultad()).abs() >= 1 
	method esSimilar (otraReceta) = ingredientes == otraReceta.ingredientes() || self.dificultadesSimilares(receta)
	method esDificil () = nivelDificultad > 5 || ingredientes.size() > 10
	method perfeccionarReceta (cocinero) = cocinero.expComidasConRecetasSimilarA(self) == 3 * self.experienciaAportada()
}

class RecetaGourmet inherits Recetas {
	override method experienciaAportada () = super() * 2
	override method esDificil () = true
}

class Comida {
	var calidad
	const property receta
	method experiencia () = calidad.experienciaAportada (receta, academia)
	method tieneRecetaSimilarA (otraReceta) = receta.esSimilar(otraReceta)
}


// Calidad

object pobre {
	method experienciaAportada (receta, academia) = academia.experienciaMaxima().min(receta.experienciaAportada()) 
}

object normal {
	method experienciaAportada (receta, academia) = receta.experienciaAportada()
}

class Superior {
	const plus 
	method experienciaAportada (receta, academia) = receta.experienciaAportada() + plus
}
