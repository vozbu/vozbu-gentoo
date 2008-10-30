# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

inherit eutils qt4 subversion
MY_PN="${PN/im/IM}"

DESCRIPTION="New Instant Messenger (ICQ) written in C++ with Qt."
HOMEPAGE="http://www.qutim.org"
LICENSE="GPL-2"
ESVN_REPO_URI="https://qutim.svn.sourceforge.net/svnroot/${PN}/trunk"

SLOT="0"
KEYWORDS=""
IUSE="debug"

RDEPEND="$(qt4_min_version 4.3)"
DEPEND="${RDEPEND}"
QT4_BUILT_WITH_USE_CHECK="png" # gif"

S="${WORKDIR}/${MY_PN}"

src_compile() {
	if use debug; then
		CFLAGS="-O0 -g -ggdb"
		CXXFLAGS="${CFLAGS}"
	fi

	eqmake4 ${MY_PN}.pro || die "eqmake4 failed"
	emake || die "emake failed"
}

src_install(){
	into /usr
	dobin build/bin/${MY_PN} || die "installation failed"
# Desktop entry
   doicon icons/qutim_64.png || die "doicon failed"
   make_desktop_entry qutIM qutIM qutim_64.png || die "make_desktop_entry failed"
}