#!/bin/bash

toast_fake_focalplane \
--out fake_blast.h5 \
--min_pix 127 \
--fwhm_arcmin 1.0 \
--fov_deg 2.0 \
--sample_rate 100.0 \
--pol_leakage 0.0 \
--psd_fknee 0.05 \
--psd_net 0.0001 \
--psd_alpha 1.0 \
--psd_fmin 1.0e-5 \
--bandcenter_ghz 150.0 \
--bandwidth_ghz 30.0
