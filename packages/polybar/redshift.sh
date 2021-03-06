#!/bin/sh
envFile=$XDG_CONFIG_HOME/polybar/scripts/env.sh
changeValue=300

changeMode() {
  sed -i "s/REDSHIFT=$1/REDSHIFT=$2/g" $envFile 
  REDSHIFT=$2
  echo $REDSHIFT
}

changeTemp() {
  if [ "$2" -gt 1000 ] && [ "$2" -lt 25000 ]
  then
    sed -i "s/REDSHIFT_TEMP=$1/REDSHIFT_TEMP=$2/g" $envFile 
    redshift -P -O $((REDSHIFT_TEMP+changeValue))
  fi
}

case $1 in 
  toggle) 
    if [ "$REDSHIFT" = on ];
    then
      changeMode "$REDSHIFT" off
      redshift -x
    else
      changeMode "$REDSHIFT" on
      redshift -O "$REDSHIFT_TEMP"
    fi
    ;;
  increase)
    changeTemp $((REDSHIFT_TEMP)) $((REDSHIFT_TEMP+changeValue))
    ;;
  decrease)
    changeTemp $((REDSHIFT_TEMP)) $((REDSHIFT_TEMP-changeValue));
    ;;
  temperature)
    case $REDSHIFT in
      on)
        if (($REDSHIFT_TEMP > 5000)); then
            COLOR="#6b6b6b"
        elif (($REDSHIFT_TEMP > 4000)); then
            COLOR="#7E6A6A"
        elif (($REDSHIFT_TEMP > 3000)); then
            COLOR="#926969"
        elif (($REDSHIFT_TEMP > 2000)); then
            COLOR="#A56868"
        elif (($REDSHIFT_TEMP > 1500)); then
            COLOR="#B96767"
        else
            COLOR="#cc6666"
        fi
        # echo "%{u$COLOR}%{+u}%{F$COLOR} $REDSHIFT_TEMP%{F-}%{u-}%{-u}"

        echo "%{F$COLOR} $REDSHIFT_TEMP%{F-}"
        ;;
      off)
        echo "%{F#6b6b6b} off%{F-}"
        ;;
    esac
    ;;
esac
