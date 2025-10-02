-- Select buildings and get the distance of buildings to a selected location
SELECT 
  p.osm_id,
  p."addr:street",
  p."addr:housenumber",
  p."addr:city",
  p."addr:postcode",
  p.building,
  ST_Distance(
    ST_Transform(p.way, 4326)::geography,
  -- Zürich, Grossmünster
    ST_SetSRID(ST_MakePoint(8.54394, 47.37011), 4326)::geography
  ) AS distance,
  ST_Transform(p.way, 4326) AS way_transformed
FROM 
public.planet_osm_polygon AS p
WHERE 
p."addr:street" IS NOT NULL
AND p."addr:city" = 'Zürich'
AND p."addr:postcode" IN ('8055', '8003')

SELECT
            p.osm_id,
            p.shop,
            p.name
            ST_Distance(
                ST_Transform(p.way, 4326)::geography,
                ST_SetSRID(ST_MakePoint(8.53936, 47.3781), 4326)::geography
            ) AS distance_meters,
            ST_TRANSFORM(p.way, 4326) AS geom
         FROM
            public.planet_osm_point AS p
         WHERE
            p.shop = 'hairdresser'
            -- AND p.distance_meters <= 500m