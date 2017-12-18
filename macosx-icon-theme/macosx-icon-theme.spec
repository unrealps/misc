%define disttype %{expand:%%(/usr/lib/rpm/redhat/dist.sh --disttype)}
%define distnum %{expand:%%(/usr/lib/rpm/redhat/dist.sh --distnum)}

Name          : RPMNAME
Version       : RPMVERSION
Release       : RPMRELEASE.%{disttype}%{distnum}
Summary       : macosx icon theme 
Group         : User Interface/X
License       : GPL2
URL           : https://www.gnome-look.org/p/1102582/
Source0       : %{name}-%{version}.tgz
BuildRequires : tar
Requires      : filesystem
BuildArch     :	noarch

%define debug_package %{nil}

%description
MacOS icon theme:
Based on Macbuntu theme

All credits to umayanga (https://www.opendesktop.org/member/434822/)

%prep
%setup -q

%build

%install
rm -rf $RPM_BUILD_ROOT

# Theme Dir
mkdir -p %{buildroot}/usr/share/icons/macosx
cp -rf * %{buildroot}/usr/share/icons/macosx/

%files
%defattr(0644,root,root,0755)
%dir /usr/share/icons/macosx
/usr/share/icons/macosx/*

%changelog
* Mon Dec 18 2017 Paulo Sousa <sousa.paulo.1975@gmail.com>> - 1
- First version
