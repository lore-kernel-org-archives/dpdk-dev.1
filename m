Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1479C982CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 06:52:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4F06400D6;
	Thu, 17 Sep 2026 08:52:34 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id D6F1D400D5
 for <dev@dpdk.org>; Thu, 17 Sep 2026 08:52:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789627952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tJxX2SVGnom3bucERyjoSW5GGO868BO8hMVRrBiaDbs=;
 b=U7hfMdYvCRicI2xtS5KQQo0q2L/DkZ3/Mq8ZHd5zgsAgI4p85uz5sezwjp2k/gXzdE9gTg
 WHfIzzCarJAiS/l8FmxEpbIuwlOvfanCvd6Htkj4/8OprVe9Cb2jSNwkO6oXTq1a0BHQzj
 GtHCxbGsVYuU8qqOo8DbkKfuqCzmFJQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-GfZFJbjCMUWvNRF00rtqVg-1; Thu, 17 Sep 2026 02:52:28 -0400
X-MC-Unique: GfZFJbjCMUWvNRF00rtqVg-1
X-Mimecast-MFC-AGG-ID: GfZFJbjCMUWvNRF00rtqVg_1789627947
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5b619951eaeso205662e87.0
 for <dev@dpdk.org>; Wed, 16 Sep 2026 23:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789627947; x=1790232747;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tJxX2SVGnom3bucERyjoSW5GGO868BO8hMVRrBiaDbs=;
 b=tqHViK0tCZnuccKjbONAiiNMNJQPf6wUP35srpHjyWsU3sgmSQAH1ZJlgSKSzhjzvu
 pDr1UQog3uDWn8YnO1T+7Sz7QTvApAq5c3oFBbUQlgRYKSjX1rKv0EQQPdi2cjUNf+pN
 r2b/nqcuIM8HTXV+7GZNFmTjZ18WouS24jMmMr33eu7IV2plsnyDV2QIN+iXv/OAHmcJ
 tWvBk1MeVBzEFP2Y532OSsXCbCBKiNpp67OMThtD2XKXCY4wKwoV8Rfbmg7zRCQ/75SZ
 zpoETCEYVLFHWh+JC/o7dPGzC86XBjLWPrp66ubbESV8nrfHpmD8eiiHLtHCwZc9CsEB
 azVg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw1FlpqknJL5NyR56MpXC/tcWbfLb+wX+YbVNMo0E0kUYlLvR4Kk8mIwWmyJjpUHE2ZN6w=@dpdk.org
X-Gm-Message-State: AFuF++kkDA+GB4jKgoQc1YvEMxX9d16sjfpNyqG8RhSyWxTi2PfZo/st
 YdHCgVFWrjqJs8y96T4uVy/VuBK3uWpYZN6R4CQ0SDFH+xmVGRkp+YhG648cf6Hvu7Pq2h92Vq4
 pyfVEjfRzouF3vW2udM10KcKUPycQmkQAgO7RyKGaGBohNU4+DO+lm6O0RSbDGMqBNm/w7L3kBR
 S6JbdQRBA8U6UOhjpC77w0vQDy6ICs0Q==
X-Gm-Gg: AYBFou3X3gFIJK1QTuRP5E4Jfx5SfRVGwaFxNMaDnNkJkmu+Xh1VU5XZEL+CXPyRgW2
 RrfjCQC9zpVKU1LR3IMsagV+rt44K4pix9VkMbxMfMzqwnO1dmsC3ANzLMN9M6un3BG4/4VCNpC
 5Ri1EBZUwkQPeOaGNaerhKxNxQAnWuWBJArNH3V9/JX66QRbQhd4FtKS6j88AD3MiXCeVvb066U
 4nEI5GA6D+wHpi3taXzzhsFFt4tql7jzPm/NF1kdCnx4zBy
X-Received: by 2002:a05:6512:60e:20b0:5b1:5e19:c496 with SMTP id
 2adb3069b0e04-5b8ba5dea7emr420946e87.14.1789627947094; 
 Wed, 16 Sep 2026 23:52:27 -0700 (PDT)
X-Received: by 2002:a05:6512:60e:20b0:5b1:5e19:c496 with SMTP id
 2adb3069b0e04-5b8ba5dea7emr420938e87.14.1789627946605; Wed, 16 Sep 2026
 23:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260915113459.4166621-1-prashant.gupta_3@nxp.com>
 <20260915120208.4185877-1-prashant.gupta_3@nxp.com>
 <20260915120208.4185877-7-prashant.gupta_3@nxp.com>
In-Reply-To: <20260915120208.4185877-7-prashant.gupta_3@nxp.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 17 Sep 2026 08:52:15 +0200
X-Gm-Features: AcwNN1WD418t7C_aV4WFjyybWQUtEKyoJBtdKEUi-WuI-aDgaLItGHVVFIOb12A
Message-ID: <CAJFAV8yx4ifJDu9L7TcbSCCYea=5+Obvfutr0AzR5yxusgzPhg@mail.gmail.com>
Subject: Re: [PATCH v3-S3 06/10] drivers: inherit dpaa2 rxq config for event
 queue
To: Prashant Gupta <prashant.gupta_3@nxp.com>
Cc: stephen@networkplumber.org, dev@dpdk.org, Jun Yang <jun.yang@nxp.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8ArI4WIyaq0GjxDj4e4ENgUSws32EQcbtrfwvfv2PL0_1789627947
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

On Tue, 15 Sept 2026 at 14:03, Prashant Gupta <prashant.gupta_3@nxp.com> wrote:
>
> From: Jun Yang <jun.yang@nxp.com>
>
> The configuration parameter in event queue attachment should use
> flc and cgid configured in rxq setup.
>
> Signed-off-by: Jun Yang <jun.yang@nxp.com>
> ---
>  drivers/bus/fslmc/portal/dpaa2_hw_pvt.h | 2 +-
>  drivers/net/dpaa2/dpaa2_ethdev.c        | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
> index 12216750a8..f87bf51d09 100644
> --- a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
> +++ b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
> @@ -1,7 +1,7 @@
>  /* SPDX-License-Identifier: BSD-3-Clause
>   *
>   *   Copyright (c) 2016 Freescale Semiconductor, Inc. All rights reserved.
> - *   Copyright 2016-2024 NXP
> + *   Copyright 2016-2025 NXP
>   *
>   */
>
> diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
> index 8cd482b538..77a93ecf91 100644
> --- a/drivers/net/dpaa2/dpaa2_ethdev.c
> +++ b/drivers/net/dpaa2/dpaa2_ethdev.c
> @@ -2817,11 +2817,12 @@ int dpaa2_eth_eventq_attach(const struct rte_eth_dev *dev,
>         struct dpaa2_dev_priv *eth_priv = dev->data->dev_private;
>         struct fsl_mc_io *dpni = (struct fsl_mc_io *)dev->process_private;
>         struct dpaa2_queue *dpaa2_ethq = eth_priv->rx_vq[eth_rx_queue_id];
> -       uint8_t flow_id = dpaa2_ethq->flow_id;
> +       uint8_t flow_id;
>         struct dpni_queue *cfg;
>         uint8_t options, priority;
>         int ret;
>
> +       flow_id = dpaa2_ethq->flow_id;
>         cfg = dpaa2_ethq->cfg;
>
>         if (queue_conf->ev.sched_type == RTE_SCHED_TYPE_PARALLEL)

This patch looks like a noop.


-- 
David Marchand

