# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
#
EAPI=7
inherit desktop

MULTILIB_COMPAT=( abi_x86_64 )

MY_PN=${PN/-bin/}

DESCRIPTION="Nintendo Switch Emulator"
HOMEPAGE="https://ryujinx.org/"
SRC_URI="https://ci.appveyor.com/api/buildjobs/2aspohw7dpiwr0de/artifacts/ryujinx-1.0.6945-linux_x64.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* amd64"

S="${WORKDIR}"
QA_PREBUILT="*"
RESTRICT="mirror strip"

RDEPEND="
	x11-libs/libX11
	dev-dotnet/dotnet-runtime-bin"

src_unpack() {
	unpack ${A}
}

src_install() {
	insinto /opt/${MY_PN}
	doins -r publish/.
	fperms +x /opt/${MY_PN}/Ryujinx
	dosym /opt/${MY_PN}/Ryujinx usr/bin/${MY_PN}
	keepdir /var/log/${MY_PN}
	fperms a+w /var/log/${MY_PN}
	dosym /var/log/${MY_PN} /opt/${MY_PN}/Logs

	newicon ${FILESDIR}/logo.png ryujinx.png

	domenu ${FILESDIR}/ryujinx.desktop
}
