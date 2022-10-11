#!/bin/bash

# # Just for fun, picking g284
# target_ra=156.0146
# target_dec=-57.9263
# target_width=5.0

# Just for fun, picking B2K deep field
target_ra=82.0
target_dec=-45.0
target_width=15.0

toast_ground_schedule \
--site-lat -77.85 \
--site-lon 166.69 \
--site-alt 36500 \
`# This is a hack for weather stuff` \
--site-name south_pole \
--telescope BLAST \
--patch-coord C \
--el-min-deg 40 \
--el-max-deg 65 \
--sun-el-max-deg 90 \
--sun-avoidance-angle-deg 45 \
--moon-avoidance-angle-deg 45 \
--start "2023-01-01 00:00:00" \
--stop "2023-01-14 00:00:00" \
--gap-s 300 \
--ces-max-time-s 1200 \
--fp-radius-deg 5.0 \
--patch SIMTARGET,1.0,${target_ra},${target_dec},${target_width} \
--out fake_blast_schedule.txt
