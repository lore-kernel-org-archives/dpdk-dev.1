Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F45CC6B24
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 07:28:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DB6040279;
	Wed, 14 Oct 2026 09:28:31 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 546D140272
 for <dev@dpdk.org>; Wed, 14 Oct 2026 09:28:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791962909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eN9JZPTXqzkhERxx6naDY+wyjSCFPn+Ckf9g+119f/I=;
 b=CJo6mz+qjtMw8tVL+kkeJHClmelJ4mZrRJvq6ECdtOeKc7BHKk7uxE5eMrdzN8VX+f6yAV
 BEiXezoj7PWP6QaYePxmVLn1uX6OokLQ8mvVN/bs/LeKGb4jzHI8yOXlh1VtQZr4MlXNFn
 iR2L/6aQyIoV4b8lQjoNjD2xTYRqdOY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-SNFpXQUmMLu_o6tkzBIx3Q-1; Wed, 14 Oct 2026 07:28:28 +0000
X-MC-Unique: SNFpXQUmMLu_o6tkzBIx3Q-1
X-Mimecast-MFC-AGG-ID: SNFpXQUmMLu_o6tkzBIx3Q_1791962907
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3a77cbb4202so3654761fa.2
 for <dev@dpdk.org>; Wed, 14 Oct 2026 00:28:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791962906; x=1792567706;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eN9JZPTXqzkhERxx6naDY+wyjSCFPn+Ckf9g+119f/I=;
 b=BCs+hThprCcMiDaT89HmHRpZEuRte0ytowUNee3KJYVSJYKDCktMXJG9bsrud0v2w4
 0M99i5Ik8HuYPcbPpV8q8cAm+HFFreT2VGt6UibhKTxsPr2dc7rY/1LyWQhQZqdIdrXn
 kNxIYUiTCD+4WGapxfo0Xpv9K+GfDxXwr3Di+VAwhmlMMQD9Rj33U4DZQFknKc231cao
 Z6V1RnHmqj/juJrK4QsCBXEJePjD5jxwolszPlU9D7wY2TO1uGLCHykRCxsxrR0Jm4VD
 C7NjyyYblMEhgjZKqDe0L7/4hNxQUrzgDBrjcsyRi0QpmsFB8asTU1p6oFi/WZ+0QdL5
 nI0Q==
X-Gm-Message-State: AFq9FYLsCvdfip4nBM9c61rluOyR+uB7fmMV6bec095wecf7NNETZE0o
 m5ZCPdGF6sPb/byoeaUzvwHfIL/493soKe9573jWG7hPwKcKS73Ruz8Ta0QVTQoFH8c3aVENR91
 frOvMoT5+9zIky21rc4BEexQ5pu3Sv5tKubqSb0rVNXPSuSbmRS9kD2NZxJkhB6RqaLUTEnW4OV
 aO+1M/PqZOcB33Rww+j7ZNBL1V95w=
X-Gm-Gg: AYBFou1/iDR4zFDDNzpl6tVIIIyfpj1QuvUeYMqdlhZvzng2bhbfEduGI6BrJP13VOv
 lZlsvLWdlTE+TgRhg9Wg8iaSy59+6QcqUkWZIe6zYekxFNcJWse958j+eb/B1ijLOB6ndapHjDR
 au5HqbRAKnwYL8u9AnEBvkuWWUwHThyeCvxQBWqRFdSHzE5Tg8x/8i8rB8JwkD9+HllA35q3HCj
 W9zd++gOJwBDIj3rIe1w4R7yetNWPe11zivSm6Wr+ep7YuM
X-Received: by 2002:a2e:a9a3:0:b0:3a2:f233:5c6e with SMTP id
 38308e7fff4ca-3a9c515d16dmr36457511fa.6.1791962906321; 
 Wed, 14 Oct 2026 00:28:26 -0700 (PDT)
X-Received: by 2002:a2e:a9a3:0:b0:3a2:f233:5c6e with SMTP id
 38308e7fff4ca-3a9c515d16dmr36457411fa.6.1791962905764; Wed, 14 Oct 2026
 00:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <20261013065127.102157-1-g.singh@nxp.com>
 <20261014035746.509685-1-g.singh@nxp.com>
In-Reply-To: <20261014035746.509685-1-g.singh@nxp.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 14 Oct 2026 09:28:13 +0200
X-Gm-Features: AclHuK_ytOOz94pgKFkASKmnLnyG-JEdFBmgpj-Vr1lkNKjTen0PFOZlfL0Kjnc
Message-ID: <CAJFAV8yV9KuWfb=1U-8Q=+vjuk6Vkxz0Lu6nw3zit_qOxn75wQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] dma/imx_edma5: introduce NXP i.MX95 eDMA5 driver
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, fengchengwen@huawei.com, hemant.agrawal@nxp.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bXi_kmAlKX6ozfT58J4AFPowoNxEJ2YBLsfwywwC5Lo_1791962907
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

On Wed, 14 Oct 2026 at 05:58, Gagandeep Singh <g.singh@nxp.com> wrote:
>
> V6-changes:
>   - Rebased the series to the top of main branch.
>
> V5-changes:
>   - Added DP logs.
>   - removed unwanted checks.
>   - fixed comments, coding style.
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
> Gagandeep Singh (5):
>   bus/platform: match device by devicetree compatible string
>   dma/imx_edma5: introduce eDMA5 dmadev skeleton
>   dma/imx_edma5: add device configuration
>   dma/imx_edma5: add data path
>   dma/imx_edma5: add statistics and dump
>
>  MAINTAINERS                              |    5 +
>  doc/guides/dmadevs/imx_edma5.rst         |   69 ++
>  doc/guides/dmadevs/index.rst             |    1 +
>  doc/guides/rel_notes/release_26_11.rst   |   15 +
>  drivers/bus/platform/platform.c          |   49 +-
>  drivers/dma/imx_edma5/imx_edma5_dmadev.c | 1156 ++++++++++++++++++++++
>  drivers/dma/imx_edma5/imx_edma5_dmadev.h |  235 +++++
>  drivers/dma/imx_edma5/imx_edma5_hw.h     |  143 +++
>  drivers/dma/imx_edma5/imx_edma5_logs.h   |   22 +
>  drivers/dma/imx_edma5/meson.build        |   10 +
>  drivers/dma/meson.build                  |    1 +
>  11 files changed, 1705 insertions(+), 1 deletion(-)
>  create mode 100644 doc/guides/dmadevs/imx_edma5.rst
>  create mode 100644 drivers/dma/imx_edma5/imx_edma5_dmadev.c
>  create mode 100644 drivers/dma/imx_edma5/imx_edma5_dmadev.h
>  create mode 100644 drivers/dma/imx_edma5/imx_edma5_hw.h
>  create mode 100644 drivers/dma/imx_edma5/imx_edma5_logs.h
>  create mode 100644 drivers/dma/imx_edma5/meson.build

Reformated the RN update and fixed a few coding style issues.
Applied, thanks.


--=20
David Marchand

