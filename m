Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E11CCD8C9D
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 17:49:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52C6543377;
	Thu, 11 Jun 2026 19:49:45 +0200 (CEST)
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by mails.dpdk.org (Postfix) with ESMTP id 8DA24427CE
 for <dev@dpdk.org>; Thu, 11 Jun 2026 19:49:44 +0200 (CEST)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-1370417c01cso106090c88.1
 for <dev@dpdk.org>; Thu, 11 Jun 2026 10:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781200183;
 x=1781804983; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=08j6ovXw0+D1kq0vmVE2LL2fVTRn5dZUXyNz0jkTwQM=;
 b=NZEPJeKbRF6C6occouSYPr/xFyj9STmJNc5TK6JdJIj+wx8SB/sOscBzV12HVeByXK
 U0PH5FSQ7Zd9zPOSITucVccWJtZTrDf/PnjudigzK8DogfNKEPeA421TG0yfDwPZCEA/
 2Ptp3y79TT1yzm0LGZ7bL4cfZbZ027VZyPqhb2yDK75lDhmc7sN5654EwANUrS84O/cX
 rmS7V8SoWKHy96SZAY7+8MKjMr4LdS4WIdcvtbn5PCObKgYwdAcKgLzIOjKY8XG0agnR
 JIhPjkIzVMtEiu+pUJOlbIHPQT5FSDp8YMlQqfoCkqSpY5D29iCy7Mt/TZmHFF871Rcm
 Sj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781200183; x=1781804983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=08j6ovXw0+D1kq0vmVE2LL2fVTRn5dZUXyNz0jkTwQM=;
 b=W3zcrwOe/0PJTGLoLeLklH8zCOmTiS/c2/07c1BV5nzfZLQH9Lh0E4eMVjJvP4nlXc
 8liKFoF6MG/vM5aSRCXGF654OjcRn1hs487J0mO0JZym12IS/as4QD35O/hvGdH5x3Ub
 0xHmMvtMKMik9CBuF6wHl4UcG4dq5LiZE0xs04hxtLMY4VTWBqGSXqpyNe+BbLPV9VN9
 YBrL0fRhi925ibVv0F55arMkGhU1rZabZpiLwoc89HEm+eyHDlGhI5pXWOcwFQD65kP5
 h5vICZD4Q35+q1sJc0ITfl4inUptgQTfil37lQYFKCyIEdgAzM0wcXUIxPDwya/2h1xp
 zM8g==
X-Gm-Message-State: AOJu0Yy69dnrBsl55e+MtL/5YUcS50vPlrzW3nbfm31x3UGXVLv3fxEz
 UZIRayn0w3VCebo0sqVEfOlLTIoaKT2crKQ7rurijdm+0FSJz5XaHUlt5hYw/0WhZlw=
X-Gm-Gg: Acq92OHyvbr2O6sARsRCPfjjfnEBREDPqa0d9BjPKxJ8VYPOpnJdGe/oZ9WDQxmK/pz
 2Ef5GIemVkR3TsBgfMY8s+Zg/IXxIXmPhwhwooL5fVslUum/QhHjNQSac6BsrRWeOWsiZATOUVn
 C/3ft6hFopmLqESNEvmtL5FzEqxU3fzvDI+HtKjqPMduwssE8qlRH28RPRBlWi795T51oB7Y3MV
 9651s2urRsZjTL+zssr8ahe3XePfL5BGUpuoa3Oks178bMyFibSy0GAY0m9fWZO8hD/Ls+deYF8
 /UqE5JLDhYTtsJaGYwrOljgCIDUbdbABQHFPtTdyaow1hQ2rb9r3APHNGlvcAl+8H7D8QAwajRL
 pXC5UoLBgUUz0nuVarZjiJW9Q9VtkrWfvpPFN7PL5BL4ho0we3jVNq2iKZWrtHip81+gadFaQ/b
 7NKc/6qi2MVBod08sIuB6jsW9zgFrJ2RuT0xwryWfJL/p3AeoMX4NgxWBsdZ7D6KOc
X-Received: by 2002:a05:7300:7309:b0:304:dfb2:2274 with SMTP id
 5a478bee46e88-30804cef532mr2923015eec.28.1781200183139; 
 Thu, 11 Jun 2026 10:49:43 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806e8b141sm2512960eec.15.2026.06.11.10.49.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 10:49:42 -0700 (PDT)
Date: Thu, 11 Jun 2026 10:49:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v8 00/18] Support VFIO cdev API in DPDK
Message-ID: <20260611104940.41312f98@phoenix.local>
In-Reply-To: <cover.1781190151.git.anatoly.burakov@intel.com>
References: <cover.1763141462.git.anatoly.burakov@intel.com>
 <cover.1781190151.git.anatoly.burakov@intel.com>
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

On Thu, 11 Jun 2026 16:08:52 +0100
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
> driver, no-IOMMU mode etc.).
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
> 
>  config/arm/meson.build                    |    1 +
>  config/meson.build                        |    1 +
>  doc/guides/prog_guide/vhost_lib.rst       |    4 -
>  doc/guides/rel_notes/deprecation.rst      |   10 -
>  drivers/bus/cdx/cdx_vfio.c                |   25 +-
>  drivers/bus/fslmc/fslmc_bus.c             |   10 +-
>  drivers/bus/fslmc/fslmc_vfio.c            |    6 +-
>  drivers/bus/pci/linux/pci.c               |    2 +-
>  drivers/bus/pci/linux/pci_vfio.c          |   33 +-
>  drivers/bus/platform/platform.c           |    9 +-
>  drivers/crypto/bcmfs/bcmfs_vfio.c         |   14 +-
>  drivers/net/hinic3/base/hinic3_hwdev.c    |    3 +-
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
>  lib/eal/linux/eal_vfio.c                  | 2437 ++++++++-------------
>  lib/eal/linux/eal_vfio.h                  |  167 +-
>  lib/eal/linux/eal_vfio_cdev.c             |  390 ++++
>  lib/eal/linux/eal_vfio_group.c            |  984 +++++++++
>  lib/eal/linux/eal_vfio_mp_sync.c          |   80 +-
>  lib/eal/linux/meson.build                 |    2 +
>  lib/eal/windows/eal.c                     |    4 +-
>  lib/vhost/vdpa_driver.h                   |    3 -
>  35 files changed, 4248 insertions(+), 1896 deletions(-)
>  create mode 100644 kernel/linux/uapi/linux/iommufd.h
>  create mode 100644 lib/eal/linux/eal_vfio_cdev.c
>  create mode 100644 lib/eal/linux/eal_vfio_group.c
> 

Big patchset so sent the big AI model at it...

Patch 4 (vfio: add container device assignment API)

Warning: header doc for rte_vfio_container_assign_device() says "<0 on
failure, rte_errno is set", but neither rte_vfio_get_group_num() nor
rte_vfio_container_group_bind() sets rte_errno on the Linux failure
paths at this point in the series. The rte_errno contract only becomes
true after the patch 12 rewrite. Either set rte_errno here or defer the
doc claim to patch 12.

Patch 5 (net/nbl: do not use VFIO group bind API)

Info: function definition does not follow DPDK style (return type on
its own line, blank line between declarations and statements):

	static int
	nbl_open_group_fd(int iommu_group_num)
	{
		char path[PATH_MAX];

		snprintf(path, sizeof(path), RTE_VFIO_GROUP_FMT, iommu_group_num);
		return open(path, O_RDWR);
	}

Patch 7 (vdpa/ifc: use container device assignment API)

Warning: this patch removes both the "internal->vfio_group_fd = -1"
initialization and the only assignment, but ifcvf_get_vfio_group_fd()
still returns the field until patch 10. Between patches 7 and 10 the
vdpa op returns 0 (zeroed allocation), i.e. a "valid" fd value. Nothing
in lib/vhost calls the op anymore so it is not reachable in practice,
but for bisectability either keep the -1 initialization here or move
patch 10 ahead of patches 7-9.

Patch 8 (vdpa/nfp: use container device assignment API)

Warning: same staging issue as patch 7, plus nfp_vdpa_vfio_teardown()
still calls rte_vfio_container_group_unbind(fd, device->iommu_group)
with device->iommu_group now never assigned (always 0 from calloc), so
every teardown between patches 8 and 10 issues an unbind for group 0
that fails silently. The teardown unbind removal currently in patch 10
belongs in this patch (patch 9 does this correctly for sfc, removing
the fields and all uses in one patch).

Patch 12 (vfio: cleanup and refactor) -- partial review

Warning: missing release notes. This patch (together with patches 2, 11,
17, 18) removes the public rte_vfio API, removes the group-bind API, and
changes rte_vfio_setup_device()/rte_vfio_get_group_num() return
semantics. None of the series touches the current release notes file;
the entire VFIO API removal and the new cdev mode need entries in
"Removed Items" / "New Features".

Info: rte_errno convention comment at top of eal_vfio.c says "ENOXIO";
the errno is ENXIO (code uses the correct one).

Patch 18 (vfio: introduce cdev mode)

Error: ioas_id is corrupted in secondary processes. struct container
puts vfio_group_config and vfio_cdev_config in a union, and both place
their first member at offset 0 (bool dma_setup_done / uint32_t ioas_id).
In vfio_select_mode(), the secondary path does:

	if (mode == RTE_VFIO_MODE_CDEV && vfio_cdev_sync_ioas(cfg) < 0)
		goto err;

	/* primary handles DMA setup for default containers */
	group_cfg->dma_setup_done = true;

In cdev mode the unconditional dma_setup_done store overwrites the low
byte of the ioas_id just received from the primary. The corrupted id is
then used by VFIO_DEVICE_ATTACH_IOMMUFD_PT and IOMMU_IOAS_MAP/UNMAP in
the secondary. It happens to work only when the primary's IOAS id has
low byte 1. Fix is to make the store mode-conditional:

	if (mode == RTE_VFIO_MODE_GROUP || mode == RTE_VFIO_MODE_NOIOMMU)
		group_cfg->dma_setup_done = true;
