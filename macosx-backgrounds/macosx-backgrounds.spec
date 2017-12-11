%define disttype %{expand:%%(/usr/lib/rpm/redhat/dist.sh --disttype)}
%define distnum %{expand:%%(/usr/lib/rpm/redhat/dist.sh --distnum)}

Name          : RPMNAME
Version       : RPMVERSION
Release       : RPMRELEASE.%{disttype}%{distnum}
Summary       : MacOS X Backgrounds (Full HD)
Group         : User Interface/X
License       : Unknown
URL           : https://512pixels.net/projects/default-mac-wallpapers-in-5k/
Source0       : %{name}-%{version}.tgz
Source1       : %{name}.xml
BuildRequires : tar
BuildRequires : unzip
Requires      : filesystem
BuildArch     :	noarch

%define debug_package %{nil}

%description
All credits to 512PIXELS:
"Every Default macOS Wallpaper – in Glorious 5K Resolution
Every major version of Mac OS X macOS has come with a new default wallpaper.
As you can see, I have collected them all here.
While great in their day, the early wallpapers are now quite small in the
world of 5K iMac with Retina displays.
Major props to the world-class designer who does all the art of Relay FM, 
the mysterious @forgottentowel, for upscaling many of these for modern screens."
Note: Images as been resize from 5K to FullHD

%prep
%setup -q

%build

%install
rm -rf $RPM_BUILD_ROOT

# Theme Dir
mkdir -p %{buildroot}/usr/share/backgrounds/%{name}
mkdir -p %{buildroot}/usr/share/backgrounds/%{name}/default
cp -rf * %{buildroot}/usr/share/backgrounds/%{name}/default/

mkdir -p %{buildroot}/usr/share/gnome-background-properties
cp -rf %{SOURCE1} %{buildroot}/usr/share/gnome-background-properties/

%files
%defattr(0644,root,root,0755)
%dir /usr/share/backgrounds/%{name}
%dir /usr/share/backgrounds/%{name}/default
/usr/share/backgrounds/%{name}/default/*
/usr/share/gnome-background-properties/%{name}.xml

%changelog
* Mon Dec 11 2017 Paulo Sousaa <sousa.paulo.1975@gmail.com>> - 1
- First version
