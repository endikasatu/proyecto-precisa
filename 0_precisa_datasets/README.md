# Proyecto PRECISA

El **Proyecto PRECISA** es un trabajo común que tiene como objetivo ofrecer una herramienta de análisis a partir de los barómetros mensuales y el Fichero Integrado de Datos del CIS. Para ello, se han agregado más de 300 barómetros de las últimas tres décadas, desde febrero de 1990 hasta la actualidad.

La idea del proyecto es sencilla. Se trata de articular una gran base de datos donde se puedan consultar las principales variables demográficas, políticas, económicas, sociales, personales y de voto. De esta forma, podemos ofrecer a los analistas, académicos, periodistas o a los cafeteros de la política y la sociología una fuente de datos muy amplia para trabajar.

## Scripts

- **`precisa_raw_dataset.R`**: Código R que se ha utilizado para combinar, organizar, limpiar, transformar y estandarizar los datos.

## Ficheros .RDS

- **`raw_dataset`**: Microdatos del CIS estandarizados. Solo contiene barómetros que incorporan intención y recuerdo de voto.

- **`full_raw_dataset`**: Versión extendida de *raw_dataset*. Incorpora todos los barómetros, independientemente de si contiene intención o recuerdo de voto.

## Variables

- `estudio`: Número de estudio
- `numentr`: Nº único de la persona entrevistada
- `legislatura`: Legislatura al que pertenece el estudio
- `año`: Año del estudio
- `mes`: Mes del estudio
- `fecha`: Fecha de publicación del estudio
- `eday`: Día de elecciones
- `dias_rest`: Días restantes entre la fecha de publicación del estudio y las elecciones
- `ccaa`: Comunidad Autónoma de la persona entrevistada
- `prov`: Provincia de la persona entrevistada
- `mun`: Municipio de la persona entrevistada
- `peso`: Peso de ponderación por CCAA asignada por el CIS (a partir de 2021)
- `int_voto`: Intención de voto para las próximas elecciones de la persona entrevistada
- `rec_voto`: Recuerdo de voto de las anteriores elecciones de la persona entrevistada
- `primer_problema`: Primer problema más importante de la persona entrevistada
- `segundo_problema`: Segundo problema más importante de la persona entrevistada
- `tercer_problema`: Tercer problema más importante de la persona entrevistada
- `sexo`: Sexo de la persona entrevistada
- `edad`: Edad de la persona entrevistada
- `grupos_edad`: Grupo de edad al que pertenece la persona entrevistada
- `grupos_edad_plus`: Grupos de edad detallado al que pertenece la persona entrevistada
- `edad`: Edad de la persona entrevistada
- `año_nacimiento`: Año de nacimiento de la persona entrevistada
- `generacion`: Generación al que pertenece la persona entrevistada
- `pareja_vivienda`: Situación de convivencia de las personas no casadas
- `estado_civil`: Estado civil de la persona entrevistada
- `convivencia`: Situación de convivencia de las personas no casadas
- `grupos_felicidad`: Escala de felicidad personal (0-10) agrupada en bloques
- `religiosidad`: Religiosidad de la persona entrevistada
- `freq_asist_relig`: Frecuencia de asistencia a oficios religiosos de la persona entrevistada
- `escolarizacion`: Escolarización de la persona entrevistada
- `nivel_estudios`: Nivel de estudios alcanzado por la persona entrevistada
- `zonas_nielsen`: Zonas geográficas [Nielsen](https://www.mapa.gob.es/es/alimentacion/temas/consumo-tendencias/distribucion-agroalimentaria/zonasgeo.aspx) al que pertenece la persona entrevistada
- `capital`: La persona entrevistada vive en una capital de provincia
- `tam_habitat`: Tamaño de hábitat de la persona entrevistada
- `nacionalidad`: Nacionalidad de la persona entrevistada
- `nac_extrangero`: Nacionalidad de la persona entrevistada (extranjeros)
- `moment_adq_nac`: Momento de adquisición de la nacionalidad española de la persona entrevistada
- `sentimiento_nac`: Sentimiento nacionalista de la persona entrevistada
- `organ_territorial`: Preferencia de la persona entrevistada entre diferentes alternativas de organización territorial del Estado en España
- `conoc_lengua`: Nivel de conocimiento de la lengua castellana de la persona entrevistada
- `conoc_lengua_atrib`: Nivel de conocimiento de la lengua castellana atribuido (entrevistador) de la persona entrevistada
- `fidelidad`: Fidelidad de voto en elecciones de la persona entrevistada
- `escala_autoubic_ideol`:  Escala de autoubicación ideológica (1-10) de la persona entrevistada [ 1-2: Izquierda; 3-4: Centro-Izquierda; 5-6: Centro; 7-8: Centro-Derecha; 9-10: Derecha]
- `grupos_ideol`: Escala de autoubicación ideológica (1-10) de la persona entrevistada agrupada en bloques que van de Izquierda a Derecha
- `val_sit_poli_esp`: Valoración de la situación política general de España
- `val_retros_poli_esp`: Valoración retrospectiva de la situación política de España (1 año)
- `val_prosp_poli_esp`: Valoración prospectiva de la situación política de España (1 año)
- `val_gestion_gob`: Valoración de la gestión del Gobierno central
- `val_labor_opos`: Valoración de la labor del primer partido de la oposición (Gobierno central)
- `val_sit_econ_esp`: Valoración de la situación económica general de España
- `val_retros_econ_esp`: Valoración retrospectiva de la situación económica de España (1 año)
- `val_prosp_econ_esp`: Valoración prospectiva de la situación económica de España (1 año)
- `val_sit_econ_pers`: Valoración de la situación económica personal actual
- `val_retros_econ_pers`: Valoración retrospectiva de la situación económica personal
- `val_prosp_econ_pers`: Valoración prospectiva de la situación económica personal
- `tipo_empresa`: Tipo de empresa u organización de la persona entrevistada
- `sit_laboral`: Situación laboral de la persona entrevistada
- `sit_profesional`: Situación profesional de la persona entrevistada
- `condicion_socioeconomica`: Condición socioeconómica de la persona entrevistada
- `estatus_socioeconomico`: Estatus socioeconómico de la persona entrevistada
- `prob_encontrar_empleo`: Probabilidad de encontrar empleo (Próximos 12 meses) (Solo a quienes están parados)
- `prob_perder_empleo`: Probabilidad de perder el empleo actual (Próximos 12 meses) (Solo a quienes trabajan)
- `aporte_ingresos_hogar`: Persona que aporta más ingresos al hogar
- `ingresos_hogar`: Ingresos del hogar de la persona entrevistada
- `ingresos_pers`: Ingresos personales de la persona entrevistada

