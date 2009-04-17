# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit cmake-utils eutils

DESCRIPTION="Post processing library for using with OpenSceneGraph"
HOMEPAGE="http://projects.tevs.eu/osgppu"
MY_P="osgPPU-0.4.0"
SRC_URI="http://projects.tevs.eu/osgppu/downloads/15 -> $MY_P.tar.gz"

LICENSE="OSGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cuda examples"

RDEPEND=">=media-gfx/openscenegraph-2.8.0
	cuda? ( dev-util/nvidia-cuda-toolkit )"
DEPEND="$RDEPEND"

S=$WORKDIR/$MY_P

src_prepare() {
	epatch "${FILESDIR}"/${PV}-magicoff.patch
	epatch "${FILESDIR}"/${PV}.patch
}

src_configure() {
	mycmakeargs="${mycmakeargs} $(cmake-utils_use_enable cuda CUDA)"
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	if use examples ; then
		exeinto /usr/share/osgPPU/bin
		doexe $CMAKE_BUILD_DIR/bin/*
		insinto /usr/share/osgPPU
		doins -r Data
		dosym ../Data /usr/share/osgPPU/bin
	fi
}
