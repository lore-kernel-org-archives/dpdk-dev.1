Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B51C5AD7B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 00:31:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCCF44021F;
	Tue, 11 Aug 2026 02:31:04 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id AA2A340144
 for <dev@dpdk.org>; Tue, 11 Aug 2026 02:31:03 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2d01663d816so21851905ad.1
 for <dev@dpdk.org>; Mon, 10 Aug 2026 17:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786408262;
 x=1787013062; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hVqoXXi2t1tzEQVqpCbduQkz4KU/8CPC20dkBWBQ1R4=;
 b=pOaPr/TiDlRgOyYTgmen3ltipR9FxwzXaVtE7VqrQdDUiW0SfzZJv0oyPXfS4WcVjz
 mSm2Xgpz/zshSrRxR+1o+PxdEYmI4AP4re1olgjhZ4ubf3VKmTx8AOnELDgFxGjDR4sh
 jnPD6WyQDlhwmX87S1Llcd5HY2WPBb1mYyuLVRNCdW8nML7R78uyNuOHJnug2DlRQenq
 VHOlWxmXL+LUezSeNOAso0T5Pnmhdw7ejebdR5CtYbtB0VU6gc331I7fj+ZdVROXCBmC
 sFfoNSj+0t9wSIz/JyGOxFqZEYb+bSkRyPqpUmuuys0VHad4v/YcxW6PNrMdmRMfTsxx
 Y2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786408262; x=1787013062;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hVqoXXi2t1tzEQVqpCbduQkz4KU/8CPC20dkBWBQ1R4=;
 b=EV3XzmN3rHy4SykA7huyRnXKUZf2BQEcGP7KBZY0W0wv6DNw+INmcWSWi/XF22mOMO
 G25M/IIFk757yZ+858rwUd3GTpAXq9K6R+N4hSaVRHMHQBuRFxAUs6N3jd58PfLrbUdX
 na0vl5SIxq+/f9OnFIrzqlmkVLhH8IS2oo9NgflfUjPK98nGyT/q6mmGnPk2FuzCryCC
 g/g6+YHDFkOdAHBQ+DKr+dhdWCFtDEIIusl0E4tleO0mKX1B4P5p0cAJcit47VljBoZL
 lmYSiQ/hEd1n8ElolxlmEMtn9rJszNHJ1PCqAvBwHf60kd2IuO4T/9GinkwBAlcMDGde
 +gcg==
X-Gm-Message-State: AOJu0Yyt5ZpV2XY58zSSy9FMCuxpYz8YpVRC1jgV+b+QXjRlOfzb1OAB
 Ygt9rHOcl2KCTcUEDSoEJNV4Nnq5kdL8jcjnGlRUHPnNUsXGPRiLtAv4h/M0iPsBm1c=
X-Gm-Gg: AR+sD12If1Vw7slXBQbZvBBFJmSITo+cPp/8+0l76AXIR9iu+8iheg/PW6wsUQbEo4E
 ifr4lyHoSpJiRWokJuumtLzHAZr5YPQWqKpiFdkIe9oU9d83HTg5lANYitzfOua8gU45TTjHXi1
 ixUKGLH6X2HC1QN3yhe1+J+Cagvjv75BdXAu2iGZOH/TeG2TSEffyrGsBxWaQKIS7+kYWcVLjst
 iNh7gh9srAW3LNA72h4MxDHYKRx6FVSr0TCWe8iwzsvH4k2K9vy4wW/h+y+c902pmNBKQzmhU1h
 Ttnw+gg2gilrTpm7DtdZ2O9eUtMqMBP+1ECIE8YWz3JRshO7yf8agvA8+R+sbU7HdnxZgxf5pjS
 5TlFYELdUevNIjk8+bqpgEMfD8zBg8euB/ZPoAQF1a+ZucLH2jLzsZZ4n05K839w67DDekXRTTC
 eqY1DLQ1Cz0wBW1QdLxDyGxdTXOIYlnMtpHho/OEJNvuuD0x4sw27XcHT4tVMYotXo54FbAlm4B
 jksjGo7JAz2wokEVJCsWaNYYmIlDric0Kx8M2S5
X-Received: by 2002:a17:903:2392:b0:2ca:b8fd:f31 with SMTP id
 d9443c01a7336-2d106da9160mr419947005ad.15.1786408262380; 
 Mon, 10 Aug 2026 17:31:02 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be8a9220sm50664737eec.7.2026.08.10.17.31.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 17:31:01 -0700 (PDT)
Date: Mon, 10 Aug 2026 17:30:59 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v11 00/20] Support VFIO cdev API in DPDK
Message-ID: <20260810173059.3e4ddc31@phoenix.local>
In-Reply-To: <cover.1786113799.git.anatoly.burakov@intel.com>
References: <cover.1763141462.git.anatoly.burakov@intel.com>
 <cover.1786113799.git.anatoly.burakov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri,  7 Aug 2026 15:46:09 +0100
Anatoly Burakov <anatoly.burakov@intel.com> wrote:

> This patchset introduces a major refactor of the VFIO subsystem in DPDK to
> support character device (cdev) interface introduced in Linux kernel, as well as
> make the API more streamlined and useful. The goal is to simplify device
> management, improve compatibility, and clarify API responsibilities.
> 
> The following sections outline the key issues addressed by this patchset and the
> corresponding changes introduced.
> 
> 1. Only group mode is supported
> ===============================
> 
> Since kernel version 4.14.327 (LTS), VFIO supports the new character device
> (cdev)-based way of working with VFIO devices (otherwise known as IOMMUFD). This
> is a device-centric mode and does away with all the complexity regarding groups
> and IOMMU types, delegating it all to the kernel, and exposes a much simpler
> interface to userspace.
> 
> The old group interface is still around, and will need to be kept in DPDK both
> for compatibility reasons, as well as supporting special cases (FSLMC bus, NBL
> driver, no-IOMMU mode etc.), but it is now internal-only and not exposed through
> the API the way it was before.
> 
> To enable this, VFIO is heavily refactored, so that the code can support both
> modes while relying on (mostly) common infrastructure.
> 
> Note that the existing `rte_vfio_device_setup/release` model is fundamentally
> incompatible with cdev mode, because for custom container cases, the expected
> flow is that the user binds the IOMMU group (and thus, implicitly, the device
> itself) to a specific container using `rte_vfio_container_group_bind`, whereas
> this step is not needed for cdev as the device fd is assigned to the container
> straight away.
> 
> Therefore, what we do instead is introduce a new API for container device
> assignment which, semantically, will assign a device to specified container, so
> that when it is mapped using `rte_pci_map_device`, the appropriate container is
> selected. Under the hood though, we essentially transition to getting device fd
> straight away at assign stage, so that by the time the PCI bus attempts to map
> the device, it is already mapped and we just return an fd. There is no
> "unassign" API because `release_device` already performs that function.
> 
> Additionally, a new `rte_vfio_get_mode` API is added for those cases that need
> some introspection into VFIO's internals, with three new modes: group
> (old-style), no-iommu (old-style but without IOMMU), and cdev (the new mode).
> Although no-IOMMU is technically a variant of group mode, the distinction is
> largely irrelevant to the user, as all usages of noiommu checks in our codebase
> are for deciding whether to use IOVA or PA, not anything to do with managing
> groups. The current plan for kernel community is to *not* introduce no-IOMMU
> cdev implementation, and IOMMUFD's own group API compatibility layer also does
> not implement no-IOMMU mode, which is why this will be kept for compatibility
> for these use cases.
> 
> There were other users of VFIO which relied on group API but only for convenience
> purposes; no actual VFIO functionality depended on those API's. Therefore, group
> API's are removed and, where appropriate, replaced with the new API's.
> 
> List of removed API's:
> 
> * `rte_vfio_get_group_fd`
> * `rte_vfio_clear_group`
> * `rte_vfio_container_group_bind` (replaced by container assign API)
> * `rte_vfio_container_group_unbind`
> * `rte_vfio_noiommu_is_enabled` (replaced by new mode API)
> 
> 2. The API responsibilities aren't clear and bleed into each other
> ==================================================================
> 
> Some API's do multiple things at once. In particular:
> 
> * `rte_vfio_get_device_info` will setup the device
> * `rte_vfio_setup_device` will get device info
> 
> These API's have been adjusted to do one thing only.
> 
> v11:
> - Addressed feedback from Stephen's AI review:
>   - Use CONTAINER_INITIALIZER for reset
>   - Set container fd to -1 in CONTAINER_INITIALIZER
>   - Fixed double close()
>   - Moved VFIO init to earlier in init sequence to account for
>     bus drivers needing no-IOMMU mode status
>   - Fixed missing ops set for cdev mode, and missing ops reset
>   - Fixed fd leak on failed attach in cdev
> 
> v10:
> - Added a patch that renames confusing error labels
> - Fixed compiler warning about unused variable
> 
> v9:
> - Moved erroneous rte_errno-related comments to later in the patchset
> - Moved removal of vDPA group fd API's to their respective patches
> - Fixed typo in errno comments (ENXIO vs ENOXIO)
> - Fixed corruption of group config in secondary process (v8 AI review)
> 
> v8:
> - Rebase
> - Fixed build errors due to variable shadowing
> - Removed duplicate fd check as kernel does not provide a way to distinguish
>   between device fd's
> 
> v7:
> - Rebase
> - Added removal of deprecation notices
> - Fixed implicit numeric comparison in patch 12
> 
> v6:
> - Fixed missing header include in vfio cdev file
> 
> v5:
> - Added back missing uapi patch
> 
> v4:
> - Fixed issues with documenting rte_vfio_mode enum
> - Separated deprecation notices into a separate patchset
> 
> v3:
> - Make API removal cleaner
> - Fix `get_group_num` usages to align with new API
> - Fix issues with function exports
> - Fix issues with `setup_device` returning old-style values in some cases
> 
> v2:
> - Make the entire API internal
> - More aggressive API pruning, complete removal of group API
> - Fixed a bug in group mode where device could not be used
> - Better documentation and deprecation notice patches
> - Moved doc patches to beginning of patchset
> 
> Anatoly Burakov (20):
>   uapi: update to v6.17 and add iommufd.h
>   vfio: make all functions internal
>   bus/pci: rename mismatching error labels
>   vfio: split get device info from setup
>   vfio: add container device assignment API
>   net/nbl: do not use VFIO group bind API
>   net/ntnic: use container device assignment API
>   vdpa/ifc: use container device assignment API
>   vdpa/nfp: use container device assignment API
>   vdpa/sfc: use container device assignment API
>   vdpa/mlx5: remove group-related API
>   vhost: remove group-related API from driver
>   vfio: remove group-based API
>   vfio: cleanup and refactor
>   bus/pci: use the new VFIO mode API
>   bus/fslmc: use the new VFIO mode API
>   net/hinic3: use the new VFIO mode API
>   net/ntnic: use the new VFIO mode API
>   vfio: remove no-IOMMU check API
>   vfio: introduce cdev mode
> 
>  config/arm/meson.build                    |    1 +
>  config/meson.build                        |    1 +
>  doc/guides/prog_guide/vhost_lib.rst       |    4 -
>  doc/guides/rel_notes/deprecation.rst      |   10 -
>  drivers/bus/cdx/cdx_vfio.c                |   25 +-
>  drivers/bus/fslmc/fslmc_bus.c             |   11 +-
>  drivers/bus/fslmc/fslmc_vfio.c            |    6 +-
>  drivers/bus/pci/linux/pci.c               |    2 +-
>  drivers/bus/pci/linux/pci_vfio.c          |   47 +-
>  drivers/bus/platform/platform.c           |    9 +-
>  drivers/crypto/bcmfs/bcmfs_vfio.c         |   14 +-
>  drivers/net/hinic3/base/hinic3_hwdev.c    |    3 +-
>  drivers/net/nbl/nbl_common/nbl_userdev.c  |   22 +-
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
>  lib/eal/linux/eal.c                       |   15 +-
>  lib/eal/linux/eal_vfio.c                  | 2448 ++++++++-------------
>  lib/eal/linux/eal_vfio.h                  |  169 +-
>  lib/eal/linux/eal_vfio_cdev.c             |  396 ++++
>  lib/eal/linux/eal_vfio_group.c            |  983 +++++++++
>  lib/eal/linux/eal_vfio_mp_sync.c          |   80 +-
>  lib/eal/linux/meson.build                 |    2 +
>  lib/eal/windows/eal.c                     |    4 +-
>  lib/vhost/vdpa_driver.h                   |    3 -
>  36 files changed, 4286 insertions(+), 1908 deletions(-)
>  create mode 100644 kernel/linux/uapi/linux/iommufd.h
>  create mode 100644 lib/eal/linux/eal_vfio_cdev.c
>  create mode 100644 lib/eal/linux/eal_vfio_group.c
> 


Still lots of AI feedback from Claude Opus 5

Patch 20/20 (vfio: introduce cdev mode)

Error: in cdev mode, DPDK memory is never DMA mapped under --legacy-mem.
vfio_select_mode()'s cdev arm calls vfio_setup_dma_mem(cfg), which walks
memsegs via rte_memseg_walk(). rte_vfio_enable() now runs at eal.c:684,
but rte_eal_memory_init() is not until :797, so every memseg list still
has memseg_arr.count == 0 and the walk maps nothing. The mem event
callback registered on the next line covers dynamic mode, but legacy
memory is populated by malloc_add_seg(), which does not call
eal_memalloc_mem_event_notify(). vfio_cdev_setup_device() does no DMA
setup either, so nothing ever maps the initial hugepages.

Group mode is unaffected because vfio_group_assign_device() calls
vfio_setup_dma_mem() lazily at first device assign, which happens after
memory init. The cdev path needs the same deferral, or an explicit
re-walk once memory is up.

Warning: ENOXIO is not an errno. The doc comments introduced in patches
14 and 20 list

	 * - ENOXIO  - VFIO support not initialized.

in twelve places in lib/eal/include/rte_vfio.h. The code sets ENXIO.

Warning: no release notes. The series makes the whole rte_vfio API
internal, removes the group-based API and rte_vfio_noiommu_is_enabled(),
and adds cdev mode. Only deprecation.rst is touched;
doc/guides/rel_notes/release_26_11.rst needs "Removed Items" and
"New Features" entries.
