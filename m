Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB0FC5CFC1
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 20:31:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 027354025F;
	Tue, 11 Aug 2026 22:31:13 +0200 (CEST)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mails.dpdk.org (Postfix) with ESMTP id 34C984021E
 for <dev@dpdk.org>; Tue, 11 Aug 2026 22:31:11 +0200 (CEST)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-c9cf07d2df6so124320a12.2
 for <dev@dpdk.org>; Tue, 11 Aug 2026 13:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786480270;
 x=1787085070; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FBd3Wm9c8owIGXXRjws3VozLHnwkhzjjX+BQMWnepiY=;
 b=C+3GLRCPCK3NUaCELvmxfrvHQp/sIMata0RF0xrQPmvi50JtYTXnGgxcEhk85s/QCS
 JK3kg/gkBHBoyq8XKHqwuKtyHV38JOe+clLXJD5r5VQSl3dAnwhLtJLKPxAUGMWU14zo
 Z5HEWlkA5hwFQBTnVu9KMlBp7oATVHo+jQywU5qlITmMQswY8FzH/ej8zAiZ1WfrHvW8
 WsSKMftKeIC82qOzRcSVb7X1aa8BTC9DkuLgfP+B2YFz8enIf1KHZDQiXdkYd20dyyWt
 CmzcchvbqZSQVKozIaJpSDqXdHKIpbpFZYw+DuBcZCrNJ401IxddRSVD9enPF9sPRtwq
 w+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786480270; x=1787085070;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FBd3Wm9c8owIGXXRjws3VozLHnwkhzjjX+BQMWnepiY=;
 b=jSgmBK3NmxGLvM1blhvJo4o97xVQ/7qKnzz8UaaSaEukZDuj/XsGqT7+9kFL9s1FW4
 KjciulgmFO5Y/D7dVuUBLrDVUzERueJjw57HDEezgz2rqQZ0eM5X49rzKuFcf8XpOwTV
 rwSRT4hOl6BP7ENtCZXw74mSzMTiiwOP7+UxZIS37hDE4P2cQr+EpTdWdEBWmswVByGt
 5q15ZdbuRZZ33t1vvWA3iLt5MOWDrZEebiTbmJJDFxsJSYgBMx+8oYvUmW9MK+0c0Des
 1PKbbM+/AC2CkqPlWeDmFtXAN8oRKIKUsd7+VszDyQPE/fFU1jFGs4NZseLoNjqzKilI
 8Cxw==
X-Gm-Message-State: AOJu0YwXmWVVzCo8j/nf4XXrlfROvwsvrtBQje28c3XNoTGgzhyKEIjg
 +ydrW1+KQM7x4wFdjJI4dsPqaXLv/gtgmHGhzCyMFlQBv0uLASYwvbDSujIZxU88B4U=
X-Gm-Gg: AR+sD10ohVBbW1WUSGGzUSXelyXiQNddQEB9NVYbCwtNurE3NpFUHSZm7IOEkEdoq8b
 9sRqH7F9RaLMUenf9L3o3KhypCsTarrMLMOQeW2JWlxPrqgc0MBNodvP1YOJkVTIWf5ZnmLaDf2
 mLe+FFOnG2ZTJw9WfHFJ7N0NJTqHQgd6EeEreB5EI7ZxUw0jKTT9p4DbH1yWsSCx5pD20uKmpio
 Ng9ODa0ajSIU8/SudPARo7blZfpqLLXXSKDFzYjBONrvUJYu0LHVYjueqG/MVYbUfkKePR82uRa
 v+3tkCxtgL2ZTs+JFOJ2ev3OIx3q4gNrrfo8PT6SUm6YZgTQM9aQLsovRmBXNnq0u3Q+jDbM6TK
 /34vDGKoJKO7l45Ij0+9hqDPpcdnPi5BVqeAHeJY9BJJvK04Ka62wpvvEuxSnqeMSCHLxbwhCfZ
 1x38eZMHwUkK+YIHgcUom5P2MFX8KyqZvJBSDi/xJ7kO79Qa7pQ/UoNDBUA0I4MOTDRFBtOYHiw
 L+CtF9O4cUuVs1kE4SUa8quGhD4YhG+uvMAnJ++
X-Received: by 2002:a05:6a20:be8f:b0:3c4:397a:69ba with SMTP id
 adf61e73a8af0-3cc37e09a7cmr3394137637.28.1786480269780; 
 Tue, 11 Aug 2026 13:31:09 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31cf36249f7sm2789157eec.2.2026.08.11.13.31.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 13:31:09 -0700 (PDT)
Date: Tue, 11 Aug 2026 13:31:06 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: dev@dpdk.org, Andy Moreton <andy.moreton@amd.com>, Viacheslav
 Galaktionov <viacheslav.galaktionov@arknetworks.am>, Roman Zhukov
 <Roman.Zhukov@arknetworks.am>, Pieter Jansen van Vuuren
 <pieter.jansen-van-vuuren@amd.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH 0/3] common/sfc_efx/base: add VADAPTER statistics for
 Medford4
Message-ID: <20260811133106.3d9674c6@phoenix.local>
In-Reply-To: <20260811174949.8993-1-ivan.malov@arknetworks.am>
References: <20260811174949.8993-1-ivan.malov@arknetworks.am>
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

On Tue, 11 Aug 2026 21:49:46 +0400
Ivan Malov <ivan.malov@arknetworks.am> wrote:

> This series adds support for per-VF (VADAPTER) MAC
> statistics on Medford4 in the libefx base layer.
> 
> The first patch selectively updates the MCDI headers, adding
> new definitions needed by the subsequent patches.
> 
> The second patch introduces netport VADAPTER statistics IDs,
> which identify the per-VF counter set returned by the NIC.
> 
> The third patch switches the netport statistics call to use
> GET_NETPORT_STATISTICS_V2, passing the EVB port handle so
> that the correct per-VF counters are retrieved.
> 
> Andy Moreton (2):
>   common/sfc_efx/base: add support for VADAPTER statistics IDs
>   common/sfc_efx/base: switch netport stats to use EVB port ID
> 
> Ivan Malov (1):
>   common/sfc_efx/base: update MCDI headers
> 
>  drivers/common/sfc_efx/base/efx_impl.h      |   3 +-
>  drivers/common/sfc_efx/base/efx_mcdi.c      |   2 +-
>  drivers/common/sfc_efx/base/efx_np.c        |  60 +++-
>  drivers/common/sfc_efx/base/efx_regs_mcdi.h | 313 +++++++++++++++++++-
>  drivers/common/sfc_efx/base/medford4_mac.c  |  12 +-
>  5 files changed, 373 insertions(+), 17 deletions(-)
> 

Detailed AI review had info level comments only.

Reviewed the series against upstream (applied cleanly with git am).

Patch 1 is generated MCDI header import, no review comments.

Patch 2/3 verification notes:

- All five efx_np_mac_stats() call sites are updated for the new
  argument order (efx_mcdi.c:2251, medford4_mac.c:175/198/201/205).
  The parameter count changed from 5 to 6, so a missed caller would
  be a compile error rather than a silent type-compatible swap.

- EFX_MCDI_DECLARE_BUF() was correctly bumped to V2_IN_LEN alongside
  emr_in_length, so the new PORT_ID write at offset 20 is in bounds.

- MC_CMD_GET_NETPORT_STATISTICS_V2_IN is a strict superset of V1:
  PORT_HANDLE/CMD/DMA_ADDR/DMA_LEN are at identical offsets, only
  PORT_ID at 20 is new.

- The new VADAPTER entries in efx_np_mac_stat_map[] land before the
  FEC entries in efx_mac_stat_t, so the array size is unchanged, and
  the map is only consulted to translate descriptors the FW actually
  reports, so the addition is inert on FW without vadapter stats.
  efx_mac.c already has the matching name strings, and
  medford4_mac_stats_get_mask() derives the mask from the LUT, so the
  counters surface automatically.

Info

Patch 2:

- EFX_NP_HW_STAT_ID() shifts the index by
  MC_CMD_STAT_ID_MAC_STAT_ID_LBN regardless of the source argument.
  This is correct today only because MAC/PHY/VADAPTER_STAT_ID_LBN are
  all 16. Using MC_CMD_STAT_ID_##_src##_STAT_ID_LBN would make the
  macro self-consistent. Pre-existing (the PHY variant has the same
  shape), so no need to fix here unless you are touching it anyway.

Patch 3:

- The request mixes V1 and V2 field names: PORT_HANDLE, CMD,
  DMA_ADDR_LO/HI and DMA_LEN still use the
  GET_NETPORT_STATISTICS_IN_* names while the length and PORT_ID use
  GET_NETPORT_STATISTICS_V2_IN_*. The offsets are identical so this
  is functionally correct, but naming all fields V2 would make it
  obvious at a glance which msgrequest is being sent.

- The V2 request length is now used unconditionally, with no
  capability check or V1 fallback. If any shipping Medford4 firmware
  implements only the 20-byte GET_NETPORT_STATISTICS_IN msgrequest,
  it will reject the 24-byte request and MAC stats break entirely,
  not just the vadapter counters. Is V2 guaranteed present in every
  FW build that advertises netport support? efx_np_mac_ctrl() already
  makes the same unconditional assumption with MAC_CTRL_IN_V2, so I
  suspect the answer is yes and there is a documented FW baseline --
  worth a line in the commit message either way.
