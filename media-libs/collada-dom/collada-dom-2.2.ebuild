# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit eutils

DESCRIPTION="COLLADA is a COLLAborative Design Activity for establishing an open
standard digital asset schema for interactive 3D applications."
HOMEPAGE="http://www.collada.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip"

LICENSE="SCEA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

# Note builds with only >=gcc-3.4
DEPEND="dev-libs/libxml2
	dev-libs/boost
	dev-libs/libpcre"
RDEPEND="${DEPEND}"

MY_PN="collada-dom"
S="${WORKDIR}/${MY_PN}"

src_unpack() {
	default
	cd "${S}"
	# Paths patch
	epatch ${FILESDIR}/domTest-2.2.patch
	epatch ${FILESDIR}/dom.mk-2.2.patch
}

DOM_VERSION=1.4
DOM_VERSION_WITHOUT_DOT=14

src_compile() {
	cd dom
	MAKE_CONFIG="project=dom"
	use test && MAKE_CONFIG="project=all"
	MAKE_CONFIG="${MAKE_CONFIG} colladaVersion=${DOM_VERSION}"
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
	doins -r ${DOM_VERSION}/dom
	cd ../build
	cd `ls`
	dolib libcollada${DOM_VERSION_WITHOUT_DOT}dom.*
	dolib libminizip.*
	if use test; then
		dobin domTest
		insinto /usr/share/${PN}
		cd ../../
		doins -r test/${DOM_VERSION}/data
	fi
}
