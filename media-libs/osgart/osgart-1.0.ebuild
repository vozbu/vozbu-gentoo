# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: valery.bickov@gmail.com$

inherit eutils

DESCRIPTION="OSGART is a library that simplifies the development of Augmented
Reality or Mixed Reality applications by combining the well-known ARToolKit
tracking library with OpenSceneGraph."
HOMEPAGE="http://www.artoolworks.com/community/osgart/"
MY_PN="osgART"
S="${WORKDIR}/${MY_PN}"
SRC_URI="http://www.artoolworks.com/dist/osgart/release/1.0/${MY_PN}-${PV}.tar.bz2"
SLOT="0"
LICENSE="Dual-licensed, under the GPL, plus commercially"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=">=media-libs/artoolkit-2.72
	>=media-gfx/openscenegraph-2.2.0"
RDEPEND=">=media-gfx/openscenegraph-2.2.0"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	epatch ${FILESDIR}/osgARTTest.patch
	epatch ${FILESDIR}/GNUmakefile.patch
}

src_compile() {
	cd bin
	emake -f GNUmakefile ARTOOLKIT_PATH=/usr
	cd ../
}

src_install() {
	dobin bin/osgart_example
	dolib bin/*.so
	insinto /usr
	doins -r include
	insinto /usr/share/${MY_PN}
	doins -r bin/Data bin/images bin/models bin/shaders bin/videos
	dodoc AUTHORS LICENSE.txt README
}

