Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC8DCDB479
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 06:09:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7E734065D;
	Wed, 24 Jun 2026 08:09:16 +0200 (CEST)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com
 [113.46.200.219])
 by mails.dpdk.org (Postfix) with ESMTP id 48A6340150;
 Wed, 24 Jun 2026 08:09:15 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=UibqLs4kYj8/4sUCVH7BoZDPToBjE9WRSj64IMGb41I=;
 b=rIaGascs6RbNlvcwJRCgYuzrR1fUBBGkawrUnD8SMOvleJZNHgAVXgwUHViq81WMa4Isv4sc8
 N55hjLTOkgMezzpgTgxkgwGXsHudU3/hMwXWu7U8WubVJByoH0KVobM/J7X3zkMhEBoHyrM23MM
 be2bcWw76ryUI+DaGSko3D0=
Received: from mail.maildlp.com (unknown [172.19.162.140])
 by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4glWVr0gn6z1prLF;
 Wed, 24 Jun 2026 14:00:04 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id 521AB203B1;
 Wed, 24 Jun 2026 14:09:11 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 24 Jun 2026 14:09:10 +0800
Message-ID: <02096633-cb82-4c04-9e39-00638146c11b@huawei.com>
Date: Wed, 24 Jun 2026 14:09:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] app/dma_perf: skip case if worker maps to main lcore
To: Rupesh Chiluka <rchiluka@marvell.com>, <dev@dpdk.org>
CC: <honest.jiang@foxmail.com>, <gakhil@marvell.com>, <anoobj@marvell.com>,
 <ktejasree@marvell.com>, <stable@dpdk.org>
References: <20260624045417.3294252-1-rchiluka@marvell.com>
 <20260624054254.3367097-1-rchiluka@marvell.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260624054254.3367097-1-rchiluka@marvell.com>
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

Acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 6/24/2026 1:42 PM, Rupesh Chiluka wrote:
> When a configured worker lcore is same as EAL main lcore, the main
> thread calls `rte_eal_remote_launch()` on itself and then waits for
> `worker_info.ready_flag`. The worker function cannot run on the main
> lcore while the main thread is blocked in that loop, and the test hangs.
> 
> Reject such cases early in the `run_test()`.
> 
> Fixes: 623dc9364dc6 ("app/dma-perf: introduce DMA performance test")
> CC: stable@dpdk.org
> 
> Signed-off-by: Rupesh Chiluka <rchiluka@marvell.com>

