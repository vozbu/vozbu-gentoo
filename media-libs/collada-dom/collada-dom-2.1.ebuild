# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="COLLADA is a COLLAborative Design Activity for establishing an open
standard digital asset schema for interactive 3D applications."
HOMEPAGE="http://www.collada.org/"
MY_PN="colladadom"
SRC_URI="mirror://sourceforge/${PN}/${MY_PN}.tar.gz"

LICENSE="SCEA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

# Note builds with only >=gcc-3.4
DEPEND="dev-libs/libxml2
	dev-libs/libpcre
	test? (dev-libs/boost)"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	# Paths patch
	epatch ${FILESDIR}/domTest.patch
}

src_compile() {
	cd dom
	MAKE_CONFIG="project=dom"
	if use test; then
		MAKE_CONFIG="project=all"
	fi
	emake ${MAKE_CONFIG}
}

src_install() {
	cd dom
	insinto /usr/include
	cd include
	doins -r dae
	doins dae.h
	doins dom.h
	doins -r modules
	doins -r 1.4/dom
	cd ../build
	cd `ls`
	dolib libcollada14dom.*
	if use test; then
		dobin domTest
		insinto /usr/share/${PN}
		cd ../../
		doins -r test/data 
	fi
}
