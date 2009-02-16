# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit eutils subversion

ESVN_REPO_URI="https://osgedit.svn.sourceforge.net/svnroot/osgedit"

DESCRIPTION="OSGEdit is an editor of scenes for the library OpenSceneGraph"
HOMEPAGE="http://osgedit.sourceforge.net/"

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

src_prepare() {
	epatch ${FILESDIR}/reflect_osg_autotransform.cpp.patch || die "Patch failed"
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
