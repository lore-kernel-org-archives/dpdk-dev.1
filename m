Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7233C71155
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 16:23:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA43340677;
	Mon, 16 Jun 2025 18:23:06 +0200 (CEST)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com
 [209.85.167.182])
 by mails.dpdk.org (Postfix) with ESMTP id 7733C4068A
 for <dev@dpdk.org>; Mon, 16 Jun 2025 18:23:05 +0200 (CEST)
Received: by mail-oi1-f182.google.com with SMTP id
 5614622812f47-4080548891fso1431644b6e.3
 for <dev@dpdk.org>; Mon, 16 Jun 2025 09:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750090985;
 x=1750695785; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9YzKpS/yvCxetxF1X8aUoN7jr9OWLJryaxJppNQatJQ=;
 b=k3lGyBFdThgjEm4VOLIbUKNSwd4iY5CW5mOZx5Uj4C+55LbnidwS05ADGX+wwGpE7B
 ESSpXs/5YPskVcs+IvWDa3T4Yf+XHI+AScNH94s9lBOIKaRNVcX4VN2uGZ2pFfrzlegD
 p+9ejXVStCJqJkepKn6Bx20ZlV0TjlfcO3IFixJe4qSW1Pr8uOJHb3MmCWL4Cjk9d6QC
 7MNrph+x4uba/2cKHyJA8IgK5AW1x2HckFCW1m6ASNmX/rFk285JBFMi5+upA8Rj1tlm
 67b2xuKRmT23maGgJMJQdITirY+d4l4Cx6n6rjy6+8k/ta5kBsLfp3RYooc0ZCSEt/NI
 HEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750090985; x=1750695785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9YzKpS/yvCxetxF1X8aUoN7jr9OWLJryaxJppNQatJQ=;
 b=ZHHyW+dLKSfYVwVkfIMygfeh5LcuEU7dihL2glCMguCNrjyO8riaHILkKAVErY8Vce
 W0UU80s9Mqyxy2UdkdjjWlfmxytOHLysLdOw3cJ1v/iZXlPTtYpHSWDudvUcKXtf2tOS
 XScaElsMogP0N0XkFz8L/s9BQ0EN/L+Z7Z0Ao7CVwddrkxmNPAl8CZJrf7nhHZ81LERx
 pnWtB7G33wYAxCEcSX7pUD8ZgM5JYBbvArVFicvGlf928t1wIoSrOQ2F6sHnr4VdB5NC
 MTkxc0gwJYrT3u6nPdrWWvoOjx8I5dauRuJ0m8Hngak3W2vg2g1Rf0zTRKcTGV2vN2BW
 A9iw==
X-Gm-Message-State: AOJu0YyaXumGviPZyqWIYbwmmnU+B/1dMsFw1x7a+FnJekxDd+qbaLsT
 mB/OpLdNHqg6ulnc2Cp3qwbiI5VxnsQwdZ7kLniBP2llwUNvzS23OoBOhuDI3VkpSqYzPqVn5lZ
 VhN5c
X-Gm-Gg: ASbGnctfsteNkOSjd4n2VcynwHtle0mUpTOGfQakeQSTZiI5nKPfPjoLaCY4TNRnBtK
 MXRKVsWPuCjT3GljH7tYxnr7zAI+elslx7JjLEAm5vvsxsMY2ugz2qsPh98I5z4PwRS0VGW/M0Q
 i4HXbINiW5Me7Nm8xDqZ/4x+S/TXmLGFupggdhKcSyh8Aq0slhRFcqwdq3gBYYWVOnu0hPSWiVd
 zQk2FOwVex1+LbEkaYr4imeYsUvgozZaHEpluFM61aJkQaukKJdqeiyrhDIt0D2frc5N54O6T1U
 UODrXKO/ldMGMKnhYZOGJ7AG8pZx5Fh5Cud44nHM8gCJP/1z50rnKHNIEq0JO0dGeE2e+zXxt7r
 FTA+mz+/pQ0BlV4gH1w9h2rJHe7u2cKEJ3JPrLG0=
X-Google-Smtp-Source: AGHT+IEVJ8xLBjuXw7hnt2FKctpICFhuLI0YtrfoX7Ef3CHgDt97ZAiKyS2xSrX9reASzxPQjkn7+w==
X-Received: by 2002:a05:6808:1481:b0:406:6fd3:ff13 with SMTP id
 5614622812f47-40a7c23e6ccmr5580049b6e.25.1750090984740; 
 Mon, 16 Jun 2025 09:23:04 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73a2855872fsm1242876a34.69.2025.06.16.09.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 09:23:04 -0700 (PDT)
Date: Mon, 16 Jun 2025 09:22:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 3/3] net/zxdh: modify RSS related issues
Message-ID: <20250616092242.04edbb86@hermes.local>
In-Reply-To: <20250607023020.3051575-3-wang.junlong1@zte.com.cn>
References: <20250607023020.3051575-1-wang.junlong1@zte.com.cn>
 <20250607023020.3051575-3-wang.junlong1@zte.com.cn>
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

On Sat,  7 Jun 2025 10:30:20 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

> modify rss related issues in testing process.

Better commit message please. Should have Fixes: tabg.


> 
> Signed-off-by: Junlong Wang <wang.junlong1@zte.com.cn>
> ---
>  drivers/net/zxdh/zxdh_ethdev.c     |  1 +
>  drivers/net/zxdh/zxdh_ethdev_ops.c | 66 +++++++++++++++++++-----------
>  drivers/net/zxdh/zxdh_ethdev_ops.h |  4 +-
>  drivers/net/zxdh/zxdh_msg.c        | 12 +++---
>  drivers/net/zxdh/zxdh_tables.c     |  8 ++--
>  5 files changed, 54 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/net/zxdh/zxdh_ethdev.c b/drivers/net/zxdh/zxdh_ethdev.c
> index 9512aff99c..a245ab24ce 100644
> --- a/drivers/net/zxdh/zxdh_ethdev.c
> +++ b/drivers/net/zxdh/zxdh_ethdev.c
> @@ -66,6 +66,7 @@ zxdh_dev_infos_get(struct rte_eth_dev *dev,
>  	dev_info->rx_offload_capa |=  RTE_ETH_RX_OFFLOAD_TCP_LRO;
>  	dev_info->rx_offload_capa |=  RTE_ETH_RX_OFFLOAD_RSS_HASH;
>  
> +	dev_info->hash_key_size = ZXDH_RSS_HASH_KEY_LEN;
>  	dev_info->reta_size = RTE_ETH_RSS_RETA_SIZE_256;
>  	dev_info->flow_type_rss_offloads = ZXDH_RSS_HF;
>  
> diff --git a/drivers/net/zxdh/zxdh_ethdev_ops.c b/drivers/net/zxdh/zxdh_ethdev_ops.c
> index c16271aeaf..86517d571a 100644
> --- a/drivers/net/zxdh/zxdh_ethdev_ops.c
> +++ b/drivers/net/zxdh/zxdh_ethdev_ops.c
> @@ -289,7 +289,7 @@ zxdh_link_info_get(struct rte_eth_dev *dev, struct rte_eth_link *link)
>  		zxdh_pci_read_dev_config(hw, offsetof(struct zxdh_net_config, status),
>  					&status, sizeof(status));
>  
> -	link->link_status = status;
> +	link->link_status = status & hw->admin_status;
>  
>  	if (status == RTE_ETH_LINK_DOWN) {
>  		link->link_speed = RTE_ETH_SPEED_NUM_UNKNOWN;
> @@ -1207,7 +1207,7 @@ zxdh_rss_hf_to_hw(uint64_t hf)
>  }
>  
>  static uint64_t
> -zxdh_rss_hf_to_eth(uint32_t hw_hf)
> +zxdh_rss_hf_to_eth(uint64_t hw_hf)
>  {
>  	uint64_t hf = 0;
>  
> @@ -1245,7 +1245,7 @@ zxdh_rss_hash_update(struct rte_eth_dev *dev,
>  	hw_hf_new = zxdh_rss_hf_to_hw(rss_conf->rss_hf);
>  	hw_hf_old = zxdh_rss_hf_to_hw(old_rss_conf->rss_hf);
>  
> -	if ((hw_hf_new != hw_hf_old || !!rss_conf->rss_hf))
> +	if ((hw_hf_new != hw_hf_old || hw->rss_enable != (!!rss_conf->rss_hf)))

You don't needs so many () here. Just:
	if (hw_hf_new != hw_hf_old || hw->rss_enable != !!rss_conf->rss_hf)

