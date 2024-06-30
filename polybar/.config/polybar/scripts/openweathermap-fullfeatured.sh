#!/bin/sh

get_icon() {
    case $1 in
        01d) icon="";;  # Clear sky (day) - sun
        01n) icon="";;  # Clear sky (night) - moon
        02d) icon="";;  # Few clouds (day) - sun behind cloud
        02n) icon="";;  # Few clouds (night) - moon behind cloud
        03*) icon="";;  # Scattered clouds - cloud
        04*) icon="";;  # Broken clouds - cloud
        09d) icon="";;  # Shower rain (day) - cloud with rain
        09n) icon="";;  # Shower rain (night) - cloud with rain
        10d) icon="";;  # Rain (day) - sun behind rain cloud
        10n) icon="";;  # Rain (night) - moon behind rain cloud
        11d) icon="";;  # Thunderstorm (day) - lightning
        11n) icon="";;  # Thunderstorm (night) - lightning
        13d) icon="";;  # Snow (day) - snowflake
        13n) icon="";;  # Snow (night) - snowflake
        50d) icon="";;  # Mist (day) - fog
        50n) icon="";;  # Mist (night) - fog
        *) icon="";;    # Default - warning sign
    esac
    echo $icon
}

get_duration() {

    osname=$(uname -s)

    case $osname in
        *BSD) date -r "$1" -u +%H:%M;;
        *) date --date="@$1" -u +%H:%M;;
    esac

}

timestamp_to_HHmm(){
    date -d @$1 +%H:%M
}

if [ -f ~/.env ]; then
  # This ought to include:
  # OPENWEATHER_KEY: openweathermap api key
  # CITY: openweathermap city id
  export $(cat ~/.env | xargs)
else
  echo "Plese ensure env set"
  exit -1
fi


UNITS="metric"
SYMBOL="°"
API="https://api.openweathermap.org/data/2.5"

if [ -n "$CITY" ]; then
    if [ "$CITY" -eq "$CITY" ] 2>/dev/null; then
        CITY_PARAM="id=$CITY"
    else
        CITY_PARAM="q=$CITY"
    fi
    current=$(curl -sf "$API/weather?appid=$OPENWEATHER_KEY&$CITY_PARAM&units=$UNITS")
    forecast=$(curl -sf "$API/forecast?appid=$OPENWEATHER_KEY&$CITY_PARAM&units=$UNITS&cnt=1")
else
    location=$(curl -sf https://location.services.mozilla.com/v1/geolocate?key=geoclue)

    if [ -n "$location" ]; then
        location_lat="$(echo "$location" | jq '.location.lat')"
        location_lon="$(echo "$location" | jq '.location.lng')"

        current=$(curl -sf "$API/weather?appid=$OPENWEATHER_KEY&lat=$location_lat&lon=$location_lon&units=$UNITS")
        forecast=$(curl -sf "$API/forecast?appid=$OPENWEATHER_KEY&lat=$location_lat&lon=$location_lon&units=$UNITS&cnt=1")
    fi
fi

if [ -n "$current" ] && [ -n "$forecast" ]; then
    current_temp=$(echo "$current" | jq ".main.temp" )
    feels_like=$(echo "$current" | jq ".main.feels_like" )
    current_icon=$(echo "$current" | jq -r ".weather[0].icon")

    current_hum=$(echo "$current" | jq ".main.humidity" )
    humidity_icon=""
    forecast_temp=$(echo "$forecast" | jq ".list[].main.temp" | cut -d "." -f 1)
    forecast_icon=$(echo "$forecast" | jq -r ".list[].weather[0].icon")

    if [ "$(awk 'BEGIN {print ("'$current_temp'" > "'$forecast_temp'")}')" -eq 1 ]; then
        trend="▼"  # Downward trend
    elif [ "$(awk 'BEGIN {print ("'$forecast_temp'" > "'$current_temp'")}')" -eq 1 ]; then
        trend="▲"  # Upward trend
    else
        trend="▬"  # No change
    fi


   sun_rise=$(echo "$current" | jq ".sys.sunrise")
   sun_set=$(echo "$current" | jq ".sys.sunset")
   now=$(date +%s)

   if [ "$sun_rise" -gt "$now" ]; then
       # daytime=" $(get_duration "$((sun_rise-now))")"
       sunriseset="󰖜 $(timestamp_to_HHmm "$((sun_rise))")"
   elif [ "$sun_set" -gt "$now" ]; then
       # daytime=" $(get_duration "$((sun_set-now))")"
       sunriseset="󰖛 $(timestamp_to_HHmm "$((sun_set))")"
   else
       # daytime=" $(get_duration "$((sun_rise-now))")"
       sunriseset="󰖜 $(timestamp_to_HHmm "$((sun_rise))")"
   fi

    echo "$(get_icon "$current_icon")  $current_temp$SYMBOL/$feels_like$SYMBOL - $humidity_icon $current_hum - $sunriseset"
fi
