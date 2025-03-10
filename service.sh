until [ "$(getprop sys.boot_completed)" = "1" ]; do
  sleep 10
done

settings put secure google_restric_info 0
