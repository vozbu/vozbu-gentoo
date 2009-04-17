# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit cmake-utils eutils subversion

ESVN_REPO_URI="svn://projects.tevs.eu/osgPPU/trunk"

DESCRIPTION="Post processing library for using with OpenSceneGraph"
HOMEPAGE="http://projects.tevs.eu/osgppu"

LICENSE="OSGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

RDEPEND=">=media-gfx/openscenegraph-2.8.0"
DEPEND="$RDEPEND"

S=$S/$PF

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
