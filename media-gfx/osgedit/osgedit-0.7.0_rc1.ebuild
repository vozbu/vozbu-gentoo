# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit eutils versionator

DESCRIPTION="OSGEdit is an editor of scenes for the library OpenSceneGraph"
HOMEPAGE="http://osgedit.sourceforge.net/"
MY_PVR=$(replace_version_separator '_' '-')
SRC_URI="mirror://sourceforge/${PN}/${PN}_${MY_PVR}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-cpp/gtkmm-2.4
	>=dev-cpp/gtksourceviewmm-2.0
	>=dev-cpp/libxmlpp-2.6
	>=media-gfx/openscenegraph-2.2.0
	>=x11-libs/gtkglext-1.0"
DEPEND="dev-util/scons
	${RDEPEND}"

S=${WORKDIR}/${PN}
src_prepare() {
	epatch ${FILESDIR}/*.patch || die "Patch failed"
}

src_compile() {
	# Extracting parameter -j from MAKEOPTS.
	SCONSOPTS=`echo ${MAKEOPTS} | sed -r s/^.*\(-j[0-9]+[\ $]\).*$/\\\\1/g`
	scons release ${SCONSOPTS} || die "Compile failed"
}

src_install() {
	# Doesn't call die because install script contains errors
	DESTDIR="${D}" scons install
}
