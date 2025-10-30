Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020FFCCF9F0
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 09:22:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1495B402ED;
	Thu, 30 Oct 2025 10:22:00 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 53F1B4064C
 for <dev@dpdk.org>; Thu, 30 Oct 2025 10:21:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761816117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E3+1XWbrVYOb++U+DaSp6Pj3hZq7EZkfIzsMcB5CUlQ=;
 b=a7ErwiC2g1PmKEgbiBHQ0wSj2Lf7V2StxEZ+9Ye2mI7WIQZF/pWa+uSFGeSjDUh+X80tC2
 AfiXL0k9O7j/jXP5CaWqceNyjW0A9iIx1CKR/gyJ2uR4QZgdbWNvkBvkqmCtAoiBNkh0aw
 Q3RTM1vgsZ71dVxV+t8zvHAWqKhvDYc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-JYo31wZjOCescFnfxW5c1A-1; Thu, 30 Oct 2025 05:21:56 -0400
X-MC-Unique: JYo31wZjOCescFnfxW5c1A-1
X-Mimecast-MFC-AGG-ID: JYo31wZjOCescFnfxW5c1A_1761816115
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-35f62a3c170so6223481fa.0
 for <dev@dpdk.org>; Thu, 30 Oct 2025 02:21:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761816114; x=1762420914;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E3+1XWbrVYOb++U+DaSp6Pj3hZq7EZkfIzsMcB5CUlQ=;
 b=WQ7lpUmCKIFaKd3uAupoLq2o4XPfplwhCpeNc2aVdnENr+w4h7vQFZLyDZk5MY6znG
 B10W9t+sIKieqS4flJkgYifCJWsgw/EpRxe+U/Fp7bx1Fcw4GNz19EBPGQ7IpCYya7hY
 BZqy5i62Q758jKNeHh0P6zVlDfPMEflPjh562lW4fLSbA7RAmYjZ5x6xXXjaHKgWcjIH
 b+gV/vSYjYWxm87iWc2Y4V3HSW+7HKnejBohz6Lja32k10/l4DUwYqZKnxhmR908QSNm
 Q1Sh4kwIhcB9qIH+cP4lxOAL2vlT6akO+xT+pDBO0J1AxKIjbSLd//W1DLYUEZggL2YJ
 nuVQ==
X-Gm-Message-State: AOJu0YxZX7Hs/E9KYd30VY62KhUUHHlZvomkLgB4BYsOAeFI/5kyhqZy
 YBbmzicZyFDiYdeqM32W0mQm3Sy525cw4wSOamy4v7C3iOuN1r9mOk0PKq4wvOWlgStig3B+ePR
 xPgY/aJx4gm5hmUFgdTJ8e1wUGuNGIcjRF40h1v/QzKBXWaDH/Xh3jak4xFkk+9tcHmO1tfJSN+
 t7515ZNwcI3gz4o3bMDEOG1fXnJNdz/g==
X-Gm-Gg: ASbGnctPccBSPMOahbxLTT8uq0+njSpny62HcE4ZVOKmd8mLq1UcNM+sLTDywHVD/zw
 emaYhNWONtX3UzOAUnvkaT6F6TAzMQQLX5UdVxy66oCRv76OS1gtFcgbppXoUInDdlNP5N/6oSU
 IaJk9t9R8t+Lfy1zeDanxDydpl+zIf6Zvn9rQ6WqXqA4EMxNnE78caHMf7aQ==
X-Received: by 2002:a05:6512:3d93:b0:594:1575:d426 with SMTP id
 2adb3069b0e04-59416e94024mr783790e87.8.1761816114417; 
 Thu, 30 Oct 2025 02:21:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxtpTrB9mkTaA4pEo7FfW71HDMoXzf7AFf7GWUJYglMsJmSRh78VYG/kZdN6oVrKSrLCJoXjtaYV41gF5zAIM=
X-Received: by 2002:a05:6512:3d93:b0:594:1575:d426 with SMTP id
 2adb3069b0e04-59416e94024mr783783e87.8.1761816113846; Thu, 30 Oct 2025
 02:21:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1761669438.git.anatoly.burakov@intel.com>
In-Reply-To: <cover.1761669438.git.anatoly.burakov@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 30 Oct 2025 10:21:41 +0100
X-Gm-Features: AWmQ_bmZMG11D4y7JjpY23uJ8nWQAvFJ8DDTeZ32afdX-LzIRXZcVi9ytPPNYb0
Message-ID: <CAJFAV8wQiRZoeZD0uOxi_aa05XsE50_LbAQLxa1b12-vet-WkQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] Support VFIO cdev API in DPDK
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: V-eyVlJGQctZd1dJ34ZxioIEnVCOXjweUYauDHZP3dw_1761816115
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 28 Oct 2025 at 17:43, Anatoly Burakov <anatoly.burakov@intel.com> wrote:
>
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
> driver, etc.).
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
> the device, it is already mapped and we just return an fd.
>
> Additionally, a new `rte_vfio_get_mode` API is added for those cases that need
> some introspection into VFIO's internals, with three new modes: group
> (old-style), no-iommu (old-style but without IOMMU), and cdev (the new mode).
> Although no-IOMMU is technically a variant of group mode, the distinction is
> largely irrelevant to the user, as all usages of noiommu checks in our codebase
> are for deciding whether to use IOVA or PA, not anything to do with managing
> groups. The current plan for kernel community is to *not* introduce no-IOMMU
> cdev implementation, which is why this will be kept for compatibility for these
> use cases.
>
> As for special cases that rely on group mode, the old group-based API calls are
> kept, but will be marked as deprecated, and will only work in group/noiommu
> mode. This has little practical consequences, as even users such as NBL or FSLMC
> bus do not actually use any of VFIO functionality, they just create a container
> and proceed to do their own thing.
>
> 2. There is duplication among API's
> ===================================
>
> Over time, several VFIO API's have been added that perform overlapping
> functions:
>
> * `rte_vfio_get_group_fd` does the same thing as `rte_vfio_container_group_bind`
> * `rte_vfio_clear_group` does the same thing as rte_vfio_container_group_unbind`
>
> The only difference between them is that for the former API's, the container
> selection is implicit (create in default if doesn't exist, delete from any
> container). It really only makes sense to keep container versions around, but
> because we don't really need any of them any more, all of them will be
> deprecated.
>
> 3. The API responsibilities aren't clear and bleed into each other
> ==================================================================
>
> Some API's do multiple things at once. In particular:
>
> * `rte_vfio_get_group_fd` opens a new group if it doesn't exist
> * `rte_vfio_container_group_bind/unbind` return group fd
> * `rte_vfio_get_device_info` will setup the device
>
> These API's have been adjusted as follows:
>
> * `rte_vfio_get_group_fd` will *not* open any fd's, it will *only* return those
>   previously bound to a container by `rte_vfio_container_group_bind`
> * `rte_vfio_container_group_bind` will *not* return any fd's (users should call
>   `rte_vfio_get_group_fd` to get it)
> * `rte_vfio_get_device_info` will *not* set up the device (users should call
>   `rte_vfio_container_device_setup` prior to calling this API)
>
> All current users of these API's were adjusted, and grou-related API's were
> marked as deprecated.
>
> Feedback and suggestions are welcome, especially from maintainers of drivers
> that depend on VFIO infrastructure.
>
> Anatoly Burakov (8):
>   uapi: update to v6.17 and add iommufd.h
>   vfio: add container device assignment API
>   vhost: remove group-related API from drivers
>   vfio: do not setup the device on get device info
>   vfio: cleanup and refactor
>   vfio: introduce cdev mode
>   doc: deprecate VFIO group-based APIs
>   vfio: deprecate group-based API
>
>  config/arm/meson.build                    |    1 +
>  config/meson.build                        |    1 +
>  doc/guides/rel_notes/deprecation.rst      |   26 +
>  drivers/bus/cdx/cdx_vfio.c                |   13 +-
>  drivers/bus/fslmc/fslmc_bus.c             |   10 +-
>  drivers/bus/fslmc/fslmc_vfio.c            |    2 +-
>  drivers/bus/pci/linux/pci.c               |    2 +-
>  drivers/bus/pci/linux/pci_vfio.c          |   17 +-
>  drivers/crypto/bcmfs/bcmfs_vfio.c         |    6 +-
>  drivers/net/hinic3/base/hinic3_hwdev.c    |    2 +-
>  drivers/net/nbl/nbl_common/nbl_userdev.c  |   18 +-
>  drivers/net/nbl/nbl_include/nbl_include.h |    1 +
>  drivers/net/ntnic/ntnic_ethdev.c          |    2 +-
>  drivers/net/ntnic/ntnic_vfio.c            |   30 +-
>  drivers/vdpa/ifc/ifcvf_vdpa.c             |   34 +-
>  drivers/vdpa/mlx5/mlx5_vdpa.c             |    1 -
>  drivers/vdpa/nfp/nfp_vdpa.c               |   37 +-
>  drivers/vdpa/sfc/sfc_vdpa.c               |   39 +-
>  drivers/vdpa/sfc/sfc_vdpa.h               |    2 -
>  kernel/linux/uapi/linux/iommufd.h         | 1292 ++++++++++
>  kernel/linux/uapi/linux/vduse.h           |    2 +-
>  kernel/linux/uapi/linux/vfio.h            |   12 +-
>  kernel/linux/uapi/version                 |    2 +-
>  lib/eal/freebsd/eal.c                     |   36 +
>  lib/eal/include/rte_vfio.h                |  414 +++-
>  lib/eal/linux/eal_vfio.c                  | 2640 +++++++++------------
>  lib/eal/linux/eal_vfio.h                  |  170 +-
>  lib/eal/linux/eal_vfio_cdev.c             |  387 +++
>  lib/eal/linux/eal_vfio_group.c            |  981 ++++++++
>  lib/eal/linux/eal_vfio_mp_sync.c          |   91 +-
>  lib/eal/linux/meson.build                 |    2 +
>  lib/vhost/vdpa_driver.h                   |    3 -
>  32 files changed, 4484 insertions(+), 1792 deletions(-)
>  create mode 100644 kernel/linux/uapi/linux/iommufd.h
>  create mode 100644 lib/eal/linux/eal_vfio_cdev.c
>  create mode 100644 lib/eal/linux/eal_vfio_group.c

Do we really need to expose all this as "applications" API?
All I see is EAL and/or drivers concerns.
Could we hide all of this as drivers API or at least clearly separate
what is driver-only stuff from other API that do make sense for an
application?
But we can't break ABI during 26.03, so maybe my suggestion would have
to wait 26.11.


Two nits on the series:
- you'll have to update the vhost documentation, for the vDPA driver API update.
- I also saw those inconsistencies: double check the experimental
symbol marks, the next release is 26.03, not 26.02 (this is no warning
in checkpatch atm, maybe something to add).


-- 
David Marchand

