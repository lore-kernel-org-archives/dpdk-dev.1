Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBB3C61DB9
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 13:07:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0951640151;
	Fri, 28 Aug 2026 15:07:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 5844D40150
 for <dev@dpdk.org>; Fri, 28 Aug 2026 15:07:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787922424; x=1819458424;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=JbfvmbhSpGYIUjFwFvAH23Rz4Cm6uhjLmM12e3Wp92U=;
 b=KfPWn0b7/1H8TYEdx6STJgDshr1fS6RsovikXUy51qliYdqW5C85am2r
 grNd9rzGikYDQqYjw+4KXYTejeHlkew+lpbKu8hSJHfQGqMhYuCWL0cvR
 lbp5cGSC+h157e1RN24CzkqvbCRrqZ6gm5iehYBbquPGWE2lYTY3cF9MX
 rMp+VjHGoBfub+zCghmI/VZkE2WJvZytl18mOJwOvkcVKIAKDeFmuzS4f
 3pz9zNwe+yc6RuMWpDUG2wXZekIlGb7HP/weIr9cT3vN3KVafdKy0m71/
 tzyVLJefvBvd9VxM0p/G4UXQuopzSioaTBDncgV97j4O5yz0GXn6wjftb Q==;
X-CSE-ConnectionGUID: CzFh/N9AQ92FswqAKID0/Q==
X-CSE-MsgGUID: mQe5l8DvT4G1N9XC/uxWDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="113964490"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="113964490"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 06:07:03 -0700
X-CSE-ConnectionGUID: rTAJVu70T5qDrXUIApnshw==
X-CSE-MsgGUID: boHarE3+SPGE3+PkDbOH6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="271959526"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 28 Aug 2026 06:07:01 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v14 00/25] Support VFIO cdev API in DPDK
Date: Fri, 28 Aug 2026 14:06:28 +0100
Message-ID: <cover.1787922362.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1763141462.git.anatoly.burakov@intel.com>
References: <cover.1763141462.git.anatoly.burakov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This patchset depends on the following:
* https://patches.dpdk.org/project/dpdk/list/?series=39072 ("net/nbl: fix use-after-free")

This patchset introduces a major refactor of the VFIO subsystem in DPDK to
support character device (cdev) interface introduced in Linux kernel, as well as
make the API more streamlined and useful. The goal is to simplify device
management, improve compatibility, make the code readable, and clarify API.

The following sections outline the key issues addressed by this patchset and the
corresponding changes introduced.

1. Only group mode is supported
===============================

Since kernel version 4.14.327 (LTS), VFIO supports the new character device
(cdev)-based way of working with VFIO devices (otherwise known as IOMMUFD). This
is a device-centric mode and does away with all the complexity regarding groups
and IOMMU types, delegating it all to the kernel, and exposes a much simpler
interface to userspace. The old group-based implementation will still be around,
and will need to be kept in DPDK for compatibility reasons.

To enable this, VFIO is heavily refactored, so that the code can support both
modes while relying on (mostly) common infrastructure.

Additionally, a new `rte_vfio_get_mode` API is added for those cases that need
some introspection into VFIO's internals, with three new modes: group
(old-style), no-iommu (old-style but without IOMMU), and cdev (the new mode).
Although no-IOMMU is technically a variant of group mode, the distinction is
largely irrelevant to the user, as all usages of noiommu checks in our codebase
are for deciding whether to use IOVA or PA, not anything to do with managing
groups. The current plan for kernel community is to *not* introduce no-IOMMU
cdev implementation, and IOMMUFD's own group API compatibility layer also does
not implement no-IOMMU mode, which is why a no-IOMMU mode looks like a distinct
VFIO mode to the outside observer, even though internally it uses group mode.

2. Custom container assignment API does not map to cdev mode
============================================================

The existing `rte_vfio_device_setup/release` model is fundamentally incompatible
with cdev mode, because for custom container cases, the expected flow is that
the user binds the IOMMU group (and thus, implicitly, the device itself) to a
specific container using `rte_vfio_container_group_bind`, whereas this step is
not needed for cdev as the device fd is assigned to the container straight away.

Therefore, what we do instead is introduce a new API for container device
assignment which, semantically, will assign a device to specified container, so
that when it is mapped using `rte_pci_map_device`, the appropriate container is
selected. Under the hood though, we essentially transition to getting device fd
straight away at assign stage, so that by the time the PCI bus attempts to map
the device, it is already mapped and we just return an fd. There is no
"unassign" API because `release_device` already performs that function.

Because the API is now unified around device assignment, the old group-specific
API's can be removed and, where appropriate, reimplemented using new API. There
were other users of VFIO which relied on group API but only for convenience
purposes; no actual VFIO functionality depended on those API's.

List of removed API's:

* `rte_vfio_get_group_fd`
* `rte_vfio_clear_group`
* `rte_vfio_container_group_bind` (replaced by container assign API)
* `rte_vfio_container_group_unbind`
* `rte_vfio_noiommu_is_enabled` (replaced by new mode API)

3. The API responsibilities aren't clear and bleed into each other
==================================================================

Some API's do multiple things at once. In particular:

* `rte_vfio_get_device_info` will setup the device
* `rte_vfio_setup_device` will get device info

These API's have been adjusted to do one thing only.

4. The API does not need to be public
=====================================

The initial idea for exposing VFIO API was to enable userspace applications to
directly map memory for DMA, but it turns out that in practice only drivers use
this API. Therefore, the entire VFIO API is made internal, driver-only, and is
renamed from `rte_vfio` to `dev_vfio`.

v14:
- Hardened the transitional patches against attempting to use VFIO without
  having done initialization
- Fixed a bunch of typos, moved a few hunks around to where they belong, and
  added a more release note entries

v13:
- Addressed feedback from Stephen's AI review:
  - Added strdup-based deduplication for group mode to avoid leaking fd's when
    container assignment API is used
  - Added more documentation about cdev mode to Linux GSG
  - Fixed comments and log levels in a couple of places
- Renamed the API from `rte_vfio_*` to `dev_vfio_*` on account of it no longer
  being a publicly visible API
- Moved `dev_vfio.h` into driver SDK headers
- Decoupled VFIO internals from FSLMC and EAL
- Added proper teardown for VFIO subsystem on cleanup

v12:
- Addressed feedback from Stephen's AI review:
  - Add release notes updates to patch 2 and 20
  - Fix ENXIO typos
  - Added a new init step after memory init to enable DMA mapping for cdev

v11:
- Addressed feedback from Stephen's AI review:
  - Use CONTAINER_INITIALIZER for reset
  - Set container fd to -1 in CONTAINER_INITIALIZER
  - Fixed double close()
  - Moved VFIO init to earlier in init sequence to account for
    bus drivers needing no-IOMMU mode status
  - Fixed missing ops set for cdev mode, and missing ops reset
  - Fixed fd leak on failed attach in cdev

v10:
- Added a patch that renames confusing error labels
- Fixed compiler warning about unused variable

v9:
- Moved erroneous rte_errno-related comments to later in the patchset
- Moved removal of vDPA group fd API's to their respective patches
- Fixed typo in errno comments (ENXIO vs ENOXIO)
- Fixed corruption of group config in secondary process (v8 AI review)

v8:
- Rebase
- Fixed build errors due to variable shadowing
- Removed duplicate fd check as kernel does not provide a way to distinguish
  between device fd's

v7:
- Rebase
- Added removal of deprecation notices
- Fixed implicit numeric comparison in patch 12

v6:
- Fixed missing header include in vfio cdev file

v5:
- Added back missing uapi patch

v4:
- Fixed issues with documenting rte_vfio_mode enum
- Separated deprecation notices into a separate patchset

v3:
- Make API removal cleaner
- Fix `get_group_num` usages to align with new API
- Fix issues with function exports
- Fix issues with `setup_device` returning old-style values in some cases

v2:
- Make the entire API internal
- More aggressive API pruning, complete removal of group API
- Fixed a bug in group mode where device could not be used
- Better documentation and deprecation notice patches
- Moved doc patches to beginning of patchset

Anatoly Burakov (25):
  uapi: update to v6.17 and add iommufd.h
  vfio: make all functions internal
  bus/fslmc: decouple from EAL VFIO
  vfio: decouple EAL from VFIO internals
  vfio: do proper teardown on VFIO cleanup
  vfio: remove modname parameter from init
  vfio: rename API to reflect internal status
  bus/pci: rename mismatching error labels
  vfio: split get device info from setup
  vfio: add container device assignment API
  net/nbl: do not use VFIO group bind API
  net/ntnic: use container device assignment API
  vdpa/ifc: use container device assignment API
  vdpa/nfp: use container device assignment API
  vdpa/sfc: use container device assignment API
  vdpa/mlx5: remove group-related API
  vhost: remove group-related API from driver
  vfio: remove group-based API
  vfio: cleanup and refactor
  bus/pci: use the new VFIO mode API
  bus/fslmc: use the new VFIO mode API
  net/hinic3: use the new VFIO mode API
  net/ntnic: use the new VFIO mode API
  vfio: remove no-IOMMU check API
  vfio: introduce cdev mode

 config/arm/meson.build                    |    1 +
 config/meson.build                        |    1 +
 doc/api/doxy-api-index.md                 |    3 +-
 doc/guides/linux_gsg/linux_drivers.rst    |   30 +
 doc/guides/prog_guide/vhost_lib.rst       |    4 -
 doc/guides/rel_notes/deprecation.rst      |   10 -
 doc/guides/rel_notes/release_26_11.rst    |   16 +
 drivers/bus/cdx/cdx.c                     |    6 +-
 drivers/bus/cdx/cdx_vfio.c                |   37 +-
 drivers/bus/fslmc/fslmc_bus.c             |   13 +-
 drivers/bus/fslmc/fslmc_vfio.c            |   66 +-
 drivers/bus/fslmc/meson.build             |    1 -
 drivers/bus/pci/linux/pci.c               |    4 +-
 drivers/bus/pci/linux/pci_vfio.c          |   79 +-
 drivers/bus/pci/pci_common.c              |   10 +-
 drivers/bus/platform/platform.c           |   17 +-
 drivers/crypto/bcmfs/bcmfs_vfio.c         |   20 +-
 drivers/net/hinic3/base/hinic3_hwdev.c    |    5 +-
 drivers/net/nbl/nbl_common/nbl_userdev.c  |   34 +-
 drivers/net/nbl/nbl_include/nbl_include.h |    1 +
 drivers/net/ntnic/ntnic_ethdev.c          |   10 +-
 drivers/net/ntnic/ntnic_vfio.c            |   48 +-
 drivers/vdpa/ifc/ifcvf_vdpa.c             |   54 +-
 drivers/vdpa/mlx5/mlx5_vdpa.c             |    1 -
 drivers/vdpa/nfp/nfp_vdpa.c               |   53 +-
 drivers/vdpa/sfc/sfc_vdpa.c               |   47 +-
 drivers/vdpa/sfc/sfc_vdpa.h               |    2 -
 drivers/vdpa/sfc/sfc_vdpa_hw.c            |   12 +-
 kernel/linux/uapi/linux/iommufd.h         | 1292 ++++++++++
 kernel/linux/uapi/linux/vduse.h           |    2 +-
 kernel/linux/uapi/linux/vfio.h            |   12 +-
 kernel/linux/uapi/version                 |    2 +-
 lib/eal/freebsd/eal.c                     |  100 +-
 lib/eal/include/dev_vfio.h                |  449 ++++
 lib/eal/include/meson.build               |    2 +-
 lib/eal/include/rte_vfio.h                |  338 ---
 lib/eal/linux/eal.c                       |   27 +-
 lib/eal/linux/eal_vfio.c                  | 2635 +++++++++------------
 lib/eal/linux/eal_vfio.h                  |  191 +-
 lib/eal/linux/eal_vfio_cdev.c             |  396 ++++
 lib/eal/linux/eal_vfio_group.c            |  983 ++++++++
 lib/eal/linux/eal_vfio_mp_sync.c          |  108 +-
 lib/eal/linux/meson.build                 |    2 +
 lib/eal/windows/eal.c                     |   16 +-
 lib/vhost/vdpa_driver.h                   |    3 -
 lib/vhost/vhost_user.c                    |   16 +-
 46 files changed, 4885 insertions(+), 2274 deletions(-)
 create mode 100644 kernel/linux/uapi/linux/iommufd.h
 create mode 100644 lib/eal/include/dev_vfio.h
 delete mode 100644 lib/eal/include/rte_vfio.h
 create mode 100644 lib/eal/linux/eal_vfio_cdev.c
 create mode 100644 lib/eal/linux/eal_vfio_group.c

-- 
2.52.0

