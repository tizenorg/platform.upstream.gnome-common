Name:           gnome-common
Version:        3.6.0
BuildRequires:  pkg-config
Requires:       autoconf
Requires:       automake
Requires:       gettext-tools
Requires:       glib2-devel
Requires:       intltool
Requires:       libtool
Requires:       pkg-config
Summary:        Common Files to Build GNOME
License:        GPL-2.0+
Group:          System/GUI/GNOME
Release:        0
Source:         http://download.gnome.org/sources/gnome-common/3.4/%{name}-%{version}.tar.xz
Url:            http://www.gnome.org/
BuildArch:      noarch

%description
Gnome-common includes files used by to build GNOME and GNOME applications.

%prep
%setup -q

%build
%configure
make %{?_smp_mflags}

%install
%make_install

%files
%defattr (-, root, root)
#%license COPYING 
%{_bindir}/gnome-autogen.sh
%{_bindir}/gnome-doc-common
%dir %{_datadir}/aclocal
%{_datadir}/aclocal/gnome-common.m4
%{_datadir}/aclocal/gnome-compiler-flags.m4
%{_datadir}/aclocal/gnome-code-coverage.m4
%{_datadir}/gnome-common/
