Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD5FD4A603
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 05:50:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18C6A41611;
	Fri, 16 Jan 2026 06:50:56 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id CBB5B4014F
 for <dev@dpdk.org>; Fri, 16 Jan 2026 06:50:53 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-47d1d8a49f5so9691415e9.3
 for <dev@dpdk.org>; Thu, 15 Jan 2026 21:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768542653;
 x=1769147453; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qZLU4CjdSblDxEVTQRteLI7uV59sbcz4PRQNeoPJWEQ=;
 b=imxGEoc2E+zSXyXIhgcdNcF8+6HCVXi8z2WNEvxaoH7HlRGxmjPtjDfEjOzz4LinBY
 dnC2Z7qHUafxGbaw2ked5Oltb2iQWsWNr35QR5yWWgyMabhkWuUk3/ur8GiHEFmsrLyi
 Ux+m0gI3h7/X5Phvksvu607w9MrvC2ihO8Cl3d6JLK+XdIX9LcjgYrQsEjaBXd+92ELl
 Ic/kYROd6FFn3DFtb2gLwlZSzMWd9qAmR0viCCovMkviUv6G01WsSITzTuExtJcrK6W9
 CJSs2ZlG2QZ5+wHO4s7zd55K71qRa0jT2Dqnji0uMZqf+Mo2NTFLkgz3pRjT3K+pJX6t
 0lBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768542653; x=1769147453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qZLU4CjdSblDxEVTQRteLI7uV59sbcz4PRQNeoPJWEQ=;
 b=Q6hDrFHS6Jg9Sd6+SFG9e5p2eUJKcPBsFsxadJ5Fbnp8UWrjil8Q/H5MrUjOJhI+1H
 3MOMu1+NPvJL9Gz/VrdtoxLbk8sA8wKepgcxNV5x5oZ6XkItGKVO2WQMgc2f5WiOKRmk
 Vs5IjngHto5xo071pc7SfVIS5ZUw3J2srM61MpUGpKs5ZwWtuBAnLDCnuzlyvk8FEsix
 hrg2mQytDReVMZATNxB7y+YsAI2531FB0CY+iRWmd9t0kSVJ8FcXbD7A6NCMxvRN2zuE
 1iLu2BLojGQ/hxbObXBo/FaDWM/O1uTUm1beSsnrhuR+EmzFpIXNKhGDLmw76ei8OcOn
 RCNA==
X-Gm-Message-State: AOJu0YzUzoncG2UQBbjp1lbIraApbV3ab3TBCwrWeyLeKg3c5bUz0msI
 DhHw6qvEda/5QLVN9tZoPio1CqygxDvS/M84yJTJs/kGlHv1mt6HcYz+4EXigTlmeu9OOz8AECn
 Qg4ED
X-Gm-Gg: AY/fxX6A8wQziRkvxMD/Kjo6Nrb6mJlwdsDx3tfL+GY8SqbnkRlEUBrQksXehQvMWqa
 pv7zL0Rk9cpYFH54XsIYLgbYq1akMXrbTToVCT8xCt8nN0GiGRWZNGM4BJXlVkYDuP7ayoU/6WT
 Scye0BmRixep9VXd6RwdawT17fCL2lzoQpYyMAME0pZCanvP4HqbEHCIx5VtOtJ7Yly+JXx1RQ+
 ETaYw1BiBoKVU+GgL0ks2TWC6liQbPWUOPIm8ssBixb4LBMaPOPzw5D7FgnC6S+Clv4ZpLX6nOg
 W7fPC787CCWuLtp+xJFso4CdxD3BlNWa1JeAsn2FUn9PaeQKv+pKSovf4GRt9H87+cIoKwr8f66
 kLNJMfBsrMueFRuOdQdv4F5L93WXEV1eppu8hgf/LaVEWxJsfRzlevVCocy7V/GF0oulXt9PS2M
 9jNcoxfBnzy0Abu+Q2iMCFmAwwxZYGFHiSsfcLKxc0Fga/HL/xEEp3
X-Received: by 2002:a05:600c:8714:b0:479:3a86:dc1c with SMTP id
 5b1f17b1804b1-4801e3531c2mr24574085e9.36.1768542653298; 
 Thu, 15 Jan 2026 21:50:53 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e9ac373sm11129905e9.1.2026.01.15.21.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 21:50:53 -0800 (PST)
Date: Thu, 15 Jan 2026 21:50:48 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: spinler@cesnet.cz
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/8] net/nfb: rework to real multiport
Message-ID: <20260115215048.436827da@phoenix.local>
In-Reply-To: <20260115151656.393106-1-spinler@cesnet.cz>
References: <20260115151656.393106-1-spinler@cesnet.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

On Thu, 15 Jan 2026 16:16:48 +0100
spinler@cesnet.cz wrote:

> From: Martin Spinler <spinler@cesnet.cz>
>=20
> This series implements real multiport for better user experience.
>=20
> The existing driver creates one ethdev/port for one PCI device.
> As the CESNET-NDK based cards aren't capable to represent each
> Ethernet port by own PCI device, new driver implementation
> processes real port configuration from firmware/card and switches
> from rte_eth_dev_pci_generic_probe to multiple rte_eth_dev_create calls.
>=20
> ---
> Depends-on: series-37064 ("net/nfb: code cleanup")
>=20
> Martin Spinler (8):
>   net/nfb: prepare for indirect queue mapping scheme
>   net/nfb: create ethdev for every eth port/channel
>   net/nfb: add vdev as alternative device probe method
>   net/nfb: add device argument "port" to limit used ports
>   net/nfb: init only MACs associated with device
>   net/nfb: add compatible cards to driver PCI ID table
>   net/nfb: report firmware version
>   doc/nfb: cleanup and update guide
>=20
>  doc/guides/nics/features/nfb.ini |   4 +
>  doc/guides/nics/nfb.rst          | 187 +++++++--------
>  drivers/net/nfb/meson.build      |   1 +
>  drivers/net/nfb/nfb.h            |  48 +++-
>  drivers/net/nfb/nfb_ethdev.c     | 399 +++++++++++++++++++++++--------
>  drivers/net/nfb/nfb_rx.c         |  21 +-
>  drivers/net/nfb/nfb_tx.c         |  21 +-
>  drivers/net/nfb/nfb_vdev.c       |  97 ++++++++
>  8 files changed, 551 insertions(+), 227 deletions(-)
>  create mode 100644 drivers/net/nfb/nfb_vdev.c
>=20
> --
> 2.52.0


AI had some good feedback on this patch series.
Some of this noise though.

# DPDK NFB Multiport Patch Series Review

**Series:** `[PATCH 1-8/8]` NFB multiport support =20
**Author:** Martin Spinler <spinler@cesnet.cz> =20
**Date:** Thu, 15 Jan 2026 =20

---

## Executive Summary

This patch series adds multiport support to the NFB driver, changing from a=
 single ethdev per PCI device to one ethdev per Ethernet channel. The serie=
s is generally well-structured and follows DPDK conventions, but has severa=
l issues requiring attention before merging.

---

## Patch-by-Patch Review

### Patch 1/8: `net/nfb: prepare for indirect queue mapping scheme`

**Subject Line:** =E2=9C=85 OK (52 chars, correct prefix, lowercase)

**Commit Message:**
- =E2=9A=A0=EF=B8=8F **WARNING:** Body is minimal - could use more context =
explaining *why* queue mapping needs to change
- =E2=9C=85 Signed-off-by present

**Code Issues:**

| Line | Severity | Issue |
|------|----------|-------|
| 113-118 | =E2=9A=A0=EF=B8=8F Warning | Unnecessary braces for single-stat=
ement `for` loops |
| 161 | =E2=9A=A0=EF=B8=8F Warning | Comment typo: "neccessary" =E2=86=92 "=
necessary" |
| 205 | =E2=9A=A0=EF=B8=8F Warning | Same typo: "neccessary" =E2=86=92 "nec=
essary" |

```c
// Current (unnecessary braces):
for (i =3D 0; i < priv->max_rx_queues; i++) {
    internals->queue_map_rx[i] =3D i;
}

// Preferred:
for (i =3D 0; i < priv->max_rx_queues; i++)
    internals->queue_map_rx[i] =3D i;
```

**Style:** =E2=9C=85 OK - uses `rte_malloc`/`rte_free` appropriately for dr=
iver code

---

### Patch 2/8: `net/nfb: create ethdev for every eth port/channel`

**Subject Line:** =E2=9C=85 OK (49 chars)

**Commit Message:**
- =E2=9C=85 Good explanation of the change rationale
- =E2=9A=A0=EF=B8=8F **WARNING:** Line 297 "informations" =E2=86=92 "inform=
ation" (grammar)
- =E2=9C=85 Signed-off-by present

**Code Issues:**

| Line | Severity | Issue |
|------|----------|-------|
| 341-342 | =E2=9A=A0=EF=B8=8F Warning | Double blank line after struct def=
inition |
| 373 | =E2=84=B9=EF=B8=8F Info | Consider using `TAILQ_HEAD_INITIALIZER` i=
nline instead of separate declaration |
| 545-547 | =E2=9A=A0=EF=B8=8F Warning | Comment says "doesn't belong" but =
code checks `ep !=3D ep_index` which is confusing |

**Structural Issues:**
- =E2=9C=85 Good use of TAILQ for device list management
- =E2=9C=85 Proper error cleanup with `goto` labels
- =E2=9A=A0=EF=B8=8F **WARNING:** `nfb_eth_common_probe()` declared in head=
er but missing `__rte_internal` tag for internal API

---

### Patch 3/8: `net/nfb: add vdev as alternative device probe method`

**Subject Line:** =E2=9C=85 OK (50 chars)

**Commit Message:**
- =E2=9C=85 Clear explanation
- =E2=9C=85 Signed-off-by present

**Code Issues:**

| Line | Severity | Issue |
|------|----------|-------|
| 719 | =E2=9D=8C Error | Copyright year "2019" should be updated to curren=
t year (2026) for new file |
| 729-730 | =E2=84=B9=EF=B8=8F Info | Double blank line |
| 766 | =E2=9A=A0=EF=B8=8F Warning | Cast `(signed)` is unusual - prefer ex=
plicit `int` comparison |
| 778 | =E2=9A=A0=EF=B8=8F Warning | `strcpy()` is unsafe - use `strlcpy()`=
 or `snprintf()` |

```c
// Current (unsafe):
strcpy(params.name, vdev_name);

// Preferred:
strlcpy(params.name, vdev_name, sizeof(params.name));
// or
snprintf(params.name, sizeof(params.name), "%s", vdev_name);
```

| Line | Severity | Issue |
|------|----------|-------|
| 751, 784 | =E2=9A=A0=EF=B8=8F Warning | Using libc `strdup()`/`free()` - =
should use `rte_strdup()`/`rte_free()` for consistency |

**License:** =E2=9C=85 SPDX-License-Identifier present and correct (BSD-3-C=
lause)

---

### Patch 4/8: `net/nfb: add device argument "port" to limit used ports`

**Subject Line:** =E2=9C=85 OK (52 chars)

**Commit Message:**
- =E2=9A=A0=EF=B8=8F **WARNING:** Line 876 - "NFB devices does not" =E2=86=
=92 "NFB devices do not" (grammar)
- =E2=9C=85 Signed-off-by present

**Code Issues:**

| Line | Severity | Issue |
|------|----------|-------|
| 905-908 | =E2=9A=A0=EF=B8=8F Warning | `static const char * const` array =
defined in header - should be in .c file to avoid multiple definitions |
| 927 | =E2=9A=A0=EF=B8=8F Warning | Using hex base (16) for port parsing b=
ut doc says `port=3D<number>` - inconsistent |
| 971 | =E2=9A=A0=EF=B8=8F Warning | Missing space after cast: `(void*)` =
=E2=86=92 `(void *)` |

```c
// Current:
if (rte_kvargs_process(kvlist, NFB_ARG_PORT, fill_port_mask, (void*) &port_=
mask))

// Preferred:
if (rte_kvargs_process(kvlist, NFB_ARG_PORT, fill_port_mask, (void *)&port_=
mask))
```

---

### Patch 5/8: `net/nfb: init only MACs associated with device`

**Subject Line:** =E2=9C=85 OK (46 chars)

**Commit Message:**
- =E2=9A=A0=EF=B8=8F **WARNING:** "informations" =E2=86=92 "information" (g=
rammar)
- =E2=9C=85 Signed-off-by present

**Code Issues:**

| Line | Severity | Issue |
|------|----------|-------|
| 1147-1148, 1155-1161, 1200-1206 | =E2=9A=A0=EF=B8=8F Warning | Unnecessar=
y braces around single `if` body |
| 1192 | =E2=84=B9=EF=B8=8F Info | Extra blank line at start of function bo=
dy |

**Good practices observed:**
- =E2=9C=85 Dynamic allocation of MAC arrays based on actual count
- =E2=9C=85 Proper cleanup with `rte_free()`

---

### Patch 6/8: `net/nfb: add compatible cards to driver PCI ID table`

**Subject Line:** =E2=9C=85 OK (52 chars)

**Commit Message:**
- =E2=9C=85 Clear list of added cards
- =E2=9C=85 Signed-off-by present

**Code Issues:**

| Line | Severity | Issue |
|------|----------|-------|
| 1421-1423 | =E2=84=B9=EF=B8=8F Info | Inconsistent spacing in `RTE_PCI_DE=
VICE` calls - some have 1 space, some have 2 |

```c
// Inconsistent:
{ RTE_PCI_DEVICE(PCI_VENDOR_ID_SILICOM, PCI_DEVICE_ID_FB2CGHH) },
{ RTE_PCI_DEVICE(PCI_VENDOR_ID_CESNET,  PCI_DEVICE_ID_COMBO400G1) },  // 2 =
spaces

// Should be consistent throughout
```

**Documentation:** =E2=9A=A0=EF=B8=8F **WARNING** - New device IDs should b=
e mentioned in release notes

---

### Patch 7/8: `net/nfb: report firmware version`

**Subject Line:** =E2=9C=85 OK (33 chars)

**Commit Message:**
- =E2=9D=8C **ERROR:** Missing commit body - should explain what firmware v=
ersion info is reported and why
- =E2=9C=85 Signed-off-by present

**Code Issues:**

| Line | Severity | Issue |
|------|----------|-------|
| 1508-1509 | =E2=9A=A0=EF=B8=8F Warning | Unnecessary cast from `void *` -=
 `dev->process_private` is already `void *` |
| 1521 | =E2=9A=A0=EF=B8=8F Warning | Cast `(signed)` is unusual - prefer `=
(int)fw_size` or comparison with explicit types |

```c
// Current (unnecessary cast):
struct pmd_internals *priv =3D (struct pmd_internals *)
        dev->process_private;

// Preferred:
struct pmd_internals *priv =3D dev->process_private;
```

**Documentation:** =E2=9C=85 Features matrix updated in patch 8

---

### Patch 8/8: `doc/nfb: cleanup and update guide`

**Subject Line:** =E2=9C=85 OK (31 chars)

**Commit Message:**
- =E2=9D=8C **ERROR:** Missing commit body - should summarize what's change=
d in docs
- =E2=9C=85 Signed-off-by present

**Documentation Issues:**

| Line | Severity | Issue |
|------|----------|-------|
| 1674-1675 | =E2=9D=8C Error | URL uses `http://` - should be `https://` p=
er DPDK guidelines |
| 1761 | =E2=9A=A0=EF=B8=8F Warning | Typo: "lack a of lot" =E2=86=92 "lack=
 a lot" |
| 1767-1770 | =E2=84=B9=EF=B8=8F Info | Extra blank lines in Features secti=
on |
| 1827 | =E2=9A=A0=EF=B8=8F Warning | Stray backtick at end: `-- -i\`` =E2=
=86=92 `-- -i` |

```rst
// Current (line 1674):
`Liberouter website <http://www.liberouter.org/>`_.

// Should be https
```

**Features Matrix:**
- =E2=9C=85 Added: Unicast MAC filter, Timestamp offload (P), FW version, M=
ultiprocess aware
- =E2=9A=A0=EF=B8=8F Should verify these actually work as documented

---

## Summary of Issues

### Errors (Must Fix)

| Patch | Issue |
|-------|-------|
| 3/8 | Copyright year 2019 in new file should be 2026 |
| 7/8 | Missing commit body |
| 8/8 | Missing commit body |
| 8/8 | URL uses `http://` instead of `https://` |

### Warnings (Should Fix)

| Patch | Issue |
|-------|-------|
| 1/8 | Typo: "neccessary" (2 occurrences) |
| 2/8 | Grammar: "informations" |
| 2/8 | Missing `__rte_internal` on internal API |
| 3/8 | Unsafe `strcpy()` - use `strlcpy()` |
| 3/8 | libc `strdup()`/`free()` instead of `rte_*` variants |
| 4/8 | Grammar: "does not" =E2=86=92 "do not" |
| 4/8 | `static const` array in header file |
| 4/8 | Missing space after cast |
| 5/8 | Grammar: "informations" |
| 6/8 | New device IDs need release notes |
| 7/8, 8/8 | Unnecessary casts from `void *` |
| 8/8 | Typo: "lack a of lot" |
| 8/8 | Stray backtick in command example |

### Info (Consider)

| Patch | Issue |
|-------|-------|
| 1/8, 5/8 | Unnecessary braces for single statements |
| 3/8, 4/8 | Double blank lines |
| 6/8 | Inconsistent spacing in macro calls |

---

## Missing Items

1. **Release Notes:** No `doc/guides/rel_notes/` entry for this significant=
 driver change
2. **Cc: stable@dpdk.org:** Not applicable (new feature, not a fix)
3. **Cover Letter:** Series lacks a cover letter explaining the overall mot=
ivation and design

---

## Recommendations

1. Add a cover letter (patch 0/8) explaining the multiport architecture cha=
nges
2. Update release notes for the new multiport support and new device IDs
3. Fix all typos and grammar issues in commit messages
4. Add commit bodies to patches 7/8 and 8/8
5. Update copyright year in new files
6. Replace unsafe string functions with safe variants
7. Consider using `rte_strdup()` instead of libc `strdup()` for consistency

---

## Verdict

**Needs Revision (v2)**

The patch series is fundamentally sound and addresses a real limitation of =
the existing driver. However, there are several documentation and style iss=
ues that should be addressed before merging. The most critical issues are t=
he missing commit bodies, documentation URL protocol, and the unsafe `strcp=
y()` usage.

