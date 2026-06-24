Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F100ACDB479
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 01:53:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04135402BC;
	Wed, 24 Jun 2026 03:53:43 +0200 (CEST)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com
 [113.46.200.220])
 by mails.dpdk.org (Postfix) with ESMTP id 2245E40150
 for <dev@dpdk.org>; Wed, 24 Jun 2026 03:53:41 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=3bhVGMG6DT2NfRFhf/rBKwAtCEV508c9JZruicZjfUk=;
 b=UV+3zIyulOHSodlrvN4sppSFJ0tOLpLBzbrGRy+gJ13m1PpjXFmxsFjrfCO4V51Ain/6gSU3T
 L4CqsS8BrOjyg90aCPD1b3LVrRixXd3TT4EUYGNGJWoIBk3btQIS0QmjRHMm/go3SuCZyHx1ZSo
 xxh9tlCqCt4vuDCsz7iy6yc=
Received: from mail.maildlp.com (unknown [172.19.162.223])
 by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4glPrH3DMkz12LD1
 for <dev@dpdk.org>; Wed, 24 Jun 2026 09:44:47 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id B2B9440561
 for <dev@dpdk.org>; Wed, 24 Jun 2026 09:53:34 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 24 Jun 2026 09:53:34 +0800
Message-ID: <e0fc2bb4-dfc3-4b6e-aece-a1a81ee78bb6@huawei.com>
Date: Wed, 24 Jun 2026 09:53:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] lib: remove use of strncpy
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20260623141930.704771-1-bruce.richardson@intel.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260623141930.704771-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo500009.china.huawei.com (7.202.194.199)
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

Series-reviewed-by: Chengwen Feng <fengchengwen@huawei.com>

On 6/23/2026 10:19 PM, Bruce Richardson wrote:
> Taking a lead from the kernel, which has just finished a multi-year
> effort to remove use of strncpy[1], rework DPDK to remove use of the
> same function. This series removes all remaining uses of strncpy
> in lib directory.
> 
> [1] https://www.phoronix.com/news/Linux-7.2-Drops-strncpy
> 
> Bruce Richardson (3):
>   ethdev: remove use of strncpy
>   eventdev: improve bounds checks for names in adapter create
>   vhost: remove use of strncpy
> 
>  lib/ethdev/ethdev_driver.c              |  7 ++++++-
>  lib/eventdev/rte_event_eth_tx_adapter.c |  4 ++--
>  lib/vhost/socket.c                      |  4 +---
>  lib/vhost/vduse.c                       |  2 +-
>  lib/vhost/vhost.c                       | 12 +++---------
>  lib/vhost/vhost.h                       |  2 +-
>  6 files changed, 14 insertions(+), 17 deletions(-)
> 
> --
> 2.53.0
> 

