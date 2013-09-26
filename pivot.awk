BEGIN {FS="|";prev_temp="";prev_sch="";output="";}
prev_sch != $2 {print output; prev_temp = $1; prev_sch = $2; output = $2;}
prev_sch = $2 {output = output "\t" $4;}
END {print output; }