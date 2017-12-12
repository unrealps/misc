%define disttype %{expand:%%(/usr/lib/rpm/redhat/dist.sh --disttype)}
%define distnum %{expand:%%(/usr/lib/rpm/redhat/dist.sh --distnum)}

Name          : RPMNAME
Version       : RPMVERSION
Release       : RPMRELEASE.%{disttype}%{distnum}
Summary       : Human (macOS like shell theme) 
Group         : User Interface/X
License       : Unknown
URL           : https://www.gnome-look.org/p/1171095/
Source0       : %{name}-%{version}.tgz
BuildRequires : tar
Requires      : filesystem
BuildArch     :	noarch

%define debug_package %{nil}

%description
Human Shell Theme:
Based on original MacBuntu theme.
Please comment your suggestions, complains and everything.
Special Thanks :
* Noobslab team
* nana-4 (Developer of Flat-Plat theme)
NOTE: Only for GNOME desktop.
Recommended GTK+ theme: Gn-OSX-H.Sierra
Recommended icons theme: macOS icons/ MacBuntu, La Capitanie
Recommended cursor theme: Capitaine
All credits to umayanga (https://www.opendesktop.org/member/434822/)

%prep
%setup -q

%build

%install
rm -rf $RPM_BUILD_ROOT

# Theme Dir
mkdir -p %{buildroot}/usr/share/themes/macosx-human
cp -rf * %{buildroot}/usr/share/themes/macosx-human/

%files
%defattr(0644,root,root,0755)
%dir /usr/share/themes/macosx-human
/usr/share/themes/macosx-human/*

%changelog
* Tue Dec 12 2017 Paulo Sousa <sousa.paulo.1975@gmail.com>> - 1
- First version
