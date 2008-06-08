# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit subversion

ESVN_REPO_URI="http://osgwidget.googlecode.com/svn/trunk/"

DESCRIPTION="Widgets library based on OSG"
HOMEPAGE="http://osgwidget.googlecode.com/"
LICENSE="OSGPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-gfx/openscenegraph"
RDEPEND="${DEPEND}"

src_compile() {
	CMAKE_CONFIG="-DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release"
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
