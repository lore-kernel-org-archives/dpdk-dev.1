Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF3CCA5FFF
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 10:00:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4CC8B40615;
	Wed,  7 Oct 2026 12:00:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1816C4027E
 for <dev@dpdk.org>; Wed,  7 Oct 2026 12:00:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791367211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SvHM5twRmUitZ+KjmOIZICQQPxrkGEUrm6zx9tPvGq0=;
 b=ZvqVKL31rEDItgVZqStnN76IMAsj9k427g+HvaPncUiFnXxAfqKTDvJb79tFD5E4plHO8R
 8twovZrOuKYQ79PUGSSEYyVF59omF4dig+Wza5+IPQtWsshoBovW/8IExEocNXE7uSPqmS
 DR4OBN9tScwTQ4FwF2QaYnfe8gBHbA8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-ruJutbkEMbGkmTiFpcltOQ-1; Wed, 07 Oct 2026 06:00:10 -0400
X-MC-Unique: ruJutbkEMbGkmTiFpcltOQ-1
X-Mimecast-MFC-AGG-ID: ruJutbkEMbGkmTiFpcltOQ_1791367209
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-3a7777d3c74so25096091fa.3
 for <dev@dpdk.org>; Wed, 07 Oct 2026 03:00:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791367208; x=1791972008;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SvHM5twRmUitZ+KjmOIZICQQPxrkGEUrm6zx9tPvGq0=;
 b=ceXltzKXwR5WuEVza97wvWGmiV2eQtX24b9haLvUtVFHxZZsATOzjYj6uRx8TazDcI
 s9mJ8hvBk3J+w6wElxjJ3RMCUnn+lVMmw8kxu+lvGfcW3rvyx141G97mEDaZ8sY/cHkr
 VkD80V9O57wUF61VWtPLZPSK5r0rs1Gl/Qa8uHJ7CxRZ4RailwaypfNPKCiOP8VPe46I
 84Zv7Ipv1M/bqtyLEVnRfxWt94Kro4Hg/0LKKb8s2RFoo8IGXvkLRAbwSgfOpo0GmB2t
 p9gTiUMq/w3Lud5dkCEtRRV3lwtVgqpKl7e7XvcSfWXUUl58kJzZgNeCsq1WRtRLnhkX
 NXHA==
X-Gm-Message-State: AFq9FYLDriRa0SIlgMjIWeQw+Rt1J3cT0MWDYqXTQvz6F9+IIsBvvPiV
 6bHDxk7lsgsXdaP1Bx9r8qIa4Q8wEbebMlxOo5Z2TVrFgdgO9kq3Ur8gAW8MS2l68GE8k2Q41Uk
 zXymeP4KjLGPuDE3efH1HSh9Vs9oxUSGuMxxOyD18n2VTFaN2Csxf7u8chrxQo/qrH8dfh6tCq4
 MoP0CKcChA6bIxPwloHWULuEmNiWXfxQ==
X-Gm-Gg: AYBFou1HYT+3lzjbfa3mF/uxxbM6yh2QDhJUSF1B1BuzzwNfWyX/PxcgMSfe6WaEmxz
 yPrsop6NYNbdoOKhd2uxwW3iOYnrRIgKhtL+pChZ5ChnPRo3vf9kXClcvKmqNQNQuWmTcmRNh48
 JeWxgvRboL5wVTDbsD/DAzwyqYlKx59bw3QwWrjXgPT1CeF8I+pUSSVv10088wC8gm1M4ccXzTt
 3SSxtXuD/6ZzVO1O09yHDD9cGz2tHJj0kDEa8MBbI4LnYjt
X-Received: by 2002:a05:651c:2215:b0:3a6:4917:db4e with SMTP id
 38308e7fff4ca-3a9a2ce5fd0mr4394441fa.17.1791367207374; 
 Wed, 07 Oct 2026 03:00:07 -0700 (PDT)
X-Received: by 2002:a05:651c:2215:b0:3a6:4917:db4e with SMTP id
 38308e7fff4ca-3a9a2ce5fd0mr4394281fa.17.1791367206015; Wed, 07 Oct 2026
 03:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1763141462.git.anatoly.burakov@intel.com>
 <20261007081026.574382-1-david.marchand@redhat.com>
In-Reply-To: <20261007081026.574382-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 7 Oct 2026 11:59:54 +0200
X-Gm-Features: AclHuK9d_4riV83hmUvvMrfIu4sE0f5eL0KpDPNF1fpxKlUWZJtet7kYL5Pytw0
Message-ID: <CAJFAV8z6fDpe7xs5HXZufYN07iwqhHwiWh-rDW9U-mp41o0S5w@mail.gmail.com>
Subject: Re: [RESEND][PATCH v19 00/26] Support VFIO cdev API in DPDK
To: dev@dpdk.org
Cc: "Burakov, Anatoly" <anatoly.burakov@intel.com>, 
 Bruce Richardson <bruce.richardson@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: i_cIb2ksrJg9bgFtJsBrAFr7rmHpRDhQPnpn4nkz28E_1791367209
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

On Wed, 7 Oct 2026 at 10:10, David Marchand <david.marchand@redhat.com> wrote:
>
> This patchset introduces a major refactor of the VFIO subsystem in DPDK to
> support character device (cdev) interface introduced in Linux kernel, as well as
> make the API more streamlined and useful. The goal is to simplify device
> management, improve compatibility, make the code readable, and clarify API.
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
> interface to userspace. The old group-based implementation will still be around,
> and will need to be kept in DPDK for compatibility reasons.
>
> To enable this, VFIO is heavily refactored, so that the code can support both
> modes while relying on (mostly) common infrastructure.
>
> Additionally, new `vfio_get_mode` API is added for those cases that need
> some introspection into VFIO's internals, with two modes: group (old-style),
> and cdev (the new mode).
>
> Historically, no-IOMMU mode was technically a variant of group mode, the
> distinction is largely irrelevant to the user, as all usages of noiommu checks
> in our codebase are for deciding whether to use IOVA or PA, not anything to do
> with managing groups. However, now that upcoming kernel versions will support
> no-IOMMU for both group, cdev compatibility, and full cdev paths, a new
> `vfio_get_iommu_mode` is also added, with two modes: safe (full IOMMU backing),
> and unsafe (no-IOMMU mode). The naming is chosen explicitly to emphasize that
> using no-IOMMU mode is not ideal.
>
> 2. Custom container assignment API does not map to cdev mode
> ============================================================
>
> The existing `rte_vfio_device_setup/release` model is fundamentally incompatible
> with cdev mode, because for custom container cases, the expected flow is that
> the user binds the IOMMU group (and thus, implicitly, the device itself) to a
> specific container using `rte_vfio_container_group_bind`, whereas this step is
> not needed for cdev as the device fd is assigned to the container straight away.
>
> Therefore, what we do instead is introduce a new API for container device
> assignment which, semantically, will assign a device to specified container, so
> that when it is mapped using `rte_pci_map_device`, the appropriate container is
> selected. Under the hood though, we essentially transition to getting device fd
> straight away at assign stage, so that by the time the PCI bus attempts to map
> the device, it is already mapped and we just return an fd. There is no
> "unassign" API because `release_device` already performs that function.
>
> Because the API is now unified around device assignment, the old group-specific
> API's can be removed and, where appropriate, reimplemented using new API. There
> were other users of VFIO which relied on group API but only for convenience
> purposes; no actual VFIO functionality depended on those API's.
>
> List of removed API's:
>
> * `rte_vfio_get_group_fd`
> * `rte_vfio_clear_group`
> * `rte_vfio_container_group_bind` (replaced by container assign API)
> * `rte_vfio_container_group_unbind`
> * `rte_vfio_noiommu_is_enabled` (replaced by new mode API)
>
> 3. The API responsibilities aren't clear and bleed into each other
> ==================================================================
>
> Some API's do multiple things at once. In particular:
>
> * `rte_vfio_get_device_info` will setup the device
> * `rte_vfio_setup_device` will get device info
>
> These API's have been adjusted to do one thing only.
>
> 4. The API does not need to be public
> =====================================
>
> The initial idea for exposing VFIO API was to enable userspace applications to
> directly map memory for DMA, but it turns out that in practice only drivers use
> this API. Therefore, the entire VFIO API is made internal, driver-only, and is
> renamed from `rte_vfio` to `dev_vfio`.
>
> v19:
>
> TL;DR: the v18/v19 diff shows no major changes, more could have been done
> probably (especially on the huge API revamp patch), but rc1 is coming...
> Compilation per patch still works, hopefully my splitting broke nothing at
> runtime.
>
> - Rebased so that CI can run on the series (did not happen with v18)
> - Reordered patches:
>   - moved the uAPI update at the end of the series when needed
>   - moved small cleanups earlier in the series (vhost DMA capability cleanup,
>     bus updates like PCI or fslmc...)
> - Replaced bus/pci update with the change I prepared when replying on v18:
>   the most notable change is that the pci bus object is left in common code
> - Fixed (well, removed) VFIO header from FreeBSD and Windows exports list
>   and removed all mentions of "Linux only" in this same header since it is
>   now only exported by Linux
>   (iow lib/eal/include/dev_vfio.h -> lib/eal/linux/include/dev_vfio.h)
> - Squashed the patches touching kernel module: those are mechanical and the
>   diff is small. Also fixed one small string truncation issue reported by AI
> - Squashed the two patches around making VFIO internal only: the diff is huge,
>   but the changes are mechanical and I saw no interest in keeping them
>   separate
> - Dropped rte_errno updates in patches that did not document the change in
>   eal_vfio.h/dev_vfio.h (such updates were dropped later in the series anyway)
> - Split the too big "vfio: cleanup and refactor" patch
>   - Mechanical changes have been isolated in first patches: like renaming or
>     reorganising structures
>   - Macros only used in one location were removed from headers
>   - vfio_containers is not exposed out of eal_vfio.c anymore
>   - Fixed uapi/linux/vfio.h inclusion (must be included *first*, important
>     because of stddef dependencies)
>   - Fixed coding style like indentation, or line wrapping for 80 columns(?)
>     or log messages split over multiple lines
>
> v18:
> - Adjusted pre-refactor VFIO cleanup to not rely on per-config enabled flag
> - Moved loaded module detection from EAL into VFIO
> - Added API to check for specific VFIO modules being loaded
> - Removed VFIO stubs from non-Linux code by removing PCI bus dependency on VFIO
> - Reworked vhost DMA capability check
> - Renamed "IOMMU mode" and "safe/unsafe" terminology to IOVA VA/PA
> - Fixed typo in FSLMC bus IOVA mode selection

Known CI issue for
https://mails.dpdk.org/archives/test-report/2026-October/1056865.html.
The Intel CI failure on doc generation can be ignored, since updates
of doc/ are filtered when applying the patches...


-- 
David Marchand

