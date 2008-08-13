# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: valery.bickov $

inherit eutils versionator

DESCRIPTION="Data pack for OpenSceneGraph examples"
HOMEPAGE="http://www.openscenegraph.org/"
MY_P="OpenSceneGraph-Data"
RELEASE_V=$(get_version_component_range 1-2 ${PV})
S="${WORKDIR}/${MY_P}-${PV}"
SRC_URI="http://www.openscenegraph.org/downloads/stable_releases/OpenSceneGraph-${RELEASE_V}/${MY_P}-${PV}.zip"
SLOT="0"
LICENSE="OSGPL-2.1"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack "${A}"
	cd "${S}"
}

src_install() {
	insinto "/usr/share/OpenSceneGraph/Data"
	doins -r * || die "Failed to install files to /usr/share/OpenSceneGraph/Data"
	insinto "/etc/env.d"
	doins "${FILESDIR}/90openscenegraph" || die "Failed to install files to /etc/env.d"
}

pkg_postinst() {
	elog
	elog "Run"
	elog "# source /etc/profile"
	elog "if you want to use OpenSceneGraph examples"
	elog "in this session."
}
