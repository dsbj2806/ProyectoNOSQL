MATCH (v:Viajedos)
WITH v, split(v.Coordenadas, ',') AS coords
WITH v, toFloat(coords[0]) AS latitud, toFloat(coords[1]) AS longitud
SET v.Coordenadas = point({ longitude: longitud, latitude: latitud })