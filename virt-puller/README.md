# virt-puller

This image is intended to pull and prep images for my other virt-* images. This image is necessary because fuse operations require privileged execution, which is not allowed durring `docker build`.

## Usage
`docker run --rm --privileged -v $(pwd):/work/ abferm/virt-puller:latest ${UBUNTU_RELEASE} ${ARCH}`