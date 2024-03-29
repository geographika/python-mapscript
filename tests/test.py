import mapscript
r = mapscript.rectObj(373464, 4687412, 598233, 4883840)
proj1 = mapscript.projectionObj("EPSG:4896")
proj2 = mapscript.projectionObj("EPSG:4326")
r.project(proj1, proj2)
print(r)

p = mapscript.pointObj(373464, 4687412)
p.project(proj1, proj2)
print(p)


# { 'minx': 82.72691967750552 , 'miny': 0 , 'maxx': 85.62714007631233 , 'maxy': 0 }

# note using other projection codes produce non-zero values:

r = mapscript.rectObj(373464, 4687412, 598233, 4883840)
proj1 = mapscript.projectionObj("EPSG:32736")
proj2 = mapscript.projectionObj("EPSG:4326")
r.project(proj1, proj2)
print(r)

# { 'minx': 31.30518256990896 , 'miny': -47.96659997779265 , 'maxx': 34.31584673048359 , 'maxy': -46.18725613171959 }

