%define disttype %{expand:%%(/usr/lib/rpm/redhat/dist.sh --disttype)}
%define distnum %{expand:%%(/usr/lib/rpm/redhat/dist.sh --distnum)}

Name          : RPMNAME
Version       : RPMVERSION
Release       : RPMRELEASE.%{disttype}%{distnum}
Summary       : macosx cursor theme 
Group         : User Interface/X
License       : LGPL
URL           : https://www.gnome-look.org/p/1148692/
Source0       : %{name}-%{version}.tgz
BuildRequires : tar
Requires      : filesystem
BuildArch     :	noarch

%define debug_package %{nil}

%description
This is an x-cursor theme inspired by macOS and based on KDE Breeze. 
It was created with Inkscape and xcursorgen, and was designed to pair 
well with my icon pack, La Capitaine

All credits to krourke (https://www.opendesktop.org/member/440119/)

%prep
%setup -q

%build

%install
rm -rf $RPM_BUILD_ROOT

# Theme Dir
mkdir -p %{buildroot}/usr/share/icons/macosx-capitaine
cp -rf * %{buildroot}/usr/share/icons/macosx-capitaine

%files
%defattr(0644,root,root,0755)
%dir /usr/share/icons/macosx-capitaine
/usr/share/icons/macosx-capitaine/*

%changelog
* Thu Dec 21 2017 Paulo Sousa <sousa.paulo.1975@gmail.com>> - 1
- First version
