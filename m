Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DDBC83F26
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Jul 2025 04:35:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C4A9D40668;
	Tue, 29 Jul 2025 06:35:31 +0200 (CEST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 1C8CE40647
 for <dev@dpdk.org>; Tue, 29 Jul 2025 06:35:30 +0200 (CEST)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4561514c7f0so49029725e9.0
 for <dev@dpdk.org>; Mon, 28 Jul 2025 21:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753763730;
 x=1754368530; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D8cUSgVHj0nh/V3x8rJzy1y12mrgAQGFbSz2QjuT6s4=;
 b=pezquSX+BbwA/Q7JuZlmeXL27ikvnaURaJCjC/8DHV2Au7YdIbDXoAbOAgPLrX7R7a
 XSw670JgxyueN7WzOl9rCfuj574tQmDnp/Q13XxERpI8581jdJDOcxKwf3o6JVYPRp+O
 G6QVhf8CfDjtxHSVCNYba8W8bV2mBArhgUyWWlsvrsxPU5xpMiwcLENnT9SnKooWLyM0
 LlctMEheY/00rqS+dPWj6L6OCv7tIdQJWakR6DF5lgByFedxLIPQ59vxkrldxhHqmgKk
 2bcvWFHpEPyDBZS+BjjjU0Nyjj5dDmi15ZMRtGY7AeDWYleQWqO70Fo9M3cx/bXQAS7l
 HypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753763730; x=1754368530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D8cUSgVHj0nh/V3x8rJzy1y12mrgAQGFbSz2QjuT6s4=;
 b=waHXYuN5RMormdX+Nqz/ikgR2vYnieWghVNWaVh2gwvB0UFuh3C55QUr5KhTBkrDu0
 LWYqfukb3T0o3tsXBet3mXsjd1lDcgqkXdG/IUjLA5uV+f39z91frxaeG3sv/iHE4mFT
 pqIOPl5xOLYPqyfv8CIAAtKXohKiE+0buuPUTjvRLWuwemP2/0PmaO8jyK8e/0pCKSzt
 MLPbS5PEQLMe2cmjbLDkhQVRIfJcrQsmNMG+8/ZnRtAIDsFFcEi56okCDGnh/mQI6z0i
 8iXz9chCi005NI1jtOqHiDPuAoVrMAFnllx0BiAl3fwWU688NW3zEp2wrCHaiU3peago
 F8aw==
X-Gm-Message-State: AOJu0Yy19rc+AV2O6MImOc6MpixluTRsGYL8amr7s77SyUgLOHyH1/xE
 CnjeYlR4uGJamf7iM6267EgL5lw66/+gavReUm478m5vXJuiaQtOEdA6Pzc6GO/9r2o=
X-Gm-Gg: ASbGncvKXGS/SfEcfwrkAEFmWb72ld498jfteCP0evBDzu4Bv+UQ0kUhQRzq6MFCbFE
 FcFyolCdhmk/ffXoKLA4dQ4e8MKxI1Ecp8JuwT9EOPsztP0CLNA10ydUBQv8JoVwAIJwMQZCrVv
 hRTrquTzVsctelDpkshdsWvqxrX1Cz8N1c/h+UrLd471hYrUVscn/ZAkHAhqpRyZrYAYCRaQLt3
 VXmtIsrVgwFfMVx1ePzkmPHcqdgsgaIT4bLmrFd5SJ7rtHBaDiyrPt8Q8MA4EhJWUcpGbEHM/WS
 NVtsuNYFQt+wnJAwyeicUIKFHSnDEbJiiz4U9NJH3nL8xugI4wpvBRlUcJylFjIVxFF4QqLp7bu
 95NpxAQzi8WT0PLxMs9e39Mc7a2vn+ZxJKiV0FZYj2n+AD57O3BzCD1KAD23FsTbZRqFfG/Uctr
 +8uOvCiZI9iA==
X-Google-Smtp-Source: AGHT+IGcByX1p0T9Rr3LwaDfn1hF94zAfGjUBQORdSJpQ6oP/DGFmeXCOHPAu8SjOJwvnAo4vG2RtA==
X-Received: by 2002:a05:600c:6487:b0:456:2a9:f815 with SMTP id
 5b1f17b1804b1-4587d857d16mr88970335e9.4.1753763729643; 
 Mon, 28 Jul 2025 21:35:29 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b782c46ef4sm8292936f8f.69.2025.07.28.21.35.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 21:35:29 -0700 (PDT)
Date: Mon, 28 Jul 2025 21:35:24 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com
Subject: Re: [PATCH v8 0/5] NXP DPAA2 driver enhancements and fixes
Message-ID: <20250728213524.1fc13730@hermes.local>
In-Reply-To: <20250702095144.3087250-1-g.singh@nxp.com>
References: <20250701042917.3000355-1-g.singh@nxp.com>
 <20250702095144.3087250-1-g.singh@nxp.com>
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

On Wed,  2 Jul 2025 15:21:39 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

> V1-logs:
> This patch series introduces enhancements and fixes to the
> NXP DPAA2 Ethernet driver.
> It includes support for
>  - software taildrop on ordered queues.
>  - setup speed capabilities.
>  - DPAA2 resource version.
>  - MAC level statistics.
>  - improve PA-VA conversion.
>  - add buffer pool depletion state configuration.
>  - fixes for shaper rate and buffer prepration.
> 
> V2-Changes:
>  - Fix compilation issue on UB2404-32
> 
> V3-Changes:
>  - Fix missing license information in fsl_dpmac.h
> 
> V4-Changes:
>  - Rebased the series to main branch top.
> 
> V5-Changes:
>  - Fix spelling error
> 
> V6-Changes:
>  - Remove new statistics and speed capabilities patches.
>  - added release notes
> 
> V7-Changes:
>  - Update taildrop packets drop logic.
> 
> V8-Changes:
>  - Remove DPBP depletion API patch
> 
> Gagandeep Singh (2):
>   net/dpaa2: fix shaper rate
>   net/dpaa2: enable software taildrop for ordered queues
> 
> Ioana Ciornei (1):
>   net/dpaa2: retrieve DPNI API version at init time
> 
> Jun Yang (2):
>   net/dpaa2: fix issue of extract buffer preparation
>   mempool/dpaa2: use unified VA to IOVA conversion
> 
>  .mailmap                                 |   1 +
>  doc/guides/rel_notes/release_25_07.rst   |   3 +
>  drivers/mempool/dpaa2/dpaa2_hw_mempool.c | 222 +++++++++++++++--------
>  drivers/net/dpaa2/dpaa2_ethdev.c         |  12 +-
>  drivers/net/dpaa2/dpaa2_ethdev.h         |   9 +-
>  drivers/net/dpaa2/dpaa2_rxtx.c           |  18 +-
>  drivers/net/dpaa2/dpaa2_tm.c             |  68 ++++---
>  7 files changed, 213 insertions(+), 120 deletions(-)
> 

Queued into next-net for 25.11
Release moved to the correct new release.
