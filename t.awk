/^@LICENSE@$/ {
	print "#"
	while ((getline < "LICENSE.formatted") > 0) {
		printf("# %s\n", $0)
	}
	print "#"
	next
}
/@SBINDIR@/ {
	gsub(/@SBINDIR@/, sbindir)
}
/@SYSCONFDIR@/ {
	gsub(/@SYSCONFDIR@/, sysconfdir)
}
{ print }
