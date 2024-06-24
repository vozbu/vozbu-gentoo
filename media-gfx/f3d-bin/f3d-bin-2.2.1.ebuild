# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A fast and minimalist 3D viewer"
HOMEPAGE="https://kitware.github.io/F3D/"
MY_PN="F3D-${PV}-Linux-x86_64-raytracing"
SRC_URI="https://github.com/f3d-app/f3d/releases/download/v${PV}/${MY_PN}.tar.xz"

LICENSE="BSD 3-clause "New" or "Revised" License"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}"/"${MY_PN}"

src_install() {
	dobin bin/*
	dolib.so lib/libf3d.so.2
	dolib.so lib/libOpenImageDenoise.so.1
	dolib.so lib/libospray.so.2
	dolib.so lib/libtbb.so.12
	dolib.so lib/librkcommon.so.1
	dolib.so lib/libtbbmalloc.so.2
	insinto /usr
	doins -r share/
}
