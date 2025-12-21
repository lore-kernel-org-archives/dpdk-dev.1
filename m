Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B836E66886
	for <dpdk-dev@archiver.kernel.org>; Sun, 21 Dec 2025 17:00:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E5A740276;
	Sun, 21 Dec 2025 18:00:26 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 8198340265
 for <dev@dpdk.org>; Sun, 21 Dec 2025 18:00:23 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-47755de027eso19058875e9.0
 for <dev@dpdk.org>; Sun, 21 Dec 2025 09:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766336423;
 x=1766941223; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hPF5uAL7UqdtNDZBI9XXrOTipTP492fKHP4QfACy7CI=;
 b=LpHdsr1pc3TsVMK7dHrGNBi6QK6eFIELI7yASNcVWdoFDLCRP1ErS/8D1KhjquoXvG
 8WV3X27B8HJwCqG+vtjVSXuFb/o6FknRuMc1Nt6k7490BKQntkcz0X3xau9u06itszlu
 M71UgXcH99VIlQPlzfXS/Aot1j+pZXeKpsJzxXsCRgoYJeUTmExW75oXLobUEpxgpR32
 xFDpBJ0iE4wPph9Xoge6oOVIB5Op0rha8iKsqKq+6ZCGUDUHn0rcHdGS9BDwqjc2aGre
 zKzcBxPspQDh1PDpI7VM7JCTkoF9KvzbS57IyE+WbjnqQ+NA+hPMxfZaxw7LtCd9mthR
 rDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766336423; x=1766941223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hPF5uAL7UqdtNDZBI9XXrOTipTP492fKHP4QfACy7CI=;
 b=PunKq0xHxUyA5eSx/HdshslC8QooXtBRUdPoUjMM4CqHjYdFFEm3kIZYyv+/udpX0s
 kIH4/mx9erbRly0DSsZAsjHQaKvAci83vnYGentLH4xEecnkRCyX0f6x5LLRurBMDdAl
 iHoxbkL/SRMNd3J8d2tvh4lZ3pcrhH7xIsERXxHT4Q2rTIv5TE4vx4SvGSOUBYUy1219
 vsLtyRcFGMAPIoTW8m9Z14C4nn+6lIdSouzMLcVsw+MBYvtEO0FFT5IUuJaXERC6yCbZ
 x68LyC+s+wCMDvFF+d29mLBJF47CxVGEaxIFZtY695APwDihDcPFC1ZzroTU8a/zR3Ji
 x/jA==
X-Gm-Message-State: AOJu0YyAKWgvdmoDMhvDNLSnE6ifcNxcvNL66FXyZLt3ZsJRdn9EtucB
 RN3HqH/HxzpwtOjUX4DNsn4q18xW5vk2U3bb9t0GoI8Y0DnDUTCEApr7LPWRcnVdK0M=
X-Gm-Gg: AY/fxX6WE1X6fUfuedAIGd03ZQQuAFdqoqfchJ7303SVHXgtiokBl2sPNgnINH38Gcm
 GFrP+nQpDDpXnfYJ8Vm8bPmtwuELfJj6Ofp+IFyhG+UOM6KlESBhwpq1CiNWRFkELFtVkqORRBM
 cx23gIvXs1jVq0y2usH1G/Lk3rM9PhOmGB7rqDGBvYmalTof8PTGf/GBpznEM6pJKxd1nhP2Wrj
 AmO4yf8JOJAkPBqhL3d6+2WIRPrZv0M/YBRKaWfMUSTEEcTz46uA9AdKDVjakj2LG/2e4Tz4qrU
 aAJbs99eJpf+3aPclS7TaWmcnxCiy4rTrTQh3s4cedL9+obdDd8OEKMTWqK8u+tMWzvtQyjJz37
 AkbvYeOuiLOYgGKkSidBPVvdioKHAshTz575rV1KClKngCz0MZWxhUAgiSyqJxaBU0hMaMZjwGS
 6CMFRma5I8gWdYA2MWoXCLkurQLY51i5WtB8NkykhlEQCjmzj9bsMv
X-Google-Smtp-Source: AGHT+IHyzQW39qTU47FlUHqYASuZujZq7rr47KKK9cQlhn0gqkvlfy0igftDZSZCWFiaygFMVoTAoA==
X-Received: by 2002:a05:600c:1d1d:b0:477:9eb8:97d2 with SMTP id
 5b1f17b1804b1-47d1953b8acmr85782935e9.8.1766336422912; 
 Sun, 21 Dec 2025 09:00:22 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3aac6d9sm83259185e9.4.2025.12.21.09.00.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Dec 2025 09:00:22 -0800 (PST)
Date: Sun, 21 Dec 2025 09:00:18 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 4/5] net/zxdh: add support primary/secondary process
Message-ID: <20251221090018.62650e49@phoenix.local>
In-Reply-To: <20251220061521.289722-5-wang.junlong1@zte.com.cn>
References: <20251220061521.289722-1-wang.junlong1@zte.com.cn>
 <20251220061521.289722-5-wang.junlong1@zte.com.cn>
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

On Sat, 20 Dec 2025 14:15:20 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

> diff --git a/drivers/net/zxdh/zxdh_ethdev_ops.c b/drivers/net/zxdh/zxdh_ethdev_ops.c
> index 8fb315eeac..068dd21876 100644
> --- a/drivers/net/zxdh/zxdh_ethdev_ops.c
> +++ b/drivers/net/zxdh/zxdh_ethdev_ops.c
> @@ -1802,22 +1802,26 @@ zxdh_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
>  	struct zxdh_hw_mac_bytes mac_bytes = {0};
>  	uint32_t i = 0;
>  
> -	zxdh_hw_vqm_stats_get(dev, ZXDH_VQM_DEV_STATS_GET,  &vqm_stats);
> -	if (hw->is_pf)
> -		zxdh_hw_mac_stats_get(dev, &mac_stats, &mac_bytes);
> +	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
> +		zxdh_hw_vqm_stats_get(dev, ZXDH_VQM_DEV_STATS_GET,  &vqm_stats);
> +		if (hw->is_pf)
> +			zxdh_hw_mac_stats_get(dev, &mac_stats, &mac_bytes);
>  
> -	zxdh_hw_np_stats_get(dev, &np_stats);
> +		zxdh_hw_np_stats_get(dev, &np_stats);
>  
> -	stats->ipackets = vqm_stats.rx_total;
> -	stats->opackets = vqm_stats.tx_total;
> -	stats->ibytes = vqm_stats.rx_bytes;
> -	stats->obytes = vqm_stats.tx_bytes;
> -	stats->imissed = vqm_stats.rx_drop + mac_stats.rx_drop;
> -	stats->ierrors = vqm_stats.rx_error + mac_stats.rx_error + np_stats.rx_mtu_drop_pkts;
> -	stats->oerrors = vqm_stats.tx_error + mac_stats.tx_error + np_stats.tx_mtu_drop_pkts;
> +		stats->ipackets = vqm_stats.rx_total;
> +		stats->opackets = vqm_stats.tx_total;
> +		stats->ibytes = vqm_stats.rx_bytes;
> +		stats->obytes = vqm_stats.tx_bytes;
> +		stats->imissed = vqm_stats.rx_drop + mac_stats.rx_drop;
> +		stats->ierrors = vqm_stats.rx_error +
> +			mac_stats.rx_error + np_stats.rx_mtu_drop_pkts;
> +		stats->oerrors = vqm_stats.tx_error +
> +			mac_stats.tx_error + np_stats.tx_mtu_drop_pkts;
>  
> -	if (hw->i_mtr_en || hw->e_mtr_en)
> -		stats->imissed  += np_stats.rx_mtr_drop_pkts;
> +		if (hw->i_mtr_en || hw->e_mtr_en)
> +			stats->imissed  += np_stats.rx_mtr_drop_pkts;
> +	}
>  

Does this driver support getting stats in the secondary process?
There are some Network Virtual Appliance products that run with all the
work being done by secondary process and only use the primary as a watchdog for restart.
