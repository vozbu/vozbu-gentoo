# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit subversion

DESCRIPTION="osgEarth enables on-demand terrain generation in OpenSceneGraph (OSG) applications"
HOMEPAGE="http://wush.net/trac/osgearth"
ESVN_REPO_URI="http://wush.net/svn/osgearth/trunk/"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gdal zip"

RDEPEND=">=dev-libs/expat-2.0.1
	>=media-gfx/openscenegraph-2.6.0
	net-misc/curl
	gdal? ( sci-libs/gdal )
	zip? ( dev-libs/libzip )"
DEPEND="${RDEPEEND}
	>=dev-util/cmake-2.4.6"

src_configure() {
	CMAKE_CONFIG="-DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release"
	mkdir build
	cd build
	cmake ../ ${CMAKE_CONFIG} || die "Configure failed"
}

src_compile() {
	cd build
	emake || die "Compile failed"
}

src_install() {
	cd build
	emake DESTDIR=${D} install || die "Install failed"
	cd ../
	insinto /usr/share/${PN}
	doins -r tests/ || die "Install test data failed"
	doins -r data/ || die "Install data failed"
}
