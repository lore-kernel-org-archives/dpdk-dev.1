Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C54DC5DF8C
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 03:12:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95C4A4027C;
	Mon, 24 Aug 2026 05:12:15 +0200 (CEST)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com
 [113.46.200.219])
 by mails.dpdk.org (Postfix) with ESMTP id 6E82740270
 for <dev@dpdk.org>; Mon, 24 Aug 2026 05:12:14 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=2kQ83NNAadDAiAKrLPn8WN01yBne86pPiPnabJ/2iEM=;
 b=mTgsy6YzGFfSyE/Y/ZQI4O6nW28dJUHvJ1KbVy2wZEGJ8zHpBs7ztx2S17c/HwdyvtdgznkmM
 IE0iQnpjMe8tPkjFtzGMqqdpzh+iDhk/Ztj0TaVEBhmFrnWggIBndPYBYAu4y05GK+CJGJ4FDYK
 tms4g8CwwGt3yw5urLd1AhY=
Received: from mail.maildlp.com (unknown [172.19.162.223])
 by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4hSwfY4X1Dz1prPv;
 Mon, 24 Aug 2026 11:01:25 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id C3E1240575;
 Mon, 24 Aug 2026 11:12:11 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 11:12:11 +0800
Message-ID: <75383b65-46eb-42b4-9471-0063ce0e4d50@huawei.com>
Date: Mon, 24 Aug 2026 11:12:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/68] app/testpmd: replace rte_memcpy with memcpy
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
CC: Aman Singh <aman.deep.singh@intel.com>, Ori Kam <orika@nvidia.com>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
 <20260821192646.146382-10-stephen@networkplumber.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260821192646.146382-10-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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

Reviewed-by: Chengwen Feng <fengchengwen@huawei.com>

On 8/22/2026 3:24 AM, Stephen Hemminger wrote:
> The standard C library memcpy is as fast and has more
> checking by analysis tools than DPDK rte_memcpy.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

