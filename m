Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5B0CCD1BF
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 17:12:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 878524065B;
	Fri, 24 Oct 2025 19:11:35 +0200 (CEST)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mails.dpdk.org (Postfix) with ESMTP id 2D42540668
 for <dev@dpdk.org>; Fri, 24 Oct 2025 19:11:33 +0200 (CEST)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-7a23208a0c2so1889929b3a.0
 for <dev@dpdk.org>; Fri, 24 Oct 2025 10:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761325892;
 x=1761930692; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=29Gcbaodgdri1oxGxeF8L3nCdzV6vM0VqClz4huK7rM=;
 b=tCr5fhumGivHxziOA1bb9SKRtLZDqSGNpWAbdXh427jb7BLgnRDuYCc0FT8+9+MEo1
 F5aLGzYlxy+QwnGTU8FDCxtSmwuBUp7Od25ejrvG0Yy8Y0SNdfudUbvJ9RpG2J95+oz1
 /nY1l+gB14YidqYraubVUMeVpe9VjpIAPHLiY5iaqxfuK/xtY5nSzhsUUZ7FFEGsDOhO
 TtdBgcDlmx6FEq2jEG5+JY2HKkx9mDgjvAgJ6SJpBl5+ZjO/6EDS2L+le0mjGqdk0mHb
 bs/Kd5p/M+Ifh3xeXh21dDMZWi8DkN3Kgv5aUN6ajKirzxA4CPZbxUmFu6+NsOGdHBcQ
 /ynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761325892; x=1761930692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=29Gcbaodgdri1oxGxeF8L3nCdzV6vM0VqClz4huK7rM=;
 b=CnLh9ufHIukboAd3CBUwRP9zHpM1t/AeFuITn1kJCjNsomt1PHZWEmvTrVcQSGFWBL
 cfx05JW/rCbjgAr+QQuCEyVtiUfZu1sCVyCycNnRdcZ8c+XSLY6EXxQg1mAwa92/hZTg
 KBCytQmGdhAoUQqzWuPqNupVI/MndQ/wGYizzkGN9p8bzVwhEKJgwclot4vHjtLAHo2H
 RNd9w+D1j265YKFfFZBnQOSI6MYa8skYR9UC8YmVFTxQULTnfzDAL6VLAxpP5aU+V+SU
 cye8Xe3BTf2NKvMGfsDJb5MtRTWFO9S3FKAoBgW4wj2qsbtU8Up2S0UMWOy7HR5RaedF
 9HYw==
X-Gm-Message-State: AOJu0Ywj5xJjrGhkxB4E4LDwIqyPB5n4yWu8u4MDb0U+UELSq/t1HcRd
 bnfym3KYTrmk/nu5aoqJwuYUKafut1Kbg00mDetm47Q6CuTVvjrV8GX7oj9oKQMyBz4IRdRbRBB
 p/wwH
X-Gm-Gg: ASbGncv8mdMp15kxIX0VT0Anfbla6OvauvXbU9Yb4wdVtSkalgqlt7zQy638aw4D6l7
 q25D6KEq/GFQEoJ3lbcNtCRb1kMrQCh+XlIhwKdTyFLlqr7XEZT3zR+42Gqjvc3BhwsPXuypoMD
 wzZhemsr8XunoeW673RU0tROpXnvt3YBxzv74firFphavN5OUB6AcOLuU2y++bQJJKYXjRmAkte
 ZZGybUyCme73AYGOy/TQRCb/wcpRfMwgySniNdvyJnZ+cZoHAhOMwBVFaMmxdrLKb70bAJ9upBc
 8GWh/UbVdRAicVY6mTf9JuIuKYYTSb6cSlglyF+U8e36bnNBzNPscnZLd+yuQiOF/Rflhtyti6k
 b3dI891A4Pxeypdp8UdEIBF1XRMs6iP0pVVS/4zojzreVhm3uDzjr+DipjF685kAY2Ql9OA0B3f
 coGDVJVyBpZAmHCCT8yFfa/pXJtVug8cwvHg==
X-Google-Smtp-Source: AGHT+IHVJeaV4tvkcg4kEHMs0765WxXxVj/riJnlvTOqVA3lhJx25avsK4gHnYhj5tCz0CrD9Xk4rQ==
X-Received: by 2002:a05:6a20:9144:b0:33f:df99:11d8 with SMTP id
 adf61e73a8af0-33fdf99148cmr1445990637.11.1761325892354; 
 Fri, 24 Oct 2025 10:11:32 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a27d583970sm4669776b3a.51.2025.10.24.10.11.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 10:11:32 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:03:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v12 13/13] net/sxe: add virtual function
Message-ID: <20251024100311.394164ba@phoenix>
In-Reply-To: <20250728090517.1811244-13-liujie5@linkdatatechnology.com>
References: <20250725104855.73326-13-liujie5@linkdatatechnology.com>
 <20250728090517.1811244-1-liujie5@linkdatatechnology.com>
 <20250728090517.1811244-13-liujie5@linkdatatechnology.com>
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

On Mon, 28 Jul 2025 17:05:17 +0800
liujie5@linkdatatechnology.com wrote:

> +static const struct eth_dev_ops sxevf_eth_dev_ops = {
> +	.dev_configure		= sxevf_dev_configure,
> +	.dev_start			= sxevf_dev_start,
> +	.dev_stop			 = sxevf_dev_stop,
> +	.link_update		  = sxevf_link_update,
> +	.stats_get			= sxevf_eth_stats_get,
> +	.xstats_get		   = sxevf_xstats_get,
> +	.stats_reset		  = sxevf_dev_stats_reset,
> +	.xstats_reset		 = sxevf_dev_stats_reset,
> +	.xstats_get_names	 = sxevf_xstats_names_get,
> +	.dev_close			= sxevf_dev_close,
> +	.dev_reset		  = sxevf_dev_reset,
> +	.promiscuous_enable   = sxevf_promiscuous_enable,
> +	.promiscuous_disable  = sxevf_promiscuous_disable,
> +	.allmulticast_enable  = sxevf_allmulticast_enable,
> +	.allmulticast_disable = sxevf_allmulticast_disable,
> +	.dev_infos_get		= sxevf_dev_info_get,
> +	.dev_supported_ptypes_get = sxevf_dev_supported_ptypes_get,
> +	.mtu_set			  = sxevf_mtu_set,
> +	.vlan_filter_set	  = sxevf_vlan_filter_set,
> +	.vlan_strip_queue_set = sxevf_vlan_strip_queue_set,
> +	.vlan_offload_set	 = sxevf_vlan_offload_set,
> +	.rx_queue_setup	   = sxevf_rx_queue_setup,
> +	.rx_queue_release	 = sxevf_rx_queue_release,
> +	.tx_queue_setup	   = sxevf_tx_queue_setup,
> +	.tx_queue_release	 = sxevf_tx_queue_release,
> +	.rx_queue_intr_enable = sxevf_rx_queue_intr_enable,
> +	.rx_queue_intr_disable = sxevf_rx_queue_intr_disable,
> +	.mac_addr_add		 = sxevf_mac_addr_add,
> +	.mac_addr_remove	  = sxevf_mac_addr_remove,
> +	.set_mc_addr_list	 = sxevf_set_mc_addr_list,
> +	.rxq_info_get		 = sxevf_rx_queue_info_get,
> +	.txq_info_get		 = sxevf_tx_queue_info_get,
> +	.mac_addr_set		 = sxevf_default_mac_addr_set,
> +	.get_reg			  = sxevf_get_regs,
> +	.reta_update		  = sxevf_rss_reta_update,
> +	.reta_query		   = sxevf_rss_reta_query,
> +	.rss_hash_update	  = sxevf_rss_hash_update,
> +	.rss_hash_conf_get	= sxevf_rss_hash_conf_get,
> +	.tx_done_cleanup	  = sxevf_tx_done_cleanup,
> +#ifdef ETH_DEV_OPS_MONITOR
> +	.get_monitor_addr	 = sxe_monitor_addr_get,
> +#endif
> +#ifdef ETH_DEV_OPS_HAS_DESC_RELATE
> +	.rx_descriptor_status = sxevf_rx_descriptor_status,
> +	.tx_descriptor_status = sxevf_tx_descriptor_status,
> +#ifdef ETH_DEV_RX_DESC_DONE
> +	.rx_descriptor_done   = sxevf_rx_descriptor_done,
> +#endif
> +#endif
> +};
> +

Another ragged looking table, align the right group.
