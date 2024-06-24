# Copyright
EAPI=8
DESCRIPTION="Ente Auth AppImage"
SRC_URI="https://github.com/ente-io/ente/releases/download/auth-v3.0.17/ente-auth-v3.0.17-x86_64.AppImage -> ${P}"
LICENSE="AGPL-3.0"
SLOT="0"
KEYWORDS="~amd64"
DEPEND=""
RDEPEND="|| ( dev-libs/libappindicator )"
S="${WORKDIR}"

inherit xdg-utils

src_unpack() {
    chmod a+x ${P}
    ${P} --appimage-extract ente_auth.desktop
    ${P} --appimage-extract usr/share/icons
}

src_prepare() {
    sed -i 's:^Exec=.*:Exec=/usr/bin/ente_auth:' squashfs-root/ente_auth.desktop
}

src_install() {
    exeinto /usr/bin
    mv "${DISTDIR}/${P}" 'ente_auth'
    doexe ente_auth
    insinto /usr/share/applications
    doins squashfs-root/usr/share/applications/ente_auth.desktop
    insinto /usr/share/
    doins -r squashfs-root/usr/share/icons
}

pkg_postinst() {
    xdg_desktop_database_update
}

