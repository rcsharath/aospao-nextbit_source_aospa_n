#!/system/bin/sh
init_completed=`getprop audio.smartamp.init`
retry=0;

smartamp_init(){
     echo ------NXP_SmartAMP init ------ >/dev/kmsg &
     tinymix 'PRI_MI2S_RX Audio Mixer MultiMedia2' 1
     tinyplay /system/etc/silence.wav -d 1 >/dev/null &
     TINYPLAY_PID=$!
     fihnxptest init
     sleep 1
     tinymix 'PRI_MI2S_RX Audio Mixer MultiMedia2' 0
     kill $TINYPLAY_PID
}

if [ "$init_completed" == ""  ]; then
     sleep 6
     while [ "$retry" -le 4 ] && [ "$init_completed" != "init" ]; do
       smartamp_init
       init_completed=`getprop audio.smartamp.init`
       if [ "$init_completed" == "init" ]; then
           echo ------NXP_SmartAMP init success ------ >/dev/kmsg &
       else
           echo ------NXP_SmartAMP init failure ------ >/dev/kmsg &
       retry=$(expr $retry + 1)
       sleep 1
       fi
     done         
#elif [ "$init_completed" == "reinit"  ] ; then
#     echo ------NXP_SmartAMP re-init------ >/dev/kmsg &
#     fihnxptest init &
elif [ "$init_completed" == "init"  ]; then
      echo ------NXP_SmartAMP init success ------ >/dev/kmsg &
fi
