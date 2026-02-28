Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88435FEE4ED
	for <dpdk-dev@archiver.kernel.org>; Sat, 28 Feb 2026 17:03:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81647402CA;
	Sat, 28 Feb 2026 18:03:42 +0100 (CET)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170]) by mails.dpdk.org (Postfix) with ESMTP id A34164013F
 for <dev@dpdk.org>; Sat, 28 Feb 2026 18:03:40 +0100 (CET)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2bdcfbd0779so3426844eec.0
 for <dev@dpdk.org>; Sat, 28 Feb 2026 09:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772298219;
 x=1772903019; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LVs+pstFMccCNJZEf/PE/RlVZiqoQCmTPz4jTSx1jug=;
 b=f0M6Uwjo1eVzWFKKJfk4yuZBk7iWEVt+11ITY/6zZI0cj6qtTEnjpf4rDZkQk3Az8Q
 HIHsG2MtUrQtZjsgcUQz+NcBvJBLd2D53X5g2HU4c52y3kG4VTXq7svINmsQOPHnmYcL
 ewTEvdZHXZoPlRMBEAHdZwh3rugnpuLGhEDIXj1G14u7PMxHOmBjvtIgyf6EMhtqKwTx
 afgqYW1zLEFtCq8DrswBCeejjChScZzYMlfPNkiSXxdU94hDqqeOtVvO9JofiQt3wNZU
 RClpwRLSMiNc1CRVlJsMMqKakRdz3YN/O17ZWIBmnACztSXVwkjwGPheIHZKjPjktzgq
 yPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772298219; x=1772903019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LVs+pstFMccCNJZEf/PE/RlVZiqoQCmTPz4jTSx1jug=;
 b=Uu3jH+WXiA5BhFZLGRhMN5HZwCjS1aNH+Mp5M5vJr64cnbdURktsQuH19000ZVxarS
 3dSs4kgobjtFkKUkFhNxUnqYrnhiXJBS29RWSsOLLHPXsuQPPv1wS6wsTK8GjnDiZPNc
 +nuWh6P29vMYV/T6tQqNIyOeB5E8EU2NdyMCFFuta5OW5BT9Z22d+3h6d9P5htFUaOQ7
 g9PIQ4BXNsxvZNrf0LaFFr90P/Pze+7MuQHAEFoGRYYsxjj4ayuy8vEFT2yQ7nicf6zQ
 l/uHFwcjv8BbfOYi3CdgcSd+CJnS4W/zc4Xuwy4gJxLHzVNgTdQfg4Ifzr/sam0x8/vd
 QJeg==
X-Gm-Message-State: AOJu0YwK07MxZ3ugtoJIrbYeuZsIe8wArkOs2+Rpcsu1kh9+asJGpTHt
 3gcv+ctoZwVZG3svRYySGbe5Jhi/xp6L70QT6Uiyhz6orOANTuSQeQI0VGv2d5rro2g=
X-Gm-Gg: ATEYQzwmWgbnse2CoaLxHSf7s93hv13vcJ0WnfAT6VeZxIvLLLlsepNtcOdhTtbZ6RF
 W2kgjyrKZX0PAy4W5pqeR1YKJ7qMOZYtTsB8K0ndC6P7pWk7WG6mTYIP2okhsRtnI4LxhWeATzw
 0Uci7/Gv5Xfx6tC5LzGlrYDmpwEym7F8gKN/vZ/0kc1ap7z9lFy5ktDK0yanq/pRtiqzWf1oqHA
 JE3fbf15r+QK9xWupPO7SI80E49L9Bd/8JBgBKQw3YXg+itab3SJTRmdjzTSXftyd13QH4jUo/4
 hMDkYShOAAF5dTe3KXBApR2pTyI3Kg/VmqTqPc3KqIGXUhiaCX4a/3JmcuCKiDpUdczmduxlCHS
 GYsBY9tzyAuy4MDZiFA71+LvSzovUYEWASd/w+w+j48kxRQtWwySP7SWtWlO+ln224djcM0Wg4X
 O1lFRvB8xzOqSN/72apUpqACUi8C5ZwfB8rVURFvvy8Axj3+loGzG209/3QbWviREj
X-Received: by 2002:a05:7301:6084:b0:2ba:9835:112d with SMTP id
 5a478bee46e88-2bde1b4e170mr2869755eec.3.1772298219310; 
 Sat, 28 Feb 2026 09:03:39 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bdd1cf0045sm5715637eec.11.2026.02.28.09.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 09:03:39 -0800 (PST)
Date: Sat, 28 Feb 2026 09:03:35 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Long Li <longli@microsoft.com>
Cc: dev@dpdk.org, Wei Hu <weh@microsoft.com>, stable@dpdk.org, Dariusz
 Sosnowski <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: Re: [PATCH v5 0/7] multi-process and VF hotplug fixes
Message-ID: <20260228090335.222ffa79@phoenix.local>
In-Reply-To: <20260227015928.14338-1-longli@microsoft.com>
References: <20260227015928.14338-1-longli@microsoft.com>
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

On Thu, 26 Feb 2026 17:59:20 -0800
Long Li <longli@microsoft.com> wrote:

> Fix several issues with VF hotplug and multi-process support in
> netvsc, mana, mlx5, and mlx4 drivers:
> 
> - Fix race conditions between VSP notifications and DPDK device events
>   during VF add/remove, with proper locking of VF-related fields
> - Add multi-process communication infrastructure for coordinating VF
>   removal across primary and secondary processes
> - Fix Protection Domain resource leak on device close in mana
> - Fix devargs memory leak during VF hotplug in netvsc
> - Fix fast-path ops (rte_eth_fp_ops) setup in secondary processes for
>   mana, mlx5, and mlx4, ensuring burst function pointers are restored
>   after STOP->START cycles
> 
> v5:
> - Patches 5,6,7: Also restore rte_eth_fp_ops burst function pointers
>   (rx_pkt_burst, tx_pkt_burst) in START_RXTX handler, not just queue
>   data pointers. Without this, after a STOP->START cycle the secondary
>   process burst pointers remain set to dummy functions.
> 
> v4:
> - Patch 1: Check hn_vf_add() return value in netvsc_hotplug_retry
> - Patch 1: Track fresh_attach to avoid tearing down original VF
>   attachment when configure/start fails on an -EEXIST path
> - Patch 2: Move counter decrement and netvsc_uninit_once() after device
>   cleanup in eth_hn_remove() to prevent use-after-free of shared data
> - Patch 2: Clear netvsc_shared_data on init failure paths to prevent
>   dangling pointer
> 
> v3:
> - Fix review comments from v2
> 
> v2:
> - Initial rework of VF add/remove locking
> 
> Long Li (7):
>   net/netvsc: fix race conditions on VF add/remove events
>   net/netvsc: add multi-process VF device removal support
>   net/mana: fix PD resource leak on device close
>   net/netvsc: fix devargs memory leak on hotplug
>   net/mana: fix fast-path ops setup in secondary process
>   net/mlx5: fix fast-path ops setup in secondary process
>   net/mlx4: fix fast-path ops setup in secondary process
> 
>  drivers/net/mana/mana.c             |  14 ++
>  drivers/net/mana/mp.c               |   8 +
>  drivers/net/mlx4/mlx4_mp.c          |   6 +
>  drivers/net/mlx5/linux/mlx5_mp_os.c |   6 +
>  drivers/net/netvsc/hn_ethdev.c      | 300 +++++++++++++++++++++++++++-
>  drivers/net/netvsc/hn_nvs.h         |   6 +
>  drivers/net/netvsc/hn_rxtx.c        |  40 ++--
>  drivers/net/netvsc/hn_var.h         |   1 +
>  drivers/net/netvsc/hn_vf.c          | 148 ++++++++------
>  9 files changed, 437 insertions(+), 92 deletions(-)

Applied to next-net.
The SHA hashes of those fixes tags was off; fixed them by
matching on the subject.

Also fixed a couple checkpatch warnings for:

CHECK:OPEN_ENDED_LINE: Lines should not end with a '('
#295: FILE: drivers/net/netvsc/hn_ethdev.c:1763:
+			rte_atomic_fetch_add_explicit(

