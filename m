Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DEAFCE086
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 14:17:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4752402E4;
	Thu, 26 Feb 2026 15:17:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id EFA7A4026F
 for <dev@dpdk.org>; Thu, 26 Feb 2026 15:17:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772115468; x=1803651468;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=FDv6QXdlgQHNWKvKlXD4fjHB45GqRBvu/FamXZTgfuU=;
 b=Wpi1FRZWgo937rBmTK26cVQN4xBgUZhUCkwrgocwDi/4kuFefvRDYQiD
 kwPkEHc+eYRB6GfYZ4Baa5ImrzwtlM5f6HS5MZeRTYwnGry2TpjOHwOId
 QwW6bxS/Eb8AcddQoujlKtZsRjNWqiiyZAi0UT0AFx5gkQgEAdEJJ06ZK
 cGQQxcsxY+3O9TUpt2IakC76VipOYDNH15iUpqxWZP5ln46OkKcYg0KFy
 LESbGPl2QUDpFvVrkQJXU658Fvs+C0ZtZOq7AXD+vlyjneB6R+PWLUPMT
 OzixVAvJn4cDIVpwi8He7H9C3/xKkAM0aFjXNmSNjCutxjedK838w51jE w==;
X-CSE-ConnectionGUID: it2GQQM9R9ua85i+65lClg==
X-CSE-MsgGUID: Yk1cycQ8ThWyowhFZjAP9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="84271065"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="84271065"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 06:17:47 -0800
X-CSE-ConnectionGUID: TkBDIJBqSRSX+ZjjBb304g==
X-CSE-MsgGUID: RWuS5fZ/RGelnla5MX2kRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="220719306"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 26 Feb 2026 06:17:47 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v7 00/18] Support VFIO cdev API in DPDK
Date: Thu, 26 Feb 2026 14:17:23 +0000
Message-ID: <cover.1772115411.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
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

This patchset introduces a major refactor of the VFIO subsystem in DPDK to
support character device (cdev) interface introduced in Linux kernel, as well as
make the API more streamlined and useful. The goal is to simplify device
management, improve compatibility, and clarify API responsibilities.

The following sections outline the key issues addressed by this patchset and the
corresponding changes introduced.

1. Only group mode is supported
===============================

Since kernel version 4.14.327 (LTS), VFIO supports the new character device
(cdev)-based way of working with VFIO devices (otherwise known as IOMMUFD). This
is a device-centric mode and does away with all the complexity regarding groups
and IOMMU types, delegating it all to the kernel, and exposes a much simpler
interface to userspace.

The old group interface is still around, and will need to be kept in DPDK both
for compatibility reasons, as well as supporting special cases (FSLMC bus, NBL
driver, etc.).

To enable this, VFIO is heavily refactored, so that the code can support both
modes while relying on (mostly) common infrastructure.

Note that the existing `rte_vfio_device_setup/release` model is fundamentally
incompatible with cdev mode, because for custom container cases, the expected
flow is that the user binds the IOMMU group (and thus, implicitly, the device
itself) to a specific container using `rte_vfio_container_group_bind`, whereas
this step is not needed for cdev as the device fd is assigned to the container
straight away.

Therefore, what we do instead is introduce a new API for container device
assignment which, semantically, will assign a device to specified container, so
that when it is mapped using `rte_pci_map_device`, the appropriate container is
selected. Under the hood though, we essentially transition to getting device fd
straight away at assign stage, so that by the time the PCI bus attempts to map
the device, it is already mapped and we just return an fd. There is no
"unassign" API because `release_device` already performs that function.

Additionally, a new `rte_vfio_get_mode` API is added for those cases that need
some introspection into VFIO's internals, with three new modes: group
(old-style), no-iommu (old-style but without IOMMU), and cdev (the new mode).
Although no-IOMMU is technically a variant of group mode, the distinction is
largely irrelevant to the user, as all usages of noiommu checks in our codebase
are for deciding whether to use IOVA or PA, not anything to do with managing
groups. The current plan for kernel community is to *not* introduce no-IOMMU
cdev implementation, which is why this will be kept for compatibility for these
use cases.

There were other users of VFIO which relied on group API but only for convenience
purposes; no actual VFIO functionality depended on those API's. Therefore, group
API's are removed and, where appropriate, replaced with the new API's.

List of removed API's:

* `rte_vfio_get_group_fd`
* `rte_vfio_clear_group`
* `rte_vfio_container_group_bind` (replaced by container assign API)
* `rte_vfio_container_group_unbind`
* `rte_vfio_noiommu_is_enabled` (replaced by new mode API)

2. The API responsibilities aren't clear and bleed into each other
==================================================================

Some API's do multiple things at once. In particular:

* `rte_vfio_get_device_info` will setup the device
* `rte_vfio_setup_device` will get device info

These API's have been adjusted to do one thing only.

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

Anatoly Burakov (18):
  uapi: update to v6.17 and add iommufd.h
  vfio: make all functions internal
  vfio: split get device info from setup
  vfio: add container device assignment API
  net/nbl: do not use VFIO group bind API
  net/ntnic: use container device assignment API
  vdpa/ifc: use container device assignment API
  vdpa/nfp: use container device assignment API
  vdpa/sfc: use container device assignment API
  vhost: remove group-related API from drivers
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
 doc/guides/prog_guide/vhost_lib.rst       |    4 -
 doc/guides/rel_notes/deprecation.rst      |    7 -
 drivers/bus/cdx/cdx_vfio.c                |   25 +-
 drivers/bus/fslmc/fslmc_bus.c             |   10 +-
 drivers/bus/fslmc/fslmc_vfio.c            |    6 +-
 drivers/bus/pci/linux/pci.c               |    2 +-
 drivers/bus/pci/linux/pci_vfio.c          |   33 +-
 drivers/bus/platform/platform.c           |    9 +-
 drivers/crypto/bcmfs/bcmfs_vfio.c         |   14 +-
 drivers/net/hinic3/base/hinic3_hwdev.c    |    2 +-
 drivers/net/nbl/nbl_common/nbl_userdev.c  |   20 +-
 drivers/net/nbl/nbl_include/nbl_include.h |    1 +
 drivers/net/ntnic/ntnic_ethdev.c          |    2 +-
 drivers/net/ntnic/ntnic_vfio.c            |   30 +-
 drivers/vdpa/ifc/ifcvf_vdpa.c             |   34 +-
 drivers/vdpa/mlx5/mlx5_vdpa.c             |    1 -
 drivers/vdpa/nfp/nfp_vdpa.c               |   37 +-
 drivers/vdpa/sfc/sfc_vdpa.c               |   39 +-
 drivers/vdpa/sfc/sfc_vdpa.h               |    2 -
 kernel/linux/uapi/linux/iommufd.h         | 1292 +++++++++++
 kernel/linux/uapi/linux/vduse.h           |    2 +-
 kernel/linux/uapi/linux/vfio.h            |   12 +-
 kernel/linux/uapi/version                 |    2 +-
 lib/eal/freebsd/eal.c                     |   98 +-
 lib/eal/include/rte_vfio.h                |  387 ++--
 lib/eal/linux/eal_vfio.c                  | 2433 ++++++++-------------
 lib/eal/linux/eal_vfio.h                  |  167 +-
 lib/eal/linux/eal_vfio_cdev.c             |  390 ++++
 lib/eal/linux/eal_vfio_group.c            |  984 +++++++++
 lib/eal/linux/eal_vfio_mp_sync.c          |   80 +-
 lib/eal/linux/meson.build                 |    2 +
 lib/eal/windows/eal.c                     |    4 +-
 lib/vhost/vdpa_driver.h                   |    3 -
 35 files changed, 4261 insertions(+), 1875 deletions(-)
 create mode 100644 kernel/linux/uapi/linux/iommufd.h
 create mode 100644 lib/eal/linux/eal_vfio_cdev.c
 create mode 100644 lib/eal/linux/eal_vfio_group.c

-- 
2.47.3

