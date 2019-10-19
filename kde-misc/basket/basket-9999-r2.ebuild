# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="7"

inherit cmake-utils git-r3 kde5

DESCRIPTION="A DropDrawers clone. Multiple information organizer"
HOMEPAGE="http://basket.kde.org/"
EGIT_REPO_URI="https://github.com/basket-notepads/basket.git"
#EGIT_BRANCH="kde5port"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"

IUSE="debug"

DEPEND="
	kde-frameworks/frameworkintegration
"

src_configure() {
	mycmakeargs=(
		-DBASKET_DISABLE_GPG=ON
	)
	kde5_src_configure
}
