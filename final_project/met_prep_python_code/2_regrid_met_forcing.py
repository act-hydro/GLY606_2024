import xarray as xr
import xesmf as xe
import sys
import os

num_args = len(sys.argv)
if num_args < 7:
    print("Too few arguments!")
    print("The total number of arguments is %s"%(num_args-1))
    print("python 2_regrid_met_forcing.py <site_id> <input_dir> <output_dir>")
    print("                               <start_year> <end_year> <domain_file>")
    sys.exit()

# site id
site_id    = sys.argv[1] # "01205500"
input_dir  = sys.argv[2] # inpur directory
odir       = sys.argv[3] # output directory
start_year = sys.argv[4] # start year
end_year   = sys.argv[5] # end year
domainfile = sys.argv[6] # domain file

# transfer start_year and end_year to integer
start_year = int(start_year)
end_year   = int(end_year)

ds = xr.open_dataset(domainfile)
# meteorological forcing data
for year in range(start_year,end_year+1):
    print("Start processing Year %s"%year)
    fname = os.path.join(input_dir,"ERA5.%s.orig_rsln.%s.nc"%(site_id,year))
    ds_met = xr.open_dataset(fname)
    ds_met = ds_met.rename({"latitude":"lat","longitude":"lon"})
    if year == start_year:
        regridder = xe.Regridder(ds_met,ds["mask"],method='bilinear')
    ds_met_regrid = regridder(ds_met)
    ofile = os.path.join(odir, "ERA5.%s.regrid.%s.nc"%(site_id,year))
    ds_met_regrid.to_netcdf(ofile)
