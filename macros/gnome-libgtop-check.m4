dnl
dnl GNOME_LIBGTOP_HOOK (script-if-libgtop-enabled, failflag)
dnl
dnl if failflag is "fail" then GNOME_LIBGTOP_HOOK will abort if gtopConf.sh
dnl is not found. 
dnl

AC_DEFUN([GNOME_LIBGTOP_HOOK],
[	
	AC_REQUIRE([GNOME_LIBGTOP_SYSDEPS])

	AC_SUBST(LIBGTOP_LIBDIR)
	AC_SUBST(LIBGTOP_INCLUDEDIR)
	AC_SUBST(LIBGTOP_LIBS)
	AC_SUBST(LIBGTOP_INCS)
	AC_SUBST(LIBGTOP_GUILE_INCS)
	AC_SUBST(LIBGTOP_GUILE_LIBS)
	AC_SUBST(LIBGTOP_BINDIR)
	AC_SUBST(LIBGTOP_SERVER)

	if test x$exec_prefix = xNONE; then
	    if test x$prefix = xNONE; then
	        libgtop_prefix=$ac_default_prefix/lib
	    else
		libgtop_prefix=$prefix/lib
	    fi
	else
	    libgtop_prefix=`eval echo \`echo $libdir\``
	fi

	AC_ARG_WITH(libgtop-includes,
	[  --with-libgtop-includes Specify location of LIBGTOP headers],[
	CFLAGS="$CFLAGS -I$withval"
	])

	AC_ARG_WITH(libgtop-libs,
	[  --with-libgtop-libs     Specify location of LIBGTOP libs],[
	LDFLAGS="$LDFLAGS -L$withval"
	libgtop_prefix=$withval
	])

	AC_ARG_WITH(libgtop,
	[  --with-libgtop          Specify prefix for LIBGTOP files],[
	if test x$withval = xyes; then
	    dnl Note that an empty true branch is not valid sh syntax.
	    ifelse([$1], [], :, [$1])
        else
	    LDFLAGS="$LDFLAGS -L$withval/lib"
	    CFLAGS="$CFLAGS -I$withval/include"
	    libgtop_prefix=$withval/lib
  	fi
	])

        AC_MSG_CHECKING(for libgtopConf.sh file in $libgtop_prefix)
	if test -f $libgtop_prefix/libgtopConf.sh; then
	    AC_MSG_RESULT(found)
	    AC_DEFINE(HAVE_LIBGTOP)
	    echo "loading libgtop configuration from $libgtop_prefix/libgtopConf.sh"
	    . $libgtop_prefix/libgtopConf.sh
	    $1
	else
	    AC_MSG_RESULT(not found)
 	    if test x$2 = xfail; then
	        AC_MSG_ERROR(Could not find the libgtopConf.sh file that is generated by libgtop install)
 	    fi
	fi

	AM_CONDITIONAL(HAVE_LIBGTOP, test -f $libgtop_prefix/libgtopConf.sh)
])

AC_DEFUN([GNOME_INIT_LIBGTOP],[
	GNOME_LIBGTOP_HOOK([],)
])