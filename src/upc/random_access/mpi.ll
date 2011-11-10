#@ class = short
#@ job_type = parallel
#@ node_usage = not_shared
#@ environment = COPY_ALL
#@ tasks_per_node = 32
#@ node = 1
#@ wall_clock_limit = 0:30:00
#@ output = $(host).$(jobid).$(stepid).out
#@ error = $(host).$(jobid).$(stepid).err
#@ queue

export GASNET_BACKTRACE=1
export MP_SHARED_MEMORY=yes  # use shared memory for MPI comm.
export LANG=en_US            # for more descriptive PE error msgs

# #poe  ./random_access 32 32   # (replace hpcc with your application)
