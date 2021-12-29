
## PROYECTO PRECISA

## Creado: Roke Álvarez Masso y Endika Nuñez Larrañaga
## Publicado: https://electoralreport.com
## Licencia: Creative Commons Attribution 4.0 International License

## Si ves cualquier error, tienes alguna duda o sugerencia,
## escribe a: contacto@electoralreport.com

#LIBRERIAS---

library(tidyverse)
library(dplyr)
library(lubridate)
library(purrr)
library(rvest)
library(foreign)
library(readxl)
library(writexl)
library(future)
library(furrr)

plan(multisession)

#MASTER VARIABLES----

election_day <- today() 

#FUNCIONES----

renom_col <- function(data = "") {
    
    data %>%
      dplyr::select(-starts_with("C.3.2")) %>%
      rename(ccaa = A.1, 
             tam_habitat = A.2,
             sexo = A.3,
             edad = A.4,
             prov = A.5,
             mun = A.6,
             area_metro = A.7,
             capital = A.8,
             nacionalidad = A.9.1,
             nac_extrangero = A.9.2,
             moment_adq_nac = A.9.3,
             conoc_lengua = A.9.4,
             conoc_lengua_atrib = A.9.5,
             val_sit_econ_esp1 = B.1.1.1,
             val_sit_econ_esp2 = B.1.1.2,
             val_retros_econ_esp = B.1.2,
             val_prosp_econ_esp = B.1.3,
             val_sit_econ_pers1 = B.2.1.1,
             val_sit_econ_pers2 = B.2.1.2,
             val_retros_econ_pers = B.2.2,
             val_prosp_econ_pers = B.2.3,
             val_sit_poli_esp = C.1.1,
             val_retros_poli_esp = C.1.2,
             val_prosp_poli_esp = C.1.3,
             organ_territorial = C.2.1,
             sentimiento_nac = C.2.2,
             escala_autoubic_ideol = C.3.1,
             val_gestion_gob = C.3.3,
             val_labor_opos = C.3.4,
             fidelidad = C.3.5,
             felicidad_pers = D.1,
             religiosidad1 = D.2.1,
             religiosidad2 = D.2.2,
             religiosidad3 = D.2.3,
             freq_asist_relig1 = D.3.1,
             freq_asist_relig2 = D.3.2,
             escolarizacion = E.1,
             nivel_estudios1 = E.2_2,
             nivel_estudios2 = E.2,
             estado_civil = F.1,
             convivencia = F.2,
             aporte_ingresos_hogar = F.3,
             sit_laboral1 = G.1.1,
             sit_laboral2 = G.1.2,
             sit_laboral3 = G.1.3,
             prob_perder_empleo = G.2,
             prob_encontrar_empleo = G.3,
             sit_profesional = G.4,
             tipo_empresa = G.5,
             condicion_socioeconomica = G.6,
             estatus_socioeconomico = G.7,
             ocupacion1 = G.8.1,
             ocupacion2 = G.8.2,
             ocupacion3 = G.8.3,
             ocupacion4 = G.8.4,
             ocupacion5 = G.8.5,
             ocupacion6 = G.8.6,
             ocupacion7 = G.8.7,
             rama_actividad1 = G.9.1,
             rama_actividad2 = G.9.2,
             rama_actividad3 = G.9.3,
             rama_actividad4 = G.9.4,
             ocup_padre = G.10.1,
             ocup_madre = G.10.2,
             rama_padre = G.11.1,
             rama_madre = G.11.2,
             ingresos_hogar = G.12,
             ingresos_pers = G.13,
             clase_soc_subj = G.14) %>%
      rename_with(tolower)
  }
recategorizar <- function(data = "") {
    
    data %>%
      
      mutate(tam_habitat = gsub("Más de 1.000.000 habitantes", ">1M", tam_habitat),
             tam_habitat = gsub("400.001 a 1.000.000 habitantes", "400K-1M", tam_habitat),
             tam_habitat = gsub("100.001 a 400.000 habitantes", "100-400K", tam_habitat),
             tam_habitat = gsub("50.001 a 100.000 habitantes", "50-100K", tam_habitat),
             tam_habitat = gsub("10.001 a 50.000 habitantes", "10-50K", tam_habitat),
             tam_habitat = gsub("2.001 a 10.000 habitantes", "<10K", tam_habitat),
             tam_habitat = gsub("Menos o igual a 2.000 habitantes", "<10K", tam_habitat),
             
             edad = as.numeric(edad),
             
             capital = gsub("Capital de CC.AA.", "Capital", capital),
             capital = gsub("Capital de provincia", "Capital", capital),
             capital = gsub("Otros municipios", "No-capital", capital),
             
             nacionalidad = gsub("Española", "Española", nacionalidad),
             nacionalidad = gsub("Española y otra", "Doble", nacionalidad),
             nacionalidad = gsub("Otra nacionalidad", "Otra", nacionalidad),
             nacionalidad = gsub("9", "", nacionalidad),
             
             conoc_lengua = gsub("Es su idioma materno", "Buena o muy buena", conoc_lengua),
             conoc_lengua = gsub("Lo habla con fluidez", "Buena o muy buena", conoc_lengua),
             conoc_lengua = gsub("Lo habla como si fuera nativo/a", "Buena o muy buena", conoc_lengua),
             conoc_lengua = gsub("Lo habla más o menos bien", "Buena o muy buena", conoc_lengua),
             conoc_lengua = gsub("Lo habla un poco", "Mala o muy mala", conoc_lengua),
             
             conoc_lengua_atrib = gsub("Es su idioma materno", "Buena o muy buena", conoc_lengua_atrib),
             conoc_lengua_atrib = gsub("Lo habla con fluidez", "Buena o muy buena", conoc_lengua_atrib),
             conoc_lengua_atrib = gsub("Lo habla como si fuera nativo/a", "Buena o muy buena", conoc_lengua_atrib),
             conoc_lengua_atrib = gsub("Lo habla más o menos bien", "Buena o muy buena", conoc_lengua_atrib),
             conoc_lengua_atrib = gsub("Lo habla un poco", "Mala o muy mala", conoc_lengua_atrib),
             conoc_lengua_atrib = gsub("No lo habla en absoluto", "Mala o muy mala", conoc_lengua_atrib),
             
             val_sit_econ_esp = coalesce(val_sit_econ_esp2, val_sit_econ_esp1),
             val_sit_econ_esp = gsub("[()]", "", val_sit_econ_esp),
             val_sit_econ_esp = gsub("Buena", "Buena o muy buena", val_sit_econ_esp),
             val_sit_econ_esp = gsub("Muy buena", "Buena o muy buena", val_sit_econ_esp),
             val_sit_econ_esp = gsub("Mala", "Mala o muy mala", val_sit_econ_esp),
             val_sit_econ_esp = gsub("Muy mala", "Mala o muy mala", val_sit_econ_esp),
             val_sit_econ_esp = gsub("NO LEER Regular", "Regular", val_sit_econ_esp),
             val_sit_econ_esp = gsub("Regular", "Regular", val_sit_econ_esp),
             
             val_sit_poli_esp = gsub("Buena", "Buena o muy buena", val_sit_poli_esp),
             val_sit_poli_esp = gsub("Muy buena", "Buena o muy buena", val_sit_poli_esp),
             val_sit_poli_esp = gsub("Mala", "Mala o muy mala", val_sit_poli_esp),
             val_sit_poli_esp = gsub("Muy mala", "Mala o muy mala", val_sit_poli_esp),
  
             organ_territorial = gsub("Un Estado con un único Gobierno Central sin autonomías", "Gobierno Central sin CCAA", organ_territorial),
             organ_territorial = gsub("Un Estado en el que las Comunidades Autónomas tengan mayor a", "CCAA con mayor autonomía", organ_territorial),
             organ_territorial = gsub("Un Estado con Comunidades Autónomas como en la actualidad", "Situación actual", organ_territorial),
             organ_territorial = gsub("Un Estado en el que las Comunidades Autónomas tengan menor a", "CCAA con menor autonomía", organ_territorial),
             organ_territorial = gsub("Un Estado en el que se reconociese a las Comunidades Autónom", "Estados independientes", organ_territorial),
             
             sentimiento_nac = gsub("[()]", "", sentimiento_nac), ##
             sentimiento_nac = gsub("Se siente tan español/a como gentilicio C.A.", "Tan español como CCAA", sentimiento_nac),
             sentimiento_nac = gsub("Se siente más español/a que gentilicio C.A.", "Más español que CCAA", sentimiento_nac),
             sentimiento_nac = gsub("Se siente únicamente español/a", "Unicamente español", sentimiento_nac),
             sentimiento_nac = gsub("Se siente más gentilicio C.A. que español/a", "Más CCAA que español", sentimiento_nac),
             sentimiento_nac = gsub("Se siente únicamente gentilicio C.A.", "Unicamente CCAA", sentimiento_nac),
             sentimiento_nac = gsub("NO LEER Ninguna de las anteriores", "Otro", sentimiento_nac),
             
             escala_autoubic_ideol = gsub(" Izquierda", "", escala_autoubic_ideol),
             escala_autoubic_ideol = gsub(" Derecha", "", escala_autoubic_ideol),
             escala_autoubic_ideol = gsub("88", "", escala_autoubic_ideol),
             escala_autoubic_ideol = as.character(escala_autoubic_ideol),
             escala_autoubic_ideol = as.numeric(escala_autoubic_ideol),
             
             val_gestion_gob = gsub("Buena", "Buena o muy buena", val_gestion_gob),
             val_gestion_gob = gsub("Muy buena", "Buena o muy buena", val_gestion_gob),
             val_gestion_gob = gsub("Mala", "Mala o muy mala", val_gestion_gob),
             val_gestion_gob = gsub("Muy mala", "Mala o muy mala", val_gestion_gob),
             
             val_labor_opos = gsub("Buena", "Buena o muy buena", val_labor_opos),
             val_labor_opos = gsub("Muy buena", "Buena o muy buena", val_labor_opos),
             val_labor_opos = gsub("Mala", "Mala o muy mala", val_labor_opos),
             val_labor_opos = gsub("Muy mala", "Mala o muy mala", val_labor_opos),
             
             fidelidad = gsub("[()]", "", fidelidad), ##
             fidelidad = gsub("Votan siempre por el mismo partido", "Siempre", fidelidad),
             fidelidad = gsub("Por lo general suelen votar por el mismo partido", "Casi siempre", fidelidad),
             fidelidad = gsub("Según lo que más les convenza en ese momento, votan por un p", "Cambia según el momento", fidelidad),
             fidelidad = gsub("NO LEER No suelen votar", "No vota", fidelidad),
             fidelidad = gsub("NO LEER Votan en blanco o nulo", "Blanco o nulo", fidelidad),
             fidelidad = gsub("NO LEER Es la primera vez que vota", "Vota por primera vez", fidelidad),
             
             felicidad_pers = gsub(" Completamente feliz", "", felicidad_pers),
             felicidad_pers = gsub(" Completamente infeliz", "", felicidad_pers),
             felicidad_pers = as.numeric(felicidad_pers),
             
             religiosidad = coalesce(religiosidad3, religiosidad2, religiosidad1),
             religiosidad = gsub("Católico no practicante", "Católico/a", religiosidad),
             religiosidad = gsub("Católico practicante", "Católico/a", religiosidad),
             religiosidad = gsub("Católico/a no practicante", "Católico/a", religiosidad),
             religiosidad = gsub("Católico/a practicante", "Católico/a", religiosidad),
             religiosidad = gsub("Católico/a", "Católico/a", religiosidad),
             
             religiosidad = gsub("Otras religiones", "Otra religión", religiosidad),
             religiosidad = gsub("Creyente de otra religión", "Otra religión", religiosidad),
             religiosidad = gsub("Indiferente, no creyente", "Ninguna religión", religiosidad),
             religiosidad = gsub("No creyente", "Ninguna religión", religiosidad),
             religiosidad = gsub("Indiferente", "Ninguna religión", religiosidad),
             religiosidad = gsub("Agnóstico/a", "Agnóstico/a", religiosidad),
             religiosidad = gsub("Ateo/a", "Ateo/a", religiosidad),
             
             freq_asist_relig = coalesce(freq_asist_relig1, freq_asist_relig2),
             freq_asist_relig = gsub("Casi todos los domingos y festivos", "Domingos y festivos", freq_asist_relig),
             freq_asist_relig = gsub("Todos los domingos y festivos", "Domingos y festivos", freq_asist_relig),
             freq_asist_relig = gsub("Varias veces al año", "Varias veces al año", freq_asist_relig),
             freq_asist_relig = gsub("Alguna vez al mes", "Varias veces al mes", freq_asist_relig),
             freq_asist_relig = gsub("Dos o tres veces al mes", "Varias veces al mes", freq_asist_relig),
             freq_asist_relig = gsub("Varias veces a la semana", "Varias veces a la semana", freq_asist_relig),
             freq_asist_relig = gsub("Nunca", "Nunca o casi nunca", freq_asist_relig),
             freq_asist_relig = gsub("Casi nunca", "Nunca o casi nunca", freq_asist_relig),
             
             escolarizacion = gsub("No, es analfabeto/a", "No", escolarizacion),
             escolarizacion = gsub("No, pero sabe leer y escribir", "No, pero sabe leer y escribir", escolarizacion),
             escolarizacion = gsub("Sí, ha ido a la escuela", "Si", escolarizacion),
             
             nivel_estudios = gsub("Sin estudios", "Sin estudios", nivel_estudios1),
             nivel_estudios = gsub("Primaria y secundaria elemental", "Primaria y secundaria", nivel_estudios1),
             nivel_estudios = gsub("Secundaria superior", "Secundaria superior", nivel_estudios1),
             nivel_estudios = gsub("F.P.", "F.P.", nivel_estudios1),
             nivel_estudios = gsub("Universitarios", "Universitarios", nivel_estudios1),
             nivel_estudios = gsub("Otros", "Otros", nivel_estudios1),
             
             convivencia_no_casadas = gsub("No tiene pareja", "No tiene pareja", convivencia),
             convivencia_no_casadas = gsub("Tiene pareja y comparten la misma vivienda", "Si tiene pareja-Comparten vivienda", convivencia),
             convivencia_no_casadas = gsub("Tiene pareja pero no comparten la misma vivienda", "Si tiene pareja-No comparten vivienda", convivencia),
             convivencia_no_casadas = gsub("Tiene pareja pero no comparten la misma vivienda", "Si tiene pareja-No comparten vivienda", convivencia),
             
             aporte_ingresos_hogar = gsub("[()]", "", aporte_ingresos_hogar),
             aporte_ingresos_hogar = gsub("Otra persona", "Otra persona", aporte_ingresos_hogar),
             aporte_ingresos_hogar = gsub("La persona entrevistada", "Persona entrevistada", aporte_ingresos_hogar),
             aporte_ingresos_hogar = gsub("NO LEER La persona entrevistada y otra casi a partes igual", "A partes iguales", aporte_ingresos_hogar),
             aporte_ingresos_hogar = gsub("NO LEER Persona entrevistada y otra casi a partes igual", "A partes iguales", aporte_ingresos_hogar),
  
             sit_laboral = coalesce(sit_laboral1, sit_laboral2, sit_laboral3),
             sit_laboral = gsub("[()]", "", sit_laboral), ##
             sit_laboral = gsub("Jubilado", "Jubilado/Pensionista", sit_laboral),
             sit_laboral = gsub("Jubilado o pensionista", "Jubilado/Pensionista", sit_laboral),
             sit_laboral = gsub("Jubilado/a o pensionista anteriormente ha trabajado", "Jubilado/Pensionista", sit_laboral),
             sit_laboral = gsub("Pensionista anteriormente no ha trabajado", "Jubilado/Pensionista", sit_laboral),
             sit_laboral = gsub("Trabaja", "Trabajador", sit_laboral),
             sit_laboral = gsub("Está parado", "Parado", sit_laboral),
             sit_laboral = gsub("Parado/a y ha trabajado antes", "Parado", sit_laboral),
             sit_laboral = gsub("Parado/a y busca su primer empleo", "Busca primer empleo", sit_laboral), #"Parado-Busca primer empleo"
             sit_laboral = gsub("Buscando primer empleo", "Busca primer empleo", sit_laboral),            #"Parado-Busca primer empleo"
             sit_laboral = gsub("Estudiante", "Estudiante", sit_laboral),
             sit_laboral = gsub("Sus labores", "Otros", sit_laboral),
             sit_laboral = gsub("Trabajo doméstico no remunerado", "Trabajo doméstico", sit_laboral), #"Trabajo doméstico no remunerado"
             sit_laboral = gsub("Otra situación", "Otros", sit_laboral),
             
             sit_laboral = gsub("Jubilado/Pensionista o pensionista", "Jubilado/Pensionista", sit_laboral),
             sit_laboral = gsub("Jubilado/Pensionista/a o pensionista anteriormente ha trabajado", 
                                "Jubilado/Pensionista", sit_laboral),
             
             prob_perder_empleo = gsub("Nada probable", "Poco o nada", prob_perder_empleo),
             prob_perder_empleo = gsub("Poco probable", "Poco o nada", prob_perder_empleo),
             prob_perder_empleo = gsub("Bastante probable", "Mucho o bastante", prob_perder_empleo),
             prob_perder_empleo = gsub("Muy probable", "Mucho o bastante", prob_perder_empleo),
             
             prob_encontrar_empleo = gsub("Nada probable", "Poco o nada", prob_encontrar_empleo),
             prob_encontrar_empleo = gsub("Poco probable", "Poco o nada", prob_encontrar_empleo),
             prob_encontrar_empleo = gsub("Bastante probable", "Mucho o bastante", prob_encontrar_empleo),
             prob_encontrar_empleo = gsub("Muy probable", "Mucho o bastante", prob_encontrar_empleo),
             
             sit_profesional = gsub("[()]", "", sit_profesional),
             sit_profesional = gsub("Asalariado/a eventual o interino/a a sueldo, comisión, jorn", "Asalariado/Eventual/Interino", sit_profesional),
             sit_profesional = gsub("Asalariado/a fijo/a a sueldo, comisión, jornal, etc. con ca", "Asalariado/Fijo", sit_profesional),
             sit_profesional = gsub("Profesional o trabajador/a autónomo/a sin asalariados/as", "Profesional/Autónomo", sit_profesional),
             sit_profesional = gsub("Empresario/a o profesional con asalariados/as", "Empresario con asalariados", sit_profesional),
             sit_profesional = gsub("Ayuda familiar sin remuneración reglamentada en la empresa ", "Recibe ayuda familiar", sit_profesional),
             sit_profesional = gsub("Miembro de una cooperativa", "Cooperativista", sit_profesional),
             sit_profesional = gsub("Otra situación", "Otros", sit_profesional),
             
             tipo_empresa = gsub("Empresa privada", "Empresa privada", tipo_empresa),
             tipo_empresa = gsub("Empresa pública", "Empresa o admón. pública", tipo_empresa),
             tipo_empresa = gsub("Administración Pública", "Empresa o admón. pública", tipo_empresa),
             tipo_empresa = gsub("Servicio doméstico", "Servicio doméstico", tipo_empresa),
             tipo_empresa = gsub("Organización sin fines de lucro", "Org. sin ánimo de lucro", tipo_empresa),
             
             condicion_socioeconomica = gsub("Jubilados/as y pensionistas", "Jubilado/Pensionista", condicion_socioeconomica),
             condicion_socioeconomica = gsub("Empleados/as de oficinas y servicios", "Oficina y servicios", condicion_socioeconomica),
             condicion_socioeconomica = gsub("Parados/as", "Parado", condicion_socioeconomica),
             condicion_socioeconomica = gsub("Directores/as y profesionales", "Directores y profesionales", condicion_socioeconomica),
             condicion_socioeconomica = gsub("Empleados/as de oficinas y servicios", "Oficina y servicios", condicion_socioeconomica),
             condicion_socioeconomica = gsub("Técnicos/as y cuadros medios", "Técnicos y cuadros medios", condicion_socioeconomica),
             condicion_socioeconomica = gsub("Pequeños/as empresarios/as", "Pequeños empresarios", condicion_socioeconomica),
             condicion_socioeconomica = gsub("Estudiantes", "Estudiante", condicion_socioeconomica),
             condicion_socioeconomica = gsub("Técnicos/as y cuadros medios", "Técnicos y cuadros medios", condicion_socioeconomica),
             condicion_socioeconomica = gsub("Agricultores/as", "Agricultores", condicion_socioeconomica),
             condicion_socioeconomica = gsub("Trabajo doméstico no remunerado", "Trabajo doméstico no remunerado", condicion_socioeconomica),
             condicion_socioeconomica = gsub("Obreros/as cualificados/as", "Obreros cualificados", condicion_socioeconomica),
             condicion_socioeconomica = gsub("Obreros/as no cualificados/as", "Obreros no-cualificados", condicion_socioeconomica),
             condicion_socioeconomica = gsub("No clasificables", "Otros", condicion_socioeconomica),
             
             estatus_socioeconomico = gsub("Clase alta/media-alta", "Alta o media-alta", estatus_socioeconomico),
             estatus_socioeconomico = gsub("Viejas clases medias", "Vieja clase-media", estatus_socioeconomico),
             estatus_socioeconomico = gsub("Nuevas clases medias", "Nueva clase-media", estatus_socioeconomico),
             estatus_socioeconomico = gsub("Obreros/as cualificados/as", "Obreros cualificados", estatus_socioeconomico),
             estatus_socioeconomico = gsub("Obreros/as no cualificados/as", "Obreros no-cualificados", estatus_socioeconomico),
             estatus_socioeconomico = gsub("No consta", "Otros", estatus_socioeconomico),
             
             ingresos_hogar = gsub("No tienen ingresos de ningún tipo", "No tiene ingresos", ingresos_hogar),
             ingresos_hogar = gsub("Menos o igual a 300 &euro;", "<300", ingresos_hogar),
             ingresos_hogar = gsub("De 301 a 600 &euro;", "301-600", ingresos_hogar),
             ingresos_hogar = gsub("De 601 a 900 &euro;", "601-900", ingresos_hogar),
             ingresos_hogar = gsub("De 901 a 1.200 &euro;", "901-1200", ingresos_hogar),
             ingresos_hogar = gsub("De 1.201 a 1.800 &euro;", "1201-1800", ingresos_hogar),
             ingresos_hogar = gsub("De 1.801 a 2.400 &euro;", "1801-2400", ingresos_hogar),
             ingresos_hogar = gsub("De 2.401 a 3.000 &euro;", "2401-3000", ingresos_hogar),
             ingresos_hogar = gsub("De 3.001 a 4.500 &euro;", "3001-4500", ingresos_hogar),
             ingresos_hogar = gsub("De 4.501 a 6.000 &euro;", "4501-6000", ingresos_hogar),
             ingresos_hogar = gsub("Más de 6.000 &euro;", ">6000", ingresos_hogar),
             
             grupos_ingresos_hogar = gsub("<300", "<600", ingresos_hogar),
             grupos_ingresos_hogar = gsub("301-600", "<600", ingresos_hogar),
             grupos_ingresos_hogar = gsub("601-900", "900-1200", ingresos_hogar),
             grupos_ingresos_hogar = gsub("901-1200", "900-1200", ingresos_hogar),
             grupos_ingresos_hogar = gsub("1201-1800", "1200-1800", ingresos_hogar),
             grupos_ingresos_hogar = gsub("1801-2400", "1800-2400", ingresos_hogar),
             grupos_ingresos_hogar = gsub("2401-3000", "2400-4500", ingresos_hogar),
             grupos_ingresos_hogar = gsub("3001-4500", ">4500", ingresos_hogar),
             grupos_ingresos_hogar = gsub("4501-6000", ">4500", ingresos_hogar),
             grupos_ingresos_hogar = gsub(">6000", ">4500", ingresos_hogar),
             
             ingresos_pers = gsub("No tienen ingresos de ningún tipo", "No tiene ingresos", ingresos_pers),
             ingresos_pers = gsub("Menos o igual a 300 &euro;", "<300", ingresos_pers),
             ingresos_pers = gsub("De 301 a 600 &euro;", "301-600", ingresos_pers),
             ingresos_pers = gsub("De 601 a 900 &euro;", "601-900", ingresos_pers),
             ingresos_pers = gsub("De 901 a 1.200 &euro;", "901-1200", ingresos_pers),
             ingresos_pers = gsub("De 1.201 a 1.800 &euro;", "1201-1800", ingresos_pers),
             ingresos_pers = gsub("De 1.801 a 2.400 &euro;", "1801-2400", ingresos_pers),
             ingresos_pers = gsub("De 2.401 a 3.000 &euro;", "2401-3000", ingresos_pers),
             ingresos_pers = gsub("De 3.001 a 4.500 &euro;", "3001-4500", ingresos_pers),
             ingresos_pers = gsub("De 4.501 a 6.000 &euro;", "4501-6000", ingresos_pers),
             ingresos_pers = gsub("Más de 6.000 &euro;", ">6000", ingresos_pers),
             
             grupos_ingresos_pers = gsub("<300", "<600", ingresos_pers),
             grupos_ingresos_pers = gsub("301-600", "<600", ingresos_pers),
             grupos_ingresos_pers = gsub("601-900", "900-1200", ingresos_pers),
             grupos_ingresos_pers = gsub("901-1200", "900-1200", ingresos_pers),
             grupos_ingresos_pers = gsub("1201-1800", "1200-1800", ingresos_pers),
             grupos_ingresos_pers = gsub("1801-2400", "1800-2400", ingresos_pers),
             grupos_ingresos_pers = gsub("2401-3000", "2400-4500", ingresos_pers),
             grupos_ingresos_pers = gsub("3001-4500", ">4500", ingresos_pers),
             grupos_ingresos_pers = gsub("4501-6000", ">4500", ingresos_pers),
             grupos_ingresos_pers = gsub(">6000", ">4500", ingresos_pers)) %>%
      
      # No se recodifican
      ## Clase_soc_subj
      ## Ocupación
      ## Rama_actividad
      ## Ocup_padre y Ocup_madre
      ## Rama_padre y Rama_madre
      
      dplyr::select(-area_metro, #-clase_soc_subj,
                    -religiosidad1, -religiosidad2, -religiosidad3,
                    -val_sit_econ_esp1, -val_sit_econ_esp2,
                    -val_sit_econ_pers1, -val_sit_econ_pers2,
                    -nivel_estudios1, -nivel_estudios2,
                    -sit_laboral1, -sit_laboral2, -sit_laboral3,
                    -ocupacion1, -ocupacion2, -ocupacion3, -ocupacion4,
                    -ocupacion5, -ocupacion6, -ocupacion7,
                    -rama_actividad1, -rama_actividad2, -rama_actividad3, -rama_actividad4,
                    -concat, -id, -id_entrev, -yr, 
                    -freq_asist_relig1, -freq_asist_relig2)
    
  }
reorder <- function(data = "") {
    
    data %>%
      dplyr::select(
        
        ## Características del estudio
        estudio, numentr, legislatura, `año`, mes,
        fecha, eday, dias_rest,
        ccaa, prov, mun,
        
        ## Ponderación, intención de voto y problemas
        peso, int_voto, rec_voto, 
        #peso_sexo_edad, peso_final,  
        primer_problema, segundo_problema, tercer_problema,
        
        ## Sexo y edad
        sexo, grupos_edad, grupos_edad_plus, edad,
        año_nacimiento, generacion,
        
        ## Sociales
        convivencia_no_casadas, 
        estado_civil, 
        convivencia, 
        grupos_felicidad,
        
        ## Religión
        religiosidad, freq_asist_relig,
        
        ## Estudios
        escolarizacion, nivel_estudios,
        
        ## Territorio / Habitat
        zonas_nielsen, capital, tam_habitat, 
        
        ## Variables identitarias
        nacionalidad, nac_extrangero, moment_adq_nac,
        sentimiento_nac, organ_territorial,
        conoc_lengua, conoc_lengua_atrib,
        
        ## Variables políticas
        fidelidad, grupos_ideol, clase_soc_subj,
        val_sit_poli_esp, val_retros_poli_esp, val_prosp_poli_esp,
        val_gestion_gob, val_labor_opos, 
        
        ## Variables económicas
        val_sit_econ_esp,
        val_retros_econ_esp, val_prosp_econ_esp,
        val_retros_econ_pers, val_prosp_econ_pers,
        
        ## Empleo
        tipo_empresa,
        sit_laboral, sit_profesional,
        condicion_socioeconomica, estatus_socioeconomico,
        prob_encontrar_empleo, prob_perder_empleo,
        
        ## Ingresos
        aporte_ingresos_hogar, 
        ingresos_hogar, ingresos_pers,
        grupos_ingresos_hogar, grupos_ingresos_pers)
    
  }

#CARGAR DATOS----

## Cargar el FID

fid <- read.spss("[DIRECTORIO DEL ARCHIVO FID.sav]",
                 to.data.frame = T,
                 use.value.labels = T,
                 reencode = T) %>%
  group_by(ESTUDIO) %>%
  mutate(ID = 1:n()) %>%
  ungroup() %>%
  rowwise() %>%
  mutate(concat = paste0(ESTUDIO,ID),
         `AÑOMES` = as.numeric(`AÑOMES`)) %>%
  suppressMessages() %>%
  suppressWarnings()

## Abrir listado de Barómetros del CIS
### Páginas a scrapear de la web de los barómetros del CIS

max_pags <- "http://www.cis.es/cis/opencm/ES/11_barometros/depositados.jsp" %>%
  read_html() %>%
  html_nodes('p.numeros > a') %>%
  html_text() %>%
  as.character()%>%
  as_tibble() %>%
  mutate_if(is.character, as.numeric) %>%
  unique() %>%
  top_n(n = 1) %>%
  as.numeric()

barometros <- future_map_dfr(.x = 1:max_pags,
                             .f = ~{
                               
                               cat(paste("Scraping page: ", .x, "\n", sep = ""))

                               url_base <- "http://www.cis.es/cis/opencm/ES/11_barometros/depositados.jsp?pagina="
                               url <- paste0(url_base, .x, "&orden=1&desc=null")
                             
                               barometros <- url %>%
                                   read_html() %>%
                                   html_nodes(xpath = '//*[@id="destacado1"]/div/table') %>%
                                   html_table() %>%
                                   as.data.frame() %>%
                                   select(fecha = Fecha, estudio = Número, titulo = `Título`) %>%
                                   filter(!str_detect(titulo, "FUSIÓN")) %>%
                                   select(-titulo) %>%
                                   mutate(fecha = dmy(fecha))
                                 
                                 return(barometros) 
                               }
                             )

lista_cis <- read.csv("0_precisa_datasets/src/lista-barometros-cis.csv", 
                      encoding = "UTF-8",
                      stringsAsFactors = FALSE,
                      sep = ";") %>%
  filter(estudio >= 2002)

## Fecha de elecciones generales

elecciones <- "https://es.wikipedia.org/wiki/Anexo:Elecciones_en_Espa%C3%B1a" %>%
  read_html() %>%
  html_nodes(xpath = "/html/body/div[3]/div[3]/div[5]/div[1]/table[13]") %>%
  html_table() %>%
  as.data.frame() %>%
  mutate(dia = gsub("de ", "", `Día`),
         eday = parse_date(paste(`dia`, `Año`, sep = " "), "%d %B %Y", locale = locale("es"))) %>%
  dplyr::select(eday, info = Elecciones.generales) %>%
  add_row(eday = election_day, info = "Próximas elecciones generales") %>%
  mutate(legislatura = 1:n()-1,
         legis_id = legislatura-1) %>%
  dplyr::select(legislatura, legis_id, eday, info) %>%
  mutate(legislatura = paste0(formatC(legislatura, width = 2, flag = "0")),
         legis_id = paste0(formatC(legis_id, width = 2, flag = "0")))

## Cargar nombres de los partidos/coaliciones

party_names_int <- read.csv("0_precisa_datasets/src/party_names.csv", sep = ";", encoding = "UTF-8") %>%
  filter(info == "Intención de voto") %>%
  mutate(legislatura = as.numeric(legislatura),
         legislatura = paste0(formatC(legislatura, width = 2, flag = "0")),
         id_party = paste(legislatura, old_name, sep = "-")) %>%
  distinct(id_party, old_name, new_name) %>%
  dplyr::select(id_party_int = id_party,
                old_name_int = old_name,
                new_name_int = new_name)

party_names_rec <- read.csv("0_precisa_datasets/src/party_names.csv", sep = ";", encoding = "UTF-8") %>%
  filter(info == "Recuerdo de voto") %>%
  mutate(legislatura = as.numeric(legislatura),
         legislatura = paste0(formatC(legislatura, width = 2, flag = "0")),
         id_party = paste(legislatura, old_name, sep = "-")) %>%
  distinct(id_party, old_name, new_name) %>%
  dplyr::select(id_party_rec = id_party,
                old_name_rec = old_name,
                new_name_rec = new_name)

#OBTENER VARIABLES----

## Sacar lista de variables de los barometros

combi_vars <- map_dfr(.x = 1:nrow(lista_cis),
                      .f = ~{
                        
                        barom <- as.numeric(lista_cis[.x, 1])
                        yr <- as.numeric(lista_cis[.x, 2])
                        
                        cat(paste0(.x, "_", barom, "_", yr, "\n", sep ="\""))
                        
                        # Montar path
                        
                        path_base <- "[DIRECTORIO DE LOS BARÓMETROS DEL CIS]"
                        path <- paste0(path_base, yr, "/", barom,".sav")
                        
                        # Leer barómetro
                        
                        cis <- read.spss(file = path,
                                         to.data.frame = T,
                                         use.value.labels = T,
                                         reencode = T) %>%
                          suppressWarnings() %>%
                          suppressMessages()
                        
                        # Atributos/subtitulos del dataset
                        
                        col.attr <- as.data.frame(attr(cis, "variable.labels"))
                        colnames(col.attr) <- "col_names"
                        
                        colnames(cis) <- t(col.attr)
                        
                        col_codes_names <- rownames_to_column(col.attr, "col_code")
                        
                        a <- tibble(colname = col_codes_names$col_names,
                                    colcode = col_codes_names$col_code, 
                                    estu = barom, year = yr)
                        
                      })

#PRINCIPALES ROBLEMAS----

## Extracción de los codigos de las columnas para las variables "Principales problemas España" 1,2 y 3

prob_new <- read.csv("0_precisa_datasets/src/principales_problemas_codigos.csv", sep = ";") %>%
  rename(`Primer problema` = Primer.problema,
         `Segundo problema` = Segundo.problema,
         `Tercer problema` = Tercer.problema) %>%
  mutate(year = year(dmy(year)),
         year = as.character(year),
         estu = as.character(estu)) %>% 
  filter(!is.na(`Primer problema`)) %>% 
  select(-X)

prob_cols <- combi_vars %>% 
  mutate(colname = as.character(colname)) %>% 
  filter(grepl(paste(c("Primer problema","Segundo problema","Tercer problema"),collapse="|"),colname)) %>% 
  filter(!grepl("Segundo problema en importancia",colname)) %>% 
  mutate(estu = as.character(estu)) %>% 
  mutate(year = as.character(year)) %>% 
  group_by(estu,colname) %>% 
  filter(row_number()==1) %>% 
  rename(col_prob_name = colname,
         col_prob_code = colcode) %>% 
  spread(col_prob_name,col_prob_code) %>%
  bind_rows(prob_new) %>% 
  unique()

#INTENCION y RECUERDO----

## Extracción de los códigos de las columnas para la variable intención de voto 
## en columnas con el nombre de la variable

inten_cols <- combi_vars %>% 
  mutate(colname = as.character(colname)) %>% 
  filter(grepl("Intención de voto",colname)) %>% 
  filter(!grepl("alternativo",colname)) %>% 
  filter(!grepl("recodificada",colname)) %>% 
  filter(!grepl("Cataluña",colname)) %>% 
  filter(!grepl("Europeo",colname)) %>% 
  filter(!grepl("autonómicas",colname)) %>% 
  filter(!grepl("municipales",colname)) %>%
  filter(!grepl("conocerse",colname)) %>% 
  filter(!grepl("pudieron",colname)) %>% 
  filter(colcode != "INTENCIONGR") %>% 
  filter(!grepl("R",colcode))

## Variable

inten_cols_final3 <- inten_cols %>% 
  rbind(tibble(colname = c("","","", "", "", "",  "", "", "", "", "", 
                           "", "", "", "", "", "", "", "", "", 
                           "", "", "", "", "", "", "", "", "", ""), 
               colcode = c("P21","P27","P31", "P31", "P31", "P32", "P30", "p32", "p27", "p33", "P32", 
                           "P31", "P32", "P28", "P34", "P33", "P28", "P33", "P26", "P25", 
                           "P34", "P33", "P33", "P28", "P18", "P27", "P25", "P34", "P29", "P31"),
               estu = c("2622","2602","2589", "2577", "2561", "2541", "2508", "2477", "2468", "2454", "2444", 
                        "2433", "2428", "2415", "2406", "2400", "2396", "2389", "2372", "2367", 
                        "2324", "2316", "2307", "2294", "2285", "2274", "2264", "2254", "2244", "2233"),
               year = c("2005","2005", "2005", "2004", "2004", "2003", "2003", "2003", "2002", "2002", "2002", 
                        "2001", "2001", "2001", "2001", "2000", "2000", "2000", "1999", "1999",
                        "1999", "1999", "1998", "1998", "1998", "1998", "1997", "1997", "1997", "1997"))) %>% 
  left_join(prob_cols)

prob_cols2 <- prob_cols %>%
  filter(!estu %in% unique(inten_cols_final3$estu)) %>%
  mutate(colcode = "", colname = "")

inten_cols_final2 <- inten_cols_final3 %>% 
  rbind(prob_cols2) 

recu_empty_codes <- tibble()

for (i in unique(combi_vars$estu)) {
  
  year <- combi_vars %>% 
    filter(estu == i) %>% 
    select(year) %>% 
    unique() %>% 
    pull()
  
  cis <- read.spss(file = paste("[DIRECTORIO DE LOS BARÓMETROS DEL CIS]", year, "/", i,".sav", sep = ""),
                   to.data.frame = T,
                   use.value.labels = T,
                   reencode = T) %>%
    suppressWarnings() %>% suppressMessages()
  
  colus <- which(cis == "No votó" | cis == "no votó" | cis == "No votó {No votó}" |
                   cis == "No votó {Novoto}", arr.ind = TRUE) %>% 
    as.data.frame() %>% 
    select(col) %>% 
    unique() %>% 
    filter(row_number()==1) %>% 
    pull()
  
  colus
  
  ciss <- cis %>% 
    select(all_of(colus))
  
  new_colcode <- colnames(ciss)
  
  a <- tibble(colname = "", colcode = new_colcode, estu = i, year = year)
  
  recu_empty_codes <- rbind(recu_empty_codes, a)
  
}

estu_inten_vacios <- inten_cols_final2 %>%
  mutate(estu = as.numeric(estu),
         year = as.numeric(year)) %>%
  left_join(recu_empty_codes, by = c("estu", "year")) %>%
  filter(is.na(`colcode.y`))

recuer_cols <- combi_vars %>%
  filter(estu %in% unique(estu_inten_vacios$estu)) %>% 
  mutate(colname = as.character(colname)) %>%
  filter(grepl("Recuerdo de voto",colname)) %>%
  # filter(!grepl("recodificada",colname)) %>%
  # filter(!grepl("de los votantes",colname)) %>%
  filter(!grepl("Cataluña",colname)) %>%
  filter(!grepl("Europeo",colname)) %>%
  filter(!grepl("autonómicas",colname)) %>%
  filter(!grepl("europeas",colname)) %>%
  filter(!grepl("municipales",colname)) %>%
  filter(!grepl("Senado",colname)) %>%
  filter(!grepl("europeo",colname)) %>%
  filter(!grepl("por primera vez a un partido",colname)) %>%
  arrange(desc(estu), colcode) %>%
  filter(duplicated(estu) == FALSE)

recuer_cols_final <- recu_empty_codes %>% 
  filter(!is.na(colcode)) %>% 
  rbind(recuer_cols) %>% 
  select(estu, year, rec_voto = colcode) %>% 
  mutate(estu = as.character(estu), year = as.character(year)) %>%
  unique()

inten_cols_final <- inten_cols_final2 %>% 
  left_join(recuer_cols_final, by = c("estu", "year")) %>% 
  mutate_at(vars(`Primer problema`, `Segundo problema`, `Tercer problema`),
            funs(na_if(.,""))) %>% 
  mutate_all(vars(toupper(.))) %>% 
  filter(estu >= 2002) %>%
  unique()

## Extraer variables de intención de voto, problemas y ponderación.

combi_cis <- future_map_dfr(.x = 1:nrow(inten_cols_final),
                        .f = ~{
                          
                          barom <- as.numeric(inten_cols_final[.x, 3])
                          yr <- as.numeric(inten_cols_final[.x, 4])
                          
                          cat(paste0(.x, "_", barom, "_", yr, "\n", sep ="\""))
                          
                          # Montar path
                          
                          path_base <- "[DIRECTORIO DE LOS BARÓMETROS DEL CIS]"
                          path <- paste0(path_base, yr, "/", barom,".sav")
                          
                          # Leer barómetro
                          
                          cis <- read.spss(file = path,
                                           to.data.frame = T,
                                           use.value.labels = T,
                                           reencode = T) %>%
                            suppressWarnings() %>% suppressMessages()
                          
                          colnames(cis) <-  toupper(colnames(cis))
                          
                          variable_voto <- inten_cols_final %>% 
                            filter(estu == barom) %>% 
                            select(colcode) %>% 
                            unique() %>% 
                            pull()
                          
                          sym_var <- sym(variable_voto)
                          
                          variable_recuerdo <- inten_cols_final %>% 
                            filter(estu == barom) %>% 
                            select(rec_voto) %>% 
                            unique() %>% 
                            pull()
                          
                          variable_recuerdo <- ifelse(is.na(variable_recuerdo), "x",variable_recuerdo)
                          
                          sym_rec <- sym(variable_recuerdo)
                          
                          variable_prob <- inten_cols_final %>% 
                            filter(estu == barom) %>% 
                            #filter(col_prob_name == "Primer problema") %>% 
                            select(`Primer problema`) %>% 
                            filter(row_number()==1) %>% 
                            unique() %>% 
                            pull()
                          
                          if ("PESO" %in% colnames(cis) == T & !is.na(variable_prob) & variable_voto != "") {
                            
                            variable_prob1 <- inten_cols_final %>% 
                              filter(estu == barom) %>% 
                              #filter(col_prob_name == "Primer problema") %>% 
                              select(`Primer problema`) %>% 
                              unique() %>% 
                              pull()
                            
                            variable_prob2 <- inten_cols_final %>% 
                              filter(estu == barom) %>% 
                              #filter(col_prob_name == "Segundo problema") %>% 
                              select(`Segundo problema`) %>% 
                              pull()
                            
                            variable_prob3 <- inten_cols_final %>% 
                              filter(estu == barom) %>% 
                              #filter(col_prob_name == "Tercer problema") %>% 
                              select(`Tercer problema`) %>% 
                              pull()
                            
                            sym_prob <- sym(variable_prob1)
                            sym_prob2 <- sym(variable_prob2)
                            sym_prob3 <- sym(variable_prob3)
                            
                            cis <- cis %>% 
                              dplyr::select(!!sym_var, !!sym_rec, !!sym_prob, !!sym_prob2, !!sym_prob3, PESO) %>%
                              mutate(PESO = as.character(PESO)) %>% 
                              mutate(int_voto = !!sym_var,
                                     primer_problema = as.character(!!sym_prob),
                                     segundo_problema = as.character(!!sym_prob2),
                                     tercer_problema = as.character(!!sym_prob3),
                                     rec_voto = !!sym_rec) %>% 
                              #`colnames<-`("int_voto") %>%
                              mutate(id_entrev = 1:n(),
                                     yr = yr,
                                     estudio = barom) %>%
                              dplyr::select(id_entrev, yr, estudio, int_voto,primer_problema,segundo_problema,
                                            tercer_problema,PESO,rec_voto)
                            
                            return(cis)
                            
                          } else if ("PESO" %in% colnames(cis) == T & !is.na(variable_prob) & variable_voto == "") {
                            
                            variable_prob1 <- inten_cols_final %>% 
                              filter(estu == barom) %>% 
                              #filter(col_prob_name == "Primer problema") %>% 
                              select(`Primer problema`) %>% 
                              unique() %>% 
                              pull()
                            
                            variable_prob2 <- inten_cols_final %>% 
                              filter(estu == barom) %>% 
                              #filter(col_prob_name == "Segundo problema") %>% 
                              select(`Segundo problema`) %>% 
                              pull()
                            
                            variable_prob3 <- inten_cols_final %>% 
                              filter(estu == barom) %>% 
                              #filter(col_prob_name == "Tercer problema") %>% 
                              select(`Tercer problema`) %>% 
                              pull()
                            
                            sym_prob <- sym(variable_prob1)
                            sym_prob2 <- sym(variable_prob2)
                            sym_prob3 <- sym(variable_prob3)
                            
                            if (variable_recuerdo == "x") {
                              cis <- cis %>% 
                                dplyr::select(!!sym_prob, !!sym_prob2, !!sym_prob3, PESO) %>%
                                mutate(PESO = as.character(PESO), int_voto = "No se pregunta",
                                       rec_voto = "No se pregunta") %>% 
                                mutate(primer_problema = as.character(!!sym_prob),
                                       segundo_problema = as.character(!!sym_prob2),
                                       tercer_problema = as.character(!!sym_prob3)) %>% 
                                #`colnames<-`("int_voto") %>%
                                mutate(id_entrev = 1:n(),
                                       yr = yr,
                                       estudio = barom) %>%
                                dplyr::select(id_entrev, yr, estudio, int_voto,primer_problema,segundo_problema,
                                              tercer_problema,PESO,rec_voto)
                              return(cis)
                            } else {
                              cis <- cis %>% 
                                dplyr::select(!!sym_rec, !!sym_prob, !!sym_prob2, !!sym_prob3, PESO) %>%
                                mutate(PESO = as.character(PESO), int_voto = "No se pregunta") %>% 
                                mutate(primer_problema = as.character(!!sym_prob),
                                       segundo_problema = as.character(!!sym_prob2),
                                       tercer_problema = as.character(!!sym_prob3),
                                       rec_voto = !!sym_rec) %>% 
                                #`colnames<-`("int_voto") %>%
                                mutate(id_entrev = 1:n(),
                                       yr = yr,
                                       estudio = barom) %>%
                                dplyr::select(id_entrev, yr, estudio, int_voto,primer_problema,segundo_problema,
                                              tercer_problema,PESO,rec_voto)
                              return(cis)
                              
                            }
                            
                            return(cis)
                            
                          } else if (!"PESO" %in% colnames(cis) == T & is.na(variable_prob)) {
                            
                            cis <- cis %>% 
                              dplyr::select(!!sym_var, !!sym_rec) %>%
                              rename(int_voto = !!sym_var,
                                     rec_voto = !!sym_rec) %>% 
                              #`colnames<-`("int_voto") %>%
                              mutate(id_entrev = 1:n(),
                                     yr = yr,
                                     estudio = barom,
                                     primer_problema = "No se pregunta",
                                     segundo_problema = "No se pregunta",
                                     tercer_problema = "No se pregunta") %>%
                              mutate(PESO = "1") %>% 
                              mutate(PESO = as.character(PESO)) %>% 
                              dplyr::select(id_entrev, yr, estudio, int_voto,segundo_problema,tercer_problema
                                            ,primer_problema,PESO,rec_voto)
                            
                            return(cis) 
                            
                          } else if ("PESO" %in% colnames(cis) == T & is.na(variable_prob)) {
                            
                            cis <- cis %>% 
                              dplyr::select(!!sym_var, !!sym_rec, PESO) %>%
                              mutate(PESO = as.character(PESO)) %>% 
                              rename(int_voto = !!sym_var,
                                     rec_voto = !!sym_rec) %>% 
                              #`colnames<-`("int_voto") %>%
                              mutate(id_entrev = 1:n(),
                                     yr = yr,
                                     estudio = barom,
                                     primer_problema = "No se pregunta",
                                     segundo_problema = "No se pregunta",
                                     tercer_problema = "No se pregunta") %>%
                              dplyr::select(id_entrev, yr, estudio, int_voto,
                                            primer_problema,segundo_problema,tercer_problema,PESO,rec_voto)
                            
                            return(cis)
                          } else if (!"PESO" %in% colnames(cis) == T & !is.na(variable_prob) & variable_voto == "") {
                            
                            variable_prob1 <- inten_cols_final %>% 
                              filter(estu == barom) %>% 
                              #filter(col_prob_name == "Primer problema") %>% 
                              select(`Primer problema`) %>% 
                              unique() %>% 
                              pull()
                            
                            variable_prob2 <- inten_cols_final %>% 
                              filter(estu == barom) %>% 
                              #filter(col_prob_name == "Segundo problema") %>% 
                              select(`Segundo problema`) %>% 
                              pull()
                            
                            variable_prob3 <- inten_cols_final %>% 
                              filter(estu == barom) %>% 
                              #filter(col_prob_name == "Tercer problema") %>% 
                              select(`Tercer problema`) %>% 
                              pull()
                            
                            sym_prob <- sym(variable_prob1)
                            sym_prob2 <- sym(variable_prob2)
                            sym_prob3 <- sym(variable_prob3)
                            
                            if (variable_recuerdo == "x") {
                              cis <- cis %>% 
                                dplyr::select( !!sym_prob, !!sym_prob2, !!sym_prob3) %>%
                                mutate(PESO = "1", int_voto = "No se pregunta",
                                       rec_voto = "No se pregunta") %>% 
                                mutate(primer_problema = as.character(!!sym_prob),
                                       segundo_problema = as.character(!!sym_prob2),
                                       tercer_problema = as.character(!!sym_prob3)) %>% 
                                #`colnames<-`("int_voto") %>%
                                mutate(id_entrev = 1:n(),
                                       yr = yr,
                                       estudio = barom) %>%
                                dplyr::select(id_entrev, yr, estudio, int_voto,primer_problema,segundo_problema,
                                              tercer_problema,PESO,rec_voto)
                              return(cis)
                              
                            } else {          
                              cis <- cis %>% 
                                dplyr::select(!!sym_rec, !!sym_prob, !!sym_prob2, !!sym_prob3) %>%
                                mutate(PESO = "1", int_voto = "No se pregunta") %>% 
                                mutate(primer_problema = as.character(!!sym_prob),
                                       segundo_problema = as.character(!!sym_prob2),
                                       tercer_problema = as.character(!!sym_prob3),
                                       rec_voto = !!sym_rec) %>% 
                                #`colnames<-`("int_voto") %>%
                                mutate(id_entrev = 1:n(),
                                       yr = yr,
                                       estudio = barom) %>%
                                dplyr::select(id_entrev, yr, estudio, int_voto,primer_problema,segundo_problema,
                                              tercer_problema,PESO,rec_voto)
                              return(cis)
                              
                            }
                            
                            return(cis)
                            
                          } else {
                            
                            variable_prob1 <- inten_cols_final %>% 
                              filter(estu == barom) %>% 
                              #filter(col_prob_name == "Primer problema") %>% 
                              select(`Primer problema`) %>% 
                              unique() %>% 
                              pull()
                            
                            variable_prob2 <- inten_cols_final %>% 
                              filter(estu == barom) %>% 
                              #filter(col_prob_name == "Segundo problema") %>% 
                              select(`Segundo problema`) %>% 
                              pull()
                            
                            variable_prob3 <- inten_cols_final %>% 
                              filter(estu == barom) %>% 
                              #filter(col_prob_name == "Tercer problema") %>% 
                              select(`Tercer problema`) %>% 
                              pull()
                            
                            sym_prob <- sym(variable_prob1)
                            sym_prob2 <- sym(variable_prob2)
                            sym_prob3 <- sym(variable_prob3)
                            
                            cis <- cis %>% 
                              dplyr::select(!!sym_var, !!sym_rec, !!sym_prob, !!sym_prob2, !!sym_prob3) %>%
                              mutate(PESO = "1") %>% 
                              mutate(int_voto = !!sym_var,
                                     primer_problema = as.character(!!sym_prob),
                                     segundo_problema = as.character(!!sym_prob2),
                                     tercer_problema = as.character(!!sym_prob3),
                                     rec_voto = !!sym_rec) %>% 
                              #`colnames<-`("int_voto") %>%
                              mutate(id_entrev = 1:n(),
                                     yr = yr,
                                     estudio = barom) %>%
                              dplyr::select(id_entrev, yr, estudio, int_voto,
                                            primer_problema,segundo_problema,tercer_problema,rec_voto,PESO)
                            return(cis)
                          }
                          
                        }) %>% 
mutate(concat = paste0(estudio, id_entrev))

#COMBINAR DATOS----

## Combinar FID con Intención de Voto, problemas y ponderación

sys_time<- Sys.time()
Sys.time()

raw_dataset2 <- fid %>%
mutate(`A.4`= as.character(`A.4`)) %>% 
mutate(`A.4`= as.numeric(`A.4`)) %>% 
left_join(combi_cis, by = "concat") %>%
dplyr::select(-estudio) %>%

### Renombrar columnas y recategorizar variables
  
renom_col() %>%
recategorizar() %>%

### Asignar fecha de elecciones
  
arrange(desc(`añomes`)) %>%
mutate(legislatura = case_when(
`añomes` <= 199306 ~ "04",
`añomes` <= 199603 ~ "05",
`añomes` <= 200003 ~ "06",
`añomes` <= 200403 ~ "07",
`añomes` <= 200803 ~ "08",
`añomes` <= 201111 ~ "09",
`añomes` <= 201512 ~ "10",
`añomes` <= 201606 ~ "11",
`añomes` <= 201904 ~ "12",
`añomes` <= 201911 ~ "13",
`añomes` <= 202312 ~ "14",
TRUE ~ ""),

### Añadir grupos de edad

edad = as.numeric(edad),
grupos_edad = case_when(
  edad >= 18 & edad <= 29 ~ "18-29",
  edad >= 30 & edad <= 44 ~ "30-44",
  edad >= 45 & edad <= 64 ~ "45-64",
  edad >= 65 ~ "65+",
  TRUE ~ ""),

grupos_edad_plus = case_when(
  edad >= 18 & edad <= 24 ~ "18-24",
  edad >= 25 & edad <= 34 ~ "25-34",
  edad >= 35 & edad <= 44 ~ "35-44",
  edad >= 45 & edad <= 54 ~ "45-54",
  edad >= 55 & edad <= 64 ~ "55-64",
  edad >= 65 & edad <= 74 ~ "65-74",
  edad >= 75 ~ "75+",
  TRUE ~ ""),

### Añadir grupos ideológicos

grupos_ideol = case_when(
  escala_autoubic_ideol >= 9 ~ "Derecha",
  escala_autoubic_ideol == 8 ~ "Centro-Derecha",
  escala_autoubic_ideol == 7 ~ "Centro-Derecha",
  escala_autoubic_ideol == 6 ~ "Centro",
  escala_autoubic_ideol == 5 ~ "Centro", 
  escala_autoubic_ideol == 4 ~ "Centro-Izquierda",
  escala_autoubic_ideol == 3 ~ "Centro-Izquierda", 
  escala_autoubic_ideol <= 2 ~ "Izquierda",
  TRUE ~ ""),

### Agrupar felicidad persona

grupos_felicidad = case_when(
  felicidad_pers >= 7 ~ "Feliz",
  felicidad_pers <= 4 ~ "Infeliz",
  felicidad_pers == 5 ~ "Ni feliz ni infeliz",
  felicidad_pers == 6 ~ "Ni feliz ni infeliz",
  TRUE ~ ""),

yrmes = paste(`año`, mes, sep = "-"),
año_nacimiento = as.numeric(`año` - edad),

### Generación

generacion = case_when(
  año_nacimiento >= 1994 & año_nacimiento <= 2010 ~ "Generación Z",
  año_nacimiento >= 1981 & año_nacimiento <= 1993 ~ "Millennials",
  año_nacimiento >= 1969 & año_nacimiento <= 1980 ~ "Generación X",
  año_nacimiento >= 1949 & año_nacimiento <= 1968 ~ "Baby Boomers",
  año_nacimiento >= 1930 & año_nacimiento <= 1948 ~ "Generación Silenciosa",
  año_nacimiento >= 1901 & año_nacimiento <= 1929 ~ "Generación Grandiosa",
  año_nacimiento >= 1883 & año_nacimiento <= 1900 ~ "Generación Perdida",
  TRUE ~ "Otros"),

### Zonas geográfcias - Municipios anonimizados

zonas_nielsen = case_when(
  prov == "Illes Balears" ~ "Noreste",
  prov == "Huesca" ~ "Noreste",
  prov == "Zaragoza"  ~ "Noreste",
  ccaa == "Cataluña" & mun != "Ávila / Barcelona" ~ "Noreste",
  prov == "Albacete" ~ "Levante",
  prov == "Murcia" ~ "Levante",
  ccaa == "Comunitat Valenciana" ~ "Levante",
  prov == "Badajoz" ~ "Sur",
  prov == "Ceuta" ~ "Sur",
  prov == "Melilla" ~ "Sur",
  ccaa == "Andalucía" ~ "Sur",
  prov == "Zamora" ~ "Centro",
  prov == "Valladolid" ~ "Centro",
  prov == "Salamanca" ~ "Centro",
  prov == "Ávila" ~ "Centro",
  prov == "Segovia" ~ "Centro",
  prov == "Soria" ~ "Centro",
  prov == "Cáceres" ~ "Centro",
  prov == "Madrid" & mun != "Girona / Madrid" ~ "Centro",
  prov == "Toledo" ~ "Centro",
  prov == "Guadalajara" ~ "Centro",
  prov == "Ciudad Real" ~ "Centro",
  prov == "Cuenca" ~ "Centro",
  prov == "Teruel" ~ "Centro",
  ccaa == "Galicia" ~ "Noroeste",
  prov == "Asturias (Principado de)" ~ "Noroeste",
  prov == "León" ~ "Noroeste",
  prov == "Cantabria" ~ "Norte",
  ccaa == "País Vasco" ~ "Norte",
  ccaa == "Navarra (Comunidad Foral de)" ~ "Norte",
  prov == "Palencia" ~ "Norte",
  prov == "Burgos" ~ "Norte",
  prov == "Rioja (La)" ~ "Norte",
  ccaa == "Canarias" ~ "Canarias",
  mun == "Girona / Madrid" ~ "Área metrop. de Madrid", 
  mun == "Ávila / Barcelona" ~ "Área metrop. de Barcelona",
  TRUE ~ ""))

eject_duration <- Sys.time() - sys_time
eject_duration

raw_dataset3 <- raw_dataset2 %>%
dplyr::select(-escala_autoubic_ideol) %>%
left_join(elecciones %>%
           select(-info, -legislatura), by = c("legislatura" = "legis_id")) %>%
left_join(barometros, by = "estudio") %>%
mutate(dias_rest = abs(as.numeric(eday - fecha))) %>%
unique() %>%
select(-yrmes) %>%

## Estandarizar nombres de los partidos/coaliciones
mutate(id_party_int = paste(legislatura, int_voto, sep = "-"),
     id_party_rec = paste(legislatura, rec_voto, sep = "-")) %>%
left_join(party_names_int, by = "id_party_int") %>%
left_join(party_names_rec, by = "id_party_rec") %>%
mutate(int_voto = new_name_int,
     rec_voto = new_name_rec) %>%
select(-contains("id_party"), -contains("old_name"), -contains("new_name"))

## Reordenar columnas

full_raw_dataset <- raw_dataset3 %>%
reorder()

raw_dataset <- raw_dataset3 %>%
filter(estudio %in% inten_cols_final$estu) %>%
reorder()

#check etiquetas recuerdo----

recu_sin_name <- raw_dataset %>% 
filter(is.na(rec_voto)) %>% 
select(numentr) %>% 
pull()

recat_recu <- raw_dataset2 %>% 
filter(numentr %in% recu_sin_name) %>% 
select(legislatura, rec_voto) %>% 
unique()

#GUARDAR DATOS----

write.csv(raw_dataset, "0_precisa_datasets/output/raw_dataset.csv")
write.csv(full_raw_dataset, "0_precisa_datasets/output/full_raw_dataset.csv")
saveRDS(raw_dataset, file = "0_precisa_datasets/output/raw_dataset.RDS")
saveRDS(full_raw_dataset, file = "0_precisa_datasets/output/full_raw_dataset.RDS")
saveRDS(elecciones, file = "0_precisa_datasets/output/elecciones.RDS")
save.image(file = "0_precisa_datasets/output/env/raw_dataset_env.RData")