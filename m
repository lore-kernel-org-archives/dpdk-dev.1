Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BBAC5B549
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 21:58:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 214CD4026C;
	Wed,  4 Jun 2025 23:58:48 +0200 (CEST)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by mails.dpdk.org (Postfix) with ESMTP id D7C644025D
 for <dev@dpdk.org>; Wed,  4 Jun 2025 23:58:46 +0200 (CEST)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-7d2107eb668so55030885a.1
 for <dev@dpdk.org>; Wed, 04 Jun 2025 14:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749074326;
 x=1749679126; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2hWnd/jclFzsIIWfUioUgrZeeQwiQc+kPNUg0II0w9M=;
 b=uxALtc1y2oKPBzHS8gQ7IFtIqzJRh2pb5fnI6KsYmK91lnuCDvEReo7Dc6C0ueblMX
 oE1bnDpN3L6g3uRM2EpRauwUE6EdxUTZGWJOIEXAqJmLo9Q9YK4Ph+1kaXoaNhuu0Pq8
 OF+1BHgtcZ1E1PeINugt/YGHqYbKIzFWyR91UQsLHOM6/DO7oiF3KbVlI3Kseji17DIY
 Mjkcc+80gBjHAq9RhOEv2Y3oCuPt1HcQVnAJSQt8LnRCgdpyhjfbPJ3W2i2P0Fp1/Jc3
 tCydze6z7B0UZ/4ymV5p2FRzCQfnaAMUh437YkG8GxLA8WLstZejqjxlOUs4zLcdJP/o
 gkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749074326; x=1749679126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2hWnd/jclFzsIIWfUioUgrZeeQwiQc+kPNUg0II0w9M=;
 b=B8mjh1N/5jfK0PmxHFHwKBgKrUW25N9aitzXlEZ4WOrPZ94CPvV1xY0dMNeEozT8Sr
 yayS0TmY/nrD2L6IPirWt/9983u9fyP+36Kd2K0GNbnfStHiOMBlhm4S12NanAj1wieD
 R/3R/0IHGT6GIlWfrbUqwGfFjIeM3SlHzWz4Aky1tW/N9THbdcrr9ZVWcEXLKpemy9SJ
 vd9xNDz38712RRHKRdXcpz9IqJp9MCborBUJ0FkS3wN1Zt3UpsAhxa/c0qgsxh/6h5cA
 LGGv0asTWpifxSvcPtRSi6bYaG7s1jAHl1tn/fAZvzcBQ3HlwrzHJ64hf3ogspo557sG
 +qDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCULg2QUcBanq3unUGLodTKbeVpOaBWWQvq9NkpHic/JMY4foggRUyDhgXnYK4UpcfeIwfo=@dpdk.org
X-Gm-Message-State: AOJu0YxTce4ot0WUJ01GD9nTmeLjxPoz1JB9ymjk/+ewTCdkirFXiL1d
 Ui6MuBfys9b5bMbp+YBshuTKx4iSI3IezKH5rPAKuns3JpNiu11CBLvbKsp/1cIJD2o=
X-Gm-Gg: ASbGncuTq1bliYEBshsC12M13x2Ng9O+JohegUEKUV7UNZ69JB/Y0QqQkq9/IgeEfVi
 28vUyfjgGwTK8WzkYHMjPJ1lcwqV2iWWHJZd4FedyXB4pt3mVhKEDdLFN97DQxjARkoOpIU8Ao9
 h5yDBthO3d4M67upBNd1UgwhDnQrB47ir2R5WPS5CUzeF0QPc5g3p1vWIinbXpjyhdfx425deOh
 7J4/w0tak60w17HvGcDtptYKY6T3isXg5DkFOl7SP5K0VM217MGYJCXum+MLAoiJO4+3b0p9LFJ
 zp5o7Mge7PNGoYLnE9on4m6AeAN/Muhz55h7ykD5BXXp5czMmw7q2b24c0EqD2pgWIm+/MYlLpc
 WNskUpXoHW+N0E9YYZ2ZWw4Y8ZOTn
X-Google-Smtp-Source: AGHT+IH6gWP8flxyGHyksEVlGyTE48IYawXENpS9rdHPBayMg1i/zUTA20E/drjfyMh72NL6k7E/sw==
X-Received: by 2002:a05:620a:4055:b0:7c5:9993:ba7e with SMTP id
 af79cd13be357-7d2198ef377mr667255185a.50.1749074326056; 
 Wed, 04 Jun 2025 14:58:46 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fac6e1a746sm106971056d6.97.2025.06.04.14.58.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 14:58:45 -0700 (PDT)
Date: Wed, 4 Jun 2025 13:23:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: <kirankumark@marvell.com>
Cc: Aman Singh <aman.deep.singh@intel.com>, Thomas Monjalon
 <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>, Andrew
 Rybchenko <andrew.rybchenko@oktetlabs.ru>, <dev@dpdk.org>
Subject: Re: [PATCH v9 1/2] ethdev: support RSS based on RoCEv2 header
Message-ID: <20250604132311.4c847ada@hermes.local>
In-Reply-To: <20250529154343.1589903-1-kirankumark@marvell.com>
References: <20250529153908.1571050-1-kirankumark@marvell.com>
 <20250529154343.1589903-1-kirankumark@marvell.com>
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

On Thu, 29 May 2025 21:13:42 +0530
<kirankumark@marvell.com> wrote:

> From: Kiran Kumar K <kirankumark@marvell.com>
> 
> On supporting hardware, RoCEv2 header can be used to
> perform RSS in the ingress path.
> 
> Signed-off-by: Kiran Kumar K <kirankumark@marvell.com>
> ---
> V9 Changes:
> * Fix checkpatch warnings.
> V8 Changes:
> * Fixed doc
> V7 Changes;
> * Addressed review comments related to rss_type_table.
>  app/test-pmd/config.c                  | 4 +++-
>  doc/guides/rel_notes/release_25_07.rst | 5 +++++
>  lib/ethdev/rte_ethdev.h                | 2 ++
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
> index e89af21cec..26fd920a36 100644
> --- a/app/test-pmd/config.c
> +++ b/app/test-pmd/config.c
> @@ -92,7 +92,8 @@ const struct rss_type_info rss_type_table[] = {
>  	{ "all", RTE_ETH_RSS_ETH | RTE_ETH_RSS_VLAN | RTE_ETH_RSS_IP | RTE_ETH_RSS_TCP |
>  		RTE_ETH_RSS_UDP | RTE_ETH_RSS_SCTP | RTE_ETH_RSS_L2_PAYLOAD |
>  		RTE_ETH_RSS_L2TPV3 | RTE_ETH_RSS_ESP | RTE_ETH_RSS_AH | RTE_ETH_RSS_PFCP |
> -		RTE_ETH_RSS_GTPU | RTE_ETH_RSS_ECPRI | RTE_ETH_RSS_MPLS | RTE_ETH_RSS_L2TPV2},
> +		RTE_ETH_RSS_GTPU | RTE_ETH_RSS_ECPRI | RTE_ETH_RSS_MPLS | RTE_ETH_RSS_L2TPV2 |
> +		RTE_ETH_RSS_IB_BTH},
>  	{ "none", 0 },
>  	{ "ip", RTE_ETH_RSS_IP },
>  	{ "udp", RTE_ETH_RSS_UDP },
> @@ -149,6 +150,7 @@ const struct rss_type_info rss_type_table[] = {
>  	{ "l3-dst-only", RTE_ETH_RSS_L3_DST_ONLY },
>  	{ "l3-src-only", RTE_ETH_RSS_L3_SRC_ONLY },
>  	{ "ipv6-flow-label", RTE_ETH_RSS_IPV6_FLOW_LABEL },
> +	{ "ib-bth", RTE_ETH_RSS_IB_BTH },
>  	{ NULL, 0},
>  };
> 
> diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
> index 6b070801de..9a3677f972 100644
> --- a/doc/guides/rel_notes/release_25_07.rst
> +++ b/doc/guides/rel_notes/release_25_07.rst
> @@ -55,6 +55,11 @@ New Features
>       Also, make sure to start the actual text at the margin.
>       =======================================================
> 
> +* **Added new RSS offload types for IB_BTH in RSS flow.**
> +
> +  Added ``RTE_ETH_RSS_IB_BTH`` macro so that the RoCE Infiniband base transport header
> +  can be used as input set for RSS.
> +
>  * **Added burst mode query function to Intel drivers.**
> 
>    Added support for Rx and Tx burst mode query to the following drivers:
> diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
> index ea7f8c4a1a..8e0c89581e 100644
> --- a/lib/ethdev/rte_ethdev.h
> +++ b/lib/ethdev/rte_ethdev.h
> @@ -602,6 +602,8 @@ struct rte_eth_rss_conf {
> 
>  #define RTE_ETH_RSS_L2TPV2             RTE_BIT64(36)
>  #define RTE_ETH_RSS_IPV6_FLOW_LABEL    RTE_BIT64(37)
> +/** RoCE InfiniBand Base Transport Header */
> +#define RTE_ETH_RSS_IB_BTH RTE_BIT64(38)
> 
>  /*
>   * We use the following macros to combine with above RTE_ETH_RSS_* for
> --
> 2.48.1
> 

Applied with some rebasing and whitespace fixes to next-net.
