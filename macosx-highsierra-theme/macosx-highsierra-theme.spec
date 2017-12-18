%define disttype %{expand:%%(/usr/lib/rpm/redhat/dist.sh --disttype)}
%define distnum %{expand:%%(/usr/lib/rpm/redhat/dist.sh --distnum)}

Name          : RPMNAME
Version       : RPMVERSION
Release       : RPMRELEASE.%{disttype}%{distnum}
Summary       : High Sierra (macOS like theme) 
Group         : User Interface/X
License       : Creative Commons by-nc-sa
URL           : https://www.gnome-look.org/p/1171688/
Source0       : %{name}-%{version}.tgz
BuildRequires : tar
Requires      : filesystem
Requires      : gtk-murrine-engine
BuildArch     :	noarch

%define debug_package %{nil}

%description
High Sierra Theme:
This is a gnome-desktop-interpretation of Mac OSX. I've tried to 
implement the feel of OSX on the gnome-applications. In version 
3.0 I've modernized it in every little detail. There is nothing 
(not a single item) that is not new. Resulting in a completely 
rewritten GTK.CSS-file four times bigger than the previous one, 
while the theme feels more responsive. I've also added a new 
dark theme (Space-grey) , so Terminal, Photo's, and Video's are 
automatically dark-themed.

I've spend a great deal of time (3 months) and effort on this theme 
into fine-tuning it, so I hope you try before you judge !

Main features:
- Support for dark theme.(Space grey)
- Use of gradients and shadows to improve readability.
- Same theming across GTK2 and GTK3. (See screenshots)

All credits to PAULXFCE (https://www.opendesktop.org/member/455718/)

%prep
%setup -q

%build

%install
rm -rf $RPM_BUILD_ROOT

# Theme Dir
mkdir -p %{buildroot}/usr/share/themes/macosx-highsierra
cp -rf * %{buildroot}/usr/share/themes/macosx-highsierra/

%files
%defattr(0644,root,root,0755)
%dir /usr/share/themes/macosx-highsierra
/usr/share/themes/macosx-highsierra/*

%changelog
* Mon Dec 18 2017 Paulo Sousa <sousa.paulo.1975@gmail.com>> - 1
- First version
