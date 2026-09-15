Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C38DC88E75
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 14:33:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D020340DDC;
	Tue, 15 Sep 2026 16:33:15 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5981840B91
 for <dev@dpdk.org>; Tue, 15 Sep 2026 16:33:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789482793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MQygtlo9pYb305KUtmu//s1nnZGLJ7FuJmFZx4/f2tA=;
 b=DLyQ0WrFjXxUXL5Yuw0cOKEHplchgUYoKm/ww8dWULbgkws9wcyEoKPKSY7mXLbC0Ejbo1
 7a4Tw7WRwTwzoZaEdc9x643SwftzE7bRDcBwPlndVLSvHUvYsmgbBPs6b3KvexZfi6E7ZU
 0KWm17rsKHyIo04oIHGKDgtYJe9Do14=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-mPQ9VtD6Oi6U-RwR8lH32A-1; Tue, 15 Sep 2026 10:33:12 -0400
X-MC-Unique: mPQ9VtD6Oi6U-RwR8lH32A-1
X-Mimecast-MFC-AGG-ID: mPQ9VtD6Oi6U-RwR8lH32A_1789482791
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc1ca15334cso6118096a12.1
 for <dev@dpdk.org>; Tue, 15 Sep 2026 07:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789482791; x=1790087591;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MQygtlo9pYb305KUtmu//s1nnZGLJ7FuJmFZx4/f2tA=;
 b=JZ9i9ANYzhyiEB+pZCE4DeZMnUmVqtgFoaAkFb2cRbT7gcz4JVhpomQolklA9q8ilL
 FbF0rf9MSif5yXVJZs/BeRny92RNSSmRZsImmJHDGNz43KC85GMoVW+bv+C0ynaNRXAR
 JCJ8bB+6TFEfskuSeP0O7RYQM5bAeuh0K3PR/HELOzmEXjMB4VfrvyRsPxZrF2Kfc4gO
 fQIWe/fzrIrxYtR/JAEdccnPmTq72WU92wyZdomQQ1mmXsu2dQTk9e3zlrk0zHkvzVPb
 J1Bt3BpRSsgpKoW7d04VzcC6lFdVp/FMLLhDF/wpTSzS7NKOQU9/U4ja55OOcDxznAhw
 dU8w==
X-Gm-Message-State: AFuF++nJT93bgPtCjW4FTF8bXL3eNl33v+R8IqpNWerlK4SoyrPpVlOy
 PpnVL/DKpOMMdNtpOSHjnK2G61XXRTVstwohc4NfaVPZKKZhc7G66STarLgtfX2XahVYptozPsS
 77NoiwXxIbbr9RShXZ6l419qsb2qA9yLqlm3FhpyJCru8vHeXnX/qFLsfrJE+ReuptHfyb6lyVq
 vI5/AkqWTumXnT2GvFrhc=
X-Gm-Gg: AYBFou11+mL7U5M3waCTqafgww9T89pdiakqmnWCVvkMKJ3INI42mwqwzMr6HyFbCaQ
 QiYnuCC3VPDdkMZe/IFmRwGp3L5BDAZrjJ49QccZY7J53KexZOcXCyBZV7LAlHQMU2lAghxMAyH
 r2ZWuQWqNu8wpGwjzgAsZ+PuS0nl0aW7eOwzsWUU5dsgQe4AKBolCY7JMJIyLbb/XUPvTZqIpqD
 C6jDgg13W6ZVbEDrQcVZ7k7YQvx0rO+qrHWY4VvoPGrsgtN
X-Received: by 2002:a05:6a21:2d43:b0:3cc:f0c7:5999 with SMTP id
 adf61e73a8af0-3db40622c8emr17516652637.16.1789482790835; 
 Tue, 15 Sep 2026 07:33:10 -0700 (PDT)
X-Received: by 2002:a05:6a21:2d43:b0:3cc:f0c7:5999 with SMTP id
 adf61e73a8af0-3db40622c8emr17516569637.16.1789482790218; Tue, 15 Sep 2026
 07:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1763141462.git.anatoly.burakov@intel.com>
 <cover.1789044746.git.anatoly.burakov@intel.com>
In-Reply-To: <cover.1789044746.git.anatoly.burakov@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 15 Sep 2026 16:32:48 +0200
X-Gm-Features: AcwNN1WZWRe7oc8YpxCugcdUZmx78Bn4khs0MIhiizhESRiYRVmid9DJWdRyRks
Message-ID: <CAJFAV8yEwjyh0KT3WhAFS1G29C2M_GbHxh1S6cRoVVsWGiM_NA@mail.gmail.com>
Subject: Re: [PATCH v17 00/26] Support VFIO cdev API in DPDK
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RSOYkRygImj5uNnqRpXvDnEggB18pi22XJHmolxqcyU_1789482791
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

On Thu, 10 Sept 2026 at 14:53, Anatoly Burakov
<anatoly.burakov@intel.com> wrote:
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

Thanks for the cleanup!

I am still in the process of reviewing.
Some first comments.


- About patch 1, I am not sure I understand your intention.
Without applying it, a conflict appears later in the series.


- Do you know if some Linux capability is needed for using the cdev mode?
Did you test this change in (unpriviledged) containers for example?


- It was a ugly/gray area so far, but should we stop exposing an API
that do nothing on Windows and FreeBSD?
Especially now that we make it internal.

Drivers calling the VFIO API may be broken/falsely announcing support
on other OSes.
I prefer a clear broken build rather than some runtime failure on
those OSes the day someone starts testing.

--vfio-intr / --vfio-vf-token EAL options are already Linux only.
So EAL common code looks already ready.

There may be one complication on the PCI bus side, with its calls to
vfio_dma_map/unmap but it seems doable (implement per OS
dma_map/dma_unmap internal symbols ?).

Something like:
https://github.com/david-marchand/dpdk/commit/cc77440883b0d38b842d6c520292b540eabb78c4
https://github.com/david-marchand/dpdk/commit/8f426089f949e0694e5201193be88de673c4283d


- Probably for later, but I see one more constant added in config/meson.build.
All VFIO objects seems to be local (or exchanged over MP messages).

How much effort would it take to remove those constants in config/meson.build?
I am thinking about RTE_MAX_VFIO_CONTAINERS, RTE_MAX_VFIO_GROUPS,
RTE_MAX_VFIO_DEVICES, EAL_VFIO_MAX_USER_MEM_MAPS.


- rte_eal_check_module() only user is VFIO.
No opensource project use it.
It could be removed in the future.


-- 
David Marchand

