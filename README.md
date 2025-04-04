This repo is for review of requests for signing shim. To create a request for review:

- clone this repo (preferably fork it)
- edit the template below
- add the shim.efi to be signed
- add build logs
- add any additional binaries/certificates/SHA256 hashes that may be needed
- commit all of that
- tag it with a tag of the form "myorg-shim-arch-YYYYMMDD"
- push it to GitHub
- file an issue at https://github.com/rhboot/shim-review/issues with a link to your tag
- approval is ready when the "accepted" label is added to your issue

Note that we really only have experience with using GRUB2 or systemd-boot on Linux, so
asking us to endorse anything else for signing is going to require some convincing on
your part.

Hint: check the [docs](./docs/) directory in this repo for guidance on submission and getting your shim signed.

Here's the template:

*******************************************************************************
### What organization or people are asking to have this signed?
*******************************************************************************
Zeetim. We are a software company from France, building ZeeOS, a managed, Linux-based operating system for thin clients.
https://zeetim.com

*******************************************************************************
### What's the legal data that proves the organization's genuineness?
The reviewers should be able to easily verify, that your organization is a legal entity, to prevent abuse.
Provide the information, which can prove the genuineness with certainty.
*******************************************************************************
Company/tax register entries or equivalent:  
(a link to the organization entry in your jurisdiction's register will do)  

We are a french company. Our DUNS (Data Universal Numbering System) is 263245068.

The public details of both your organization and the issuer in the EV certificate used for signing .cab files at Microsoft Hardware Dev Center File Signing Services.  
(**not** the CA certificate embedded in your shim binary)

Example:

```
Issuer: O=MyIssuer, Ltd., CN=MyIssuer EV Code Signing CA
Subject: C=XX, O=MyCompany, Inc., CN=MyCompany, Inc.
```

```
Serial Number: 0e:80:d1:94:45:43:43:78:0a:05:eb:0f
Signature Algorithm: sha256WithRSAEncryption
Issuer: C = BE, O = GlobalSign nv-sa, CN = GlobalSign GCC R45 EV CodeSigning CA 2020
Validity
  Not Before: Mar 28 13:01:27 2022 GMT
  Not After : Mar 28 13:01:27 2025 GMT
Subject: businessCategory = Private Organization, serialNumber = 533 155 909, jurisdictionC = FR, C = FR, ST = \C3\8Ele-de-France, L = Vitry-sur-Seine, street = 15 BIS RUE FR\C3\89D\C3\89RIC JOLIOT CURIE, O = ZEETIM SAS, CN = ZEETIM SAS
```

*******************************************************************************
### What product or service is this for?
*******************************************************************************
ZeeOS is a lightweight Thin Client OS designed to replace the pre-existing OS on any device.

*******************************************************************************
### What's the justification that this really does need to be signed for the whole world to be able to boot it?
*******************************************************************************
As UEFI Secure Boot is now considered as mandatory feature of hardware, it is critical for Zeetim to support Secure Boot in order that our Operating System can boot on Hardware in which Secure Boot is enabled  without rolling out custom keys first. This provides customer’s with a Secure Operating System for accessing VDI, DaaS and SaaS Workspace based solutions.

*******************************************************************************
### Why are you unable to reuse shim from another distro that is already signed?
*******************************************************************************
The linux kernel and the modules needs to be customized to support customer's peripherals and needs. Currently no known Linux distro with Secure Boot is shipping a suitable kernel, so we need to compile our own.

*******************************************************************************
### Who is the primary contact for security updates, etc.?
The security contacts need to be verified before the shim can be accepted. For subsequent requests, contact verification is only necessary if the security contacts or their PGP keys have changed since the last successful verification.

An authorized reviewer will initiate contact verification by sending each security contact a PGP-encrypted email containing random words.
You will be asked to post the contents of these mails in your `shim-review` issue to prove ownership of the email addresses and PGP keys.
*******************************************************************************
- Name: Damien Lanson
- Position: R&D Engineer
- Email address: damien.lanson@zeetim.com
- PGP key fingerprint: 5d5b0b38a21474df8fa47f28c9f75089b68e35dc
- https://keyserver.ubuntu.com/pks/lookup?search=damien.lanson%40zeetim.com&fingerprint=on&op=index

(Key should be signed by the other security contacts, pushed to a keyserver
like keyserver.ubuntu.com, and preferably have signatures that are reasonably
well known in the Linux community.)

*******************************************************************************
### Who is the secondary contact for security updates, etc.?
*******************************************************************************
- Name: Sabir Tapory
- Position: Chief Technology Officer
- Email address: sabir.tapory@zeetim.com
- PGP key fingerprint: 14bcc273b860476a17c741c846ca43df6e49efba
- https://keyserver.ubuntu.com/pks/lookup?search=sabir.tapory%40zeetim.com&fingerprint=on&op=index

(Key should be signed by the other security contacts, pushed to a keyserver
like keyserver.ubuntu.com, and preferably have signatures that are reasonably
well known in the Linux community.)

*******************************************************************************
### Were these binaries created from the 16.0 shim release tar?
Please create your shim binaries starting with the 16.0 shim release tar file: https://github.com/rhboot/shim/releases/download/16.0/shim-16.0.tar.bz2

This matches https://github.com/rhboot/shim/releases/tag/16.0 and contains the appropriate gnu-efi source.

Make sure the tarball is correct by verifying your download's checksum with the following ones:

```
7b518edd63eb840081912f095ed1487a  shim-16.0.tar.bz2
c2453b9b3c02bc01eea248e9cf634a179ff8828c  shim-16.0.tar.bz2
d503f778dc75895d3130da07e2ff23d2393862f95b6cd3d24b10cbd4af847217  shim-16.0.tar.bz2
b4367f3b1e0716d093f4230902e392d3228bd346e2e07a9377c498d8b3b08a5c0ad25c31aa03af66f54648618074a29b55a3e51925e5cfe5c7ac97257bd25880  shim-16.0.tar.bz2
```

Make sure that you've verified that your build process uses that file as a source of truth (excluding external patches) and its checksum matches. Furthermore, there's [a detached signature as well](https://github.com/rhboot/shim/releases/download/16.0/shim-16.0.tar.bz2.asc) - check with the public key that has the fingerprint `8107B101A432AAC9FE8E547CA348D61BC2713E9F` that the tarball is authentic. Once you're sure, please confirm this here with a simple *yes*.

A short guide on verifying public keys and signatures should be available in the [docs](./docs/) directory.
*******************************************************************************
Yes

*******************************************************************************
### URL for a repo that contains the exact code which was built to result in your binary:
Hint: If you attach all the patches and modifications that are being used to your application, you can point to the URL of your application here (*`https://github.com/YOUR_ORGANIZATION/shim-review`*).

You can also point to your custom git servers, where the code is hosted.
*******************************************************************************
https://github.com/zeetim/shim-review

*******************************************************************************
### What patches are being applied and why:
Mention all the external patches and build process modifications, which are used during your building process, that make your shim binary be the exact one that you posted as part of this application.
*******************************************************************************

We use 3 patches:
- The first one disable fallback mechanism: it removes fallback image from build process and disable fallback during secondary stage loading
- The second one disable mok mechanism: shim do not load any mok variable anymore. Shim is just relying on db certificates, db hashes, and vendor certificate to verify second stage loader. It also removes mok manager image from the build process
- The last one allows to set default mok molicy at build time: it allow to require nx policy from commandline.

*******************************************************************************
### Do you have the NX bit set in your shim? If so, is your entire boot stack NX-compatible and what testing have you done to ensure such compatibility?

See https://techcommunity.microsoft.com/t5/hardware-dev-center/nx-exception-for-shim-community/ba-p/3976522 for more details on the signing of shim without NX bit.
*******************************************************************************
Yes NX flag is set in our shim. We have used Canonical patches to enforce NX flag in grub. Linux kernel is already NX compatible.
*******************************************************************************
### What exact implementation of Secure Boot in GRUB2 do you have? (Either Upstream GRUB2 shim_lock verifier or Downstream RHEL/Fedora/Debian/Canonical-like implementation)
Skip this, if you're not using GRUB2.
*******************************************************************************
We are using Canonical implementation of Secure Boot.

*******************************************************************************
### Do you have fixes for all the following GRUB2 CVEs applied?
**Skip this, if you're not using GRUB2, otherwise make sure these are present and confirm with _yes_.**

* 2020 July - BootHole
  * Details: https://lists.gnu.org/archive/html/grub-devel/2020-07/msg00034.html
  * CVE-2020-10713
  * CVE-2020-14308
  * CVE-2020-14309
  * CVE-2020-14310
  * CVE-2020-14311
  * CVE-2020-15705
  * CVE-2020-15706
  * CVE-2020-15707
* March 2021
  * Details: https://lists.gnu.org/archive/html/grub-devel/2021-03/msg00007.html
  * CVE-2020-14372
  * CVE-2020-25632
  * CVE-2020-25647
  * CVE-2020-27749
  * CVE-2020-27779
  * CVE-2021-3418 (if you are shipping the shim_lock module)
  * CVE-2021-20225
  * CVE-2021-20233
* June 2022
  * Details: https://lists.gnu.org/archive/html/grub-devel/2022-06/msg00035.html, SBAT increase to 2
  * CVE-2021-3695
  * CVE-2021-3696
  * CVE-2021-3697
  * CVE-2022-28733
  * CVE-2022-28734
  * CVE-2022-28735
  * CVE-2022-28736
  * CVE-2022-28737
* November 2022
  * Details: https://lists.gnu.org/archive/html/grub-devel/2022-11/msg00059.html, SBAT increase to 3
  * CVE-2022-2601
  * CVE-2022-3775
* October 2023 - NTFS vulnerabilities
  * Details: https://lists.gnu.org/archive/html/grub-devel/2023-10/msg00028.html, SBAT increase to 4
  * CVE-2023-4693
  * CVE-2023-4692
*******************************************************************************
All of these CVEs are patched in upstream grub and shim

*******************************************************************************
### If shim is loading GRUB2 bootloader, and if these fixes have been applied, is the upstream global SBAT generation in your GRUB2 binary set to 4?
Skip this, if you're not using GRUB2, otherwise do you have an entry in your GRUB2 binary similar to:  
`grub,4,Free Software Foundation,grub,GRUB_UPSTREAM_VERSION,https://www.gnu.org/software/grub/`?
*******************************************************************************
Yes

*******************************************************************************
### Were old shims hashes provided to Microsoft for verification and to be added to future DBX updates?
### Does your new chain of trust disallow booting old GRUB2 builds affected by the CVEs?
If you had no previous signed shim, say so here. Otherwise a simple _yes_ will do.
*******************************************************************************
It is out second submission. Our fist submission did not get signed by Microsoft.

*******************************************************************************
### If your boot chain of trust includes a Linux kernel:
### Is upstream commit [1957a85b0032a81e6482ca4aab883643b8dae06e "efi: Restrict efivar_ssdt_load when the kernel is locked down"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1957a85b0032a81e6482ca4aab883643b8dae06e) applied?
### Is upstream commit [75b0cea7bf307f362057cc778efe89af4c615354 "ACPI: configfs: Disallow loading ACPI tables when locked down"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=75b0cea7bf307f362057cc778efe89af4c615354) applied?
### Is upstream commit [eadb2f47a3ced5c64b23b90fd2a3463f63726066 "lockdown: also lock down previous kgdb use"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eadb2f47a3ced5c64b23b90fd2a3463f63726066) applied?
Hint: upstream kernels should have all these applied, but if you ship your own heavily-modified older kernel version, that is being maintained separately from upstream, this may not be the case.  
If you are shipping an older kernel, double-check your sources; maybe you do not have all the patches, but ship a configuration, that does not expose the issue(s).
*******************************************************************************
We are using upstream version of the Linux kernel

*******************************************************************************
### How does your signed kernel enforce lockdown when your system runs
### with Secure Boot enabled?
Hint: If it does not, we are not likely to sign your shim.
*******************************************************************************
We have set the following configuration in the Linux kernel:
```conf
CONFIG_SECURITY_LOCKDOWN_LSM=y 
CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=y
CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY=y

CONFIG_MODULES=y
CONFIG_MODULE_SIG_FORCE=y
```

*******************************************************************************
### Do you build your signed kernel with additional local patches? What do they do?
*******************************************************************************
No we are using upstream version of Linux kernel

*******************************************************************************
### Do you use an ephemeral key for signing kernel modules?
### If not, please describe how you ensure that one kernel build does not load modules built for another kernel.
*******************************************************************************
Yes

*******************************************************************************
### If you use vendor_db functionality of providing multiple certificates and/or hashes please briefly describe your certificate setup.
### If there are allow-listed hashes please provide exact binaries for which hashes are created via file sharing service, available in public with anonymous access for verification.
*******************************************************************************
We are not using vendor_db functionality.

*******************************************************************************
### If you are re-using the CA certificate from your last shim binary, you will need to add the hashes of the previous GRUB2 binaries exposed to the CVEs mentioned earlier to vendor_dbx in shim. Please describe your strategy.
This ensures that your new shim+GRUB2 can no longer chainload those older GRUB2 binaries with issues.

If this is your first application or you're using a new CA certificate, please say so here.
*******************************************************************************
Since our last submission did not get signed by Microsoft, we have reused the same CA certificate.

*******************************************************************************
### Is the Dockerfile in your repository the recipe for reproducing the building of your shim binary?
A reviewer should always be able to run `docker build .` to get the exact binary you attached in your application.

Hint: Prefer using *frozen* packages for your toolchain, since an update to GCC, binutils, gnu-efi may result in building a shim binary with a different checksum.

If your shim binaries can't be reproduced using the provided Dockerfile, please explain why that's the case, what the differences would be and what build environment (OS and toolchain) is being used to reproduce this build? In this case please write a detailed guide, how to setup this build environment from scratch.
*******************************************************************************
Our build is reproducible using "docker build" command. We have also created a Makefile to pass build arguments to Docker. 

*******************************************************************************
### Which files in this repo are the logs for your build?
This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
*******************************************************************************
`build.log` contains all build log.

*******************************************************************************
### What changes were made in the distro's secure boot chain since your SHIM was last signed?
For example, signing new kernel's variants, UKI, systemd-boot, new certs, new CA, etc..

Skip this, if this is your first application for having shim signed.
*******************************************************************************
We have not changed anything in the secureboot chain since our last submission. We have only updated components to their latest stable version.

*******************************************************************************
### What is the SHA256 hash of your final shim binary?
*******************************************************************************
`b81f0565eba1f7039f880ab272cf7316b287a896a2712e2eb28dac39d833a3a6`

*******************************************************************************
### How do you manage and protect the keys used in your shim?
Describe the security strategy that is used for key protection. This can range from using hardware tokens like HSMs or Smartcards, air-gapped vaults, physical safes to other good practices.
*******************************************************************************
The key is stored on a FIPS-140-2 USB token (YubiKey), connected to the build machine, and only the authorized persons know the password.

*******************************************************************************
### Do you use EV certificates as embedded certificates in the shim?
A _yes_ or _no_ will do. There's no penalty for the latter.
*******************************************************************************
No

*******************************************************************************
### Are you embedding a CA certificate in your shim?
A _yes_ or _no_ will do. There's no penalty for the latter. However,
if _yes_: does that certificate include the X509v3 Basic Constraints
to say that it is a CA? See the [docs](./docs/) for more guidance
about this.
*******************************************************************************
Yes

*******************************************************************************
### Do you add a vendor-specific SBAT entry to the SBAT section in each binary that supports SBAT metadata ( GRUB2, fwupd, fwupdate, systemd-boot, systemd-stub, shim + all child shim binaries )?
### Please provide the exact SBAT entries for all binaries you are booting directly through shim.
Hint: The history of SBAT and more information on how it works can be found [here](https://github.com/rhboot/shim/blob/main/SBAT.md). That document is large, so for just some examples check out [SBAT.example.md](https://github.com/rhboot/shim/blob/main/SBAT.example.md)

If you are using a downstream implementation of GRUB2 (e.g. from Fedora or Debian), make sure you have their SBAT entries preserved and that you **append** your own (don't replace theirs) to simplify revocation.

**Remember to post the entries of all the binaries. Apart from your bootloader, you may also be shipping e.g. a firmware updater, which will also have these.**

Hint: run `objcopy --only-section .sbat -O binary YOUR_EFI_BINARY /dev/stdout` to get these entries. Paste them here. Preferably surround each listing with three backticks (\`\`\`), so they render well.
*******************************************************************************
SBAT of GRUB2 binary:
```csv
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
grub,4,Free Software Foundation,grub,2.12,https://www.gnu.org/software/grub/
grub.peimage,2,Canonical,grub2,2.12-5ubuntu7,https://salsa.debian.org/grub-team/grub/-/blob/master/debian/patches/secure-boot/efi-use-peimage-shim.patch
grub.zeetim,1,Zeetim,grub,2.12,mail:contact@zeetim.com
```
__Note:__ We are closer to the upstream version of GRUB2 than the Canonical version since we are only using a small subset of their patches. That is why we have only included `grub.peimage` entry.

*******************************************************************************
### If shim is loading GRUB2 bootloader, which modules are built into your signed GRUB2 image?
Skip this, if you're not using GRUB2.

Hint: this is about those modules that are in the binary itself, not the `.mod` files in your filesystem.
*******************************************************************************
```
part_msdos part_gpt part_msdos fat memdisk squash4 iso9660 cpio loopback
keylayouts at_keyboard
all_video gfxterm terminal
font gettext echo regexp cat
gcry_sha256 gcry_sha512 gcry_dsa gcry_rsa
password_pbkdf2 pbkdf2
efinet tftp http
linux boot halt reboot minicmd sleep test gzio normal configfile
peimage
```

*******************************************************************************
### If you are using systemd-boot on arm64 or riscv, is the fix for [unverified Devicetree Blob loading](https://github.com/systemd/systemd/security/advisories/GHSA-6m6p-rjcq-334c) included?
*******************************************************************************
We are using GRUB2.

*******************************************************************************
### What is the origin and full version number of your bootloader (GRUB2 or systemd-boot or other)?
*******************************************************************************
We are downloading grub sources from official website: http://ftp.gnu.org/gnu/grub
We are using the lastest version: 2.12 .

*******************************************************************************
### If your shim launches any other components apart from your bootloader, please provide further details on what is launched.
Hint: The most common case here will be a firmware updater like fwupd.
*******************************************************************************
We are only launching GRUB2.

*******************************************************************************
### If your GRUB2 or systemd-boot launches any other binaries that are not the Linux kernel in SecureBoot mode, please provide further details on what is launched and how it enforces Secureboot lockdown.
Skip this, if you're not using GRUB2 or systemd-boot.
*******************************************************************************
GRUB2 only loads Linux kernel.

*******************************************************************************
### How do the launched components prevent execution of unauthenticated code?
Summarize in one or two sentences, how your secure bootchain works on higher level.
*******************************************************************************
shim verifies signature of grub, grub verifies signature of kernel. Grub also use a builtin GPG key that ensures that all grub configs and initrd cannot be modified. Kernel modules are signed and verified against ephemeral key.

*******************************************************************************
### Does your shim load any loaders that support loading unsigned kernels (e.g. certain GRUB2 configurations)?
*******************************************************************************
No

*******************************************************************************
### What kernel are you using? Which patches and configuration does it include to enforce Secure Boot?
*******************************************************************************
We are using the latest longterm release of the Linux kernel (currently 6.12.20) without additional patches.

*******************************************************************************
### What contributions have you made to help us review the applications of other applicants?
The reviewing process is meant to be a peer-review effort and the best way to have your application reviewed faster is to help with reviewing others. We are in most cases volunteers working on this venue in our free time, rather than being employed and paid to review the applications during our business hours. 

A reasonable timeframe of waiting for a review can reach 2-3 months. Helping us is the best way to shorten this period. The more help we get, the faster and the smoother things will go.

For newcomers, the applications labeled as [*easy to review*](https://github.com/rhboot/shim-review/issues?q=is%3Aopen+is%3Aissue+label%3A%22easy+to+review%22) are recommended to start the contribution process.
*******************************************************************************
- [Ctrl IQ, Inc EL7 Shim 15.8 for x64 & ia32](https://github.com/rhboot/shim-review/issues/430#issuecomment-2326738460)
- [Shim 15.8 for IGEL OS (x86_64)](https://github.com/rhboot/shim-review/issues/434#issuecomment-2329069279)
- [shim-16.0 for Isoo (20250321)](https://github.com/rhboot/shim-review/issues/463#issuecomment-2751780558)
- [shim-16.0 for opsi](https://github.com/rhboot/shim-review/issues/466#issuecomment-2757625785)

*******************************************************************************
### Add any additional information you think we may need to validate this shim signing application.
*******************************************************************************
Microsoft asks us to remove fallbak and mok addons from Shim. That is why we are using 2 additional patches since our last submission.
