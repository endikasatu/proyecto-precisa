# Proyecto PRECISA

El **Proyecto PRECISA** es un trabajo que aúna los datos de los barómetros mensuales y el Fichero Integrado de Datos (FID) del Centro de Investigaciones Sociológicas (CIS). El objetivo del proyecto es ofrecer datos demográficos, políticos, económicos, sociales, personales y variables de voto. Para ello, se combinan los distintos ficheros, se estandarizan y se incorporan nuevas variables y, por último, se realizan diferentes análisis a partir de los datos generados previamente.

Este proyecto ha sido realizado por:

- **Roke Álvarez Masso** | [Twitter](https://twitter.com/harlesden88) | [Github](https://github.com/roke1988)
- **Endika Nuñez Larrañaga** | [Twitter](https://twitter.com/endikasatu) | [Github](https://github.com/endikasatu)

Los análisis e interactivos se pueden consultar en el blog **TheElectoralReport**:

- 📊 [Así votan los distintos grupos demográficos en España](https://electoralreport.com/demograficos-2019-2023)

Metodología del proyecto:

- ⚙️ [Qué es y cómo funciona el proyecto PRECISA](https://electoralreport.com/metodologia-proyecto-precisa)



## Capítulos

El **Proyecto PRECISA** se compone de diferentes capítulos. Estas son las que se han publicado hasta ahora:

- 📁 `0_precisa_datasets:` Creación de una base de datos estandarizada que incluye variables demográficas y de voto.
- 📁 `1_demograficos`: Estimación del apoyo a los partidos y coaliciones de los diferentes grupos demográficos.



## Ficheros .csv

| Nombre del fichero   | Descripción                                                  | Capítulo             | Link                                                         |
| -------------------- | ------------------------------------------------------------ | :------------------- | ------------------------------------------------------------ |
| `raw_dataset`        | Microdatos con la intención y recuerdo de voto disponible.   | `0_precisa_datasets` | [🔗](https://github.com/endikasatu/proyecto-precisa/0_precisa_datasets/output/raw_dataset.csv) |
| `full_raw_dataset`   | Microdatos con datos parciales sobre intención y recuerdo de voto. | `0_precisa_datasets` | [🔗](https://github.com/endikasatu/proyecto-precisa/0_precisa_datasets/output/full_raw_dataset.csv) |
| `estudio_final_data` | Estimación de voto de los grupos demográficos para cada barómetro. | `1_demograficos`     | [🔗](https://github.com/endikasatu/proyecto-precisa/1_demograficos/output/estudio_final_data.csv) |
| `legis_final_data`   | Estimación de voto de los grupos demográficos para cada legislatura. | `1_demograficos`     | [🔗](https://github.com/endikasatu/proyecto-precisa/1_demograficos/output/legis_final_data.csv) |



## Licencia

El software publicado en este repositorio se guardan bajo la [licencia MIT](https://github.com/endikasatu/demograficos/blob/main/LICENSE). Los datos generados están disponibles bajo la licencia [Creative Commons Attribution 4.0 International License](https://creativecommons.org/licenses/by/4.0/).

