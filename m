Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E022CA600D
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 17:28:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 947D140294;
	Thu,  8 Oct 2026 19:28:03 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7762640284
 for <dev@dpdk.org>; Thu,  8 Oct 2026 19:28:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791480481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k32rDsRV+BTLLwgl7xuP+Z61PgH5EEzAwMRHxyfmC+4=;
 b=FPEi6h26tAjLOgabW+tENSMyRTOyVXfo0hXWolM2kouiAQatXl0C/KfEBEgHDmR0iRHPEn
 YwfGBKeH0JFuP6yK26XqX1RKb1sW0R8W/pEFARcguUSY9/i1pMBe/2pUyHo+JteksBGPsL
 cfZIUgVEJJy5tq2WoUhpAqYVO0bQMcw=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-YHCQlK4EO6uWPOGG1Rcsww-1; Thu, 08 Oct 2026 13:28:00 -0400
X-MC-Unique: YHCQlK4EO6uWPOGG1Rcsww-1
X-Mimecast-MFC-AGG-ID: YHCQlK4EO6uWPOGG1Rcsww_1791480479
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5bb78051100so3449740e87.3
 for <dev@dpdk.org>; Thu, 08 Oct 2026 10:27:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791480478; x=1792085278;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k32rDsRV+BTLLwgl7xuP+Z61PgH5EEzAwMRHxyfmC+4=;
 b=eZZVwox3mrv9Recj9ttqj0ESTywDYVrLWA3y09/kxyuD5qXDTmrJTTTLykpe61QHdV
 4J66AXz9l3OYuPd8GPRTFpGGYQ0vDqaoxxbSKOQvLolxfF9n6lYmfZrELbu6aYwkO/+S
 Bi7sPR/sQSvzQywgQaUXSOZUMFZCWJfBVO00w7b1ZW6eqkLIQsjjp2jYFfUsl5fOgZDd
 /0g79Lu6LCD8RcQ9Km5dGyKTw39hBdfxnuWdGIiWEMvfp8PUmW5Ttl6wPOskIr/YfeT0
 xD+JSyb/OGz+sgntkT0cG1ISWlfOZrt+l09fao6UhxhecYzfMr/uBz78day6u9ZHJOMD
 FEKQ==
X-Gm-Message-State: AFq9FYKIeFHYUr0E/Sgx+29QA5j+cGKfTAIiHpg3lDJiYNwbbFvDvOv3
 v/azaVRNvyx2B0gvLOVepcP5InqwRZpqwnQC8+BcMBa7RnGjdJT3u+DbkZOfiY01gkrKa6/DH2M
 qEDaWU9oZXe2BI+L+0x4LqAGeK6TJCPY8YSdOIAxQXNLGB3jM0WACl9GcR0ELtQt+LAjDZBwGqu
 z4yj3+wRkWUVb2xiAxK34=
X-Gm-Gg: AYBFou1CpYBo+EIKMzwoOeoYaDndYpmyMGlH/wXQjDW5usoE5DGp5Er28fCMUgmrYWP
 e3xZAX8V5glOHufHtHa7PtmQ6zUV7cK/QFhYRXTHYF658mYbsz/SyMYQsgXGMl/fZBuIBjN/Ktu
 OxxJlF11P6v0fUBWzhP150IwYlY2k+axICoPVQPuWNBGCNWWCpoyZaHtJlzEs5zJGVBtLIn1gjB
 FUNpEp2LrkdkMA696MR9TufZnLv1SKMdQGrR5L+Gf87ak9e
X-Received: by 2002:a05:6512:1153:b0:5b8:f457:fe6e with SMTP id
 2adb3069b0e04-5bcd06ddee4mr2459912e87.17.1791480478528; 
 Thu, 08 Oct 2026 10:27:58 -0700 (PDT)
X-Received: by 2002:a05:6512:1153:b0:5b8:f457:fe6e with SMTP id
 2adb3069b0e04-5bcd06ddee4mr2459904e87.17.1791480478064; Thu, 08 Oct 2026
 10:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260811104933.3843522-1-g.singh@nxp.com>
 <20260812092929.563973-1-g.singh@nxp.com>
In-Reply-To: <20260812092929.563973-1-g.singh@nxp.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 8 Oct 2026 19:27:45 +0200
X-Gm-Features: AclHuK_jVQowwoYbOPVUmyGdOcEs7cFoVJdRxKVjwaQzqZuegutgcsfq4ty5Zwo
Message-ID: <CAJFAV8z0pe6-B8Mmab2fkfji76rgboMbWD5BcFLQLGz96xtcFg@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] dma/imx_edma5: introduce NXP i.MX95 eDMA5 driver
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: dev@dpdk.org, Gagandeep Singh <g.singh@nxp.com>, hemant.agrawal@nxp.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dGBH3E5CyK2UJZ3ZXs-DGXeoZhnleKI0JrnO-tH-Nno_1791480479
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hello Chengwen,

On Wed, 12 Aug 2026 at 11:29, Gagandeep Singh <g.singh@nxp.com> wrote:
>
> V4-changes:
>   - Removed the redundant local buffer "want"
>   - Updated the comment for RTE_PMD_REGISTER_ALIAS
>   - Removed stray extra blank line.
>
> V3-changes:
>  - Fixed below AI comments:
>    - Dead quote-stripping removed (`of_device_is_compatible`)
>    - Redundant `goto out` removed
>    - New Features entry added for bus platform changes.
>    - Scatter-gather doc corrected in both sections
>    - Unused CH_MATTR macros removed
>    - Fixed SG sub-transfer length cap (`imx_edma5_copy_sg`)
>    - Updated Per-job timeout logic.
>    - Updated `rte_mem_iova2virt` per-op in IOVA=3DVA mode logic
>    - Updated comments and documentation as per the AI comments.
>
> V2-changes:
>  - Added dependent patch: bus/platform: match device by devicetree compat=
ible string
>  - Fixed multiple AI reported issues includes:
>    - removed the alias from the driver, no need of it
>    - removed imx_edma5_write32 from data-path, reported as coherency
>      concern.
>    - fix submit for previously enqueued jobs.
>    - Added dsb in data path
>    - Added a commnet for rte_mem_iova2virt() NULL behaviour.
>    - Fixed: TCD NBYTES bits 31:30 are SMLOE/DMLOE =E2=80=94 full 32-bit l=
ength corrupts them
>    - Data path is fully synchronous: Acknowledged but intentionally defer=
red =E2=80=94
>      the synchronous design is a deliberate simplification for the initia=
l upstream submission.
>      Noted in docs.
>    - In-memory TCD64 pool is more complex than needed:
>      Noted/deferred =E2=80=94 the pool structure was retained for forward=
 compatibility
>      with hardware SG chaining.
>    - Extended `imx_edma5_dump()` to read and print `CH_CSR` and `CH_ES` r=
egisters
>      for every configured vchan.
>    - Double and stary lines removed.
>
> V1:
> This patch series adds a new dmadev Poll-Mode Driver (PMD) for the NXP
> i.MX95 eDMA5 (Enhanced DMA Type 5) controller.
>
> Key features supported by this driver:
>   - Memory-to-memory copy (RTE_DMA_OP_TYPE_MEMCPY)
>   - Scatter-gather memory copy (RTE_DMA_OP_TYPE_SG)
>   - 64-bit TCD (Transfer Control Descriptor) format
>   - Non-coherent DMA with explicit cache clean/invalidate
>   - Per-channel statistics and register dump for debug
>
> Patch breakdown:
>   [1/5] bus/platform: add dependent patch to detect device using
>         compatible string.
>   [2/5] Skeleton: bus probe/remove, dmadev registration, MAINTAINERS,
>         doc index, and release notes for 26.11.
>   [3/5] Device configuration: vchan setup, TCD ring allocation,
>         start/stop, and capability reporting.
>   [4/5] Data path: enqueue (copy and sg), doorbell, completion poll.
>   [5/5] Statistics and dump: per-channel counters and register dump.
>
> Tested on NXP i.MX95 EVK with vfio-platform.
>
>
> Gagandeep Singh (5):
>   bus/platform: match device by devicetree compatible string
>   dma/imx_edma5: introduce eDMA5 dmadev skeleton
>   dma/imx_edma5: add device configuration
>   dma/imx_edma5: add data path
>   dma/imx_edma5: add statistics and dump
>
>  MAINTAINERS                                |    5 +
>  doc/guides/dmadevs/imx_edma5.rst           |   69 ++
>  doc/guides/dmadevs/index.rst               |    1 +
>  doc/guides/rel_notes/release_26_11.rst     |   15 +
>  drivers/bus/platform/bus_platform_driver.h |   11 +-
>  drivers/bus/platform/platform.c            |   49 +-
>  drivers/dma/imx_edma5/imx_edma5_dmadev.c   | 1190 ++++++++++++++++++++
>  drivers/dma/imx_edma5/imx_edma5_dmadev.h   |  234 ++++
>  drivers/dma/imx_edma5/imx_edma5_hw.h       |  143 +++
>  drivers/dma/imx_edma5/imx_edma5_logs.h     |   16 +
>  drivers/dma/imx_edma5/meson.build          |   10 +
>  drivers/dma/meson.build                    |    1 +
>  12 files changed, 1741 insertions(+), 3 deletions(-)
>  create mode 100644 doc/guides/dmadevs/imx_edma5.rst
>  create mode 100644 drivers/dma/imx_edma5/imx_edma5_dmadev.c
>  create mode 100644 drivers/dma/imx_edma5/imx_edma5_dmadev.h
>  create mode 100644 drivers/dma/imx_edma5/imx_edma5_hw.h
>  create mode 100644 drivers/dma/imx_edma5/imx_edma5_logs.h
>  create mode 100644 drivers/dma/imx_edma5/meson.build

Please, could you have a look at this new DMA driver?


--=20
David Marchand

