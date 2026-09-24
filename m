Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE509C98314
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 07:51:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE55D42F4D;
	Thu, 24 Sep 2026 09:51:23 +0200 (CEST)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com
 [113.46.200.222])
 by mails.dpdk.org (Postfix) with ESMTP id 1A69642EE5
 for <dev@dpdk.org>; Thu, 24 Sep 2026 09:51:23 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=8Vo9yeLt5Ib9nlfUaa8rDxMgROO9R94+4pjtCRLPX6A=;
 b=ncrLRhRH9Lu7Z4FlFE2TCz9BWLiqfW7P9z3P0JYbAoY9Re/ECjKTlk4ouZHXfP4ubxmc/FH5h
 ZyMIFyDAeVmo10I10bWr+cbyMgJLPR/Xyl1lNYDMj93orb+OVV5dRhuJb0fwVFrrNJbEB7tJZWh
 G7Tr2g/92Ml6vDaP7FJhNaI=
Received: from mail.maildlp.com (unknown [172.19.163.127])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4hr5Lp1BvkzLlTC;
 Thu, 24 Sep 2026 15:39:14 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id 16F7640561;
 Thu, 24 Sep 2026 15:51:20 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 24 Sep 2026 15:51:19 +0800
Message-ID: <71020cb6-4779-44a2-8f0e-2f813905bdfa@huawei.com>
Date: Thu, 24 Sep 2026 15:51:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/16] app/test: use common division round up macro
To: Joshua Washington <joshwash@google.com>, Fan Zhang
 <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>
CC: <dev@dpdk.org>
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260923010742.2468145-1-joshwash@google.com>
 <20260923010742.2468145-16-joshwash@google.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260923010742.2468145-16-joshwash@google.com>
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

Acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 9/23/2026 9:07 AM, Joshua Washington wrote:
> The RTE_DIV_ROUND_UP in rte_common.h makes DIV_CEIL redundant.
> 
> Signed-off-by: Joshua Washington <joshwash@google.com>

