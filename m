Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3690DCD4F54
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 15:34:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 27BE740262;
	Fri, 29 May 2026 17:34:52 +0200 (CEST)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by mails.dpdk.org (Postfix) with ESMTP id 2496C400D7
 for <dev@dpdk.org>; Fri, 29 May 2026 17:34:51 +0200 (CEST)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-134fe980658so16545722c88.1
 for <dev@dpdk.org>; Fri, 29 May 2026 08:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780068890;
 x=1780673690; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tAk7D/itVlhNcFfMS7IF4aOfYU2gcR6oQ42KqApuZlc=;
 b=d5ktqf5z2VquJYSsvNs7z4QPladmeJDw8ijzEr4qkoZrRSPOaPu+HwO1hvz2X0zvEM
 AD50N+hiJJPYeCbk9fAknV40RRLxTNt4JlYSlMF/1ahORXn/tcS5uiMW8gpEgH3mEj2H
 UXPoDcPkOLLP6Zx4xsVsY1a70TnTrSyHZK7gYVqTXPEshRwBULSNJtM7VOxNtMe3BF7n
 2YjcUMv4eJnV5Xc4+YqHH5b8hrwtoAkClbxzBVw3IW07dl2CelhFGUd09pjAv+WrylP7
 i9gqFvVdEPipDdPxl4FrBLV7w68cTUMTiJs23i4+tTCUhTrc/ZhBZCu5sztkrMz6Rx2K
 M13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780068890; x=1780673690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tAk7D/itVlhNcFfMS7IF4aOfYU2gcR6oQ42KqApuZlc=;
 b=fOKOuIfE5XMuupiQlW29sc1qK2lh7Cl2iigCLRYnCK6/DG2VEjvDGxUtOX5/l06heF
 OweoWpXkzQ2yODwRggvuZku2yOKPVETLuq0IHJYRrLY7D9Fse72n/uKu/W9JSmE+EcLN
 7d/It38Vnjo4/ehpWQy99P14v+jqzAz+Q7f0Scaj3I12XUfmY5UkCwImBLCdwZ4PuAbo
 WDBFvr4jqv0Hr1ceZWx63FKr9NSjbKpFFi8606M3QQJcpetoB/hdmSFV9GJTekqlapNQ
 j2ha/CukwEX4/EBWC91SclN8iidBdhK7SOyTRtevILmj8LA5Ackb5IcYXr9JQwTNHJEq
 quXw==
X-Gm-Message-State: AOJu0YzC5ehKMM8PfhvWT5L6c95ru5XoOdjCatZXCWcbOIfobk4tbNkv
 ASlaxQ3i2sXFDb8sUzW4HnNeMnSa3BqzCSDuL1adwv4T60DjmZ2eEiHiTHaRzbRGv+E=
X-Gm-Gg: Acq92OEZbgahqHM+JaBt4MroHZYsCdYrVrB3YyhGriqRu5YGmgbsRXYJ88O7T13sYpd
 s0g+eLI2f7QQWh7RVtvhx7WeyEXqS25h66ZOUC2BwTb9vk+Gc+7aYSjRZL1POuZvkGxCjGsTZZk
 0FwOOJ0moc9+jAUoOG6eN+fPzFvqXeWxcRoMwvrjAYXFbQfih7xZ1tTHTLW4kpNG+4wRsCV/KOP
 unZ6FuhEFuQFN6cY8SEtBqOjT6MTfgaSqaUm2W59fLqoJOsIZ2CGkECC2iJsMgVAyMJUf+jJDXC
 XuUL0Sftey0HYS4wgQtJjG1gkg6xQZGqwNpHro4TlrXec2NLW2jlp8tgWN2OuhCEbgGMpIFpi3A
 NwGkSRk4ID8QAFb4rXKyCQ8Pk9ggdfBp4vAWJq0KgVXsD4FwTEQoYUkUgtqI/ierNm6JifoMaQ3
 V2mFhwZFWu87z6FzbqYxqKPfqK0pPGbDTPE3zeI1eXV4+3Ij2aiiW6+TDGDfxQI27ou7vR6DC4K
 9c=
X-Received: by 2002:a05:7301:290b:b0:2ed:e12:3769 with SMTP id
 5a478bee46e88-304fa6b6007mr149670eec.31.1780068889817; 
 Fri, 29 May 2026 08:34:49 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed53f002sm1711918eec.18.2026.05.29.08.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 08:34:49 -0700 (PDT)
Date: Fri, 29 May 2026 08:34:46 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wei Hu <weh@linux.microsoft.com>
Cc: dev@dpdk.org, longli@microsoft.com, weh@microsoft.com
Subject: Re: [PATCH v5 1/1] net/mana: add device reset support
Message-ID: <20260529083446.4082ab23@phoenix.local>
In-Reply-To: <20260529142648.148407-2-weh@linux.microsoft.com>
References: <20260529142648.148407-1-weh@linux.microsoft.com>
 <20260529142648.148407-2-weh@linux.microsoft.com>
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

On Fri, 29 May 2026 07:26:48 -0700
Wei Hu <weh@linux.microsoft.com> wrote:

> diff --git a/drivers/net/mana/mana.c b/drivers/net/mana/mana.c
> index 67396cda1f..89e45c53c1 100644
> --- a/drivers/net/mana/mana.c
> +++ b/drivers/net/mana/mana.c
> @@ -13,7 +13,10 @@
>  #include <ethdev_pci.h>
>  #include <rte_kvargs.h>
>  #include <rte_eal_paging.h>
> +#include <rte_alarm.h>
>  #include <rte_pci.h>
> +#include <rte_rcu_qsbr.h>
> +#include <rte_lock_annotations.h>
>  
>  #include <infiniband/verbs.h>
>  #include <infiniband/manadv.h>
> @@ -103,6 +106,23 @@ mana_dev_configure(struct rte_eth_dev *dev)
>  			      RTE_ETH_RX_OFFLOAD_VLAN_STRIP);
>  
>  	priv->num_queues = dev->data->nb_rx_queues;
> +	DRV_LOG(DEBUG, "priv %p, port %u, dev port %u, num_queues: %u",
> +		priv, priv->port_id, priv->dev_port, priv->num_queues);
> +
> +	/*
> +	 * Register data path thread IDs (rx and tx) with the RCU
> +	 * quiescent state variable for device state synchronization.
> +	 */
> +	for (int i = 0; i < 2 * priv->num_queues; i++) {
> +		if (rte_rcu_qsbr_thread_register(priv->dev_state_qsv, i) != 0) {
> +			DRV_LOG(ERR, "Failed to register rcu qsv thread %d of total %d",
> +				i, 2 * priv->num_queues - 1);
> +			return -EINVAL;
> +		}
> +		DRV_LOG(DEBUG,
> +			"Register thread 0x%x for priv %p, port %u",
> +			i, priv, priv->port_id);
> +	}
>  

If device driver now has dependency on RCU you need to update meson.build
to show that. No other driver does this. Creating threads in driver is
discouraged because it can lead to other problems in applications.

If possible, I would figure out how to manage reset without creating a thread
per-queue. Or at least one control thread and use epoll() and eventfd's.

