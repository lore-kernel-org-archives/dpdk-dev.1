Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCC6C61DBE
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Aug 2026 14:18:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C7C84013F;
	Tue, 25 Aug 2026 16:18:12 +0200 (CEST)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com
 [209.85.167.175])
 by mails.dpdk.org (Postfix) with ESMTP id 80AFD400D7
 for <dev@dpdk.org>; Tue, 25 Aug 2026 16:18:11 +0200 (CEST)
Received: by mail-oi1-f175.google.com with SMTP id
 5614622812f47-4af81963f35so4152825b6e.0
 for <dev@dpdk.org>; Tue, 25 Aug 2026 07:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787667491;
 x=1788272291; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iOnvK/s1/eMpU3MzUSWEnvie1PEsPHHEHhzqz/HJmK8=;
 b=xHHYcb/dLZfotfo9QS66I1/Xr0OWeZGrGtTf+AAYNq+7bvzhDAClRolgC8fYikCXNl
 DNAdxrRQY85Cs5b612cQTrMWqAo3nF7BFT4xCrK+zMSUoeiWzPzzid979Y96L0c4BDjk
 X76n5GjBCxoWs10hhagd01TVVY2Fx49p7cq0Y+DooUfg3Kiebgs+M1LY+hHMjmCBLHQJ
 5y2/uAO1ax0TiaIJ8ya7//U8qtykUTj3vAef1KYYKhVK5TkyfSHAMY+K7sE7b2dV2Gp+
 dy3TrzgdVqcdzB5Rh6RAqhPEHEB4TVj8dJeinXOLSOKXaC/rWvW2iCV6xg0X9LPFa1k/
 IUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787667491; x=1788272291;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iOnvK/s1/eMpU3MzUSWEnvie1PEsPHHEHhzqz/HJmK8=;
 b=JaiSZuId9yWkn9lwLpzuXillY39deUYm1qy9EQiRvXVspUi7tJCAhwfLfVcqLrpJcQ
 elyxohgXxUC1QyuBbXBgfHvAN3YcRz9RO4N9ZwZhCr0mRFRfPqk/i9Yo+2Kj0yuEOyV1
 6iYVkrAQKYzmd6RVL7hDCEwi8rA/J11Cq6DFD8GYcIeyTv7buQohBYEqEMN0W6ltmO6C
 tgIH6WOttH6AGTRSVKrc46T0daYkjxw6RUuyXGqar2xB+ev26DP3EK0LklLGflrbV5Am
 RHIuMnvOoLQlF4ojmtFf811RcVo7g6a3xwPZMc4R71G8fjjrnmj4rhMh3PO8NsmMdy+M
 Zuqw==
X-Gm-Message-State: AFuF++ng+EvYBGyNTWTlDPFckcJEgrnWdDXnfwlGSSz21yzqGRGKoMoJ
 TgklE/FdQFXSS9z34o72Ql6bvaahVVMTf9I3dGQcP6ZxzVAbQaf/fsVVqkK4g0khZMQ=
X-Gm-Gg: AR+sD13F4cXgGsgPTDKpGChM18qOojSJOPULA3BH38yvX8+/PthcfM0bhZoUZbwPwk1
 qREkcfcSwAXtF3D+m2nhJTqLmd+Pg10iXIfFL0AmUyHQt2jXyWabDLa59VXFSpag2Ge3fm/zkZa
 78WGdhBBfpqoK6UmDSMo+JydY8a/CmUG9E4fdO87h4C/DkDNzgyqEU/dq+iCIVDFI/w8xKMfP9J
 nA2aHogJFu4j6Hg8EPmEnCr4UrvrGS9+WReMC2aVzGpse8Zs1BW9Xw40Z5KqGb0iHizoSFghj/V
 NTgqE8lPPTwG6MnF0gLRaF/fgRxxtI3QpjRtVDbJuUlbwzdKYHts/UdeS6Ez/AQk0EP61VzhTn7
 z+d+SgpsFykJgO3uQwve8xSdJYrnjqTZKHmoGoUV6oZQCIgqSysuLy8YCh2gP5yLpiW4PJgcSCS
 /JS/NSomGmgQ0ihdJ/28mb+gGxKFr1txh5c2HcFRW47lK8pS5rtLZeEMrVbTg4+0S2VXoObIGqD
 oAiIgp6ljBRDn4ikMS5HVPbGtSpsw==
X-Received: by 2002:a05:6808:1202:b0:4ab:2abe:f031 with SMTP id
 5614622812f47-4b2ef2cd5a6mr29150751b6e.6.1787667490453; 
 Tue, 25 Aug 2026 07:18:10 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14186173199sm34191792c88.9.2026.08.25.07.18.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 07:18:10 -0700 (PDT)
Date: Tue, 25 Aug 2026 07:17:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v12 00/20] Support VFIO cdev API in DPDK
Message-ID: <20260825071754.0aeead6c@phoenix.local>
In-Reply-To: <cover.1787663786.git.anatoly.burakov@intel.com>
References: <cover.1763141462.git.anatoly.burakov@intel.com>
 <cover.1787663786.git.anatoly.burakov@intel.com>
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

On Tue, 25 Aug 2026 14:20:57 +0100
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
> v12:
> - Addressed feedback from Stephen's AI review:
>   - Add release notes updates to patch 2 and 20
>   - Fix ENXIO typos
>   - Added a new init step after memory init to enable DMA mapping for cdev
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
>  doc/guides/rel_notes/release_26_11.rst    |   13 +
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
>  lib/eal/freebsd/eal.c                     |  104 +-
>  lib/eal/include/rte_vfio.h                |  401 ++--
>  lib/eal/linux/eal.c                       |   22 +-
>  lib/eal/linux/eal_vfio.c                  | 2471 ++++++++-------------
>  lib/eal/linux/eal_vfio.h                  |  169 +-
>  lib/eal/linux/eal_vfio_cdev.c             |  396 ++++
>  lib/eal/linux/eal_vfio_group.c            |  983 ++++++++
>  lib/eal/linux/eal_vfio_mp_sync.c          |   80 +-
>  lib/eal/linux/meson.build                 |    2 +
>  lib/eal/windows/eal.c                     |    4 +-
>  lib/vhost/vdpa_driver.h                   |    3 -
>  37 files changed, 4350 insertions(+), 1907 deletions(-)
>  create mode 100644 kernel/linux/uapi/linux/iommufd.h
>  create mode 100644 lib/eal/linux/eal_vfio_cdev.c
>  create mode 100644 lib/eal/linux/eal_vfio_group.c
> 

The patch series in pretty good shape. AI still has feedback but
not sure how important the details are now.

Review: [PATCH v12 00/20] vfio: introduce cdev mode

Applied cleanly on top of 26.11-rc0 (d55ccd4 "pci: remove deprecated
catch-all flag") with plain git am. Patch 01 was diffed against the
v6.17 kernel tree; iommufd.h, vfio.h and vduse.h match exactly apart
from the usual headers_install guard rewrites. Build testing waived
per request.

Patches 03, 05, 07-13, 15-19 have no findings.

Patch 02 vfio: make all functions internal
------------------------------------------

Info: doc/api/doxy-api-index.md still lists rte_vfio.h under the
public API index. With every function now tagged @internal (and
INTERNAL_DOCS off), that page will render almost empty. Drop the
entry or move it alongside the other driver-SDK headers.

Patch 04 vfio: split get device info from setup
-----------------------------------------------

Info: in pci_vfio_ioport_map() secondary path, the old
rte_vfio_get_device_info() with fd == 0 cleaned up internally on a
GET_INFO failure. Now the sequence is setup, intr_dev_fd_set, then
get_device_info, and a get_device_info failure returns -1 without
rte_vfio_release_device(). The fd is at least recorded in the intr
handle so a later unmap can close it; the surrounding fill_regions
path already has the same shape, so this only preserves the existing
pattern rather than adding a new class of leak.

Patch 06 net/nbl: do not use VFIO group bind API
------------------------------------------------

Warning: replacing rte_vfio_container_group_bind() with a direct
open(RTE_VFIO_GROUP_FMT) changes behaviour when two nbl devices share
an IOMMU group. The kernel allows a VFIO group file to be open only
once (vfio_group_fops_open returns -EBUSY when group->opened_file is
already set). Previously the EAL cache returned the same fd for the
second device; now the second open() fails and the driver drops to
the rte_pci_map_device() fallback. If shared groups are not a
supported nbl topology, a comment saying so would avoid the next
person tripping on this; otherwise keep a small per-group fd table in
the driver.

Patch 14 vfio: cleanup and refactor
-----------------------------------

Warning: rte_vfio_enable() is no longer safe to call twice, and
drivers/bus/pci/linux/pci_vfio.c:pci_vfio_is_enabled() still calls
it a second time when rte_vfio_is_enabled("vfio_pci") is false. On a
second call with VFIO already up, vfio_select_mode() does
vfio_container_create(), which returns containers[1] (containers[0]
is active), hits "cfg != vfio_cfg.default_cfg", returns
RTE_VFIO_MODE_NONE, and rte_vfio_enable() then stores that into
vfio_cfg.mode, disabling a working VFIO instance and leaving
containers[1] marked active. Reachability is narrow (vfio loaded,
vfio_pci sysfs entry absent, device reports kdrv VFIO), but the fix
is trivial: return 0 early from rte_vfio_enable() when vfio_cfg.mode
!= RTE_VFIO_MODE_NONE.

Warning: new non-static globals `containers` and `vfio_cfg` in
eal_vfio.c (declared extern in eal_vfio.h) have no subsystem prefix.
These are exactly the kind of names that collide when an application
is statically linked against EAL. spapr_dma_win_len /
spapr_dma_win_page_sz were already unprefixed globals and could be
made static while the file is being reorganised. Suggest
vfio_containers / vfio_global_cfg (or similar) and static for the
spapr pair.

Info: RTE_MAX_VFIO_DEVICES (256) is a new hard per-container limit.
The previous implementation did not track device fds at all, so a
process that maps more than 256 VFIO devices in the default container
now fails with ENOSPC where it used to work. Probably fine for real
deployments, but worth a line in the release notes next to the
config knob.

Info: in group mode, rte_vfio_container_assign_device() now opens a
device fd of its own, and the subsequent rte_vfio_setup_device()
(via rte_pci_map_device) opens a second one for the same device, as
the in-code comment acknowledges. Both are closed by
rte_vfio_container_destroy(), so nothing leaks, but note that
rte_vfio_release_device() on the second fd no longer triggers the
vfio-pci last-close reset because the assign fd is still open. The
vdpa drivers destroy the container immediately afterwards, so no
practical issue today.

Info: the primary-side SOCKET_REQ_GROUP handler now only returns a
group fd that the primary already has open; the old handler opened
the group on demand. Secondary processes cannot map devices the
primary has not set up anyway (they need the primary's resource
tailq entry), so this is fine, just a behaviour change to be aware
of.

Patch 20 vfio: introduce cdev mode
----------------------------------

Warning: vfio_cdev_assign_device() logs at ERR level
("Device %s already assigned to this container") on the expected
path. Every vdpa driver does rte_vfio_container_assign_device()
followed by rte_pci_map_device(), and in cdev mode the second call
lands here and returns VFIO_EXISTS, which rte_vfio_setup_device()
then treats as success. That should be DEBUG, not ERR.

Warning: no user-facing documentation for the new mode.
doc/guides/linux_gsg/linux_drivers.rst still describes VFIO purely in
terms of IOMMU groups. It should say that cdev/iommufd is now
supported, that group mode is preferred whenever /dev/vfio/vfio is
usable and cdev is only selected as a fallback (there is no EAL
option to force it), that /dev/iommu must be accessible, and that VF
tokens in cdev mode need kernel >= 6.17 (the NOTICE in
cdev_attach_device_to_iommufd is the only place this is stated).

Info: cdev mode does not handle no-IOMMU cdev devices. The kernel
exposes those as /dev/vfio/devices/noiommu-vfioX, but
cdev_open_device_fd() only builds "vfioX", so the open fails and
rte_vfio_get_mode() would never report RTE_VFIO_MODE_NOIOMMU for
them. Since group mode wins when available this is mostly
theoretical, but a comment or explicit rejection would be clearer
than an open() failure.

Info: the comment in vfio_cdev_setup_device() says "attach device to
iommufd - only in primary" but the enclosing condition is primary OR
non-default container. Fix the comment.

Info: rte_vfio_get_device_num() is added with no in-tree caller. The
commit message says it is for future use; that is acceptable for an
internal symbol but easy to forget, so consider dropping it until
something needs it.

Summary
-------

The series is in good shape and the refactor is a real improvement in
readability. The remaining items are all Warning or below; the
rte_vfio_enable() re-entry and the unprefixed globals are the two I
would want addressed before merge, plus the ERR-level log on the
normal cdev assign path and a docs paragraph for the new mode.

