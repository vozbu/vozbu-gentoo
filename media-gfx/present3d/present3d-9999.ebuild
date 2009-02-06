# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit subversion

ESVN_REPO_URI="http://www.openscenegraph.org/svn/Present3D/trunk"

DESCRIPTION="Present3D is the ultimate in mono and stereo presentation tool."
HOMEPAGE="http://www.openscenegraph.org/projects/Present3D/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="examples sdl"
SRC_URI="examples? ( http://www.openscenegraph.org/downloads/present3D/examples/present3D_examples.zip )"

RDEPEND="
	dev-libs/libxml2
	media-gfx/openscenegraph
	sdl? ( media-libs/libsdl )"
DEPEND="
	${RDEPEND}
	>=dev-util/cmake-2.4.7"

src_unpack() {
	subversion_src_unpack
	default
}

src_configure() {
	CMAKE_CONFIG="-DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release"
	use sdl && CMAKE_CONFIG="${CMAKE_CONFIG} -DBUILD_WITH_SDL:BOOL=ON"

	mkdir build
	cd build
	cmake ../ ${CMAKE_CONFIG}
}

src_compile() {
	cd build
	emake || die "compilation failed"
}

src_install() {
	cd build
	emake DESTDIR=${D} install || die "einstall failed"
	if use examples ; then
		cd ../
		insinto /usr/share/${PN}
		doins -r present3D_examples/*
	fi
}
