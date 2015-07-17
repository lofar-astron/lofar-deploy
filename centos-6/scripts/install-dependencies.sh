# admin
yum -y install sudo

# download
yum -y install git svn wget 

# build
yum -y install automake-devel aclocal autoconf autotools cmake make

# compiler
yum -y install g++ gcc gcc-c++ gcc-gfortran

# libraries
yum -y install blas-devel boost-devel fftw3-devel fftw3-libs python-devel lapack-devel libpng-devel libxml2-devel numpy-devel readline-devel ncurses-devel f2py bzip2-devel libicu-devel scipy

# misc
yum -y install bison flex ncurses sudo tar bzip2 which

# python packages
easy_install pyfits
