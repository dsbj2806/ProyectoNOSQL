MATCH (v:Persona)
WITH v, split(v.ViveEn, ',') AS coords
WITH v, toFloat(coords[0]) AS latitud, toFloat(coords[1]) AS longitud
SET v.ViveEn = point({ longitude: longitud, latitude: latitud })