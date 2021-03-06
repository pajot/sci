# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_5,2_6,2_7} )
PYTHON_REQ_USE="tk"

inherit distutils-r1 eutils

MY_PN="gle"
MY_P="${MY_PN}-${PV/_rc3/}"

PYTHON_MODNAME="${MY_PN}"

DESCRIPTION="MGLTools Plugin -- gle"
HOMEPAGE="http://mgltools.scripps.edu"
#SRC_URI="http://mgltools.scripps.edu/downloads/tars/releases/REL${PV}/mgltools_source_${PV}.tar.gz"
SRC_URI="http://dev.gentoo.org/~jlec/distfiles/mgltools_source_${PV/_/}.tar.gz"

LICENSE="MGLTOOLS"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/opengl"
DEPEND="${RDEPEND}
	dev-lang/swig"

S="${WORKDIR}"/${MY_P}

src_unpack() {
	tar xzpf "${DISTDIR}"/${A} mgltools_source_${PV/_/}/MGLPACKS/${MY_P}.tar.gz
	tar xzpf mgltools_source_${PV/_/}/MGLPACKS/${MY_P}.tar.gz
}

python_prepare_all() {
	ecvs_clean
	find "${S}" -name LICENSE -type f -delete || die

	sed  \
		-e 's:^.*CVS:#&1:g' \
		-e 's:^.*LICENSE:#&1:g' \
		-i "${S}"/MANIFEST.in || die
	distutils-r1_python_prepare_all
}
