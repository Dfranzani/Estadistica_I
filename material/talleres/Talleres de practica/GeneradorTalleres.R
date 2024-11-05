# # Ejecutar archivos .Rnw que generar los talleres en PDF Latex
# 
# generar.talleres = function(){
#   talleres = list.files(path = "material/talleres/Talleres de practica")
#   # Omitimos el preámbulo ya que los incorporamos dentro de cada taller
#   talleres = talleres[grepl(".Rnw", talleres) & !grepl("main", talleres)]
#   g = lapply(as.list(talleres), function(taller){
#     # taller = "taller1.Rnw"
#     salida = paste("material/talleres/Talleres de practica/",
#                    gsub(pattern = ".Rnw", replacement = "", x = taller),
#                    ".tex",
#                    sep = "")
#     library(knitr)
#     # Incorporamos cada contenido de los talleres en un archivo main
#     knitr::knit2pdf(input = "material/talleres/Talleres de practica/main.Rnw", output = salida)
#   })
#   
#   # Borramos los archivos .tex
#   borrar = list.files(path = "material/talleres/Talleres de practica")
#   borrar = borrar[grepl(".tex", borrar)]
#   borrar = paste0("material/talleres/Talleres de practica/", borrar)
#   borrar = file.remove(borrar)
# }
# 
# # Warnings respecto al directorio ambiente en el que se compila (proyecto), respecto a la salida (carpeta material/talleres).
# suppressWarnings(generar.talleres())

# Establecemos las rutas absolutas de los archivos RSweave a compilar, sino se genera un error en la carpeta de figuras para cada uno de los archivos hijos RSweave.
dir_proj = getwd()
dir_files = paste0(dir_proj, "/material/talleres/Talleres de practica")
# dir_figures = paste0(dir_proj, "/material/talleres/Talleres de practica/figures/")
if (!grepl("/material/talleres/Talleres de practica", dir_proj)) setwd(dir_files)

# Ejecutar archivos .Rnw que generar los talleres en PDF Latex
generar.talleres = function(){
  talleres = list.files()
  # Omitimos el preámbulo ya que los incorporamos dentro de cada taller
  talleres = talleres[grepl(".Rnw", talleres) & !grepl("main", talleres)]
  g = lapply(as.list(talleres), function(taller){
    # taller = "taller1.Rnw"
    salida = paste0(gsub(pattern = ".Rnw", replacement = "", x = taller), ".tex")
    library(knitr)
    # Incorporamos cada contenido de los talleres en un archivo main
    knitr::knit2pdf(input = "main.Rnw", output = salida)
  })
  
  # Borramos los archivos .tex
  borrar = list.files()
  borrar = borrar[grepl(".tex", borrar)]
  # borrar = paste0("material/talleres/Talleres de practica/", borrar)
  borrar = file.remove(borrar)
}

# Warnings respecto al directorio ambiente en el que se compila (proyecto), respecto al directorio de trabajo.
suppressWarnings(generar.talleres())
setwd(dir_proj)