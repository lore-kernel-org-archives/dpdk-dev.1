Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A67CA6017
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 08:03:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55F6F4026D;
	Sat, 10 Oct 2026 10:03:10 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 70629400EF
 for <dev@dpdk.org>; Sat, 10 Oct 2026 10:03:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791619387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t+DAlG6uYuDU79SYwufp+3rSoL7mz0MUf8yPlpMzf7c=;
 b=IwWo7F7SDeWw4HVKhykMV+cFN9SceIoMNZy3yw0PHVA49QhnYqlLlJBKaPWs5MAaMbmyu5
 1XzKrClunSZE49g8O+k1oWb7EAR7EGgNj6EDdHtCh38YG5QSkRdmIrZOiiAPsKnQFmW1v9
 wn7Cw3FSLWjg5ptntQw2Z/bjBFxoxZE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-82AMFgcvMwOYaDBGJ96-FA-1; Sat, 10 Oct 2026 08:03:06 +0000
X-MC-Unique: 82AMFgcvMwOYaDBGJ96-FA-1
X-Mimecast-MFC-AGG-ID: 82AMFgcvMwOYaDBGJ96-FA_1791619384
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5ba3e136779so206236e87.1
 for <dev@dpdk.org>; Sat, 10 Oct 2026 01:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791619384; x=1792224184;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=t+DAlG6uYuDU79SYwufp+3rSoL7mz0MUf8yPlpMzf7c=;
 b=tv17ucIe543FDcqCySs7SH2sfKeEQ7nQsTResY9gxSrZioTx8YdZjA2akxzgqpY2ri
 Ahbbz95uKyuymKh8UwBx91nGHvQLST7jJlpQvNzqz9ZS4KKfAvvB8R+6LwZoPP1mlY6r
 8XvNuZr6YZ4cVnInHCN0z9T+1fMNZnNSGMP66HzZhHwjhYjkAsrEnna+WGcn0kkz9JNw
 gv7+pwkE6vj05ZWyysNxOPrsTuMkGjTZoJMyxzrxpFiFJ3MYduvq9SZHxwAocXyC/Vyv
 lVJOth/NWTKgQkrRIYf1CBLjSC2cDoUEvJHOzMTHTkUtKMCB98j+qzC3UP8+wgBlOp/F
 2M4A==
X-Gm-Message-State: AFq9FYL05Roz1bjYKyVB8y3bvnB8Ha2k05YGOkR1HiSLVyTo04rOHz0u
 n8q0yXiClQQzo+cj3T5KQ0vumTpQHZY1W4QQeBec0v0FJiZ4FuhVgQu5zVZ8jtxlRVUT/LfFYN3
 FJfSHQi8eBnK/0ZJ6PieTBJnHNMSFl1XTwfK+TQ6ddkS5AVmgzGxVxSgydkUOg4494tc38IqxL3
 JDRBsa4IAuCRx2zhdd1bU=
X-Gm-Gg: AYBFou2grNsvgZ6Ct/mQbygpVqtc5INTgM2f8/EPcYJYIXG2uCBuCs1zBQ5Wo+nxAz1
 xQYgOe0gMG/zOn6Vk5DI+rHbBpY9UoxoAlDPFEkdXk3in02LNQgIVDJD7OlWtjbohzYaTCmgtun
 ysfl1/PJMIbdQgKPEueUMLTcg7xJntH3EviU9Mxf3A4zpzlU5uRUbkEXlc/Zy3hdbF+WBHpQnXR
 YpCkoabx0FckfvoRrV2MmpA1xoXp5u0JZL79zPRWb3zXSBI
X-Received: by 2002:a05:6512:1291:b0:5b8:997b:c606 with SMTP id
 2adb3069b0e04-5bcde8cb424mr1533450e87.41.1791619384343; 
 Sat, 10 Oct 2026 01:03:04 -0700 (PDT)
X-Received: by 2002:a05:6512:1291:b0:5b8:997b:c606 with SMTP id
 2adb3069b0e04-5bcde8cb424mr1533439e87.41.1791619383881; Sat, 10 Oct 2026
 01:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1763141462.git.anatoly.burakov@intel.com>
 <20261007081026.574382-1-david.marchand@redhat.com>
In-Reply-To: <20261007081026.574382-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Sat, 10 Oct 2026 10:02:52 +0200
X-Gm-Features: AclHuK9aZe1csuFvuV2dB0loT-NsCg9iJRzZNe66iH3PnCKqdlvdCj315Wgewo0
Message-ID: <CAJFAV8zDEov_9zro0kK5O9RvVpqTQWH+sgb+4_6z4Aigw0nsNQ@mail.gmail.com>
Subject: Re: [RESEND][PATCH v19 00/26] Support VFIO cdev API in DPDK
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, 
 Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6CYWL6mLrHL8zrVGot608yB-XK1oysLTbc1iyUsDLbA_1791619384
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

CI looks happy.
Thanks for the reviews on my cleanup.

Series applied for rc1.
Thanks.


-- 
David Marchand

