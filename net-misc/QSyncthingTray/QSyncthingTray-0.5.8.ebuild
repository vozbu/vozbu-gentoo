# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit cmake-utils eutils

DESCRIPTION="A Traybar Application for Syncthing written in C++"
HOMEPAGE="https://github.com/sieren/qsyncthingtray/"
SRC_URI="https://github.com/sieren/QSyncthingTray/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-qt/qtwidgets:5
		dev-qt/qtnetwork:5
		dev-qt/qtprintsupport:5
		"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/CMakeLists.txt.patch"
}

src_install() {
	cmake-utils_src_install
	newicon resources/images/Icon1024.png ${PN}.png
	make_desktop_entry "${PN}" "${PN}" "${PN}" "Network" "StartupNotify=false"
}
