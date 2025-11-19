Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A23CF318B
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 11:02:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E01BE402C3;
	Wed, 19 Nov 2025 12:02:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id B1DA740265
 for <dev@dpdk.org>; Wed, 19 Nov 2025 12:02:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763550127; x=1795086127;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=rvQUHVrqyEiZNBpp84dWJrKUjUrqs1IosZZR0LaQk+k=;
 b=RuYATf4cCUzHmtlO7N88Nj1fdDig0ntNRKdxwAqB4QWI7xWV4Mr0XDJr
 9q0e0rlGkAi112b2Il+vyXf0/2ipHP5gf2kinRv0SGbNboa7/rLdFml3p
 Cgo5AyJoxHPtgvGGwZRfjYwex6zCVP0GIJLW/ZBGmfgD8JEs0IepPmp7o
 tJOwHCeT5qNHln9UZPVgZaNDzmoAwKdS2ngzDapOCtyRjCb8VYLZo/1ly
 hEIcJ9mx88utlXaq/eDz2FabuOe4J/FKrJSD3dtwbX6SOpQ9VKbMf4soH
 jj7b2JOnVuDCoc9zOBWJp79E9wimzuFe8km/tmySU4XLlCaVffRlnxUY/ A==;
X-CSE-ConnectionGUID: hJ5EMcB7QiaDpMIn9j8iYw==
X-CSE-MsgGUID: V/Nc3s72SbOAMeDJknVjXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="76942074"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="76942074"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 03:02:06 -0800
X-CSE-ConnectionGUID: oH/QPP6GQrqtc0hg+pIJoQ==
X-CSE-MsgGUID: /jaQqH9AQii/1I7U4vV1zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="214409156"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa002.fm.intel.com with ESMTP; 19 Nov 2025 03:02:05 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v4 00/17] Support VFIO cdev API in DPDK
Date: Wed, 19 Nov 2025 11:01:43 +0000
Message-ID: <cover.1763549736.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1761669438.git.anatoly.burakov@intel.com>
References: <cover.1761669438.git.anatoly.burakov@intel.com>
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

Anatoly Burakov (17):
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
 lib/eal/freebsd/eal.c                     |   98 +-
 lib/eal/include/rte_vfio.h                |  387 ++--
 lib/eal/linux/eal_vfio.c                  | 2433 ++++++++-------------
 lib/eal/linux/eal_vfio.h                  |  167 +-
 lib/eal/linux/eal_vfio_cdev.c             |  389 ++++
 lib/eal/linux/eal_vfio_group.c            |  984 +++++++++
 lib/eal/linux/eal_vfio_mp_sync.c          |   80 +-
 lib/eal/linux/meson.build                 |    2 +
 lib/eal/windows/eal.c                     |    4 +-
 lib/vhost/vdpa_driver.h                   |    3 -
 30 files changed, 2955 insertions(+), 1865 deletions(-)
 create mode 100644 lib/eal/linux/eal_vfio_cdev.c
 create mode 100644 lib/eal/linux/eal_vfio_group.c

-- 
2.47.3

