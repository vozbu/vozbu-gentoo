# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit cmake-utils subversion

ESVN_REPO_URI="https://osgal.svn.sourceforge.net/svnroot/osgal"
ESVN_PATCHES="${FILESDIR}/osgal-r74.patch"

DESCRIPTION="osgAL is a toolkit for handling spatial (3D) sound in the OpenSceneGraph rendering library."
HOMEPAGE="http://www.vrlab.umu.se/research/osgAL/"
SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-gfx/openscenegraph
	media-libs/freealut
	media-libs/libvorbis"
RDEPEND="${DEPEND}"

src_install() {
	cmake-utils_src_install
	OSG_VER=`osgversion --version-number`
	dosym /usr/lib/libosgdb_osgAL.so /usr/lib/osgPlugins-${OSG_VER}/osgdb_osgal.so
}

