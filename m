Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA4ACDB46F
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 12:25:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5ABA340150;
	Mon, 22 Jun 2026 14:25:55 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5101040144
 for <dev@dpdk.org>; Mon, 22 Jun 2026 14:25:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782131152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I0o20wYAVFH3e2xemI1hXbZqEGDryGm+xc0kBuIzlVQ=;
 b=PhA7lwlwi7HLuItYCn1QxkQTr6vo8eGmPEkAHOjV+tSLA3AXvt7eQDEsuOAjAPgV/nAmGs
 GwZqYPQMgSM3pVcJ/s895AF1G7prcfBCUgzE7nmrdqQ3WHMHnMZmR5nMIguEfAuFoT5lvO
 Q9qh3dMBMwI2A2bIqjOtlJkar1lqQkA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-MKs_6g67POqE_1oYaGa3Ng-1; Mon, 22 Jun 2026 08:25:51 -0400
X-MC-Unique: MKs_6g67POqE_1oYaGa3Ng-1
X-Mimecast-MFC-AGG-ID: MKs_6g67POqE_1oYaGa3Ng_1782131150
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-3967d7545fcso18436531fa.0
 for <dev@dpdk.org>; Mon, 22 Jun 2026 05:25:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782131150; x=1782735950;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I0o20wYAVFH3e2xemI1hXbZqEGDryGm+xc0kBuIzlVQ=;
 b=WxJEHZX0KpnO0Folr7t/iZR+4kWXaQJrEwik4FkjfUBQt2LvuMqg+mU3QnxZydnnk9
 YljZeUJG9UQRYn5efKNGEcmn0JXKM2gPXYj58cxHbAZIf3TkhnUc3RSj0YqppsyZe6Kn
 WllPLdlnozXPvHzWU6WzSHW1Dz+86ZqVU47ePTHuLRhxRddZm+zVcQSzXTuaTsL8PEoJ
 OREX3O6U+VEtvM8hnKVFXaUGuFLHrAiveSd2/GFA3iAumRqGhah75Izaw6IYnDomq9Yn
 OFm8yzoljO6kWqYAnGaeJOXRP1WjGV5nFuS+j5YJnmecu5nTUdQVpqfoFjOFpgb8nyeM
 r2Ew==
X-Gm-Message-State: AOJu0YynNf7zQ0M42pSE70kV0GGpdZ71Nbo4bD/ja8ifdCKS14N8nB4o
 v+j6qHKJhaDjORq2cpDzWhLDv3kRs33mqZO3Ci4lypOI/2D6xET5rxObzK8skyJmeDUQhlgTEPO
 bpdcd6FxWKDZZC/mDcmhdnNySfS1ScWUXT3hwm1Z/KYrMd+bcRdxlVNidpQOoW7A9ik21YHWl94
 KpTWhoUCzRpfaMnpjN48Q=
X-Gm-Gg: AfdE7clHX4uiUV/U8dZtUDI+p+SJlBOGfQU97QycGu7N8yRFss/6diGP5Mem4rocl98
 DCUFyP5y2Jpwy2bVxaeep4I0ea8jUFS39m3hM2mFLoj+j/X4gaGddl+AQ84buA57lbc8vnLsSmL
 OvbzqJtfF+C/eYaJPPlwV3uKdhC71jU8Jarc23D/IXmrHFdNHpxURIuh5BtA7sSYFxQZvyf1PoX
 s6wqQucie7OxIvhCWwI9CHYUp6FPLWA9WU5W0OnoICHEGhHbRNIvQPoKPc=
X-Received: by 2002:a19:ee05:0:b0:5a8:6d58:b29 with SMTP id
 2adb3069b0e04-5ad576e9818mr2766758e87.22.1782131149458; 
 Mon, 22 Jun 2026 05:25:49 -0700 (PDT)
X-Received: by 2002:a19:ee05:0:b0:5a8:6d58:b29 with SMTP id
 2adb3069b0e04-5ad576e9818mr2766745e87.22.1782131148964; Mon, 22 Jun 2026
 05:25:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260518181856.1228373-1-raghavendra.ningoji@amd.com>
 <20260525184244.1758825-1-raghavendra.ningoji@amd.com>
In-Reply-To: <20260525184244.1758825-1-raghavendra.ningoji@amd.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 22 Jun 2026 14:25:36 +0200
X-Gm-Features: AVVi8CeFEBbaRNRk8w8L3i4U5IA1v2979pMSVMyYHvdtTCcZwmPojZ_lDpmJF8s
Message-ID: <CAJFAV8y3UtU8QHg+UtRu5w+HiZS5f9Q67RK5nsHThR6LkTr4oQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] dma/ae4dma: add AMD AE4DMA DMA PMD
To: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, 
 Bhagyada Modali <bhagyada.modali@amd.com>, Robin Jarry <rjarry@redhat.com>,
 Selwin.Sebastian@amd.com, Chengwen Feng <fengchengwen@huawei.com>,
 Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: N31h0LFmOUj6ym5my6rPiWkCwtximFcyYEd_cUBBchk_1782131150
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

Hello,

On Mon, 25 May 2026 at 20:43, Raghavendra Ningoji
<raghavendra.ningoji@amd.com> wrote:
>
> This series adds a new dmadev poll-mode driver for the AMD AE4DMA
> hardware DMA engine. An AE4DMA engine exposes 16 hardware command
> queues, each with a 32-entry descriptor ring; the PMD maps each
> hardware channel to its own dmadev with a single virtual channel,
> so a PCI function appears as 16 dmadevs named "<pci-bdf>-ch0" ..
> "<pci-bdf>-ch15".
>
> Driver characteristics:
>
>  - Memory-to-memory copy operations only (RTE_DMA_CAPA_MEM_TO_MEM).
>  - Completion is detected via the hardware's per-queue read_idx
>    register, which the engine advances as it processes descriptors.
>    The descriptor status / err_code bytes are read only to classify
>    each drained slot as success or failure.
>  - vchan_status reports IDLE/ACTIVE based on HW read_idx vs write_idx
>    and HALTED_ERROR when the queue is not enabled.
>  - depends on bus_pci and dmadev.
>
> The v1 was submitted as a single patch.  Per review feedback the
> driver is now introduced in three logical patches, following the
> pattern of the recent hisi_acc dmadev driver:
>
>   1/3 - introduce driver (probe, remove, per-queue HW init)
>   2/3 - add control path operations (dev_ops)
>   3/3 - add data path operations (copy, submit, completion)
> ---
> Changes in v2:
>  - Split the monolithic v1 patch into three logical patches
>    (introduce / control path / data path), mirroring the
>    structure used by drivers/dma/hisi_acc.
>  - Fix checkpatches.sh warnings in drivers/dma/ae4dma/ae4dma_internal.h:
>      * Use RTE_LOG_LINE_PREFIX (with RTE_LOGTYPE_AE4DMA_PMD) instead
>        of the deprecated rte_log() call form.
>      * Replace the GCC variadic argument-pack extension ("args...")
>        with C99 __VA_ARGS__ in the AE4DMA_PMD_{LOG,DEBUG,INFO,ERR,
>        WARN} macros.
>  - Move __rte_cache_aligned to the "struct" keyword position on
>    struct ae4dma_cmd_queue, as required by checkpatches.sh.
>
> v1:https://patches.dpdk.org/project/dpdk/patch/20260518181856.1228373-1-raghavendra.ningoji@amd.com/
>
> Raghavendra Ningoji (3):
>   dma/ae4dma: introduce AMD AE4DMA DMA PMD
>   dma/ae4dma: add control path operations
>   dma/ae4dma: add data path operations
>
>  .mailmap                               |   1 +
>  MAINTAINERS                            |   5 +
>  doc/guides/dmadevs/ae4dma.rst          |  75 +++
>  doc/guides/dmadevs/index.rst           |   1 +
>  doc/guides/rel_notes/release_26_07.rst |   7 +
>  drivers/dma/ae4dma/ae4dma_dmadev.c     | 738 +++++++++++++++++++++++++
>  drivers/dma/ae4dma/ae4dma_hw_defs.h    | 160 ++++++
>  drivers/dma/ae4dma/ae4dma_internal.h   | 118 ++++
>  drivers/dma/ae4dma/meson.build         |   7 +
>  drivers/dma/meson.build                |   1 +
>  usertools/dpdk-devbind.py              |   5 +-
>  11 files changed, 1117 insertions(+), 1 deletion(-)
>  create mode 100644 doc/guides/dmadevs/ae4dma.rst
>  create mode 100644 drivers/dma/ae4dma/ae4dma_dmadev.c
>  create mode 100644 drivers/dma/ae4dma/ae4dma_hw_defs.h
>  create mode 100644 drivers/dma/ae4dma/ae4dma_internal.h
>  create mode 100644 drivers/dma/ae4dma/meson.build
>
>
> base-commit: f724d1c0d1c1636b9c171c34db3f17c3defaa2f3

I did a pass on this series and sent comments, nothing blocking but please fix.


-- 
David Marchand

