# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit versionator

DESCRIPTION="OSGEdit is an editor of scenes for the library OpenSceneGraph"
HOMEPAGE="http://osgedit.sourceforge.net/"
MY_PVR=$(replace_version_separator '_' '-')
SRC_URI="mirror://sourceforge/${PN}/${PN}_${MY_PVR}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMDEP=">=dev-cpp/gtkmm-2.4
	>=dev-cpp/libgtksourceviewmm-1.0
	>=dev-libs/libxml2-2.6
	>=media-gfx/openscenegraph-2.2.0
	>=x11-libs/gtkglext-1.0"
DEPEND="dev-util/scons
	${COMDEP}"
RDEPEND="${COMDEP}"

