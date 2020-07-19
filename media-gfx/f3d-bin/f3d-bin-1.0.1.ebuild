# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A fast and minimalist 3D viewer"
HOMEPAGE="https://kitware.github.io/F3D/"
SRC_URI="https://gitlab.kitware.com/f3d/f3d/uploads/8495b462789f1dd3e45589a8c5b9332d/f3d-1.0.1-Linux.tar.xz"

LICENSE="BSD 3-clause "New" or "Revised" License"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

MY_PV="f3d-${PV}"

S="${WORKDIR}"/"${MY_PV}"-Linux

src_install() {
	dodir "/usr"
	mv bin share "${ED}/usr/"
}
