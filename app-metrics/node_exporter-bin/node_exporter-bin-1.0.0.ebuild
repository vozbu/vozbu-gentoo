# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit systemd

DESCRIPTION="Prometheus exporter for machine metrics"
HOMEPAGE="https://github.com/prometheus/node_exporter"
MY_PN=${PN%%-bin}
MY_P=${MY_PN}-${PV}
SRC_URI="https://github.com/prometheus/node_exporter/releases/download/v${PV}/${MY_P}.linux-amd64.tar.gz"

LICENSE="Apache-2.0 BSD BSD-2 MIT"
SLOT="0"
KEYWORDS="~amd64"

QA_PREBUILT=".*"
RESTRICT="strip"

DEPEND="acct-group/node_exporter
	acct-user/node_exporter
	!app-metrics/node-exporter"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}.linux-amd64"

src_install() {
	dobin node_exporter
	dodoc LICENSE NOTICE
	systemd_dounit "${FILESDIR}"/node_exporter.service
	insinto /etc/sysconfig
	newins "${FILESDIR}"/sysconfig.node_exporter node_exporter
	keepdir /var/lib/node_exporter /var/log/node_exporter
	fowners ${MY_PN}:${MY_PN} /var/lib/node_exporter /var/log/node_exporter
}
