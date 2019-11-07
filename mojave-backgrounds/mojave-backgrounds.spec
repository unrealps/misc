%define disttype %{expand:%%(/usr/lib/rpm/redhat/dist.sh --disttype)}
%define distnum %{expand:%%(/usr/lib/rpm/redhat/dist.sh --distnum)}

%define debug_package %{nil}

Name          : RPMNAME
Version       : RPMVERSION
Release       : RPMRELEASE.%{disttype}%{distnum}
Summary       : MacOS X Mojave Backgrounds
Group         : User Interface/X
License       : Unknown
URL           : https://media.idownloadblog.com/wp-content/uploads/2018/06/macOS-Mojave-Day-wallpaper.jpg
Source0       : %{name}-%{version}.tgz
Source1       : mojave-day.xml
Source2       : mojave-night.xml
Source3       : mojave-animated.xml
Source4       : mojave-day-gnome.xml
Source5       : mojave-night-gnome.xml
Source6       : mojave-animated-gnome.xml
Requires      : filesystem
BuildArch     :	noarch


%description
Mojave backgrounds

%package gnome
Summary      : MacOS X Mojave Backgrounds time based
Requires     : %{name} = %{version}-%{release}

%description gnome
Time base Mojave Backgrounds for Gnome

%prep
%setup -q

%build

%install
rm -rf $RPM_BUILD_ROOT

# Theme Dir
mkdir -p %{buildroot}/usr/share/backgrounds/mojave
mkdir -p %{buildroot}/usr/share/backgrounds/mojave/default
cp -rf * %{buildroot}/usr/share/backgrounds/mojave/default/
cp -f %{SOURCE1} %{buildroot}/usr/share/backgrounds/mojave/default/
cp -f %{SOURCE2} %{buildroot}/usr/share/backgrounds/mojave/default/
cp -f %{SOURCE3} %{buildroot}/usr/share/backgrounds/mojave/default/

mkdir -p %{buildroot}/usr/share/gnome-background-properties
cp -rf %{SOURCE4} %{buildroot}/usr/share/gnome-background-properties/
cp -rf %{SOURCE5} %{buildroot}/usr/share/gnome-background-properties/
cp -rf %{SOURCE6} %{buildroot}/usr/share/gnome-background-properties/

%files
%defattr(0644,root,root,0755)
%dir /usr/share/backgrounds/mojave
%dir /usr/share/backgrounds/mojave/default
%dir /usr/share/backgrounds/mojave/default/tv-wide
%dir /usr/share/backgrounds/mojave/default/wide
%dir /usr/share/backgrounds/mojave/default/standard
%dir /usr/share/backgrounds/mojave/default/normalish
/usr/share/backgrounds/mojave/default/*.xml
/usr/share/backgrounds/mojave/default/tv-wide/*.png
/usr/share/backgrounds/mojave/default/wide/*.png
/usr/share/backgrounds/mojave/default/standard/*.png
/usr/share/backgrounds/mojave/default/normalish/*.png

%files gnome
%defattr(0644,root,root,0755)
/usr/share/gnome-background-properties/mojave-day-gnome.xml
/usr/share/gnome-background-properties/mojave-night-gnome.xml
/usr/share/gnome-background-properties/mojave-animated-gnome.xml

%changelog
* Sat Nov 2 2019 Paulo Sousaa <sousa.paulo.1975@gmail.com>> - 1
- First version
