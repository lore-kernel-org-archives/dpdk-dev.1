Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C50CD2D100
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 23:16:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 720224060C;
	Wed, 14 Jan 2026 00:16:38 +0100 (CET)
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
 [209.85.208.65]) by mails.dpdk.org (Postfix) with ESMTP id B0568402BE
 for <dev@dpdk.org>; Wed, 14 Jan 2026 00:16:36 +0100 (CET)
Received: by mail-ed1-f65.google.com with SMTP id
 4fb4d7f45d1cf-6505cac9879so13748826a12.1
 for <dev@dpdk.org>; Tue, 13 Jan 2026 15:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768346196;
 x=1768950996; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eqJnLY4wga0ygzXy7N/y8sHYl8T2crKmg2y1e2ly/bI=;
 b=sQ4zapCT7jPUUZ2DGhBXBcqhWVwTz6ihYKvBoUXgMT0jRt5n9lvd/vjiEyo4/pvPvR
 Ecz6g4iUtFBYXbNE85sWxW/3LMLLPnuzpwhPBzlHiqNWlw8PK0PrgNvQdf8prTTya9Og
 gbAexUh4azNqeYfxyTIIKrSRQDjLixvFok2q7M9A3rSFMpUKnOv1qgyHirTPDugeyYQ8
 PTnJL4Q1hzRzFwilvRKnjzCKtogKFPD/dPSYYOXljjhfuozso2QW97y+l9ry8D/A3iU7
 sbGq/9AppHXfIopuFAzmvaYRf/FwstrJWbtim3VP122frAPEAsqz2Rb27Ea1+6QtdvPh
 82jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768346196; x=1768950996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eqJnLY4wga0ygzXy7N/y8sHYl8T2crKmg2y1e2ly/bI=;
 b=TvQWRhiOZYwzgMh4zINDO/nJp63QoPfllwgsYySx0EzzOira/L54SSgnR9EW4tGKyx
 PnQJrZT9MGxS5Wa0ThIDEFqNmT1ju+LWTF2W8IJgT60l0VCeNmZQs6ZV2NWYAjIxz8xu
 lLhfy2hKxBkOcGryfd7oeLRLQUxmqy0qyVkfuwUhG9LONRheAcUDCnJWwmMLSnH3Hht/
 EKQJxR6jctU+Ua8bUvabkQf622SRG2uQSuuoKGABX6N34ZbxIJNCVDlLUJToFO+lTecW
 RNiHDc+edctQ9IN7LJ6z5tKDFa4l1E3aL20ZNCyjLnD7UwDUru6MuqOH6FpvmCPN31q7
 H0oA==
X-Gm-Message-State: AOJu0YyUHCUCsTzoP7VVTiWjdpj6wbpu52uhJhvrJLriY2vxxicQfEvp
 BEMM6CfPgIrJg0BxJ8wIfyRpMLR0dLaAqk7EBOREWDW9R3gmRzvg8PYVBwntRDKu+kQ=
X-Gm-Gg: AY/fxX45gi+i9oOtxYkauf8HXxdzBZheFuHnisK/2gw+N6GFtXj3H2PuXVDRhNMEI+3
 moakT1HIxyANK/HlVJumwRLXA87CsccV18hMtj0TLBQOvvV0yd/VzDyhS4gi6qlTQZ6EH64V2w4
 9dIENeofdLrlUNturOBMUYEL5gtJfv8uD1O78qdJNN6bEUyiKrnpqHCuAM68MYCxnb4yjzcF6Ku
 iVSsqfr5ohOXEHXcQY6A/dZc74HR1Xk+K0UJTljqfGDRCks7NWyRKE9Lluz9hYypLZlekIQV8Jo
 tQwZuaSdMqGbbwFWnjeuY3RvddksUX5W7dUkPhf89V926m/jlY8vbXyiWamLtqstF3NTfmSX1MB
 lu5yWnxF+L5Iz6EYP5KSFZTFSeVMUsTVAV4vxQ7rqm/yO52EQW+vDxQbGoAId5pzMHSsxYu2iFi
 VzAJHHq1kgCIl8u4y5k8Sc1tv5JyGpHoj/6gomCoWiheMlCgvctmXxKz1bFsSUJbE=
X-Received: by 2002:a05:6402:2547:b0:653:af6c:12c4 with SMTP id
 4fb4d7f45d1cf-653ee146faamr173381a12.6.1768346196184; 
 Tue, 13 Jan 2026 15:16:36 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507b8c4479sm21490155a12.1.2026.01.13.15.16.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 15:16:35 -0800 (PST)
Date: Tue, 13 Jan 2026 15:16:30 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v6 00/18] Support VFIO cdev API in DPDK
Message-ID: <20260113151630.5381bef2@phoenix.local>
In-Reply-To: <cover.1763719706.git.anatoly.burakov@intel.com>
References: <cover.1761669438.git.anatoly.burakov@intel.com>
 <cover.1763719706.git.anatoly.burakov@intel.com>
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

On Fri, 21 Nov 2025 10:08:45 +0000
Anatoly Burakov <anatoly.burakov@intel.com> wrote:

> This patchset introduces a major refactor of the VFIO subsystem in DPDK to
> support character device (cdev) interface introduced in Linux kernel, as =
well as
> make the API more streamlined and useful. The goal is to simplify device
> management, improve compatibility, and clarify API responsibilities.
>=20
> The following sections outline the key issues addressed by this patchset =
and the
> corresponding changes introduced.
>=20
> 1. Only group mode is supported
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>=20
> Since kernel version 4.14.327 (LTS), VFIO supports the new character devi=
ce
> (cdev)-based way of working with VFIO devices (otherwise known as IOMMUFD=
). This
> is a device-centric mode and does away with all the complexity regarding =
groups
> and IOMMU types, delegating it all to the kernel, and exposes a much simp=
ler
> interface to userspace.
>=20
> The old group interface is still around, and will need to be kept in DPDK=
 both
> for compatibility reasons, as well as supporting special cases (FSLMC bus=
, NBL
> driver, etc.).
>=20
> To enable this, VFIO is heavily refactored, so that the code can support =
both
> modes while relying on (mostly) common infrastructure.
>=20
> Note that the existing `rte_vfio_device_setup/release` model is fundament=
ally
> incompatible with cdev mode, because for custom container cases, the expe=
cted
> flow is that the user binds the IOMMU group (and thus, implicitly, the de=
vice
> itself) to a specific container using `rte_vfio_container_group_bind`, wh=
ereas
> this step is not needed for cdev as the device fd is assigned to the cont=
ainer
> straight away.
>=20
> Therefore, what we do instead is introduce a new API for container device
> assignment which, semantically, will assign a device to specified contain=
er, so
> that when it is mapped using `rte_pci_map_device`, the appropriate contai=
ner is
> selected. Under the hood though, we essentially transition to getting dev=
ice fd
> straight away at assign stage, so that by the time the PCI bus attempts t=
o map
> the device, it is already mapped and we just return an fd. There is no
> "unassign" API because `release_device` already performs that function.
>=20
> Additionally, a new `rte_vfio_get_mode` API is added for those cases that=
 need
> some introspection into VFIO's internals, with three new modes: group
> (old-style), no-iommu (old-style but without IOMMU), and cdev (the new mo=
de).
> Although no-IOMMU is technically a variant of group mode, the distinction=
 is
> largely irrelevant to the user, as all usages of noiommu checks in our co=
debase
> are for deciding whether to use IOVA or PA, not anything to do with manag=
ing
> groups. The current plan for kernel community is to *not* introduce no-IO=
MMU
> cdev implementation, which is why this will be kept for compatibility for=
 these
> use cases.
>=20
> There were other users of VFIO which relied on group API but only for con=
venience
> purposes; no actual VFIO functionality depended on those API's. Therefore=
, group
> API's are removed and, where appropriate, replaced with the new API's.
>=20
> List of removed API's:
>=20
> * `rte_vfio_get_group_fd`
> * `rte_vfio_clear_group`
> * `rte_vfio_container_group_bind` (replaced by container assign API)
> * `rte_vfio_container_group_unbind`
> * `rte_vfio_noiommu_is_enabled` (replaced by new mode API)
>=20
> 2. The API responsibilities aren't clear and bleed into each other
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Some API's do multiple things at once. In particular:
>=20
> * `rte_vfio_get_device_info` will setup the device
> * `rte_vfio_setup_device` will get device info
>=20
> These API's have been adjusted to do one thing only.
>=20
> v6:
> - Fixed missing header include in vfio cdev file
>=20
> v5:
> - Added back missing uapi patch
>=20
> v4:
> - Fixed issues with documenting rte_vfio_mode enum
> - Separated deprecation notices into a separate patchset
>=20
> v3:
> - Make API removal cleaner
> - Fix `get_group_num` usages to align with new API
> - Fix issues with function exports
> - Fix issues with `setup_device` returning old-style values in some cases
>=20
> v2:
> - Make the entire API internal
> - More aggressive API pruning, complete removal of group API
> - Fixed a bug in group mode where device could not be used
> - Better documentation and deprecation notice patches
> - Moved doc patches to beginning of patchset
>=20
> Anatoly Burakov (18):
>   uapi: update to v6.17 and add iommufd.h
>   vfio: make all functions internal
>   vfio: split get device info from setup
>   vfio: add container device assignment API
>   net/nbl: do not use VFIO group bind API
>   net/ntnic: use container device assignment API
>   vdpa/ifc: use container device assignment API
>   vdpa/nfp: use container device assignment API
>   vdpa/sfc: use container device assignment API
>   vhost: remove group-related API from drivers
>   vfio: remove group-based API
>   vfio: cleanup and refactor
>   bus/pci: use the new VFIO mode API
>   bus/fslmc: use the new VFIO mode API
>   net/hinic3: use the new VFIO mode API
>   net/ntnic: use the new VFIO mode API
>   vfio: remove no-IOMMU check API
>   vfio: introduce cdev mode
>=20
>  config/arm/meson.build                    |    1 +
>  config/meson.build                        |    1 +
>  doc/guides/prog_guide/vhost_lib.rst       |    4 -
>  drivers/bus/cdx/cdx_vfio.c                |   25 +-
>  drivers/bus/fslmc/fslmc_bus.c             |   10 +-
>  drivers/bus/fslmc/fslmc_vfio.c            |    6 +-
>  drivers/bus/pci/linux/pci.c               |    2 +-
>  drivers/bus/pci/linux/pci_vfio.c          |   33 +-
>  drivers/bus/platform/platform.c           |    9 +-
>  drivers/crypto/bcmfs/bcmfs_vfio.c         |   14 +-
>  drivers/net/hinic3/base/hinic3_hwdev.c    |    2 +-
>  drivers/net/nbl/nbl_common/nbl_userdev.c  |   20 +-
>  drivers/net/nbl/nbl_include/nbl_include.h |    1 +
>  drivers/net/ntnic/ntnic_ethdev.c          |    2 +-
>  drivers/net/ntnic/ntnic_vfio.c            |   30 +-
>  drivers/vdpa/ifc/ifcvf_vdpa.c             |   34 +-
>  drivers/vdpa/mlx5/mlx5_vdpa.c             |    1 -
>  drivers/vdpa/nfp/nfp_vdpa.c               |   37 +-
>  drivers/vdpa/sfc/sfc_vdpa.c               |   39 +-
>  drivers/vdpa/sfc/sfc_vdpa.h               |    2 -
>  kernel/linux/uapi/linux/iommufd.h         | 1292 +++++++++++
>  kernel/linux/uapi/linux/vduse.h           |    2 +-
>  kernel/linux/uapi/linux/vfio.h            |   12 +-
>  kernel/linux/uapi/version                 |    2 +-
>  lib/eal/freebsd/eal.c                     |   98 +-
>  lib/eal/include/rte_vfio.h                |  387 ++--
>  lib/eal/linux/eal_vfio.c                  | 2433 ++++++++-------------
>  lib/eal/linux/eal_vfio.h                  |  167 +-
>  lib/eal/linux/eal_vfio_cdev.c             |  390 ++++
>  lib/eal/linux/eal_vfio_group.c            |  984 +++++++++
>  lib/eal/linux/eal_vfio_mp_sync.c          |   80 +-
>  lib/eal/linux/meson.build                 |    2 +
>  lib/eal/windows/eal.c                     |    4 +-
>  lib/vhost/vdpa_driver.h                   |    3 -
>  34 files changed, 4261 insertions(+), 1868 deletions(-)
>  create mode 100644 kernel/linux/uapi/linux/iommufd.h
>  create mode 100644 lib/eal/linux/eal_vfio_cdev.c
>  create mode 100644 lib/eal/linux/eal_vfio_group.c
>=20

Since this is a big patch and hard to see everything, ran the patch
series through AI with the current AGENTS.md guideline.
Agree that a release note is needed.


## DPDK Patch Review: VFIO cdev Mode Series (v6, 18 patches)

**Author:** Anatoly Burakov <anatoly.burakov@intel.com>

### Overview
This 18-patch series introduces VFIO cdev (IOMMUFD) mode support, refactors=
 VFIO infrastructure, and makes VFIO APIs internal. The series is at v6 and=
 has accumulated several Acked-by tags.

---

### =E2=9C=85 PASSED Checks

| Check | Status |
|-------|--------|
| Subject lines =E2=89=A460 characters | =E2=9C=93 All pass |
| Subject lowercase (except acronyms) | =E2=9C=93 Correct |
| Component prefixes | =E2=9C=93 Valid: `vfio:`, `bus/pci:`, `net/nbl:`, `v=
dpa/sfc:`, etc. |
| No trailing periods in subjects | =E2=9C=93 None found |
| Body wrapped at 75 characters | =E2=9C=93 All pass |
| Body does not start with "It" | =E2=9C=93 Confirmed |
| `Signed-off-by:` present | =E2=9C=93 All 18 patches |
| VF/PF capitalization | =E2=9C=93 Correct usage |
| SPDX license in new files | =E2=9C=93 BSD-3-Clause with copyright in `eal=
_vfio_group.c`, `eal_vfio_cdev.c` |
| `__rte_internal` placement | =E2=9C=93 Alone on line, in header files onl=
y |
| Kernel UAPI headers | =E2=9C=93 GPL-2.0 (appropriate for kernel headers) |
| Tag order | =E2=9C=93 Correct (Signed-off-by before Acked-by) |

---

### =E2=9A=A0=EF=B8=8F WARNINGS (should fix)

#### 1. Missing Release Notes
**Severity:** Warning =20
**Location:** Series-wide

This series makes significant API changes that warrant release notes:

- **Patch 02/18:** Makes entire VFIO API internal-only (ABI change for appl=
ications)
- **Patch 12/18:** Changes return value semantics for `rte_vfio_setup_devic=
e()` and `rte_vfio_get_group_num()` (now return -1 with `rte_errno=3DENODEV=
` instead of 1)
- **Patch 18/18:** Introduces new VFIO cdev mode (`RTE_VFIO_MODE_CDEV`)

**Recommendation:** Add entry to `doc/guides/rel_notes/release_25_XX.rst` d=
ocumenting:
- VFIO API is now internal (drivers only)
- Return value changes for affected functions
- New cdev/IOMMUFD mode support

#### 2. Implicit Integer Comparison
**Severity:** Warning =20
**Location:** Patch 12/18, `eal_vfio_group.c`

```c
// Line ~8360 in mbox (in vfio_has_supported_extensions function)
if (!n_extensions)    // n_extensions is unsigned int
```

**Should be:**
```c
if (n_extensions =3D=3D 0)
```

Per AGENTS.md: "Integers - compare explicitly with zero"

---

### =E2=84=B9=EF=B8=8F INFO (observations)

1. **Good commit message structure:** The series has well-written commit me=
ssages, particularly patch 12/18 which clearly documents the behavioral cha=
nges.

2. **Proper API tagging:** All new internal APIs use `__rte_internal` corre=
ctly positioned.

3. **Kernel header long line:** Line 613 in `iommufd.h` exceeds 100 chars, =
but this is a verbatim kernel UAPI header import - acceptable.

4. **Acks accumulated:** Patches 01, 12, and 14 have maintainer Acks (Steph=
en Hemminger, Hemant Agrawal).

---

### Summary

| Category | Count |
|----------|-------|
| Errors | 0 |
| Warnings | 2 |
| Info | 4 |

**Verdict:** The series is in good shape for this stage (v6). The two warni=
ngs should be addressed before merging:
1. Add release notes for the API changes
2. Fix the implicit integer comparison in `vfio_has_supported_extensions()`
