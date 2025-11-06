# Notes

## Flathub
```
flatpak remote-modify --no-filter --enable flathub
flatpak install --reinstall flathub $(flatpak list --app-runtime=org.fedoraproject.Platform --columns=application | tail -n +1 )
flatpak remote-delete fedora
```

## Wezterm
```
sudo wget https://copr.fedorainfracloud.org/coprs/wezfurlong/wezterm-nightly/repo/fedora-$(rpm -E %fedora)/wezfurlong-wezterm-nightly-fedora-$(rpm -E %fedora).repo -O /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:wezfurlong:wezterm-nightly.repo
sudo rpm-ostree install wezterm
```

## Steam
Install `steam-devices` package.
