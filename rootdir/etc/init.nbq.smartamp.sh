#!/system/bin/sh
init_completed=`getprop audio.smartamp.init`

if [ "$init_completed" == ""  ]; then
     sleep 6
     echo ------NXP_speaker_INIT------ >/dev/kmsg &
     tinymix 'PRI_MI2S_RX Audio Mixer MultiMedia2' 1
     tinyplay /system/etc/silence.wav -d 1 >/dev/null &
     fihnxptest init
     sleep 1
     tinymix 'PRI_MI2S_RX Audio Mixer MultiMedia2' 0
elif [ "$init_completed" == "reinit"  ]; then
      echo ------NXP_SmartAMP re-init------ >/dev/kmsg &
      fihnxptest init &
elif [ "$init_completed" == "init"  ]; then
      echo ------NXP_SmartAMP init success ------ >/dev/kmsg &
fi
