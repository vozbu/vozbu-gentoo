# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils subversion

ESVN_REPO_URI="svn://projects.tevs.eu/osgPPU/trunk"
ESVN_PATCHES="*.patch"

DESCRIPTION="Post processing library for using with OpenSceneGraph"
HOMEPAGE="http://projects.tevs.eu/osgppu"

LICENSE="OSGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

MY_CDEPEND=">=media-gfx/openscenegraph-9999"
DEPEND="$MY_CDEPEND
	>=dev-util/cmake-2.4.8"
RDEPEND="$MY_CDEPEND"

S=$S/$PF

src_compile() {
	CMAKE_CONFIG="-DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release"
	mkdir build
	cd build
	cmake ../ $CMAKE_CONFIG
	emake || die "compile failed"
}

src_install() {
	cd build
	make DESTDIR=$D install || die "einstall filed"
	if use examples ; then
		exeinto /usr/share/osgPPU/bin
		doexe bin/*
	fi
}
