#!/bin/bash

fp_file=fake_blast.h5
schedule=fake_blast_schedule.txt
# Set to something small for testing sky coverage, etc
sample_rate=10.0
# sample_rate=100.0

# Output directory
out_dir="sim"
mkdir -p ${out_dir}

# This option is for testing.  It "thins" the focalplane
# by a factor of 1/thinfp.  Set to "1" for all detectors.
thinfp=16

# Make sure that the product of these two numbers
# does not exceed the number of physical cores.
mpi_procs=4
omp_threads=2


#---------------------------------------------

export OMP_NUM_THREADS=${omp_threads}

mpirun -np ${mpi_procs} toast_sim_ground.py \
--focalplane ${fp_file} \
--thinfp ${thinfp} \
--schedule ${schedule} \
--sample_rate ${sample_rate} \
`# Scanning params` \
--sim_ground.scan_rate_az '1.0 deg / s' \
--sim_ground.scan_accel_az '3.0 deg / s2' \
`# Disable atmosphere sim` \
--sim_atmosphere.disable \
`# Simulated sky signal from a map` \
--scan_wcs_map.disable \
`# Noise simulation (from elevation-modulated focalplane parameters)` \
--sim_noise.enable \
`# Gain mismatch` \
`#--gainscrambler.enable` \
`#--gainscrambler.sigma 0.01` \
`# Timeconstant convolution` \
`#--convolve_time_constant.disable` \
`#--convolve_time_constant.tau '3 ms'` \
`# Write to HDF5` \
`#--save_hdf5.enable` \
`# Filter params` \
--polyfilter1D.disable \
`#--polyfilter1D.order 3` \
--polyfilter2D.disable \
`#--polyfilter2D.order 5` \
--common_mode_filter.disable \
`# Pointing matrix` \
--pixels_healpix_radec.disable \
--pixels_healpix_radec.nside 2048 \
--pixels_wcs_radec.enable \
`#--pixels_wcs_radec.auto_bounds` \
--pixels_wcs_radec.projection "CAR" \
--pixels_wcs_radec.resolution "(0.05 deg, 0.05 deg)" \
`# Mapmaking params` \
--mapmaker.iter_max 100 `# only used if templates enabled` \
--mapmaker.map_rcond_threshold 1.0e-5 \
--mapmaker.solve_rcond_threshold 1.0e-5 \
`# Destriping offsets.  Disabling results in a binned map` \
--baselines.enable \
--baselines.step_time "5.0 s" \
--out_dir ${out_dir}
