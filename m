Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BC7C55838
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 03:52:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C7EC4027E;
	Thu,  6 Aug 2026 05:52:50 +0200 (CEST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id 19C8D4021E
 for <dev@dpdk.org>; Thu,  6 Aug 2026 05:52:49 +0200 (CEST)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-383b4a3755fso1749669a91.3
 for <dev@dpdk.org>; Wed, 05 Aug 2026 20:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785988368;
 x=1786593168; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7hKgm/veXU6bJMcJhx2h4NimENwcXRoZjZqhEp0Xvhw=;
 b=xdcvbkmPY6nZb4rFbIhP4TWC201zAWInhNpRVZK91jD9kL2CvK0mmcPSGjA0EjpaxY
 z0+5nYO1Ox+3EKC3uPIVvqjUVIOfDrJC8dm9etPxQ8fewzOZSTlTO/gEV6Kr+7ccgoX0
 XwK/yHG1ew0rhn5phSZRk+PTTFlopUAROP368uYpSpksbH2aRKReU3ljBTFc/2q+j53M
 pOXXJ5hyaGrf+dBl4zbzP2mJbFoscmJYHQmbGgaiILDut40n8pcT+bUl+kh1o5TNnKI5
 2TgPAVDTQQljbc7lXsAXK1Kn79GG7coM4fMd2N8ZoFMT6xBPcxnmn5HeSsm7W6YrikCc
 Jr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785988368; x=1786593168;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7hKgm/veXU6bJMcJhx2h4NimENwcXRoZjZqhEp0Xvhw=;
 b=NjDQgoZGEbIcRQpDVWAQVjBXhuPbajJAQIuwTbEv9TK/lYL1FH133onXTGDMRVK4G2
 y2Inz2pW1ImJ7Hj7+ZA+t7B9qkrv/oCm8MyELqyxkXAU5B6Fc1tQ1wXouNvZDDc4SIuw
 vlyOZP8v+Q5XxBw57mVged8iOIENOtLYSzQC3IMVVXvXUonoAlF56Y51AoVeZVCJ9e1m
 0oJ+cRGWKkrl04yiZt0msg0Z6NngZr7+UxorZNVYSe7zBlArBFK8OOISZcOloRtRInfI
 rL+px3btevXn1LTfRdN+eShHQHxjJLLKs1YJ0iuQsfxzdIsG155n8rEj0DGQytIe9co5
 rvhQ==
X-Gm-Message-State: AOJu0YzJmD50mGU5WE6xM7xScY8IwazKQGVLVPRstKBI0r+8GCoemxKg
 EWNDtBtGxMHks0ysUt/xfcGT1GMUj91HT8eB+GEcSxzFhAfaAGrYl5cCmbAuLkGmOaw=
X-Gm-Gg: AR+sD10UU9Dnb4fJ6/gRKWzZhP7gEzDcjbBUfqubkQBZXuFjmFWBiTy7LPzre22mxB5
 NGYtOpyaUEmtbD/zc3WphOEYKGDq8zSnNlFPY3BMuGAU0fNm8r/qB7KpFyMWjnKun5FOTsjoq+9
 3TJ9247UuQcuZPcOmeV3t3e+ZpfEA4F2BqNacu5lITd7pziGyFE8/NG/USouIcZ+u1sz58puTpt
 oYu+PQ/CFks87tKhmLPoUXOlFtZLNiiD5q/RsmKg31HoAVqVW28Vm6iKjYFCwzmrmA+AD1ZCxlB
 QjEofqjQrKf/WCOqGSedf4j0/Thcmbcd5GhmbJlvrKzwaDrAqQi5Ti1SXnyfPPWn6gxJLBfsyMO
 VBBZwm1lNuTZzbRcXnox9gkbtFtkfWDLIcO40xlL7645B1eeJgYsKpZWBeLXhGFfLuasJOFnAn1
 RlPhB0iIuRvQ4DItvPgFulRywt+r0i7qBBdxk6FWkEvz3+dcV4sKcaDW12uw9Z6+7fSW2Dan8O/
 EYxchY/10hKix6WTjvSawQ07RMw9w==
X-Received: by 2002:a17:90b:560c:b0:38e:70d5:b12d with SMTP id
 98e67ed59e1d1-3903c537991mr12733731a91.6.1785988368121; 
 Wed, 05 Aug 2026 20:52:48 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fca908068sm19326925c88.12.2026.08.05.20.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 20:52:47 -0700 (PDT)
Date: Wed, 5 Aug 2026 20:52:44 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v9 00/19] Support VFIO cdev API in DPDK
Message-ID: <20260805205244.55f20724@phoenix.local>
In-Reply-To: <cover.1785937060.git.anatoly.burakov@intel.com>
References: <cover.1763141462.git.anatoly.burakov@intel.com>
 <cover.1785937060.git.anatoly.burakov@intel.com>
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

On Wed,  5 Aug 2026 14:45:29 +0100
Anatoly Burakov <anatoly.burakov@intel.com> wrote:

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

AI diagnosed apply failure.

This does not apply to main. Patches 8 and 11 have stale context:
patch 8 still has the rte_pci_unmap_device() call in
nfp_vdpa_vfio_setup() that 7185c65c95c6 ("vdpa/nfp: fix double PCI
unmap on unplug") removed in June, and patch 11 has the pre-1c726e28fd
wording of the RARP line in vhost_lib.rst. The series applies cleanly
at 481aeec3d7, so v9 looks to be based on a tree from before 2026-06-24.
Both are context-only; please rebase for v10.

Much of the stuff in cover letter needs to be release notes.

More AI (Claude Opus) comments:
Patch 13 (vfio: cleanup and refactor)

Error: container fd 0 is closed on the error path. CONTAINER_INITIALIZER
only initializes the mem_maps lock, so container_fd is 0, not -1. The
pre-refactor code initialized every vfio_cfgs[i].vfio_container_fd to -1.
vfio_container_erase() tests

	if (cfg->container_fd >= 0 && close(cfg->container_fd))

so any path that allocates a container and fails before assigning the fd
closes stdin. rte_vfio_container_create() has three such paths (group
open failure, iommufd open failure, and the default: arm), as does
vfio_select_mode()'s err label. Add .container_fd = -1 to
CONTAINER_INITIALIZER, and use the same initializer in
vfio_container_erase() instead of (struct container){0}.

Error: double close in vfio_has_supported_extensions(). The VFIO_CHECK_
EXTENSION error path closes vfio_container_fd and returns -1, and the
caller vfio_group_open_container_fd() then closes it again:

	ret = vfio_has_supported_extensions(vfio_container_fd);
	if (ret) {
		EAL_LOG(DEBUG, "No supported IOMMU extensions found!");
		close(vfio_container_fd);
		return -1;
	}

Upstream had the close in the callee on both error paths and none in the
caller; the refactor added the caller close and removed only one of the
two callee closes. The fd may already have been handed out to another
thread by then. Drop the close() inside vfio_has_supported_extensions().

Warning: no release notes. The series makes the entire rte_vfio API
internal, removes the group-based API and rte_vfio_noiommu_is_enabled(),
and adds cdev mode. Only deprecation.rst is touched;
doc/guides/rel_notes/release_26_11.rst needs "Removed Items" and
"New Features" entries.

Patch 14 (bus/pci: use the new VFIO mode API)

Error: noiommu is no longer detected. pci_device_iova_mode() runs from
rte_pci_get_iommu_class() during rte_bus_get_iommu_class(), which
rte_eal_init() calls at line 689, well before rte_vfio_enable() at line
775. rte_vfio_get_mode() returns RTE_VFIO_MODE_NONE at that point, so
is_vfio_noiommu_enabled latches to 0 and IOVA VA is selected on a
noiommu system. The old rte_vfio_noiommu_is_enabled() read
/sys/module/vfio/parameters/enable_unsafe_noiommu_mode directly and was
therefore valid before VFIO init. The noiommu probe needs to stay
sysfs-based, or IOVA mode selection has to move after rte_vfio_enable().

Patch 15 (bus/fslmc: use the new VFIO mode API)

Error: fslmc bus scan now fails on every system. rte_fslmc_scan() is
called from rte_bus_scan() at eal.c:680, again before rte_vfio_enable().
The new check

	if (rte_vfio_get_mode() != RTE_VFIO_MODE_GROUP &&
			rte_vfio_get_mode() != RTE_VFIO_MODE_NOIOMMU) {
		ret = -EINVAL;
		goto scan_fail;
	}

always sees RTE_VFIO_MODE_NONE, so no DPAA2 device is ever scanned. The
same ordering problem applies to rte_dpaa2_get_iommu_class() and to
fslmc_vfio_add_group(), which will now always pick VFIO_TYPE1_IOMMU.

Warning: the new scan_fail branch has no log message, unlike every other
failure in that function, so the failure is silent.

Patch 19 (vfio: introduce cdev mode)

Error: vfio_cfg.ops is never set in a cdev-mode secondary. The only
assignment is in vfio_cdev_enable(), reached solely from the primary arm
of vfio_select_mode(). The secondary path calls vfio_sync_mode() and
vfio_cdev_sync_ioas(), neither of which touches ops. A cdev secondary
therefore has ops == NULL and every rte_vfio_container_dma_map()/
dma_unmap() fails in vfio_dma_mem_map() with "VFIO support not
initialized". The same applies to a container made with
rte_vfio_container_create() in a secondary: it opens an iommufd and
allocates an IOAS but leaves ops NULL. Set vfio_cfg.ops to the iommufd
ops in the secondary cdev path as well.

Note also that container_dma_map()/container_dma_unmap() dereference
vfio_cfg.ops->partial_unmap without a NULL check; only vfio_dma_mem_map()
guards it.

Patch 5 (net/nbl: do not use VFIO group bind API)

Info: nbl_open_group_fd() needs a blank line between the declaration and
the statements:

	static int
	nbl_open_group_fd(int iommu_group_num)
	{
		char path[PATH_MAX];

		snprintf(path, sizeof(path), RTE_VFIO_GROUP_FMT, iommu_group_num);
		return open(path, O_RDWR);
	}

