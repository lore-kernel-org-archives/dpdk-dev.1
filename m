Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FC210AB82B
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Mar 2026 22:43:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4215340297;
	Thu, 26 Mar 2026 23:43:01 +0100 (CET)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id 6A04540274
 for <dev@dpdk.org>; Thu, 26 Mar 2026 23:43:00 +0100 (CET)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-2c160cb021cso1590983eec.1
 for <dev@dpdk.org>; Thu, 26 Mar 2026 15:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774564979;
 x=1775169779; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k/MsGQzNmrs44rh8VFu9l5/WWe+DGiUc6U/suWoL+2Y=;
 b=e22Qvl2xeaplQQraPnTQeHBDCTh5oE8z9y4Af6NaJcGbKx1+rMzIXejhc8fOt+tfQi
 bL3OUk2ANODjO4fqGQUfybBcoVrx/S00tf/Jzd91Ke0qRsCdy5ACNyvQgwocjucSlIqO
 NxCes1V9eOVDrx3tdafIPqv6oPVNBFeQfBYt1P7w9mr9vs4YX5EgojMwXA9E8QFBiN4u
 ThGXyYTrpRlAU2TgjfxRbkU6k44H6ggoRFLcoQVIzccFHG9bWL1yZhfLnlc5GGo1SwJR
 gcGNt4BgO37J61gI3FjJexo5SqRziNDK3Or4qycMolL82d5hnoxDzqWZ9OfGHl9hlILC
 Z3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774564979; x=1775169779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k/MsGQzNmrs44rh8VFu9l5/WWe+DGiUc6U/suWoL+2Y=;
 b=bfQdosMGm0/KpO6LYAKCE6UyiOZHE8QACO/o5ilHj0kZCzMu949OhYkKY+u06CvWxr
 y6Fgu3yASljHDGYLXx2C/NB9Rq+Xwk1dRXuJwOgHfp0NadObSTO92Cm3ECb6mGx0oydO
 ihRtCYN1fi6c4H+L/eap2hfuVj/7nLGg5cUcFMkdyxw3bkBodAWocTg3IMfdu/asDdSM
 qzQMjTmfuQppe2aMcHCwHPCLjcbKNPThjWp+lbYVNZBIpIixqGx/p/r/MmCqUyZ5hHd4
 jGNMZzVMkgBO5iqmiUOo2pEHdBbjsOa0ZdDXkmxamJ7jDx6mZqvsuErJpT+I16I/xyzK
 pBmQ==
X-Gm-Message-State: AOJu0Yye8DOLlD4g9ZqVBgIikDlNzldPOPYzADhc4O1w9jp4ADFf9C/M
 Jndb7mWDy7GAvJDKaKHWxViibmyUcuylhApWdmKTGSdA9A7YgWFE1D8qbO/KZ46u9IY=
X-Gm-Gg: ATEYQzy0IIgIH/6mm0kkWMXqmyN0nwHSUMsAijJ4IYAqbfAi3B9nV4BWxYfDXVx95Yz
 aBiBuWCSkL+vJz2Ch2PMfxP5mQEjQmepNiu+93NY5Y0ONTMrOi9ulU16k4KvTp9q4IfDTavC+OB
 nL/TTtjaeQndOtugsy5/uNZC6ivXIQaSQ/rwiZ8/p+uPek/TP0+kQ0ZRx66ca8LYVRZk9+H49yR
 z4WjVHJYpQn0o5ypldvrEY5xUDZdZLSE+lre3YJSBq4vFH3K6jexOMdpZQJp+k9KHPCUjIr0qZj
 bDzvh5dkyLAdEDnLaPe58SDaMeDV3FBCjDDC+r8d+wx0ndSTDcNWYGzU5naEWf87VDIfzPFKtWo
 PidgxXhY9fSODEtdHxEZFtKPa7AfT/Yfx8+8707SRcEWYyuBSYLK3dNGbv9dDfFohjJT25N+5qW
 +uLtIczuhVdsdEWTEO3RuZC5dOtATs6jfd/lg=
X-Received: by 2002:a05:7300:6da5:b0:2be:2043:614b with SMTP id
 5a478bee46e88-2c185e1295bmr174348eec.18.1774564979144; 
 Thu, 26 Mar 2026 15:42:59 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c16ee01674sm4111743eec.27.2026.03.26.15.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 15:42:58 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:42:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maxime Leroy <maxime@leroys.fr>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com
Subject: Re: [PATCH v4 00/17] net/dpaa2: fixes and improvements
Message-ID: <20260326154254.4fc7562f@phoenix.local>
In-Reply-To: <20260325204544.101444-1-maxime@leroys.fr>
References: <20260306133035.179709-1-maxime@leroys.fr>
 <20260325204544.101444-1-maxime@leroys.fr>
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

On Wed, 25 Mar 2026 21:45:27 +0100
Maxime Leroy <maxime@leroys.fr> wrote:

> Various fixes and improvements for the dpaa2 net driver and fslmc bus.
> 
> Patches 1-6 fix resource leaks on port close, error paths, link status
> and devargs propagation on hotplug.
> 
> Patches 7-14 fix additional bugs: spurious VLAN insertion, error packet
> dump crash, packet type classification, checksum offload flags, software
> taildrop buffer access, burst mode info reporting, SG table walk bounds,
> and MAC stats DMA allocation.
> 
> Patch 15 is a minor cleanup in the link status area.
> 
> Patches 16-17 add devargs alternatives for getenv-based configuration
> of taildrop and data stashing options.
> 
> Changes since v3:
> - Patch 3: rename DPNI_OPT_HIGH_PERF_BUFFER to DPNI_OPT_V1_PFDR_IN_PEB,
>   rename MAX_NB_RX_DESC to MAX_NB_RX_DESC_IN_PEB, keep total_nb_rx_desc
>   calculation unconditional and only guard the warning, update warning
>   messages to suggest removing the option or reducing descriptors (Hemant)
> 
> Changes since v2:
> - Fix checkpatch warnings: short SHA in Fixes tag (patch 14),
>   long line in commit message (patch 10)
> - Fix check-git-log warnings: shorten headlines (patches 3, 9, 12, 14),
>   fix tag order Fixes/Cc (patches 10, 11), fix wrong Fixes reference
>   (patch 8), remove colon after function name in commit body (patch 8),
>   lowercase macro name in headline (patch 15)
> 
> Changes since v1:
> - Add Cc: stable@dpdk.org on patches with Fixes: tags (Stephen)
> - Reorder series: fixes first, then improvements (Stephen)
> - Patch 2: squash with former patch 4 (Hemant)
> - Patch 6: move devargs refresh from plug to scan rescan path (David)
> - Patch 17: keep getenv for backward compatibility, add devargs as
>   alternative instead of replacement
> - Drop former patch 11 (bus/fslmc: remove dead blocklist check) to
>   avoid disaligning with other buses (David)
> - New patches 8, 11-14 fixing issues reported by Stephen
> - New patches 7, 9-10 fixing VLAN insertion and packet classification
>   issues
> 
> Maxime Leroy (17):
>   net/dpaa2: fix queue block memory leak on port close
>   net/dpaa2: fix Rx error queue memory leaks
>   net/dpaa2: warn on Rx descriptor limit in high perf mode
>   net/dpaa2: fix resource leak on softparser failure
>   net/dpaa2: fix link not up after port stop/start
>   bus/fslmc: fix devargs not propagated on hotplug
>   net/dpaa2: fix spurious VLAN insertion on non-VLAN packets
>   net/dpaa2: fix error packet dump crash and memory leak
>   net/dpaa2: fix L4 packet type in slow parse path
>   net/dpaa2: fix L3/L4 checksum offload flags
>   net/dpaa2: fix software taildrop buffer access
>   net/dpaa2: fix burst mode info report
>   net/dpaa2: add SG table walk upper bound in Rx path
>   net/dpaa2: fix MAC stats DMA alloc per xstats call
>   net/dpaa2: use check interval macro in link down path
>   net/dpaa2: add devargs to disable Rx taildrop
>   net/dpaa2: add devargs alternative for data stashing getenv
> 
>  drivers/bus/fslmc/fslmc_bus.c           |   4 +
>  drivers/bus/fslmc/portal/dpaa2_hw_pvt.h |  16 +-
>  drivers/net/dpaa2/dpaa2_ethdev.c        | 210 ++++++++++++------------
>  drivers/net/dpaa2/dpaa2_ethdev.h        |   3 +
>  drivers/net/dpaa2/dpaa2_rxtx.c          |  85 +++++-----
>  drivers/net/dpaa2/mc/fsl_dpni.h         |   6 +
>  6 files changed, 164 insertions(+), 160 deletions(-)
> 

Review was clean. Added to next-net
