# PROGRESS BAR CODE

# INITIALIZE THIS OUTSIDE OF LOOP // seq_ids IS WHAT THE FOR LOOP IS LOOPING THROUGH

# PROGRESS BAR
pb <- txtProgressBar(min = 0, max = nrow(seq_ids), style = 3)
timestart <- proc.time()

for (i in 1:nrow(seq_ids)){

	setTxtProgressBar(pb, i-1)
}

# OUTSODE OF LOOP

# PROGRESS BAR
timeend <- proc.time()
totaltime <- timeend-timestart