Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC6EFD8FF4
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 19:25:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1011F4027F;
	Thu, 26 Feb 2026 20:25:56 +0100 (CET)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTP id 64DB2400D6
 for <dev@dpdk.org>; Thu, 26 Feb 2026 20:25:55 +0100 (CET)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-8c7199e7f79so156877185a.0
 for <dev@dpdk.org>; Thu, 26 Feb 2026 11:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772133955;
 x=1772738755; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kO1J1bxb4bhdYEiHXg2W0MhMtSP34jvRwS2xRQHY2Bs=;
 b=a1VqSmQEtWBD+HaTFQKSWKiIzoU6vtDhei+j++DReuMVz4ELjyCeQ7jrJKX4wwSMLD
 pJr0IklVoiJT7wKvE72LPZIZ9m4GQiU5WYPJ0XqKwWdQ0UaH2daUgTCxtzZKar+LMdpZ
 IAlAZCmtgAp1MpzcMt3L3S8G5c+J0dl1+yxNMNLFf70ISb49vHX18GfTNb+4Wh/108hZ
 CbR+ibDRF9MrVxUkXgu47HOpaSsU/VCrsdlwinXqncAI9c83QukGAYjCu5LzM59pjgid
 mVlLQxRH+O0T1DzhEhlNR5yIspGMwRDvHL7V2WqTiYQi3/c8dJdq7ESTzs/2GLIaHK/I
 rLhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772133955; x=1772738755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kO1J1bxb4bhdYEiHXg2W0MhMtSP34jvRwS2xRQHY2Bs=;
 b=LOnwr7q7kQeT0O7FPYcibEHMFWnPm4T2PIdkbUX24I131GVKo570M+HYgcdNnFmLvk
 b1yhdl2r1Fs5mtAntN8/Rs7HNgnqVe9sXD7GUMPalEdBHji/dpItMWXDxZkn7adu+O1z
 5DvBoa6ktXKzCiWoA5q609SLPG5GzqFFzcoEP33NRNI9Jyh2vpEEtjPECZmsgmA3bpzN
 tSbcmHyGtufeTkxbwrhnLvpyXMXNmyckLkUREmgdo6ATGdIRKUKtV3OKooIJyTyOpsjZ
 U72Di8Y3ecG4k/m62n3o/W8Pb+6RY/uSGVCQrKrPqNNCK5cKexXmnPRJAawZVFhoN5c4
 J3pQ==
X-Gm-Message-State: AOJu0YzjL0TX9jE1vcbkWIrnJRhESdNwYlTYyeIGeGBmkcU90V411MNJ
 vJeLlVWXnnkue6d9nSfirKYkpeUuKJMI10KofMyJKqM6EeNzq2+tz2Lfo4tWVNi2yp8=
X-Gm-Gg: ATEYQzzEEupN6pekKEYpFuFn+u7joL06oo1eiL/GXzpHwJxW043siYBCccR9kotNS2o
 Rpnx6hbpstdbVjieWEBYvrPsgNeMTVlBVr5b5ul8h2rcBD4RjNBVpTgrULL7WgrSNDNuSJqxBdo
 sgzaAZhKhIQeLOcwh4KOZKKPypPyY/Wvh+6ONdVeCELyGuDrkYJVIfHLPc3tJGmfgVsYTZ9+AS1
 FfKA3a7UxpP2WZzXfSixdPoayB85gDaaD21LzygHKT4159qzLz/+JJJFv7ivXzBw6Hq/LiFaE1j
 K+bRobuskqADHV8CDQErklhjXGmzIfNmB1B6wrXONU4yb4cGOIutug6uf7T/gTfAKQIyTUEbitu
 VNjGEhk2gAAIB8FWyvRUN/NsK3UKBVTW3qoiobe7gjbgSo5VKd9enMzvYo9oAOqGO5URfrpOcZ7
 1HBLX91sJEdzijFC7zwconGerWh9cE2PrSJ259bSJ0f9NDZfyI0UTAyoh5vCjaqv8/8YXWWKTtO
 WQ=
X-Received: by 2002:a05:620a:1a10:b0:8c6:af59:5e28 with SMTP id
 af79cd13be357-8cbc8d80dfcmr18614385a.22.1772133954603; 
 Thu, 26 Feb 2026 11:25:54 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf68a0fbsm274755885a.22.2026.02.26.11.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 11:25:54 -0800 (PST)
Date: Thu, 26 Feb 2026 11:25:51 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maxime Leroy <maxime@leroys.fr>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com, david.marchand@redhat.com
Subject: Re: [PATCH v2 00/17] net/dpaa2: fixes and improvements
Message-ID: <20260226112551.7ec09c50@phoenix.local>
In-Reply-To: <20260226143341.282188-1-maxime@leroys.fr>
References: <20260218160453.142311-1-maxime@leroys.fr>
 <20260226143341.282188-1-maxime@leroys.fr>
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

On Thu, 26 Feb 2026 15:33:24 +0100
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
>   net/dpaa2: fix rx error queue memory leaks
>   net/dpaa2: warn on rx descriptor limit only in high perf buffer mode
>   net/dpaa2: fix resource leak on softparser failure
>   net/dpaa2: fix link not up after port stop/start
>   bus/fslmc: fix devargs not propagated on hotplug
>   net/dpaa2: fix spurious VLAN insertion on non-VLAN packets
>   net/dpaa2: fix error packet dump crash and memory leak
>   net/dpaa2: fix L4 packet type classification in slow parse path
>   net/dpaa2: fix L3/L4 checksum offload flags
>   net/dpaa2: fix software taildrop buffer access
>   net/dpaa2: fix burst mode info to report active burst function
>   net/dpaa2: add SG table walk upper bound in Rx path
>   net/dpaa2: fix MAC stats DMA buffer allocation per xstats call
>   net/dpaa2: use CHECK_INTERVAL macro in set_link_down
>   net/dpaa2: add devargs to disable Rx taildrop
>   net/dpaa2: add devargs alternative for data stashing getenv
> 
>  drivers/bus/fslmc/fslmc_bus.c           |   4 +
>  drivers/bus/fslmc/portal/dpaa2_hw_pvt.h |  16 +-
>  drivers/net/dpaa2/dpaa2_ethdev.c        | 211 ++++++++++++------------
>  drivers/net/dpaa2/dpaa2_ethdev.h        |   3 +
>  drivers/net/dpaa2/dpaa2_rxtx.c          |  85 +++++-----
>  drivers/net/dpaa2/mc/fsl_dpni.h         |   6 +
>  6 files changed, 164 insertions(+), 161 deletions(-)
> 

Please fix the free bulk bug on Transmit and revise
patches so that check-git-log.sh does not complain so much.
