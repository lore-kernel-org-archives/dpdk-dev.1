Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B77BCA0EE0
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 15:04:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B687A40657;
	Wed, 13 Aug 2025 17:04:46 +0200 (CEST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id 1BA4440265
 for <dev@dpdk.org>; Wed, 13 Aug 2025 17:04:44 +0200 (CEST)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-459e7ea3ebeso26410775e9.0
 for <dev@dpdk.org>; Wed, 13 Aug 2025 08:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755097484;
 x=1755702284; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PoCYYMDm5xsDKsqDWqkyOiebYLVPvMGl9JrTl6ToBoQ=;
 b=BWMuZiNe5UZtp2tzCmR93IqvwQj8zosSgvloVIFRmba/CxremNLwZyTLDLMclzqGVP
 oit6n/MWJAPhWqTwCMsVSnlqSXmKh1AsziLdemzzOwyNnMj9kCj7x3kJCwau8d2rRar0
 ewxCvO/ivP3ULvw5V8Ns2+jfGhL+pCUNo50i7siIaABheiNUr23pHhpNM84NhmEzlzjz
 IVDqjegWPlWGvFgE+dGofAaSc14iLd6wMZUmKSYGjeFQmyvNH8+D4lHXJ9UzMXiMS/mX
 gQInOfpgJztzIl9PAePM4EOZ/wyI4QJqaB9S0UFxTP0GNCt13fK30ue61FgxznXwZ/O1
 S4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755097484; x=1755702284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PoCYYMDm5xsDKsqDWqkyOiebYLVPvMGl9JrTl6ToBoQ=;
 b=X4I8xgncN2c1di3kp/d5HefpyFoJ2umqOhDCHmouPZEfRkvYsr+HPt1YXnlqEeUTwx
 4YoeAoGClE1UbIwP7oAVcs88F5voGm2NQ1vD/fSLcsbUllk5rgS9kQc1609TB4Lbyksu
 3z6frN+PyKa0qIx/L6NMVe8AQgO9rpgk2Hi8aKmzUIiSjN/kc9i1j5jutUolr2BhQy8w
 ERZQFd3MUZa5NXKv+jgnlU+GlScpmrb+Felwo5daqwuyvk7Ez1S+Bi96l71uImgR1/q6
 KVK4dy6bwRdzn9lQXT7cWsFw9bRB/xtV/vgiAzs3AHyYBEkPaTqfPAFHgow2noIyT2JU
 Xb5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7T1ApzfwHAB3BNX72amAKg0dPK56CKKsy5KwAWEEKgquX+37kO0jdX9ubCSaZ8sZl0xc=@dpdk.org
X-Gm-Message-State: AOJu0YyULSrqZuygNoDwYZqp+tg51HOJ51lZke4hjbL1j3jiPkzPDgas
 aLoGce4lyG4+OEG0I6Rjaus1HMSPYePIaseAlhhMV1umaaOMFPaXDUr+JkFQa3FyOSE=
X-Gm-Gg: ASbGnct6tvuVTYX8pjJcGE3l9g0yzdng93SKpWu9yOlys9V3UUhqSFUbFlVsO7K0tZW
 WmiUlZnV94pot54+9BsTsRP9w7mMSEAGMKIjEOGpJSNSTfv0mtjkZTMWvNK5ZAOB6hURAdjHTBS
 2fa0yLOgNhubscQgnjy3cDEUCcoBPdkXHO2cS1Ks1YMcafRf2H3vwHk1ff0Q+xbIbVZsWq8Ql48
 i4+naPqj0pk27MqUNpberKLQ1GSpNvyjBUUxFrYP81/Tbuv4LtlWlQRwoSNK75Qh8ILmHQNgdA7
 a1H4YqtxGjdH6ZtymQHQnvKXYCpGeyGy63ZlLpkx5mKK/Lp09o0ILOBpdSk+7iJ3XBEtKmrSWCM
 3+VIjJ6YajQngdQHxzLA1FVy78mqoIeMEK3VlzEskAS6vqVlQDzUe8EWeElvNTVXtBKrwzG8stL
 Q=
X-Google-Smtp-Source: AGHT+IGmKswFE4a9sKa2tPhaAh4AzYgrnQ7kf9cvTE2bcPSwL5cMTXCyVGvLi30elIdyxa5PpFN/YA==
X-Received: by 2002:a05:600c:1d20:b0:456:8eb:a35c with SMTP id
 5b1f17b1804b1-45a1660aa3fmr34323335e9.31.1755097484440; 
 Wed, 13 Aug 2025 08:04:44 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1a58f543sm5668975e9.20.2025.08.13.08.04.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 08:04:44 -0700 (PDT)
Date: Wed, 13 Aug 2025 08:04:39 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: <skori@marvell.com>
Cc: Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, <dev@dpdk.org>, Nithin Dabilpuram
 <ndabilpuram@marvell.com>
Subject: Re: [PATCH v3 1/1] ethdev: add support to provide link type
Message-ID: <20250813080439.113a955d@hermes.local>
In-Reply-To: <20250813084508.1446318-1-skori@marvell.com>
References: <20250606092904.3145608-1-skori@marvell.com>
 <20250813084508.1446318-1-skori@marvell.com>
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

On Wed, 13 Aug 2025 14:13:56 +0530
<skori@marvell.com> wrote:

> From: Sunil Kumar Kori <skori@marvell.com>
> 
> Adding link type parameter to provide the type
> of port like twisted pair, fibre etc.
> 
> Also added an API to convert the RTE_ETH_LINK_TYPE_XXX
> to a readable string.
> 
> Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
> Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
> ---
> v2..v3
>  - Extend link type list as per suggestion
> 
>  lib/ethdev/ethdev_trace.h        |  7 +++++
>  lib/ethdev/ethdev_trace_points.c |  3 ++
>  lib/ethdev/rte_ethdev.c          | 47 ++++++++++++++++++++++++++++++--
>  lib/ethdev/rte_ethdev.h          | 47 ++++++++++++++++++++++++++++++++
>  4 files changed, 102 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/ethdev/ethdev_trace.h b/lib/ethdev/ethdev_trace.h
> index 482befc209..c5cba0edba 100644
> --- a/lib/ethdev/ethdev_trace.h
> +++ b/lib/ethdev/ethdev_trace.h
> @@ -2110,6 +2110,13 @@ RTE_TRACE_POINT_FP(
>  	rte_trace_point_emit_string(ret);
>  )
>  
> +RTE_TRACE_POINT_FP(
> +	rte_eth_trace_link_type_to_str,
> +	RTE_TRACE_POINT_ARGS(uint8_t link_type, const char *ret),
> +	rte_trace_point_emit_u8(link_type);
> +	rte_trace_point_emit_string(ret);
> +);
> +
>  /* Called in loop in examples/bond and examples/ethtool */
>  RTE_TRACE_POINT_FP(
>  	rte_eth_trace_macaddr_get,
> diff --git a/lib/ethdev/ethdev_trace_points.c b/lib/ethdev/ethdev_trace_points.c
> index 071c508327..706acdf356 100644
> --- a/lib/ethdev/ethdev_trace_points.c
> +++ b/lib/ethdev/ethdev_trace_points.c
> @@ -206,6 +206,9 @@ RTE_TRACE_POINT_REGISTER(rte_eth_trace_link_speed_to_str,
>  RTE_TRACE_POINT_REGISTER(rte_eth_trace_link_to_str,
>  	lib.ethdev.link_to_str)
>  
> +RTE_TRACE_POINT_REGISTER(rte_eth_trace_link_type_to_str,
> +	lib.ethdev.link_type_to_str)
> +
>  RTE_TRACE_POINT_REGISTER(rte_eth_trace_stats_get,
>  	lib.ethdev.stats_get)
>  
> diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
> index dd7c00bc94..0cf4a805b7 100644
> --- a/lib/ethdev/rte_ethdev.c
> +++ b/lib/ethdev/rte_ethdev.c
> @@ -3285,18 +3285,61 @@ rte_eth_link_to_str(char *str, size_t len, const struct rte_eth_link *eth_link)
>  	if (eth_link->link_status == RTE_ETH_LINK_DOWN)
>  		ret = snprintf(str, len, "Link down");
>  	else
> -		ret = snprintf(str, len, "Link up at %s %s %s",
> +		ret = snprintf(str, len, "Link up at %s %s %s %s",
>  			rte_eth_link_speed_to_str(eth_link->link_speed),
>  			(eth_link->link_duplex == RTE_ETH_LINK_FULL_DUPLEX) ?
>  			"FDX" : "HDX",
>  			(eth_link->link_autoneg == RTE_ETH_LINK_AUTONEG) ?
> -			"Autoneg" : "Fixed");
> +			"Autoneg" : "Fixed",
> +			rte_eth_link_type_to_str(eth_link->link_type));
>  
>  	rte_eth_trace_link_to_str(len, eth_link, str, ret);
>  
>  	return ret;
>  }
>  
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_link_type_to_str, 25.11)
> +const char *
> +rte_eth_link_type_to_str(uint8_t link_type)
> +{
> +	static const char * const link_type_str[] = {
> +		[RTE_ETH_LINK_TYPE_NONE] = "None",
> +		[RTE_ETH_LINK_TYPE_TP] = "Twisted Pair",
> +		[RTE_ETH_LINK_TYPE_AUI] = "Attachment Unit Interface",
> +		[RTE_ETH_LINK_TYPE_MII] = "Media Independent Interface",
> +		[RTE_ETH_LINK_TYPE_FIBRE] = "Fibre",
> +		[RTE_ETH_LINK_TYPE_BNC] = "BNC",
> +		[RTE_ETH_LINK_TYPE_DA] = "Direct Attach Copper",
> +		[RTE_ETH_LINK_TYPE_SGMII] = "SGMII",
> +		[RTE_ETH_LINK_TYPE_QSGMII] = "QSGMII",
> +		[RTE_ETH_LINK_TYPE_XFI] = "XFI",
> +		[RTE_ETH_LINK_TYPE_SFI] = "SFI",
> +		[RTE_ETH_LINK_TYPE_XLAUI] = "XLAUI",
> +		[RTE_ETH_LINK_TYPE_GAUI] = "GAUI",
> +		[RTE_ETH_LINK_TYPE_XAUI] = "XAUI",
> +		[RTE_ETH_LINK_TYPE_GBASE] = "GBASE",
> +		[RTE_ETH_LINK_TYPE_CAUI] = "CAUI",
> +		[RTE_ETH_LINK_TYPE_LAUI] = "LAUI",
> +		[RTE_ETH_LINK_TYPE_SFP] = "SFP",
> +		[RTE_ETH_LINK_TYPE_SFP_DD] = "SFP_DD",
> +		[RTE_ETH_LINK_TYPE_SFP_PLUS] = "SFP_PLUS",
> +		[RTE_ETH_LINK_TYPE_SFP28] = "SFP28",
> +		[RTE_ETH_LINK_TYPE_QSFP] = "QSFP",
> +		[RTE_ETH_LINK_TYPE_QSFP_PLUS] = "QSFP_PLUS",
> +		[RTE_ETH_LINK_TYPE_QSFP28] = "QSFP28",
> +		[RTE_ETH_LINK_TYPE_QSFP56] = "QSFP56",
> +		[RTE_ETH_LINK_TYPE_QSFP_DD] = "QSFP_DD",
> +		[RTE_ETH_LINK_TYPE_OTHER] = "Unknown"
> +	};
> +	const char *str = NULL;
> +
> +	if ((link_type < RTE_DIM(link_type_str)) && link_type_str[link_type])
> +		str = link_type_str[link_type];
> +
> +	rte_eth_trace_link_type_to_str(link_type, str);
> +	return str;
> +}
> +
>  RTE_EXPORT_SYMBOL(rte_eth_stats_get)
>  int
>  rte_eth_stats_get(uint16_t port_id, struct rte_eth_stats *stats)
> diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
> index f9fb6ae549..e82e50017f 100644
> --- a/lib/ethdev/rte_ethdev.h
> +++ b/lib/ethdev/rte_ethdev.h
> @@ -329,6 +329,38 @@ struct rte_eth_stats {
>  #define RTE_ETH_SPEED_NUM_UNKNOWN UINT32_MAX /**< Unknown */
>  /**@}*/
>  
> +/**@{@name PORT type
> + * Ethernet port type
> + */
> +#define RTE_ETH_LINK_TYPE_NONE     0  /**< Not defined */
> +#define RTE_ETH_LINK_TYPE_TP       1  /**< Twisted Pair */
> +#define RTE_ETH_LINK_TYPE_AUI      2  /**< Attachment Unit Interface */
> +#define RTE_ETH_LINK_TYPE_MII      3  /**< Media Independent Interface */
> +#define RTE_ETH_LINK_TYPE_FIBRE    4  /**< Fibre */
> +#define RTE_ETH_LINK_TYPE_BNC      5  /**< BNC */
> +#define RTE_ETH_LINK_TYPE_DA       6  /**< Direct Attach copper */
> +#define RTE_ETH_LINK_TYPE_SGMII    7  /**< SGMII */
> +#define RTE_ETH_LINK_TYPE_QSGMII   8  /**< QSGMII */
> +#define RTE_ETH_LINK_TYPE_XFI      9  /**< XFI */
> +#define RTE_ETH_LINK_TYPE_SFI     10  /**< SFI */
> +#define RTE_ETH_LINK_TYPE_XLAUI   11  /**< XLAUI */
> +#define RTE_ETH_LINK_TYPE_GAUI    12  /**< GAUI */
> +#define RTE_ETH_LINK_TYPE_XAUI    13  /**< XAUI */
> +#define RTE_ETH_LINK_TYPE_GBASE   14  /**< GBASE */
> +#define RTE_ETH_LINK_TYPE_CAUI    15  /**< CAUI */
> +#define RTE_ETH_LINK_TYPE_LAUI    16  /**< LAUI */
> +#define RTE_ETH_LINK_TYPE_SFP     17  /**< SFP */
> +#define RTE_ETH_LINK_TYPE_SFP_DD  18  /**< SFP_DD */
> +#define RTE_ETH_LINK_TYPE_SFP_PLUS 19  /**< SFP_PLUS */
> +#define RTE_ETH_LINK_TYPE_SFP28   20  /**< SFP28 */
> +#define RTE_ETH_LINK_TYPE_QSFP    21  /**< QSFP */
> +#define RTE_ETH_LINK_TYPE_QSFP_PLUS 22  /**< QSFP_PLUS */
> +#define RTE_ETH_LINK_TYPE_QSFP28  23  /**< QSFP28 */
> +#define RTE_ETH_LINK_TYPE_QSFP56  24  /**< QSFP56 */
> +#define RTE_ETH_LINK_TYPE_QSFP_DD 25  /**< QSFP_DD */
> +#define RTE_ETH_LINK_TYPE_OTHER  0x1F /**< Other type */
> +/**@}*/
> +
>  /**
>   * A structure used to retrieve link-level information of an Ethernet port.
>   */
> @@ -341,6 +373,7 @@ struct rte_eth_link {
>  			uint16_t link_duplex  : 1;  /**< RTE_ETH_LINK_[HALF/FULL]_DUPLEX */
>  			uint16_t link_autoneg : 1;  /**< RTE_ETH_LINK_[AUTONEG/FIXED] */
>  			uint16_t link_status  : 1;  /**< RTE_ETH_LINK_[DOWN/UP] */
> +			uint16_t link_type    : 5;  /**< RTE_ETH_LINK_TYPE_XXX */
>  		};
>  	};
>  };
> @@ -3116,6 +3149,20 @@ int rte_eth_link_get_nowait(uint16_t port_id, struct rte_eth_link *link)
>  __rte_experimental
>  const char *rte_eth_link_speed_to_str(uint32_t link_speed);
>  
> +/**
> + * @warning
> + * @b EXPERIMENTAL: this API may change without prior notice.
> + *
> + * This function converts an Ethernet link type to a string.
> + *
> + * @param link_type
> + *   The link type to convert.
> + * @return
> + *   The string representation of the link type.
> + */
> +__rte_experimental
> +const char *rte_eth_link_type_to_str(uint8_t link_type);
> +
>  /**
>   * @warning
>   * @b EXPERIMENTAL: this API may change without prior notice.

This is causing test failures.
I suspect that since resulting string changed, the test expectations are off.
Need to fix tests as well.
