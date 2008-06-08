# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils fdo-mime multilib

IUSE=""

DESCRIPTION="OpenOffice productivity suite"

MY_PV=${PV/_p1/}
SRC_URI="x86? (http://ftp.chg.ru/pub/OpenOffice-RU/${MY_PV}/ru/OOo_${MY_PV}_LinuxIntel_ru_infra.tar.gz)
	amd64? (ftp://ftp.chg.ru/pub/OpenOffice-RU/${MY_PV}/ru/OOo_${MY_PV}_LinuxX86-64_ru_infra.tar.gz)"

HOMEPAGE="http://www.i-rs.org/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="!app-office/openoffice
	x11-libs/libXaw
	sys-libs/glibc
	>=dev-lang/perl-5.0
	app-arch/zip
	app-arch/unzip
	>=media-libs/freetype-2.1.10-r2
	>=app-admin/eselect-oodict-20060706
	java? ( >=virtual/jre-1.4 )"

DEPEND="${RDEPEND}
	sys-apps/findutils"

PROVIDE="virtual/ooo"
RESTRICT="strip"

src_install () {

	#Multilib install dir magic for AMD64
	has_multilib_profile && ABI=x86
	INSTDIR="/usr/$(get_libdir)/openoffice"

	einfo "Installing OpenOffice.org into build root..."
	dodir ${INSTDIR}
	mv "${WORKDIR}"/openoffice.org2.4/* "${D}${INSTDIR}"

	#Menu entries, icons and mime-types
	cd "${D}${INSTDIR}/share/xdg/"

	for desk in base calc draw impress math printeradmin writer; do
		mv ${desk}.desktop openoffice.org-2.4-${desk}.desktop
		sed -i -e s/openoffice.org2.4/ooffice/g openoffice.org-2.4-${desk}.desktop || die
		sed -i -e s/openofficeorg24-${desk}/ooo-${desk}/g openoffice.org-2.4-${desk}.desktop || die
		domenu openoffice.org-2.4-${desk}.desktop
		insinto /usr/share/pixmaps
#		Icons are not presented in PRO version :-(
#		newins "${WORKDIR}/usr/share/icons/gnome/48x48/apps/openofficeorg24-${desk}.png" ooo-${desk}.png
	done

#	This folder is not presented in PRO version :-(
#	insinto /usr/share/mime/packages
#	doins "${WORKDIR}/usr/share/mime/packages/openoffice.org.xml"

	# Install wrapper script
	newbin "${FILESDIR}/wrapper.in" ooffice
	sed -i -e s/LIBDIR/$(get_libdir)/g "${D}/usr/bin/ooffice" || die

	# Component symlinks
	for app in base calc draw impress math writer; do
		dosym ${INSTDIR}/program/s${app} /usr/bin/oo${app}
	done

	dosym ${INSTDIR}/program/spadmin.bin /usr/bin/ooffice-printeradmin
	dosym ${INSTDIR}/program/soffice /usr/bin/soffice

	# Change user install dir
	sed -i -e s/.openoffice.org2/.ooo-2.0/g "${D}${INSTDIR}/program/bootstraprc" || die

	# Non-java weirdness see bug #99366
#	use !java && rm -f "${D}${INSTDIR}/program/javaldx"

	# Remove the provided dictionaries, we use our own instead
	rm -f "${D}"${INSTDIR}/share/dict/ooo/*

	# prevent revdep-rebuild from attempting to rebuild all the time
	insinto /etc/revdep-rebuild && doins "${FILESDIR}/50-openoffice-bin"

}

pkg_postinst() {

	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update

	eselect oodict update --libdir $(get_libdir)

	[[ -x /sbin/chpax ]] && [[ -e /usr/$(get_libdir)/openoffice/program/soffice.bin ]] && chpax -zm /usr/$(get_libdir)/openoffice/program/soffice.bin

	elog " To start OpenOffice.org, run:"
	elog
	elog " $ ooffice"
	elog
	elog " Also, for individual components, you can use any of:"
	elog
	elog " oobase, oocalc, oodraw, ooimpress, oomath, or oowriter"
	elog
	elog " Spell checking is now provided through our own myspell-ebuilds, "
	elog " if you want to use it, please install the correct myspell package "
	elog " according to your language needs. "

}
