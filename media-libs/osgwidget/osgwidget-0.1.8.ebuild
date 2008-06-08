# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Widgets library based on OSG"
HOMEPAGE="http://osgwidget.googlecode.com/"
MY_PN="osgWidget"
MY_P="${MY_PN}-${PV}"
SRC_URI="http://osgwidget.googlecode.com/files/${MY_P}.zip"

LICENSE="OSGPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-gfx/openscenegraph"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_compile() {
	CMAKE_CONFIG="-DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release -DOSGWIDGET_USEPYTHON=OFF"
	cd build
	cmake ../ ${CMAKE_CONFIG}
	emake || die "Compile failed"
}

src_install() {
	cd build
	make DESTDIR="${D}" install
	cd "${S}"
	insinto /usr
	doins -r include
}
