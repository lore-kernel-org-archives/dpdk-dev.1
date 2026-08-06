Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F4CC5AC7C
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 17:13:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 128A34027E;
	Thu,  6 Aug 2026 19:13:23 +0200 (CEST)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mails.dpdk.org (Postfix) with ESMTP id 40C6D40262
 for <dev@dpdk.org>; Thu,  6 Aug 2026 19:13:21 +0200 (CEST)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-cbe6295f05bso951562a12.1
 for <dev@dpdk.org>; Thu, 06 Aug 2026 10:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786036400;
 x=1786641200; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xkZTf+cGL9uge7/FJLl5JLAKm9OKdH09YHDag8BESjs=;
 b=YKf9gDBYw1cOghavSURC2WwvG0i196a6csMYSrbygCLCVQHL0JJH7ey/LE1jVCFTlQ
 Izou0877HOHAaloXmj5mXuxGVW76XPH+dHs9c686mNp1rpy9t985gNDWmBNu5T218eie
 Ew5/mG1FS1EuoASzvi/yPQpQvgC0FSFG+XjfOVOihVsm7IOoFb5rcMHOM2+LR9j/viRs
 +7nFTG6RDZd2Ev/+zotJLrjDyEpnYK2V30gLJ0p6XbdC2Wu6c915nEZhIf2h1Q6V09Y8
 nGVycyUm0/A81oGKOVTjbbxXwHfhSoq+w9PawLXc8EB8+8Zj6OydFTFW+tjnN7iSpfvT
 o77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786036400; x=1786641200;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xkZTf+cGL9uge7/FJLl5JLAKm9OKdH09YHDag8BESjs=;
 b=aLuDz6EYH3ayZ/w2F1uv4DlaEByauWZntCzyTz22DujuN1R0L/H0sWjToujaUWOklQ
 b+JeY1PkFDvC+TQZ5LGk1URjepzPL947W7rRvk0nBY026U8D0J3wyifQcUjgZpBF/RZa
 Pvsj13EZQ16/9kMXhHbPZcGnh7w3I5X+BeOcTE0986x9kEzceuNWE3fdIgZDWskiwETg
 bGfWmIq4vA4LA7tcwbNH5dJB5h+sdaVe3FlbmzTfRx0cX9dkG0ZMlYSbkhLytAVIKhGN
 FTUumCqGssDBP58dZ3cWqwkmic0zmPTh+JYHWCp7qE+eCO9zKYex7TcaDTGGvxPbKY60
 AfgA==
X-Gm-Message-State: AOJu0Yyh7fK2Qdndgz1STDwYcdrGQPY3kRvOhQ4NPcodRGtrcMyPt6HC
 u07+x4Xhhs7YNmGcv2r2XXS2260xZcQK+oX67gZrI/wRmvA00ZZ/zBTLSkc+l4HVoG8=
X-Gm-Gg: AR+sD10QdX1XTHOobjortR7YIcQDyWJzMoKOefjp90+MCtJbMRlkZFx5rvcHyh6ehdu
 avDqtnPcwm7x0wsjDcPLeeROX8+4fiVNd9d45aKw1c6Zo9bZAE5YlKasg0Xb6b83k4jP5Tnk4gO
 SySyb8zlwe6cybM3yhazUQYFqWED6e0hBDUjSueveQpmVibRQwhmdshQR9SDz5NK2dWvdnCvihe
 mdJN13btGJsk/gqCtBUrIksgCCeLqlDpNt6ktTpFCEYBXasfJTV/UR5qbepkFzDK7QbDqUxrKed
 339SSc+prD4AeXzxQbGscOeY4PlH4mqaIQTnhw9ggQ9aYwW981afDuPkJ7cPT5NJ3rQ2nJchcxC
 zOEdIsl4aWQoHm63ZnzAQgX1cGGwy/iS1dTdZEM/icPGgsm5VKRZDfUT+FSbK4eoZgo0mhnLGTv
 FlW+lUoJE9l3p1KbTD5ytdMYhADm969Y1D8gV3DCDCTNYTvvKH6bBwzX6rSoJ1QgYi2lbYurtjG
 6Jzn/YHklUK5vZlnIeoC3ic/XfKFV1IMqJ+UFyK
X-Received: by 2002:a05:6a21:3393:b0:3bf:b7e8:68ab with SMTP id
 adf61e73a8af0-3cb9c0712b1mr9630236637.2.1786036400113; 
 Thu, 06 Aug 2026 10:13:20 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fca9111b6sm26075811c88.13.2026.08.06.10.13.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 10:13:16 -0700 (PDT)
Date: Thu, 6 Aug 2026 10:13:13 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v10 00/20] Support VFIO cdev API in DPDK
Message-ID: <20260806101313.5240bf7a@phoenix.local>
In-Reply-To: <cover.1786025387.git.anatoly.burakov@intel.com>
References: <cover.1763141462.git.anatoly.burakov@intel.com>
 <cover.1786025387.git.anatoly.burakov@intel.com>
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

On Thu,  6 Aug 2026 15:11:00 +0100
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
>  drivers/bus/fslmc/fslmc_bus.c             |   10 +-
>  drivers/bus/fslmc/fslmc_vfio.c            |    6 +-
>  drivers/bus/pci/linux/pci.c               |    2 +-
>  drivers/bus/pci/linux/pci_vfio.c          |   47 +-
>  drivers/bus/platform/platform.c           |    9 +-
>  drivers/crypto/bcmfs/bcmfs_vfio.c         |   14 +-
>  drivers/net/hinic3/base/hinic3_hwdev.c    |    3 +-
>  drivers/net/nbl/nbl_common/nbl_userdev.c  |   21 +-
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
>  lib/eal/linux/eal_vfio.c                  | 2444 ++++++++-------------
>  lib/eal/linux/eal_vfio.h                  |  167 +-
>  lib/eal/linux/eal_vfio_cdev.c             |  390 ++++
>  lib/eal/linux/eal_vfio_group.c            |  984 +++++++++
>  lib/eal/linux/eal_vfio_mp_sync.c          |   80 +-
>  lib/eal/linux/meson.build                 |    2 +
>  lib/eal/windows/eal.c                     |    4 +-
>  lib/vhost/vdpa_driver.h                   |    3 -
>  35 files changed, 4263 insertions(+), 1903 deletions(-)
>  create mode 100644 kernel/linux/uapi/linux/iommufd.h
>  create mode 100644 lib/eal/linux/eal_vfio_cdev.c
>  create mode 100644 lib/eal/linux/eal_vfio_group.c
> 

Still lots of open AI review feedback:

Patch 14/20 (vfio: cleanup and refactor)

Error: close(fd 0) on the container error path. CONTAINER_INITIALIZER in
eal_vfio.h sets only the mem_maps lock, so container_fd is 0:

	#define CONTAINER_INITIALIZER \
		((struct container){ \
			.mem_maps = {.lock = RTE_SPINLOCK_RECURSIVE_INITIALIZER,}, \
		})

vfio_container_erase() then does

	if (cfg->container_fd >= 0 && close(cfg->container_fd))

so any container allocated but not yet given an fd closes stdin on
teardown. rte_vfio_container_create() reaches this from three arms
(group open failure, iommufd open failure, default:), and
vfio_select_mode()'s err label reaches it too. The pre-refactor code
initialized every vfio_cfgs[i].vfio_container_fd to -1. Add
.container_fd = -1 to CONTAINER_INITIALIZER, and use that initializer in
vfio_container_erase() rather than (struct container){0}.

Error: double close in vfio_has_supported_extensions(). The
VFIO_CHECK_EXTENSION failure path closes vfio_container_fd and returns
-1, and vfio_group_open_container_fd() closes it again:

	ret = vfio_has_supported_extensions(vfio_container_fd);
	if (ret) {
		EAL_LOG(DEBUG, "No supported IOMMU extensions found!");
		close(vfio_container_fd);
		return -1;
	}

Upstream had the close in the callee on both of its error paths and none
in the caller. The refactor added the caller close but removed only the
n_extensions == 0 close, leaving the ioctl path closing twice. Drop the
close() inside vfio_has_supported_extensions().

Warning: no release notes. The series makes the whole rte_vfio API
internal, removes five public functions, and adds cdev mode. Only
deprecation.rst is touched; release_26_11.rst needs "Removed Items" and
"New Features" entries.

Patch 15/20 (bus/pci: use the new VFIO mode API)

Error: noiommu is never detected. pci_device_iova_mode() runs under
rte_bus_get_iommu_class() at eal.c:689; rte_vfio_enable() does not run
until :775. rte_vfio_get_mode() returns RTE_VFIO_MODE_NONE at that
point, so is_vfio_noiommu_enabled latches to 0 and IOVA VA is chosen on
a noiommu system. rte_vfio_noiommu_is_enabled() read the sysfs knob and
did not depend on VFIO init.

Patch 16/20 (bus/fslmc: use the new VFIO mode API)

Error: fslmc bus scan fails on every system. rte_fslmc_scan() runs from
rte_bus_scan() at eal.c:680, also before rte_vfio_enable(), so

	if (rte_vfio_get_mode() != RTE_VFIO_MODE_GROUP &&
			rte_vfio_get_mode() != RTE_VFIO_MODE_NOIOMMU) {
		ret = -EINVAL;
		goto scan_fail;
	}

always takes the failure branch and no DPAA2 device is ever scanned. The
same ordering issue applies to rte_dpaa2_get_iommu_class() and to
fslmc_vfio_add_group(), which will now always select VFIO_TYPE1_IOMMU.

Warning: the new scan_fail branch logs nothing, unlike every other
failure in that function, so the failure is silent.

Patch 20/20 (vfio: introduce cdev mode)

Error: vfio_cfg.ops is never set in a cdev-mode secondary. The only
assignment is in vfio_cdev_enable(), reached solely from the primary arm
of vfio_select_mode(); the secondary arm calls vfio_sync_mode() and
vfio_cdev_sync_ioas(), neither of which touches ops. Every
rte_vfio_container_dma_map()/dma_unmap() in a cdev secondary therefore
fails in vfio_dma_mem_map() with "VFIO support not initialized". A
container made by rte_vfio_container_create() in a secondary has the
same problem: iommufd opened, IOAS allocated, ops NULL. Set ops in the
secondary cdev path.

Note also that container_dma_map()/container_dma_unmap() dereference
vfio_cfg.ops->partial_unmap with no NULL check; only vfio_dma_mem_map()
guards it.

Patch 3/20 (bus/pci: rename mismatching error labels)

Info: "Specifcally" in the commit body.

Patch 6/20 (net/nbl: do not use VFIO group bind API)

Info: blank line needed between the declaration and the statements in
nbl_open_group_fd().
