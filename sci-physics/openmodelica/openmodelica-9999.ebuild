# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=5
PYTHON_COMPAT=( python2_7 )
inherit subversion autotools python-single-r1

DESCRIPTION="Modelling language for technical systems."
HOMEPAGE="https://www.openmodelica.org/"
ESVN_REPO_URI="https://openmodelica.org/svn/OpenModelica/trunk@25593"

LICENSE="OSMC-PL"
SLOT="0"
KEYWORDS=""
IUSE="python orb qtclients"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

DEPEND="virtual/blas
	virtual/lapack
	virtual/pkgconfig
	virtual/jdk
	sys-libs/readline
	sci-mathematics/lpsolve
	dev-db/sqlite:3
	qtclients? ( orb? ( net-misc/omniORB ) x11-libs/qwt dev-qt/qtcore:4 )
	dev-java/antlr
	sci-libs/omc-libs
	python? ( orb? ( net-misc/omniORBpy ) ${PYTHON_DEPS} )
"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoconf
}

src_configure() {
	LAPACK=$(pkg-config --libs-only-l lapack)
	econf --without-paradiseo --with-lapack="${LAPACK}" $(use_with orb omniORB ) $(use_enable python python-interface) 
}

src_compile() {
	emake omc || die
	emake mosh || die
	use qtclients && emake qtclients || die
}

src_install() {
	use python && python_export ${PYTHON_TARGETS} PYTHON_SITEDIR; export PYTHONPATH="../build/${PYTHON_SITEDIR#/usr}" ; 
	default
}

pkg_setup() {
	use python && python-single-r1_pkg_setup;
}
