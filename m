Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C30C3ABA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Apr 2025 15:07:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A1DB402A3;
	Tue, 29 Apr 2025 17:07:03 +0200 (CEST)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mails.dpdk.org (Postfix) with ESMTP id 3B5DB40277
 for <dev@dpdk.org>; Tue, 29 Apr 2025 17:07:02 +0200 (CEST)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-af91fc1fa90so5574515a12.0
 for <dev@dpdk.org>; Tue, 29 Apr 2025 08:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1745939221;
 x=1746544021; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qO4FBBIArLLVVLO1j7UOvCFOfLVWy76N+wOgcfrYcRE=;
 b=W90kRwkF4G3QpXOnjdenpGpzUfFD5OCUIWq9rknYdO7gVuhSGD4L0UQAD0ASpyMPtb
 qZC9IT/VgB7YSHa0T7ycSP/EO/B/A3wLrLeOUsWKD+RFFAUIpFrdLIv+4NpAHEG+5G/V
 sdaKe9k3urhhgiaQxDQtVDWccdosn8fvgaNpSKZebruYk+oPRuebpohVar53Pc231viJ
 USusbH6Uqo7VJdJxC/0l1WJnsaqVvVK2mdWSpV2PbpVP4v/XekDYM+jhncfX0Mb/GvKY
 X9cxPlEe9hdTML3tSpMVXUmz6XO1Gp2s7yVVW9b9cDYfyL5qJap3c/R27P6MN6oGwl8A
 0skA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745939221; x=1746544021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qO4FBBIArLLVVLO1j7UOvCFOfLVWy76N+wOgcfrYcRE=;
 b=tQQv56MhJmxJugFPsvyqJLfTkRdnAc/hzmNThfU352x2uaeI38AcuXjY7WdHMgOD5e
 ZxqVu8ugmr1wZGLLU416ONc3QWY3ZNrbHABmMkKPTgRRz6X0reCHlFRUUIKFYUPkU1RL
 6Y7FeIBEku8ZfcJokru+lSJwXSmoafiyBB2tgakWIIVjEQL3ET4Izgp/NCJc/hd6ZuTj
 xLdUvPsICg/8kLFJau39VdY5ahJveeXZivfzxEnzp1OrV07ylCMWp0bZTt0wbGYsF/Vg
 9fKglyTKtCPWc88j9gFjmAUp1d1blnLgiawuNyHyMjrmBjWPo2f2xMkIto84G/AcupBp
 YC0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5s1z0YMlRIHUOfh28BRNNgjepCxV7mCnoTvHUv+YlRJIxwmdyt4G/lVGGYbjpUDx/jH4=@dpdk.org
X-Gm-Message-State: AOJu0YytJZsCoiBMraEjHD8rsAjee9GukECe0vhOLkDcY7xBcwxJJf/j
 IwZNuAGHwCRi6v/yCmt6V8aSoTzWa9U6dmLlmhE+3mj2M7FP3Jz1mgeajMvzW9w=
X-Gm-Gg: ASbGncuk1pWP/+7hsfqAudZvf4gMxyM0xTN7E0MuD2t/oQe5DcMQd02ymnj7UKomkDG
 n/Lpt0Swdngh8VPZGCX8wSmN2eMbOrVANVQtlg+HC8P/QeG7Ckz/y3ztxwsDg5i4LGsl2vXb+o2
 du7KFDbR0Ez0Onlkdaik2hAXwas0jg/kjVuTq4pdbWeUbTY0eydWn4znCrbyxA/evI+e8Dzgcbk
 eANILD+edFfnH+NJOY68Axm66FLQplHcCQy/PNdI5SKNeWA/syDuJEO0QB3V6ZRmNqhcl9bbMao
 vr23oQZ/ULgMoLT9cBaz5j4KnXe984EbpQUXcFZK2G8WN4GzmfBqay2CGQlmj5mi2GvQvz6iTfn
 Hdr1gkYlt4IqrftfN
X-Google-Smtp-Source: AGHT+IFvHTArVzByJ16VVkS1KmlCy24i64gzaZgggdms8waa0fd41I4UD3iLwmv7vErumekivBpyPg==
X-Received: by 2002:a17:90a:c2c7:b0:309:e351:2e3d with SMTP id
 98e67ed59e1d1-30a23dd992dmr5441599a91.12.1745939221172; 
 Tue, 29 Apr 2025 08:07:01 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db51026dfsm103939125ad.170.2025.04.29.08.07.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 08:07:00 -0700 (PDT)
Date: Tue, 29 Apr 2025 08:06:59 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: <kirankumark@marvell.com>
Cc: Aman Singh <aman.deep.singh@intel.com>, Thomas Monjalon
 <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>, Andrew
 Rybchenko <andrew.rybchenko@oktetlabs.ru>, <dev@dpdk.org>
Subject: Re: [PATCH v2 1/2] ethdev: support RSS based on RoCEv2 header
Message-ID: <20250429080659.2ff24ee8@hermes.local>
In-Reply-To: <20250429095242.1861885-1-kirankumark@marvell.com>
References: <20250422051459.661395-1-kirankumark@marvell.com>
 <20250429095242.1861885-1-kirankumark@marvell.com>
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

On Tue, 29 Apr 2025 15:22:41 +0530
<kirankumark@marvell.com> wrote:

> diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
> index e89af21cec..444e4b0388 100644
> --- a/app/test-pmd/config.c
> +++ b/app/test-pmd/config.c
> @@ -89,67 +89,69 @@ static const struct {
>  
>  const struct rss_type_info rss_type_table[] = {
>  	/* Group types */
> -	{ "all", RTE_ETH_RSS_ETH | RTE_ETH_RSS_VLAN | RTE_ETH_RSS_IP | RTE_ETH_RSS_TCP |
> -		RTE_ETH_RSS_UDP | RTE_ETH_RSS_SCTP | RTE_ETH_RSS_L2_PAYLOAD |
> -		RTE_ETH_RSS_L2TPV3 | RTE_ETH_RSS_ESP | RTE_ETH_RSS_AH | RTE_ETH_RSS_PFCP |
> -		RTE_ETH_RSS_GTPU | RTE_ETH_RSS_ECPRI | RTE_ETH_RSS_MPLS | RTE_ETH_RSS_L2TPV2},
> -	{ "none", 0 },
> -	{ "ip", RTE_ETH_RSS_IP },
> -	{ "udp", RTE_ETH_RSS_UDP },
> -	{ "tcp", RTE_ETH_RSS_TCP },
> -	{ "sctp", RTE_ETH_RSS_SCTP },
> -	{ "tunnel", RTE_ETH_RSS_TUNNEL },
> -	{ "vlan", RTE_ETH_RSS_VLAN },
> +	{"all", RTE_ETH_RSS_ETH | RTE_ETH_RSS_VLAN | RTE_ETH_RSS_IP | RTE_ETH_RSS_TCP |
> +			RTE_ETH_RSS_UDP | RTE_ETH_RSS_SCTP | RTE_ETH_RSS_L2_PAYLOAD |
> +			RTE_ETH_RSS_L2TPV3 | RTE_ETH_RSS_ESP | RTE_ETH_RSS_AH | RTE_ETH_RSS_PFCP |
> +			RTE_ETH_RSS_GTPU | RTE_ETH_RSS_ECPRI | RTE_ETH_RSS_MPLS |
> +			RTE_ETH_RSS_L2TPV2 | RTE_ETH_RSS_IB_BTH},
> +	{"none", 0},
> +	{"ip", RTE_ETH_RSS_IP},
> +	{"udp", RTE_ETH_RSS_UDP},
> +	{"tcp", RTE_ETH_RSS_TCP},
> +	{"sctp", RTE_ETH_RSS_SCTP},
> +	{"tunnel", RTE_ETH_RSS_TUNNEL},
> +	{"vlan", RTE_ETH_RSS_VLAN},

Why so many changes here. the format was better before with space after the {.

> diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
> index 093b85d206..1b8ba5ab90 100644
> --- a/doc/guides/rel_notes/release_25_07.rst
> +++ b/doc/guides/rel_notes/release_25_07.rst
> @@ -24,36 +24,10 @@ DPDK Release 25.07
>  New Features
>  ------------
>  
> -.. This section should contain new features added in this release.
> -   Sample format:
> +* **Added new RSS offload types for IB_BTH in RSS flow.**
>  
> -   * **Add a title in the past tense with a full stop.**
> -
> -     Add a short 1-2 sentence description in the past tense.
> -     The description should be enough to allow someone scanning
> -     the release notes to understand the new feature.
> -
> -     If the feature adds a lot of sub-features you can use a bullet list
> -     like this:
> -
> -     * Added feature foo to do something.
> -     * Enhanced feature bar to do something else.
> -
> -     Refer to the previous release notes for examples.
> -
> -     Suggested order in release notes items:
> -     * Core libs (EAL, mempool, ring, mbuf, buses)
> -     * Device abstraction libs and PMDs (ordered alphabetically by vendor name)
> -       - ethdev (lib, PMDs)
> -       - cryptodev (lib, PMDs)
> -       - eventdev (lib, PMDs)
> -       - etc
> -     * Other libs
> -     * Apps, Examples, Tools (if significant)
> -
> -     This section is a comment. Do not overwrite or remove it.
> -     Also, make sure to start the actual text at the margin.
> -     =======================================================
> +  Added ``RTE_ETH_RSS_IB_BTH`` macro so that the IB BTH header can be used as
> +  input set for RSS.


The current practice in DPDK is to leave the release note template stuff in place
until the final steps of the release process.

Also could be one line description.

> diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
> index ea7f8c4a1a..3f5317c489 100644
> --- a/lib/ethdev/rte_ethdev.h
> +++ b/lib/ethdev/rte_ethdev.h
> @@ -602,6 +602,7 @@ struct rte_eth_rss_conf {
>  
>  #define RTE_ETH_RSS_L2TPV2             RTE_BIT64(36)
>  #define RTE_ETH_RSS_IPV6_FLOW_LABEL    RTE_BIT64(37)
> +#define RTE_ETH_RSS_IB_BTH RTE_BIT64(38)

Since other related RSS options are indented with spaces, this should be as well.

The golden rules of patches: change as little as possible, and make the new
code look code look the same as the original.
