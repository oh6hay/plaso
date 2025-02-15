- [ ] Update version and documentation
  - `./utils/update_release.sh`
- [ ] Create GitHub release and tag
- [ ] Upload source package and signature to Github release page as pre-release
  - `python -m build --sdist`
  - `gpg --armor --detach-sign dist/plaso-$VERSION.tar.gz > dist/plaso-$VERSION.tar.gz.asc`
- [ ] [Update GIFT PPA](https://github.com/log2timeline/l2tdocs/blob/main/process/GIFT%20PPA.md) staging
  - Build Ubuntu source debs: `PYTHONPATH=. ./tools/build.py --preset plaso dpkg-source`
- [ ] [Update GIFT COPR](https://github.com/log2timeline/l2tdocs/blob/main/process/GIFT%20COPR.md) staging
  - Build Fedora source rpms: `PYTHONPATH=. ./tools/build.py --preset plaso srpm`
- [ ] [Update l2tbinaries](https://github.com/log2timeline/l2tdocs/blob/main/process/l2tbinaries.md) win32 staging
  - Build 32-bit Windows binaries: `PYTHONPATH=. ./tools/build.py --preset plaso wheel`
- [ ] [Update l2tbinaries](https://github.com/log2timeline/l2tdocs/blob/main/process/l2tbinaries.md) win64 staging
  - Build 64-bit Windows binaries: `PYTHONPATH=. ./tools/build.py --preset plaso wheel`
- [ ] [Update Docker image](https://github.com/log2timeline/l2tdocs/blob/main/process/Maintainers%20guide.md#updating-the-plasos-image-on-dockers-hub-to-the-latest-version-in-ppa)
- [ ] Run integration tests
- [ ] Promote pre-release to release
  - GitHub release
- [ ] Promote staging to stable
  - GIFT PPA
  - GIFT COPR
  - l2tbinaires
  - Docker image
- [ ] [Update PyPI](https://github.com/log2timeline/l2tdocs/blob/main/process/PyPI.md)
- [ ] Write and publish blog post
