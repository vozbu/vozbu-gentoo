# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="library for controling IEEE 1394 conforming based cameras"
HOMEPAGE="http://sourceforge.net/projects/libdc1394/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="X doc +juju usb"

DEPEND=">=sys-libs/libraw1394-1.2.0
		doc? ( app-doc/doxygen )
		juju? ( >=sys-kernel/linux-headers-2.6.23-r3 )
		usb? ( >=dev-libs/libusb-1.0 )
		X? ( x11-libs/libSM x11-libs/libXv )"

src_configure() {
	econf \
		--program-suffix=2 \
		$(use_with X x) \
		$(use_enable doc doxygen-html) \
		|| die "econf failed"
}

src_compile() {
	emake || die "emake failed"
	if use doc ; then
		emake doc || die "emake doc failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc NEWS README AUTHORS ChangeLog
	use doc && dohtml doc/html/*
}
