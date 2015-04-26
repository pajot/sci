# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=5
inherit subversion autotools

DESCRIPTION="Libraries necessary to build omc, the OpenModelica compiler."
HOMEPAGE="https://www.openmodelica.org/"
ESVN_PROJECT="openmodelica"
ESVN_REPO_URI="https://openmodelica.org/svn/OpenModelica/trunk@25730"

LICENSE="OSMC-PL"
SLOT="0"
KEYWORDS=""
IUSE=""
# python interface

DEPEND="virtual/blas
	virtual/lapack
	virtual/pkgconfig
	virtual/jdk
	sys-libs/readline
	sci-mathematics/lpsolve
	dev-db/sqlite:3
	x11-libs/qwt
	dev-qt/qtcore:4
	dev-java/antlr
	${PYTHON_DEPS}
"
RDEPEND="${DEPEND}"

src_configure() {
	LAPACK=$(pkg-config --libs-only-l lapack)
	eautoconf
	econf --without-paradiseo --with-lapack="${LAPACK}" 
}

src_compile() {
	emake boehm-gc-lib || die
}

src_install() {
	BUILDDIR_LIB=${WORKDIR}/${P}/build/lib/omc
	# BUILDDIR_INC=${WORKDIR}/${P}/build/include/omc
	dolib ${BUILDDIR_LIB}/*
	# doheader ${BUILDDIR_INC}/*
}
