Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19795CA5FFF
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 08:10:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D9C740290;
	Wed,  7 Oct 2026 10:10:35 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 903DE40264
 for <dev@dpdk.org>; Wed,  7 Oct 2026 10:10:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791360633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Gcs3izKHu7goFveVH+RIIXh4CDVkuyDUjPJhibQ5f8=;
 b=hAg8d4IfvRgXrTjI7QPgZqP2vwG6RvcuWUZk+qdsOCTb7aVCL324/zTVcG0L3dmFq4F6u8
 0YPPFxBbQBnldDiM5Op9gCMh5p1awRM8+3FDZXiNFRX0kLCnAy3QJ/mHt3Gqmo0jyb4SyF
 P/qpmYqk86axNsRMiie+L30wTf0p+z8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-PTeveUcSP3yOjdc-n_LDDw-1; Wed,
 07 Oct 2026 04:10:31 -0400
X-MC-Unique: PTeveUcSP3yOjdc-n_LDDw-1
X-Mimecast-MFC-AGG-ID: PTeveUcSP3yOjdc-n_LDDw_1791360631
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C492019774E4
 for <dev@dpdk.org>; Wed,  7 Oct 2026 08:10:30 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2E3AB41D for <dev@dpdk.org>; Wed,  7 Oct 2026 08:10:29 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Subject: [RESEND][PATCH v19 00/26] Support VFIO cdev API in DPDK
Date: Wed,  7 Oct 2026 10:09:57 +0200
Message-ID: <20261007081026.574382-1-david.marchand@redhat.com>
In-Reply-To: <cover.1763141462.git.anatoly.burakov@intel.com>
References: <cover.1763141462.git.anatoly.burakov@intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DVayIGuvFMJJ7nHgWYk2Qqud74O6a9wv_W5W_jsB3b4_1791360631
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Additionally, new `vfio_get_mode` API is added for those cases that need
some introspection into VFIO's internals, with two modes: group (old-style),
and cdev (the new mode).

Historically, no-IOMMU mode was technically a variant of group mode, the
distinction is largely irrelevant to the user, as all usages of noiommu checks
in our codebase are for deciding whether to use IOVA or PA, not anything to do
with managing groups. However, now that upcoming kernel versions will support
no-IOMMU for both group, cdev compatibility, and full cdev paths, a new
`vfio_get_iommu_mode` is also added, with two modes: safe (full IOMMU backing),
and unsafe (no-IOMMU mode). The naming is chosen explicitly to emphasize that
using no-IOMMU mode is not ideal.

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

v19:

TL;DR: the v18/v19 diff shows no major changes, more could have been done
probably (especially on the huge API revamp patch), but rc1 is coming...
Compilation per patch still works, hopefully my splitting broke nothing at
runtime.

- Rebased so that CI can run on the series (did not happen with v18)
- Reordered patches:
  - moved the uAPI update at the end of the series when needed
  - moved small cleanups earlier in the series (vhost DMA capability cleanup,
    bus updates like PCI or fslmc...)
- Replaced bus/pci update with the change I prepared when replying on v18:
  the most notable change is that the pci bus object is left in common code
- Fixed (well, removed) VFIO header from FreeBSD and Windows exports list
  and removed all mentions of "Linux only" in this same header since it is
  now only exported by Linux
  (iow lib/eal/include/dev_vfio.h -> lib/eal/linux/include/dev_vfio.h)
- Squashed the patches touching kernel module: those are mechanical and the
  diff is small. Also fixed one small string truncation issue reported by AI
- Squashed the two patches around making VFIO internal only: the diff is huge,
  but the changes are mechanical and I saw no interest in keeping them
  separate
- Dropped rte_errno updates in patches that did not document the change in
  eal_vfio.h/dev_vfio.h (such updates were dropped later in the series anyway)
- Split the too big "vfio: cleanup and refactor" patch
  - Mechanical changes have been isolated in first patches: like renaming or
    reorganising structures
  - Macros only used in one location were removed from headers
  - vfio_containers is not exposed out of eal_vfio.c anymore
  - Fixed uapi/linux/vfio.h inclusion (must be included *first*, important
    because of stddef dependencies)
  - Fixed coding style like indentation, or line wrapping for 80 columns(?)
    or log messages split over multiple lines

v18:
- Adjusted pre-refactor VFIO cleanup to not rely on per-config enabled flag
- Moved loaded module detection from EAL into VFIO
- Added API to check for specific VFIO modules being loaded
- Removed VFIO stubs from non-Linux code by removing PCI bus dependency on VFIO
- Reworked vhost DMA capability check
- Renamed "IOMMU mode" and "safe/unsafe" terminology to IOVA VA/PA
- Fixed typo in FSLMC bus IOVA mode selection

v17:
- Support multiple devices per group in NBL

v16:
- Fixed an unused variable compile error due to typo
- Fixed code for patch 19 being accidentally added into patch 21
- Included the NBL fix[1] in the patchset to enable CI testing

[1] https://patches.dpdk.org/project/dpdk/patch/75e8e3b8ff4d0647e2a5216dcde0d93f3856e821.1787820465.git.anatoly.burakov@intel.com/

v15:
- Fixed resource leak in group mode deduplication path
- On account of kernel 7.3 supporting no-IOMMU mode in kernel version 7.3,
  split the "VFIO mode" model into two distinct axis: group/cdev, and IOMMU mode

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

Anatoly Burakov (24):
  vhost: check DMA capability only once
  bus/fslmc: decouple from EAL VFIO
  bus/pci: rename mismatching error labels
  vfio: make all functions internal
  vfio: add module check API
  vfio: teardown internals on VFIO cleanup
  vfio: split get device info from setup
  vfio: add container device assignment API
  net/nbl: do not use VFIO group bind API
  net/ntnic: use container device assignment API
  vdpa/ifc: use container device assignment API
  vdpa/nfp: use container device assignment API
  vdpa/sfc: use container device assignment API
  vhost: remove group-related API from driver
  vfio: remove group-based API
  vfio: rename some internal types and macros
  vfio: declare global configuration
  vfio: separate group-based IOMMU types
  vfio: add some check on input parameters
  vfio: decouple device setup from bus concerns
  vfio: introduce IOVA mode
  vfio: introduce VFIO mode
  uapi: import IOMMUFD header
  vfio: introduce cdev mode

David Marchand (2):
  bus/pci: move VFIO concerns in Linux implementation
  eal: provide VFIO only for Linux

 config/arm/meson.build                    |    1 +
 config/meson.build                        |    1 +
 doc/api/doxy-api-index.md                 |    3 +-
 doc/guides/linux_gsg/linux_drivers.rst    |   30 +
 doc/guides/prog_guide/vhost_lib.rst       |    4 -
 doc/guides/rel_notes/deprecation.rst      |   10 -
 doc/guides/rel_notes/release_26_11.rst    |   12 +
 drivers/bus/cdx/cdx.c                     |    6 +-
 drivers/bus/cdx/cdx_vfio.c                |   38 +-
 drivers/bus/fslmc/fslmc_bus.c             |   12 +-
 drivers/bus/fslmc/fslmc_vfio.c            |   66 +-
 drivers/bus/fslmc/meson.build             |    1 -
 drivers/bus/pci/bsd/pci.c                 |   12 +
 drivers/bus/pci/linux/pci.c               |   39 +-
 drivers/bus/pci/linux/pci_vfio.c          |   84 +-
 drivers/bus/pci/pci_common.c              |   26 +-
 drivers/bus/pci/private.h                 |   41 +
 drivers/bus/pci/windows/pci.c             |   12 +
 drivers/bus/platform/platform.c           |   17 +-
 drivers/crypto/bcmfs/bcmfs_vfio.c         |   23 +-
 drivers/net/hinic3/base/hinic3_hwdev.c    |    5 +-
 drivers/net/nbl/nbl_common/nbl_userdev.c  |   73 +-
 drivers/net/nbl/nbl_common/nbl_userdev.h  |    1 +
 drivers/net/nbl/nbl_include/nbl_include.h |    1 +
 drivers/net/ntnic/ntnic_ethdev.c          |    4 +-
 drivers/net/ntnic/ntnic_vfio.c            |   48 +-
 drivers/vdpa/ifc/ifcvf_vdpa.c             |   54 +-
 drivers/vdpa/mlx5/mlx5_vdpa.c             |    1 -
 drivers/vdpa/nfp/nfp_vdpa.c               |   53 +-
 drivers/vdpa/sfc/sfc_vdpa.c               |   47 +-
 drivers/vdpa/sfc/sfc_vdpa.h               |    2 -
 drivers/vdpa/sfc/sfc_vdpa_hw.c            |   12 +-
 kernel/linux/uapi/linux/iommufd.h         | 1302 ++++++++++
 lib/eal/common/eal_private.h              |   14 -
 lib/eal/freebsd/eal.c                     |  128 -
 lib/eal/include/meson.build               |    1 -
 lib/eal/include/rte_vfio.h                |  338 ---
 lib/eal/linux/eal.c                       |   62 +-
 lib/eal/linux/eal_vfio.c                  | 2661 +++++++++------------
 lib/eal/linux/eal_vfio.h                  |  164 +-
 lib/eal/linux/eal_vfio_cdev.c             |  415 ++++
 lib/eal/linux/eal_vfio_group.c            |  923 +++++++
 lib/eal/linux/eal_vfio_mp_sync.c          |  118 +-
 lib/eal/linux/include/dev_vfio.h          |  451 ++++
 lib/eal/linux/include/meson.build         |    4 +
 lib/eal/linux/meson.build                 |    2 +
 lib/eal/windows/eal.c                     |   23 -
 lib/vhost/socket.c                        |    5 +-
 lib/vhost/vdpa_driver.h                   |    3 -
 lib/vhost/vhost.h                         |    1 +
 lib/vhost/vhost_user.c                    |   16 +-
 51 files changed, 4978 insertions(+), 2392 deletions(-)
 create mode 100644 kernel/linux/uapi/linux/iommufd.h
 delete mode 100644 lib/eal/include/rte_vfio.h
 create mode 100644 lib/eal/linux/eal_vfio_cdev.c
 create mode 100644 lib/eal/linux/eal_vfio_group.c
 create mode 100644 lib/eal/linux/include/dev_vfio.h

-- 
2.54.0

