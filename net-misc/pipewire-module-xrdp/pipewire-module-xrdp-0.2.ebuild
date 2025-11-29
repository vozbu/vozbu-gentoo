# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="This module allows xrdp to generate sound on a pipewire-based system."
HOMEPAGE="http://www.xrdp.org/"
SRC_URI="https://github.com/neutrinolabs/pipewire-module-xrdp/archive/refs/tags/v${PV}/v${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=net-misc/xrdp-0.9.14:0=
	>=media-video/pipewire-0.3.58
"
DEPEND=${RDEPEND}

src_prepare() {
	eautoreconf
	default
}
