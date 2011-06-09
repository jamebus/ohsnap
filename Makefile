prefix?=/usr/local
sysconfdir?=${prefix}/etc
sbindir?=${prefix}/sbin

all: ohsnap ohsnap.conf.sample

ohsnap: t.awk LICENSE.formatted ohsnap.in
	awk -v sysconfdir=${sysconfdir} -v sbindir=${sbindir} -f t.awk < ohsnap.in > ohsnap

LICENSE.formatted: LICENSE
	fmt -c < LICENSE > LICENSE.formatted

ohsnap.conf.sample: t.awk ohsnap.conf.sample.in
	awk -v sysconfdir=${sysconfdir} -v sbindir=${sbindir} -f t.awk < ohsnap.conf.sample.in > ohsnap.conf.sample

install: ohsnap ohsnap.conf.sample
	install -m 0500 ohsnap ${sbindir}
	install -m 0400 ohsnap.conf.sample ${sysconfdir}
	test -f ${sysconfdir}/ohsnap.conf || install -m 0600 ohsnap.conf.sample ${sysconfdir}/ohsnap.conf

clean:
	rm -f ohsnap ohsnap.conf.sample LICENSE.formatted

.PHONY: all install clean
