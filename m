Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D137CD98E1
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 04:02:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BECFD40276;
	Wed, 17 Jun 2026 06:02:28 +0200 (CEST)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com
 [113.46.200.221])
 by mails.dpdk.org (Postfix) with ESMTP id 2F3E04026A
 for <dev@dpdk.org>; Wed, 17 Jun 2026 06:02:27 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=j1BWW5bSFT+5bMPemwResw5cwHZztDkOODJHB64ycZc=;
 b=FQEJcZMxvdjhgf+xqBIjSdDuAVRT+2vNcBCaFZL1pCF7BAFihHrMAuxow6Bv0wvK6ObO4uF1p
 ctNZy8n3cwW7bOYxpmT+hLZTQtuJ5wXnLrsyenXJ40eIm8tf5Ry0yPWZxqBLAqMex6WBPCrVIwv
 xRD2+XxEYiPRcKJ6fon8sUA=
Received: from mail.maildlp.com (unknown [172.19.162.144])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gg9361rHFzRhSq;
 Wed, 17 Jun 2026 11:54:26 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id 6E8FF4056D;
 Wed, 17 Jun 2026 12:02:24 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 17 Jun 2026 12:02:24 +0800
Message-ID: <bf6ccea4-e195-41a4-beb8-ff4b78011ade@huawei.com>
Date: Wed, 17 Jun 2026 12:02:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ethdev: fix fast-path ops on a stopped port
To: Maxime Leroy <maxime@leroys.fr>, <dev@dpdk.org>
References: <20260616094259.686555-1-maxime@leroys.fr>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260616094259.686555-1-maxime@leroys.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
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

Series-acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 6/16/2026 5:42 PM, Maxime Leroy wrote:
> Two small fixes for fast-path ops on a stopped port:
> patch 1 stops rte_eth_rx_queue_count() from dereferencing NULL after a port
> stop, patch 2 makes the dummy queue count return 0 (empty queue) instead of
> -ENOTSUP.
> 
> Maxime Leroy (2):
>   ethdev: keep fast-path ops valid after port stop
>   ethdev: return 0 from dummy queue count
> 
>  lib/ethdev/ethdev_driver.c  | 2 +-
>  lib/ethdev/ethdev_private.c | 7 +++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 

