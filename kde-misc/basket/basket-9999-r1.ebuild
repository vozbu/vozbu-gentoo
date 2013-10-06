# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit git kde4-base

DESCRIPTION="A DropDrawers clone. Multiple information organizer"
HOMEPAGE="http://basket.kde.org/"
EGIT_REPO_URI="git://gitorious.org/basket/basket.git"
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

src_unpack() {
	git_src_unpack
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_enable crypt)
	)
	kde4-base_src_configure
}