# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="osgAL is a toolkit for handling spatial (3D) sound in the OpenSceneGraph rendering library."
HOMEPAGE="http://www.vrlab.umu.se/research/osgAL/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND="media-gfx/openscenegraph
	media-libs/freealut
	media-libs/libvorbis"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install
	OSG_VER=`osgversion --version-number`
	dosym /usr/lib/libosgdb_osgAL.so /usr/lib/osgPlugins-${OSG_VER}/osgdb_osgal.so
}

