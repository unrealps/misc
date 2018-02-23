%define disttype %{expand:%%(/usr/lib/rpm/redhat/dist.sh --disttype)}
%define distnum %{expand:%%(/usr/lib/rpm/redhat/dist.sh --distnum)}

Name          : RPMNAME
Version       : RPMVERSION
Release       : RPMRELEASE.%{disttype}%{distnum}
Summary       : libpurple Rocket.Chat Plugin
Group         : Applications/Internet
License       : GPL3
URL           : https://bitbucket.org/EionRobb/purple-rocketchat
Source0       : %{name}-%{version}.tgz
BuildRequires : tar libpurple-devel libmarkdown-devel json-glib-devel glib2
Requires      : libpurple

%description
Adds support for Rocket.Chat to libpurple clients, such as Pidgin.

%package pidgin
Summary: libpurple Rochet.Chat plugin Icons for Pidgin
Requires: pidgin
Requires: %{name} = %{version}-%{release}

%description pidgin
libpurple Rochet.Chat plugin Icons for Pidgin

%prep
%setup -q

%build
make

%install
rm -rf $RPM_BUILD_ROOT

mkdir -p %{buildroot}%{_libdir}/purple-2
mkdir -p %{buildroot}%{_datarootdir}/licenses/%{name}
mkdir -p %{buildroot}%{_datarootdir}/pixmaps/pidgin/protocols
mkdir -p %{buildroot}%{_datarootdir}/pixmaps/pidgin/protocols/16
mkdir -p %{buildroot}%{_datarootdir}/pixmaps/pidgin/protocols/22
mkdir -p %{buildroot}%{_datarootdir}/pixmaps/pidgin/protocols/48
cp -f librocketchat.so %{buildroot}%{_libdir}/purple-2/
cp -f LICENSE %{buildroot}%{_datarootdir}/licenses/%{name}/
cp -f rocketchat16.png %{buildroot}%{_datarootdir}/pixmaps/pidgin/protocols/16/rocketchat.png
cp -f rocketchat22.png %{buildroot}%{_datarootdir}/pixmaps/pidgin/protocols/22/rocketchat.png
cp -f rocketchat48.png %{buildroot}%{_datarootdir}/pixmaps/pidgin/protocols/48/rocketchat.png

%files
%defattr(0644,root,root,0755)
%dir %{_datarootdir}/licenses/%{name}
%{_libdir}/purple-2/librocketchat.so
%{_datarootdir}/licenses/%{name}/LICENSE

%files pidgin
%defattr(0644,root,root,0755)
%{_datarootdir}/pixmaps/pidgin/protocols/16/rocketchat.png
%{_datarootdir}/pixmaps/pidgin/protocols/22/rocketchat.png
%{_datarootdir}/pixmaps/pidgin/protocols/48/rocketchat.png

%changelog
* Fri Feb 23 2018 Paulo Sousa <sousa.paulo.1975@gmail.com>> - 1
- First version
