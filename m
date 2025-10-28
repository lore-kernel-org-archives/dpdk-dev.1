Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915F6CCD1BF
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 16:43:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7508C4028D;
	Tue, 28 Oct 2025 17:43:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 3202C4021E
 for <dev@dpdk.org>; Tue, 28 Oct 2025 17:43:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761669809; x=1793205809;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=aYOLC6KO+u8zbCAgRHLTEeZfnCY4RPh3qNLwMhwAbFg=;
 b=OzBo8NaO8YnCVPYl2P9yX3liLEWdaV6xle3HXBv7ouh+2sTnmRKQK+7D
 A2hif6kYr7M9ha6uhMwShDE86KampnLCDfaESxxJMVLSdTu04jrT4H8il
 gd2OU94u1CK72NpyV7FTZZgkOSt8aQzK+d3S+oKr++aZ0GdrY4budyvv9
 ZzKVEeSDKPvRbc+AdRtu0f9MJnJ4/pcdVVibUmeP5PLpQOAzvBLU83llF
 y8quvT5Eaqw+eaYidom9BWQFp8M/lYb9IIf+D/TRUpmNc6HQcApokIHv+
 Fo//+8uG/WGH3aPBOLcygEKJ+s/zpTq3wtIjHkhWv63hmxXScB/KhcFXV Q==;
X-CSE-ConnectionGUID: TunpVJllTmuMZ+yBd5pIDQ==
X-CSE-MsgGUID: 5Uv7wtmmTP6Tcuk1xTi03A==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63663615"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; d="scan'208";a="63663615"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2025 09:43:28 -0700
X-CSE-ConnectionGUID: inXYfGJwT8KCrXoGGek1SA==
X-CSE-MsgGUID: Ng9D6t2tS5yzNvkWuhQ+ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; d="scan'208";a="189452743"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 28 Oct 2025 09:43:27 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 0/8] Support VFIO cdev API in DPDK
Date: Tue, 28 Oct 2025 16:43:13 +0000
Message-ID: <cover.1761669438.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
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
the device, it is already mapped and we just return an fd.

Additionally, a new `rte_vfio_get_mode` API is added for those cases that need
some introspection into VFIO's internals, with three new modes: group
(old-style), no-iommu (old-style but without IOMMU), and cdev (the new mode).
Although no-IOMMU is technically a variant of group mode, the distinction is
largely irrelevant to the user, as all usages of noiommu checks in our codebase
are for deciding whether to use IOVA or PA, not anything to do with managing
groups. The current plan for kernel community is to *not* introduce no-IOMMU
cdev implementation, which is why this will be kept for compatibility for these
use cases.

As for special cases that rely on group mode, the old group-based API calls are
kept, but will be marked as deprecated, and will only work in group/noiommu
mode. This has little practical consequences, as even users such as NBL or FSLMC
bus do not actually use any of VFIO functionality, they just create a container
and proceed to do their own thing.

2. There is duplication among API's
===================================

Over time, several VFIO API's have been added that perform overlapping
functions:

* `rte_vfio_get_group_fd` does the same thing as `rte_vfio_container_group_bind`
* `rte_vfio_clear_group` does the same thing as rte_vfio_container_group_unbind`

The only difference between them is that for the former API's, the container
selection is implicit (create in default if doesn't exist, delete from any
container). It really only makes sense to keep container versions around, but
because we don't really need any of them any more, all of them will be
deprecated.

3. The API responsibilities aren't clear and bleed into each other
==================================================================

Some API's do multiple things at once. In particular:

* `rte_vfio_get_group_fd` opens a new group if it doesn't exist
* `rte_vfio_container_group_bind/unbind` return group fd
* `rte_vfio_get_device_info` will setup the device

These API's have been adjusted as follows:

* `rte_vfio_get_group_fd` will *not* open any fd's, it will *only* return those
  previously bound to a container by `rte_vfio_container_group_bind`
* `rte_vfio_container_group_bind` will *not* return any fd's (users should call
  `rte_vfio_get_group_fd` to get it)
* `rte_vfio_get_device_info` will *not* set up the device (users should call
  `rte_vfio_container_device_setup` prior to calling this API)

All current users of these API's were adjusted, and grou-related API's were
marked as deprecated.

Feedback and suggestions are welcome, especially from maintainers of drivers
that depend on VFIO infrastructure.

Anatoly Burakov (8):
  uapi: update to v6.17 and add iommufd.h
  vfio: add container device assignment API
  vhost: remove group-related API from drivers
  vfio: do not setup the device on get device info
  vfio: cleanup and refactor
  vfio: introduce cdev mode
  doc: deprecate VFIO group-based APIs
  vfio: deprecate group-based API

 config/arm/meson.build                    |    1 +
 config/meson.build                        |    1 +
 doc/guides/rel_notes/deprecation.rst      |   26 +
 drivers/bus/cdx/cdx_vfio.c                |   13 +-
 drivers/bus/fslmc/fslmc_bus.c             |   10 +-
 drivers/bus/fslmc/fslmc_vfio.c            |    2 +-
 drivers/bus/pci/linux/pci.c               |    2 +-
 drivers/bus/pci/linux/pci_vfio.c          |   17 +-
 drivers/crypto/bcmfs/bcmfs_vfio.c         |    6 +-
 drivers/net/hinic3/base/hinic3_hwdev.c    |    2 +-
 drivers/net/nbl/nbl_common/nbl_userdev.c  |   18 +-
 drivers/net/nbl/nbl_include/nbl_include.h |    1 +
 drivers/net/ntnic/ntnic_ethdev.c          |    2 +-
 drivers/net/ntnic/ntnic_vfio.c            |   30 +-
 drivers/vdpa/ifc/ifcvf_vdpa.c             |   34 +-
 drivers/vdpa/mlx5/mlx5_vdpa.c             |    1 -
 drivers/vdpa/nfp/nfp_vdpa.c               |   37 +-
 drivers/vdpa/sfc/sfc_vdpa.c               |   39 +-
 drivers/vdpa/sfc/sfc_vdpa.h               |    2 -
 kernel/linux/uapi/linux/iommufd.h         | 1292 ++++++++++
 kernel/linux/uapi/linux/vduse.h           |    2 +-
 kernel/linux/uapi/linux/vfio.h            |   12 +-
 kernel/linux/uapi/version                 |    2 +-
 lib/eal/freebsd/eal.c                     |   36 +
 lib/eal/include/rte_vfio.h                |  414 +++-
 lib/eal/linux/eal_vfio.c                  | 2640 +++++++++------------
 lib/eal/linux/eal_vfio.h                  |  170 +-
 lib/eal/linux/eal_vfio_cdev.c             |  387 +++
 lib/eal/linux/eal_vfio_group.c            |  981 ++++++++
 lib/eal/linux/eal_vfio_mp_sync.c          |   91 +-
 lib/eal/linux/meson.build                 |    2 +
 lib/vhost/vdpa_driver.h                   |    3 -
 32 files changed, 4484 insertions(+), 1792 deletions(-)
 create mode 100644 kernel/linux/uapi/linux/iommufd.h
 create mode 100644 lib/eal/linux/eal_vfio_cdev.c
 create mode 100644 lib/eal/linux/eal_vfio_group.c

-- 
2.47.3

