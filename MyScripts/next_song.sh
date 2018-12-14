#!/bin/bash
val1=0,6 # Громкость по умолчанию
echo "Текущая громкость = $val1"
   	
for (( ; ; ))
do
   	echo "Нажмите Enter для того, чтобы включить следующей трек [ hit CTRL+C to stop ]"
   	echo "Или введите необходимую громкость (от 0,1 до 0,99):"
	read val0
   	
	val2="0,"
	val3="0."
	if [[ "$val0" =~ "$val2" ]] || [[ "$val0" =~ "$val3" ]]; then
		val1=$val0		
		echo "Текущая громкость = $val1"
		rhythmbox-client --set-volume $val1	
	else
		rhythmbox-client --next --set-volume $val1
	fi

done
