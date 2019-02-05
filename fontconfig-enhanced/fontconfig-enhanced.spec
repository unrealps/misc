Name:    fontconfig-enhanced
Version: 1.3.0
Release: 1%{?dist}
Summary: Enhanced default settings for Fontconfig and FreeType

Group:   System Environment/Libraries
License: Public Domain

BuildArch:     noarch
BuildRequires: fontpackages-devel
Requires:      fontpackages-filesystem
Requires:      freetype-subpixel

%description
Font configuration files that enable subpixel rendering.

%install
install -m 0755 -d %{buildroot}%{_fontconfig_templatedir} \
                   %{buildroot}%{_fontconfig_confdir}

ln -s %{_fontconfig_templatedir}/10-autohint.conf \
      %{buildroot}%{_fontconfig_confdir}/10-autohint.conf

ln -s %{_fontconfig_templatedir}/10-sub-pixel-rgb.conf \
      %{buildroot}%{_fontconfig_confdir}/10-sub-pixel-rgb.conf

ln -s %{_fontconfig_templatedir}/11-lcdfilter-light.conf\
      %{buildroot}%{_fontconfig_confdir}/11-lcdfilter-default.conf
%post
echo "Now open gnome-tweak-tool, go to tab 'fonts' and configure:"
echo "Hinting       : Slight"
echo "Antialiasing  : Subpixel"
echo "Scaling Factor: 0,90"

%files
%{_fontconfig_confdir}/*

%changelog
* Wed Dec 13 2017 Paulo Sousa <sousa.paulo.1975@gmail.com> - 1
- Initial packaging.
