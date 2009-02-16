# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit subversion

ESVN_REPO_URI="svn://projects.tevs.eu/osgPPU/trunk"

DESCRIPTION="Post processing library for using with OpenSceneGraph"
HOMEPAGE="http://projects.tevs.eu/osgppu"

LICENSE="OSGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

RDEPEND=">=media-gfx/openscenegraph-2.8.0"
DEPEND="$RDEPEND
	>=dev-util/cmake-2.4.5"

S=$S/$PF

src_configure() {
	CMAKE_CONFIG="-DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release"
	mkdir build
	cd build
	cmake ../ $CMAKE_CONFIG || die "Configure failed"
}

src_compile() {
	cd build
	emake || die "Compile failed"
}

src_install() {
	cd build
	emake DESTDIR=$D install || die "Install failed"
	if use examples ; then
		exeinto /usr/share/osgPPU/bin
		doexe bin/*
	fi
}
