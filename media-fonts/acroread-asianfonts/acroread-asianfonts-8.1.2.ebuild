# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/acroread-asianfonts/acroread-asianfonts-7.0.8.ebuild,v 1.5 2007/07/02 15:03:37 peper Exp $

inherit eutils

BASE_URI="ftp://ftp.adobe.com/pub/adobe/reader/unix/8.x/8.1.2/misc/FontPack81_"

DESCRIPTION="Asian font packs for Adobe Acrobat Reader"
HOMEPAGE="http://www.adobe.com/products/acrobat/acrrasianfontpack.html"
SRC_URI="linguas_zh_CN? ( ${BASE_URI}chs_i486-linux.tar.gz )
	linguas_zh_TW? ( ${BASE_URI}cht_i486-linux.tar.gz )
	linguas_ja? ( ${BASE_URI}jpn_i486-linux.tar.gz )
	linguas_ko? ( ${BASE_URI}kor_i486-linux.tar.gz )
	!linguas_zh_CN? ( !linguas_zh_TW? ( !linguas_ja? ( !linguas_ko? (
		${BASE_URI}chs_i486-linux.tar.gz
		${BASE_URI}cht_i486-linux.tar.gz
		${BASE_URI}jpn_i486-linux.tar.gz
		${BASE_URI}kor_i486-linux.tar.gz
	) ) ) )"
# linguas_ce? ( ${BASE_URI}ce_i386-linux.tar.gz )
# linguas_hatv? ( ${BASE_URI}hatv_i386-linux.tar.gz )
SLOT="0"
LICENSE="Adobe"
KEYWORDS="amd64 x86"
IUSE="linguas_zh_CN linguas_zh_TW linguas_ja linguas_ko"
RESTRICT="mirror"

DEPEND=">=app-text/acroread-8.1.2"

S="${WORKDIR}"

pkg_setup() {
	local NOUSE

	if ! use linguas_zh_CN && ! use linguas_zh_TW &&
		! use linguas_ja && ! use linguas_ko ; then
		NOUSE=true
	else
		NOUSE=false
	fi

	if ! built_with_use '>=app-text/acroread-8.1.2' linguas_zh_TW && (use linguas_zh_TW || $NOUSE); then
		INST_LANG="${INST_LANG} CHT"
	fi

	if ! built_with_use '>=app-text/acroread-8.1.2' linguas_ja && (use linguas_ja || $NOUSE); then
		INST_LANG="${INST_LANG} JPN"
	fi

	if ! built_with_use '>=app-text/acroread-8.1.2' linguas_ko && (use linguas_ko || $NOUSE); then
		INST_LANG="${INST_LANG} KOR"
	fi

	if ! built_with_use '>=app-text/acroread-8.1.2' linguas_zh_CN && (use linguas_zh_CN || $NOUSE); then
		INST_LANG="${INST_LANG} CHS"
	fi

	if [ "${INST_LANG}" = "" ] ; then
		eerror "You don't have to install acroread-asianfonts."
		eerror "Please unmerge acroread-asianfonts."
		einfo "# emerge -C acroread-asianfonts"
		die "You don't have to install acroread-asianfonts."
	fi
}

src_install() {
	local INSTALLDIR="/opt"

	dodir ${INSTALLDIR}
	for lang in ${INST_LANG}
	do
		einfo "Installing ${lang} pack ..."
		tar xf "${lang}KIT/LANG${lang}.TAR" --no-same-owner -C "${D}/${INSTALLDIR}"
	done

	einfo "Installing Asian CMaps ..."
	tar xf ${INST_LANG/* /}KIT/LANGCOM.TAR --no-same-owner -C "${D}/${INSTALLDIR}"
	tar xf ${INST_LANG/* /}KIT/BINCOM.TAR --no-same-owner -C "${D}/${INSTALLDIR}"

	# bug 152288
	rm "${D}/${INSTALLDIR}"/Adobe/Reader8/Resource/CMap/Identity-{V,H}
	rm -r "${D}/${INSTALLDIR}"/Adobe/Reader8/Reader


	insinto ${INSTALLDIR}/Adobe/Reader8/Resource
	doins ${INST_LANG/* /}KIT/LICREAD.TXT || die

	fowners -R -L --dereference 0:0 ${INSTALLDIR}
}