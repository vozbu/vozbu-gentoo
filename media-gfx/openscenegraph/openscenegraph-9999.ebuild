# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit subversion

ESVN_REPO_URI="http://www.openscenegraph.org/svn/osg/OpenSceneGraph/trunk"

DESCRIPTION="Cross platform, object orientated threading library maintained by the OpenSceneGraph team."
HOMEPAGE="http://www.openscenegraph.org/"
SLOT="0"
LICENSE="OSGPL-2.1"
KEYWORDS="~x86 ~amd64"
IUSE="debug examples"

DEPEND="virtual/opengl 
	app-arch/unzip
	media-libs/jpeg 
	media-libs/tiff
	media-libs/giflib
	media-libs/freetype
	>=dev-util/cmake-2.4.7
	>=media-libs/libpng-1.2 
	media-libs/lib3ds"
RDEPEND="$DEPEND"

src_compile() {
	CMAKE_CONFIG="-DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release"
	if use examples ; then
		CMAKE_CONFIG="${CMAKE_CONFIG} -DBUILD_OSG_EXAMPLES=ON"
	fi
	mkdir build
	cd build
	cmake ../ ${CMAKE_CONFIG}
	emake || die "compile failed"

	if use debug ; then
		CMAKE_DEBUG_CONFIG="-DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Debug -DBUILD_OSG_APPLICATIONS=OFF"
		cd ../
		mkdir build_debug
		cd build_debug
		cmake ../ ${CMAKE_DEBUG_CONFIG}
		emake || die "debug compile failed"
	fi
}

src_install() {
	# First install debug for release overwrites plugin files
	if use debug ; then
		cd build_debug
		make DESTDIR=${D} install || die "einstall failed"
		cd ../
		insinto "/usr/src/${PF}"
		doins -r src/*
	fi

	cd build
	make DESTDIR=${D} install || die "einstall failed"
	cd ../
	insinto "/usr/lib/pkgconfig"
	doins packaging/pkgconfig/openthreads.pc
	doins packaging/pkgconfig/openscenegraph.pc
}
