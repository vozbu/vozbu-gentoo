# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils versionator

DESCRIPTION="Cross platform, object orientated threading library maintained by the OpenSceneGraph team."
HOMEPAGE="http://www.openscenegraph.org/"

MY_PV=$(get_version_component_range 1-3)
MY_P="OpenSceneGraph-${MY_PV}"
if [ $(get_version_component_range 3) -eq 0 ] ; then
	MY_SERIES=$(get_version_component_range 1-2);
else
	MY_SERIES=$(get_version_component_range 1-3);
fi
SRC_URI="http://www.openscenegraph.org/downloads/stable_releases/OpenSceneGraph-${MY_SERIES}/source/${MY_P}.zip"

SLOT="0"
LICENSE="OSGPL-2.1"
KEYWORDS="amd64 x86"
IUSE="collada debug doc examples pdf vnc xine"

MY_CDEPEND="virtual/opengl
	app-arch/unzip
	media-libs/jpeg
	media-libs/tiff
	media-libs/giflib
	media-libs/freetype
	>=media-libs/libpng-1.2
	media-libs/lib3ds
	collada? ( >=media-libs/collada-dom-2.1 )
	pdf? ( app-text/poppler-bindings )
	vnc? ( net-libs/libvncserver )
	xine? ( >=media-libs/xine-lib-1.1.15-r1 )"
DEPEND="$MY_CDEPEND
	>=dev-util/cmake-2.4.7
	doc? ( app-doc/doxygen )"
RDEPEND="$MY_CDEPEND"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	# Apply all patches for this version from single file
	if [ -f ${FILESDIR}/${PV}.patch ] ; then
		epatch ${FILESDIR}/${PV}.patch || die "Patch failed"
	fi
}

src_configure() {
	CMAKE_CONFIG="-DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release -DOSG_USE_REF_PTR_IMPLICIT_OUTPUT_CONVERSION:BOOL=OFF"
	use examples && CMAKE_CONFIG="${CMAKE_CONFIG} -DBUILD_OSG_EXAMPLES:BOOL=ON"
	use doc && CMAKE_CONFIG="${CMAKE_CONFIG} -DBUILD_DOCUMENTATION:BOOL=ON"

	mkdir build
	cd build
	cmake ../ ${CMAKE_CONFIG} || die "Configure failed"

	if use debug ; then
		CMAKE_DEBUG_CONFIG="-DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Debug -DBUILD_OSG_APPLICATIONS=OFF"
		cd ../
		mkdir build_debug
		cd build_debug
		cmake ../ ${CMAKE_DEBUG_CONFIG} || die "Debug configure failed"
	fi
}

src_compile() {
	cd build
	emake || die "Compile failed"
	if use doc ; then
		emake doc_openscenegraph || die "Build documentation failed, try with USE=-doc"
		emake doc_openthreads
	fi

	if use debug ; then
		cd ../build_debug
		emake || die "Debug compile failed"
	fi
}

src_install() {
	# First install debug for release overwrites plugin files
	if use debug ; then
		cd build_debug
		emake DESTDIR=${D} install || die "Install failed"
		cd ../
		insinto "/usr/src/${PF}"
		doins -r src/*
	fi

	cd build
	emake DESTDIR=${D} install || die "Install failed"
	use doc && dosym /usr/doc/OpenSceneGraphReferenceDocs /usr/share/doc/${PF}/html
	cd ../
	insinto "/usr/lib/pkgconfig"
	doins packaging/pkgconfig/openthreads.pc
	doins packaging/pkgconfig/openscenegraph.pc
}
