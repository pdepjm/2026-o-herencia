class Estudiante {
  var felicidad
  const varitas = []
  
  method lanzarHechizo(nube) {
    const varita = self.elegirVarita()
    varita.hechiza(nube)
  }
  
  method elegirVarita() = varitas.max({ varita => varita.potencia() })
  
  method restarFelicidad(cantidad) {
    felicidad = 0.max(felicidad - cantidad)
  }
}

class NubeGris {
  var tristeza
  
  method perderTristeza(cantidad) {
    tristeza = 0.max(tristeza - cantidad)
  }
  
  method entristecer(estudiante) {
    estudiante.restarFelicidad(tristeza)
  }
  
  method estaDespejada() = tristeza == 0
}

class NubeTormenta inherits NubeGris {
  const resistencia
  
  override method perderTristeza(cantidad) {
    const cantidadFinal = cantidad - resistencia
    super(cantidadFinal)
  }
}

class Varita {
  var brillo
  
  method potencia()
  
  method aplicarEfecto(nube)
  
  method puedeLanzar() = brillo > 0
  
  method hechiza(nube) {
    if (not self.puedeLanzar()) {
      throw new DomainException(message = "Varita no puede hechizar.")
    }
    nube.perderTristeza(self.potencia())
    if (brillo > 80) self.aplicarEfecto(nube)
    self.perderBrillo()
  }
  
  method desgaste() = 20
  
  method perderBrillo() {
    brillo = (brillo - self.desgaste()).max(0)
  }
}

class VaritaJuguete inherits Varita {
  override method potencia() = 50
  
  override method desgaste() = 0
  override method aplicarEfecto(nube) {}
}

class VaritaEstrella inherits Varita {
  override method potencia() = 100 - brillo
  
  override method aplicarEfecto(nube) {
    brillo *= 2
  }
}

class VaritaCorazon inherits Varita {
  const amor
  
  override method puedeLanzar() = true
  
  override method potencia() = amor * 2
  override method aplicarEfecto(nube) {
    if(amor > 50) nube.perderTristeza(1000)
  }
}
