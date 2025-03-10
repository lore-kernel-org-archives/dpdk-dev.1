Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B85AC28B28
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Mar 2025 02:33:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3FA84021F;
	Mon, 10 Mar 2025 03:33:53 +0100 (CET)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mails.dpdk.org (Postfix) with ESMTP id 25FBD40151
 for <dev@dpdk.org>; Mon, 10 Mar 2025 03:33:51 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.163.252])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZB1875PRYzCs86;
 Mon, 10 Mar 2025 10:30:15 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 878AF1800C9;
 Mon, 10 Mar 2025 10:33:47 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 10 Mar 2025 10:33:47 +0800
Message-ID: <f4637840-110f-4680-9c22-7b2c07241e27@huawei.com>
Date: Mon, 10 Mar 2025 10:33:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma\ae4dma: added AMD user space DMA driver
To: Bhagyada Modali <bhagyada.modali@amd.com>, <dev@dpdk.org>
CC: <ssebasti@amd.com>, <rningoji@amd.com>
References: <20250309084526.972512-1-bhagyada.modali@amd.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250309084526.972512-1-bhagyada.modali@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

Hi,

This commit modify the test-dma-perf and rte_mempool.h, but I can't get useful info
from the commit log.

So I recommend you split it to multiple commits, each commit implements a small function,
and well doc in commit log, this will help reviewer better understand.

Thanks

On 2025/3/9 16:45, Bhagyada Modali wrote:
> Added a user-space driver with support for the AMD EPYC
> 4th Generation DMA (AE4DMA) offload engine.
> 
> Implementation of new user-space driver supporting
> DMA memory copy offload on AMD EYPC 9004 & 8004 systems
> (Genoa and Siena processors).
> 
> Signed-off-by: Bhagyada Modali <bhagyada.modali@amd.com>
> ---
>  app/test-dma-perf/benchmark.c        |  24 +-
>  app/test-dma-perf/config.ini         | 134 ++++--
>  app/test-dma-perf/main.c             |   2 -
>  app/test/test_dmadev.c               |  43 +-
>  drivers/dma/ae4dma/ae4dma_dmadev.c   | 656 +++++++++++++++++++++++++++
>  drivers/dma/ae4dma/ae4dma_hw_defs.h  | 225 +++++++++
>  drivers/dma/ae4dma/ae4dma_internal.h | 125 +++++
>  drivers/dma/ae4dma/meson.build       |   7 +
>  drivers/dma/meson.build              |   1 +
>  lib/mempool/rte_mempool.h            |   2 +-
>  usertools/dpdk-devbind.py            |   5 +-
>  11 files changed, 1146 insertions(+), 78 deletions(-)
>  create mode 100644 drivers/dma/ae4dma/ae4dma_dmadev.c
>  create mode 100644 drivers/dma/ae4dma/ae4dma_hw_defs.h
>  create mode 100644 drivers/dma/ae4dma/ae4dma_internal.h
>  create mode 100644 drivers/dma/ae4dma/meson.build

