# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit cmake-utils eutils versionator

DESCRIPTION="Open source high performance 3D graphics toolkit"
HOMEPAGE="http://www.openscenegraph.org/projects/osg/"

MY_PV=$(get_version_component_range 1-3)
MY_P="OpenSceneGraph-${MY_PV}"
if [ $(get_version_component_range 3) -eq 0 ] ; then
	MY_SERIES=$(get_version_component_range 1-2);
else
	MY_SERIES=$(get_version_component_range 1-3);
fi
SRC_URI="http://www.openscenegraph.org/downloads/stable_releases/OpenSceneGraph-${MY_SERIES}/source/${MY_P}.zip"

LICENSE="wxWinLL-3 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE="collada curl doc examples gif jpeg jpeg2k osgapps pdf png svg tiff truetype vnc xine xrandr xulrunner"

RDEPEND="virtual/opengl
	virtual/glu
	x11-libs/libSM
	x11-libs/libXext
	collada? ( >=media-libs/collada-dom-2.1 )
	curl? ( net-misc/curl )
	gif? ( media-libs/giflib )
	jpeg? ( media-libs/jpeg )
	jpeg2k? ( media-libs/jasper )
	pdf? ( virtual/poppler-glib[cairo] )
	png? ( media-libs/libpng )
	svg? ( gnome-base/librsvg )
	tiff? ( media-libs/tiff )
	truetype? ( media-libs/freetype:2 )
	vnc? ( net-libs/libvncserver )
	xine? ( media-libs/xine-lib )
	xrandr? ( x11-libs/libXrandr )
	xulrunner? ( net-libs/xulrunner )
	"
DEPEND="${RDEPEND}
	app-arch/unzip
	doc? ( app-doc/doxygen )"

S="${WORKDIR}"/${MY_P}

DOCS="AUTHORS.txt ChangeLog NEWS.txt"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-magicoff.patch
	# Apply all patches for this version from single file
	if [ -f ${FILESDIR}/${PV}.patch ] ; then
		epatch ${FILESDIR}/${PV}.patch || die "Patch failed"
	fi
}

src_configure() {
	mycmakeargs="-DOSG_USE_REF_PTR_IMPLICIT_OUTPUT_CONVERSION:BOOL=OFF"
	mycmakeargs="${mycmakeargs} $(cmake-utils_use_enable curl CURL)"
	mycmakeargs="${mycmakeargs} $(cmake-utils_use_enable gif GIF)"
	mycmakeargs="${mycmakeargs} $(cmake-utils_use_enable jpeg JPEG)"
	mycmakeargs="${mycmakeargs} $(cmake-utils_use_enable jpeg2k JPEG2K)"
	mycmakeargs="${mycmakeargs} $(cmake-utils_use_enable pdf PDF)"
	mycmakeargs="${mycmakeargs} $(cmake-utils_use_enable png PNG)"
	mycmakeargs="${mycmakeargs} $(cmake-utils_use_enable svg SVG)"
	mycmakeargs="${mycmakeargs} $(cmake-utils_use_enable tiff TIFF)"
	mycmakeargs="${mycmakeargs} $(cmake-utils_use_enable truetype FREETYPE)"
	mycmakeargs="${mycmakeargs} $(cmake-utils_use_enable xine XINE)"
	mycmakeargs="${mycmakeargs} $(cmake-utils_use_enable xrandr XRANDR)"
	mycmakeargs="${mycmakeargs} $(cmake-utils_use_enable xulrunner XUL)"

	mycmakeargs="${mycmakeargs} $(cmake-utils_use doc BUILD_DOCUMENTATION)"
	mycmakeargs="${mycmakeargs} $(cmake-utils_use examples BUILD_OSG_EXAMPLES)"
	mycmakeargs="${mycmakeargs} $(cmake-utils_use osgapps BUILD_OSG_APPLICATIONS)"
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
	use doc && cmake-utils_src_compile doc_openscenegraph
	use doc && cmake-utils_src_compile doc_openthreads
}

src_install() {
	cmake-utils_src_install
	use doc && dosym /usr/doc/OpenSceneGraphReferenceDocs /usr/share/doc/${PF}/html
	insinto "/usr/lib/pkgconfig"
	doins packaging/pkgconfig/openthreads.pc
	doins packaging/pkgconfig/openscenegraph.pc
}
