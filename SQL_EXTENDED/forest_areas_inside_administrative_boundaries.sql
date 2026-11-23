SELECT
    p.osm_id,
    p.landuse,
    ST_Area(
        ST_Transform(
            ST_Intersection(p.way, z.way),
            32632
        )
    ) / 10000 AS area_ha,
    ST_Transform(
        ST_Intersection(p.way, z.way),
        4326
    ) AS clipped_geom
FROM public.planet_osm_polygon AS p
JOIN public.planet_osm_polygon AS z
  ON ST_Intersects(z.way, p.way)
WHERE
    z.admin_level = '8'
    AND z.name = 'Zürich'
    AND z.boundary = 'administrative'
    AND p.landuse = 'forest';