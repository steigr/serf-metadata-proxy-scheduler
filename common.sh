
count_alive_proxies() {
	serf members -tag metadata-proxy=true -status=alive \
	| grep -v "^$" \
	| wc -l
}

tag() {
	[[ "x$1" = "xadd" ]] && serf tags -set $2=true
	[[ "x$1" = "xdel" ]] && serf tags -delete $2
}

metadata_proxy() {
	[[ "x$1" = "stop" ]] && tag add metadata-proxy
  systemctl $1 metadata-proxy
	[[ "x$1" = "start" ]] && tag del metadata-proxy
}