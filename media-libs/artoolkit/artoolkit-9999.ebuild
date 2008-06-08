# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit subversion

ESVN_REPO_URI="http://artoolkit.svn.sourceforge.net/svnroot/artoolkit/trunk/artoolkit/"

DESCRIPTION="The Augmented Reality Tool Kit (ARToolKit) captures images from
video sources, optically tracks markers in the images, and composites them with
computer-generated content using OpenGL."
HOMEPAGE="http://artoolkit.sourceforge.net/"
MY_PN="ARToolKit"
LICENSE="Dual-licensed, under the GPL, plus commercially by ARToolworks, Inc."
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="=media-libs/libdc1394-1*"
RDEPEND="${DEPEND}"
pkg_setup() {
	ewarn "Building ARToolKit with supporting IEEE1394 cameras only"
}

src_compile() {
	if use amd64; then
		epatch "${FILESDIR}/Configure.patch"
	fi
	./Configure < "${FILESDIR}/answers"
	emake
}

src_install() {
	dobin bin/calib_camera2 bin/calib_cparam bin/calib_dist bin/mk_patt bin/twoView bin/videoTest
	dolib lib/*.a
	insinto /usr/include
	doins -r include/AR
	dodoc COPYING.txt ChangeLog.txt README.txt
	dohtml -r doc/*
	insinto /usr/share/${MY_PN}
	doins -r bin/Data bin/Wrl patterns
	exeinto /usr/share/${MY_PN}/bin
	doexe bin/collideTest bin/exview bin/graphicsTest bin/loadMultiple \
		bin/modeTest bin/multiTest bin/optical bin/paddleDemo \
		bin/paddleInteractionTest bin/paddleTest bin/rangeTest bin/relationTest	\
		bin/simpleLite bin/simpleTest bin/simpleTest2
	insinto /etc/env.d
	doins "${FILESDIR}/90artoolkit" || die "Failed to install files to /etc/env.d"
}
