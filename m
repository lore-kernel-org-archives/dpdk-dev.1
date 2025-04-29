Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61A1C369DC
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Apr 2025 23:59:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A06CA402A7;
	Wed, 30 Apr 2025 01:59:57 +0200 (CEST)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id 8625E402A3
 for <dev@dpdk.org>; Wed, 30 Apr 2025 01:59:56 +0200 (CEST)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-306bf444ba2so6333354a91.1
 for <dev@dpdk.org>; Tue, 29 Apr 2025 16:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1745971195;
 x=1746575995; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xEMtJGQVNGEGfp/6cbxiRk+yIWPihehgdnBPKd1l1BI=;
 b=bPDJ7P+vPr1UdF2KH5QSwfI9vbzgpvZfASdF2isG8H7+7xCcRcGaXqmNo6RMUNEMiG
 7or6WaFRjGNoK5ZpMbOvYqu3J+vrtv6svzIMMIwwgU/wRdVRD1zhBCEdxMeoWTYVcQEu
 i46umAy12+G3X6xpJrMa3MkGm15e0TfxUav7c1aDfV5Yr4h/KO1Kd6qso5y1EXWDnuO9
 /RQMw1x1yvF1AcNBeuVydbRlOhS+S7HBNYtJl+bZJf47h0XfChbEAyVx2zyBobpSY/t6
 6aNlzJynQwqy8P42QJ0cpi+XMaCIuznPA033aRadpKwM1NL+tjlo4o73h2cUFdcvhda4
 U9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745971195; x=1746575995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xEMtJGQVNGEGfp/6cbxiRk+yIWPihehgdnBPKd1l1BI=;
 b=Rbv7kXU3LzZZ84Na3fKqVTFFPDkqTKQDsOzaQpA9IfqDYwnmFRocCBEry9Iq/bjqbx
 lNjXbQK69RljzQKngDz+g01QhpoNve2ZS+SviF1jU72BWmZcMbTQ20QYwWxTVuDr+wZ/
 JSKKJYAuieg6ynROOgIpZz/5z7cvZ3yw+GzCsvU7uSlRHsawsNb7Iuofu42KUxtlbn48
 hHX9MNi3/JvXytAATEjXV+jfQ5wfo27up+MXWnW52LPWYTCFTXzMK+7YVfr93ykBO57q
 el7/xBT3znuYdfwJmtJe4bWM8kxSlaZOvOYI86OvEWSr/GvqaYIst0j+NQ0xWtpkFVLe
 /Vug==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJHMrBlOzI7pUMoo/j4kRjs2cFWhhv5Ij7rtZsqDF7faGkvthGg8CMHLnOo3SM7e5gUXs=@dpdk.org
X-Gm-Message-State: AOJu0YwqP9ve0uaH0+VtxfEC23i8kJKxRPv91A+olzvavRMMTW6A8hEx
 RAWYRw+tg1+r1Lblcu3kXxdlxZIaRvRe8ttHQpqsyHorCgbMdhdKs0bmCpBjoOQ=
X-Gm-Gg: ASbGncsaDsSpRKnyp5u+oDpF2oUDjtGE8Rjf6phM/bJlhzzyrDlD/Dvq8yzC5tbzzzd
 GNbqaWfqm3N8lWWhQQDQ+5GHNNk1BuW/PulBQuRGxkRNIlBURKPEL7dgyB6flh/88iqYpsi0Kqw
 Eit1enCb0+Xl6puqxIedvYRvrtbvCwCZWncfb93QxKaGKqjEBUaqO4T6wIz8QRa7fJq32RHuuPa
 cugur87XqVZJvqxgb+MSaDS8lVVFcHgCn7BkwjtZk4zlwOFFDcEHQaPcutKm2P4GLpeV7ZMsuYB
 BvHLlz8RQxEpv+l8VvpPnJyH2OUdUaIoFhSbyCw2ExBPicireHhf4B7uJNyoOsUhGlZRv+awGWn
 /zIwoXyh1LUq9eGw3
X-Google-Smtp-Source: AGHT+IHsFZBxL3i5zWYRZAwnK/w31PODw5tdf6hIFphO4iZAm1nC1i/brDp7/LVPrLE1LG5X6pi1dw==
X-Received: by 2002:a17:90b:3f87:b0:309:ffa5:d526 with SMTP id
 98e67ed59e1d1-30a33300f70mr1443064a91.16.1745971195477; 
 Tue, 29 Apr 2025 16:59:55 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a34a3990fsm159271a91.38.2025.04.29.16.59.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 16:59:55 -0700 (PDT)
Date: Tue, 29 Apr 2025 16:59:53 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: <skori@marvell.com>
Cc: Thomas Monjalon <thomas@monjalon.net>, Ferruh Yigit
 <ferruh.yigit@amd.com>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 <dev@dpdk.org>
Subject: Re: [PATCH] ethdev: remove callback checks from fast path
Message-ID: <20250429165953.0ff82613@hermes.local>
In-Reply-To: <20250429181132.2544771-1-skori@marvell.com>
References: <20250429181132.2544771-1-skori@marvell.com>
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

On Tue, 29 Apr 2025 23:41:30 +0530
<skori@marvell.com> wrote:

>  
> +static inline void
> +rte_eth_set_dummy_fops(struct rte_eth_dev *eth_dev)

Not fastpath, do not add inline here

> +{
> +	eth_dev->rx_pkt_burst = rte_eth_pkt_burst_dummy;
> +	eth_dev->tx_pkt_burst = rte_eth_pkt_burst_dummy;
> +	eth_dev->tx_pkt_prepare = rte_eth_tx_pkt_prepare_dummy;
> +	eth_dev->rx_queue_count = rte_eth_rx_queue_count_dummy;
> +	eth_dev->tx_queue_count = rte_eth_tx_queue_count_dummy;
> +	eth_dev->rx_descriptor_status = rte_eth_descriptor_status_dummy;
> +	eth_dev->tx_descriptor_status = rte_eth_descriptor_status_dummy;
> +	eth_dev->recycle_tx_mbufs_reuse = rte_eth_recycle_tx_mbufs_reuse_dummy;
> +	eth_dev->recycle_rx_descriptors_refill = rte_eth_recycle_rx_descriptors_refill_dummy;
> +}
> +
>  /**
>   * Copy pci device info to the Ethernet device data.
>   * Shared memory (eth_dev->data) only updated by primary process, so it is safe
> @@ -147,6 +161,11 @@ rte_eth_dev_pci_generic_probe(struct rte_pci_device *pci_dev,
>  	if (!eth_dev)
>  		return -ENOMEM;
>  
> +	/* Update fast path ops with dummy callbacks. Driver will update
> +	 * them with required callbacks in the init function.
> +	 */
> +	rte_eth_set_dummy_fops(eth_dev);
> +

What about non PCI ethdev's?
And in PCI devices there is lots of duplicated code already initilizes these.
Needs to be consolidated and documented. Actually the whole probe process needs more documentation.

Also need to make sure secondary process setup is not broken.

