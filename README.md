# Notes

## Flathub

```
sudo flatpak remote-modify --no-filter --enable flathub
sudo flatpak install --reinstall flathub $(flatpak list --app-runtime=org.fedoraproject.Platform --columns=application | tail -n +1 )
sudo flatpak remote-delete fedora
```

## Wezterm

```
sudo wget https://copr.fedorainfracloud.org/coprs/wezfurlong/wezterm-nightly/repo/fedora-$(rpm -E %fedora)/wezfurlong-wezterm-nightly-fedora-$(rpm -E %fedora).repo -O /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:wezfurlong:wezterm-nightly.repo
sudo rpm-ostree install wezterm
```

## Steam

Install `steam-devices` package.

## Asus X470-F Gaming fan workaround

Create the file `/etc/modprobe.d/disable-asus-wmi.conf` and add this entry :
```
blacklist asus_wmi_sensors
```

## Btrbk

Follow instructions at <https://gitub.com/digint/btrbk> and use the following configuration:
```
timestamp_format long
snapshot_preserve_min 1d
snapshot_preserve 4d

target_preserve_min 7d
target_preserve 15d 5w 3m

volume /mnt/btr_pool
  snapshot_dir btrbk_snapshots
  target /mnt/data/btrbk_backups
  subvolume home

volume /mnt/data
#  snapshot_preserve_min 7d
#  snapshot_preserve 14d
```
