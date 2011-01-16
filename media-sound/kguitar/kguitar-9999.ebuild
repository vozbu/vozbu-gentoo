# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit kde4-base subversion
ESVN_REPO_URI="https://kguitar.svn.sourceforge.net/svnroot/kguitar/branches/kde4"

DESCRIPTION="KGuitar is a guitarist helper program focusing on tabulature editing and MIDI synthesizers support"
HOMEPAGE="http://kguitar.sf.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="handbook midi test"

DEPEND="midi? ( >=media-libs/tse3-0.3.0 )"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/kguitar_kde4.patch
}
src_configure() {
	mycmakeargs="${mycmakeargs} $(cmake-utils_use handbook KDE4_ENABLE_HTMLHANDBOOK)"
	mycmakeargs="${mycmakeargs} $(cmake-utils_use midi WITH_TSE3)"
	mycmakeargs="${mycmakeargs} $(cmake-utils_use test KDE4_BUILD_TESTS)"
	cmake-utils_src_configure
}
