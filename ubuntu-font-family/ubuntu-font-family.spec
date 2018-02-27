%define disttype %{expand:%%(/usr/lib/rpm/redhat/dist.sh --disttype)}
%define distnum %{expand:%%(/usr/lib/rpm/redhat/dist.sh --distnum)}

Name          :	ubuntu-font-family	
Version:        RPMVERSION
Release:        RPMRELEASE.%{disttype}%{distnum}
Summary       :	This is the Ubuntu Font Family. It is a unique, custom designed font that has a very distinctive look and feel.
Group         : User Interface/X		
License       : Ubuntu Font License, 1.0	
URL           : http://font.ubuntu.com/
Source        : ubuntu-font-family-%{version}.zip	
BuildRequires : unzip	
Requires      : fontpackages-filesystem
Requires      : fontconfig 	

%define debug_package %{nil}

%description
The way typography is used says as much about our brand as the words themselves.

The Ubuntu typeface has been specially created to complement the Ubuntu tone of voice.
It has a contemporary style and contains characteristics unique to the Ubuntu brand 
that convey a precise, reliable and free attitude.

%prep
%setup -q

%build

%install
rm -rf $RPM_BUILD_ROOT

# Fonts
mkdir -p %{buildroot}/usr/share/fonts/ubuntu-font-family
cp -f *.ttf %{buildroot}/usr/share/fonts/ubuntu-font-family/  

# Docs
mkdir -p %{buildroot}/usr/share/doc/ubuntu-font-family
cp -f *.txt %{buildroot}/usr/share/doc/ubuntu-font-family/

%post
/usr/bin/fc-cache -f

%postun
if [ $1 ==0 ]
then
	/usr/bin/fc-cache -f
fi

%files
%defattr(0644,root,root,0755)
%dir /usr/share/fonts/ubuntu-font-family
/usr/share/fonts/ubuntu-font-family/*
%dir /usr/share/doc/ubuntu-font-family
%doc /usr/share/doc/ubuntu-font-family/*

%changelog
* Thu Dec 3 2015 Paulo Sousa <psousa@telecom.pt> 
- Initial spec file
