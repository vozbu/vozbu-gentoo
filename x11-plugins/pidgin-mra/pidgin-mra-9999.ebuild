# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2

DESCRIPTION="pidgin mail.ru plugin"

EGIT_REPO_URI="http://github.com/dreadatour/pidgin-mra"
EGIT_BRANCH="master"
EGIT_COMMIT="${EGIT_BRANCH}"
GIT_ECLASS="git"
DESCRIPTION=""

LICENSE="GPLv2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="net-libs/libproxy,
	 net-im/pidgin"

RDEPEND="
        ${DEPEND_COMMON}
        "
DEPEND="
        ${DEPEND_COMMON}
        "
#src_unpack() {
#	git_src_unpack
#}

#src_prepare() {
#	git clone $EGIT_REPO_URI
#}

#src_compile() {
#	emake
#}

#src_install() {
#	emake install DESTDIR="${D}" || die "make install failure"
#}
