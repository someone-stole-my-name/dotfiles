update-keepass(){
    current_path=$(pwd)
    cd ~/git/kp
    git add . && git commit -m "update" && git push
    cd $current_path
}

openssl-getCN() {
    if [ -z "$1" ]; then
      echo openssl-getCN CERTIFICATE
      return
  fi

  openssl x509 -noout -subject -in $1
}

valid-ip() {
  perl -MRegexp::Common=net -e 'exit(shift() !~ /^$RE{net}{IPv4}$/)' "$1"
}
