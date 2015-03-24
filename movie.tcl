axes location off
display projection Orthographic

mol new trj/movie.lammpstrj

mol modselect 0 top type 1
mol modstyle 0 top VDW 0.8
mol modcolor 0 top Velocity

mol addrep top
mol modselect 1 top type 2
mol modstyle 1 top VDW 0.5
mol modcolor 1 top Velocity

