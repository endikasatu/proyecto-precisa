# Proyecto PRECISA

El proyecto PRECISA es un estudio prospectivo que tiene como objetivo ofrecer una herramienta de análisis a partir de los datos del Centro de Investigaciones Sociológicas (CIS). Para ello, se han agregado más de 300 barómetros de las últimas tres décadas, desde junio de 1989 hasta la actualidad. Entre todos los barómetros se configura una base de datos de más de 800.000 entrevistas y 70 variables a lo largo de todo el territorio. Este proyecto no incluye estudios preelectorales y postelectorales del CIS.

Este proyecto ha sido realizado por:

- **Roke Álvarez Masso** | [Twitter](https://twitter.com/harlesden88) | [Github](https://github.com/roke1988)
- **Endika Nuñez Larrañaga** | [Twitter](https://twitter.com/endikasatu) | [Github](https://github.com/endikasatu)

Los análisis e interactivos se pueden consultar en el blog **TheElectoralReport**:

- 📊 [Así votan los distintos grupos demográficos en España](https://electoralreport.com/demograficos-2019-2023)

Metodología del proyecto:

- ⚙️ [Qué es y cómo funciona el proyecto PRECISA](https://electoralreport.com/metodologia-proyecto-precisa)

## Capítulos

El  proyecto **PRECISA** se compone de diferentes capítulos. Estas son las que se han publicado hasta ahora:

- 📁 [**`0_precisa_datasets`**](https://github.com/endikasatu/proyecto-precisa/tree/main/0_precisa_datasets): Base de datos estandarizada que incluye variables demográficas, políticas, económicas, sociales y personales.
- 📁 [**`1_demograficos`**](https://github.com/endikasatu/proyecto-precisa/tree/main/1_demograficos): Estimación del apoyo a los partidos de los diferentes grupos demográficos.
- 📁 2_int_voto_grupos: Evolución de la estimación de voto a los partidos de los diferentes grupos demográficos.
- 📁 3_matriz_transferencias: Transferencias de voto entre partidos. 
- 📁 4_pricipales_problemas: Principales problemas de España.
- 📁 5_perfil_votantes: Perfil de los partidos políticos.

## Ficheros .csv

| Nombre del fichero | Descripción                                                  | Capítulo             | Link                                                         |
| ------------------ | ------------------------------------------------------------ | :------------------- | ------------------------------------------------------------ |
| `raw_dataset`      | Microdatos con la intención y recuerdo de voto disponible.   | `0_precisa_datasets` | [🔗](https://github.com/endikasatu/proyecto-precisa/blob/main/0_precisa_datasets/output/raw_dataset.RDS) |
| `full_raw_dataset` | Microdatos con datos parciales sobre intención y recuerdo de voto. | `0_precisa_datasets` | [🔗](https://github.com/endikasatu/proyecto-precisa/blob/main/0_precisa_datasets/output/full_raw_dataset.RDS) |

## Artículos en prensa

| Medio de comunicación | Titular                                                      | Capítulo                  | Link                                                         |
| --------------------- | ------------------------------------------------------------ | :------------------------ | ------------------------------------------------------------ |
| `elDiario.es`         | Sexo, religión, edad o estudios: cómo ha cambiado el perfil del votante según el CIS | ``2_int_voto_grupos``     | [🔗](https://www.eldiario.es/politica/sexo-religion-edad-estudios-cambiado-perfil-votante-cis_1_8546042.html) |
| `elDiario.es`         | Con Rajoy, la corrupción; con Sánchez, la economía: la evolución de las preocupaciones ciudadanas, según el CIS | `4_pricipales_problemas`  | [🔗](https://www.eldiario.es/politica/rajoy-corrupcion-sanchez-economia-evolucion-preocupaciones-ciudadanas-cis_1_8547695.html) |
| `elDiario.es`         | Un mundo bipartidista que colapsó: cómo refleja el CIS el cambio a la fragmentación política | `3_matriz_transferencias` | [🔗](https://www.eldiario.es/politica/mundo-bipartidista-colapso-refleja-cis-cambio-fragmentacion-politica_1_8548214.html) |
| `elDiario.es`         | La importancia de las mujeres y el papel de los jóvenes: quién compone la bolsa de votantes de cada partido | `5_perfil_votantes`       | [🔗](https://www.eldiario.es/politica/importancia-mujeres-papel-jovenes-votantes-compone-bolsa-votantes-partido_1_8548380.html) |

## Licencia

El software publicado en este repositorio se guardan bajo la [licencia MIT](https://github.com/endikasatu/demograficos/blob/main/LICENSE). Los datos generados están disponibles bajo la licencia [Creative Commons Attribution 4.0 International License](https://creativecommons.org/licenses/by/4.0/).

