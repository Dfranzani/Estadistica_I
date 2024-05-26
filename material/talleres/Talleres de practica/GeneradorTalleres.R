# Ejecutar archivos .Rnw que generan los talleres en PDF Latex

generar.talleres = function(){
  talleres = list.files(path = "material/talleres/Talleres de practica")
  # Omitimos el preámbulo ya que los incorporamos dentro de cada taller
  talleres = talleres[grepl(".Rnw", talleres) & !grepl("main", talleres)]
  g = lapply(as.list(talleres), function(taller){
    # taller = "taller1.Rnw"
    salida = paste("material/talleres/Talleres de practica/",
                   gsub(pattern = ".Rnw", replacement = "", x = taller),
                   ".tex",
                   sep = "")
    library(knitr)
    # Incorporamos cada contenido de los talleres en un archivo main
    knitr::knit2pdf(input = "material/talleres/Talleres de practica/main.Rnw", output = salida)
  })
  
  # Borramos los archivos .tex
  borrar = list.files(path = "material/talleres/Talleres de practica")
  borrar = borrar[grepl(".tex", borrar)]
  borrar = paste0("material/talleres/Talleres de practica/", borrar)
  borrar = file.remove(borrar)
}

# Warnings respecto al directorio ambiente en el que se compila (proyecto), respecto a la salida (carpeta material/talleres).
suppressWarnings(generar.talleres())
