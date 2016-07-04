# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit git-2 kde4-base

DESCRIPTION="A DropDrawers clone. Multiple information organizer"
HOMEPAGE="http://basket.kde.org/"
EGIT_REPO_URI="git://github.com/kelvie/basket.git"
EGIT_COMMIT="d5ec89"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"

IUSE="debug crypt"

PATCHES=(
"${FILESDIR}/${PN}-crypt.patch"
"${FILESDIR}/${PN}-tools.patch"
"${FILESDIR}/${PN}-integration-CMakeLists.patch"
)

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_enable crypt)
	)
	kde4-base_src_configure
}
