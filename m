Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33A8CA0EDC
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 02:10:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9287D4068E;
	Wed, 13 Aug 2025 04:10:39 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mails.dpdk.org (Postfix) with ESMTP id 954A5400EF;
 Wed, 13 Aug 2025 04:10:37 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4c1sJH4rvNztTCk;
 Wed, 13 Aug 2025 10:09:35 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id E340E14020C;
 Wed, 13 Aug 2025 10:10:35 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 Aug 2025 10:10:35 +0800
Message-ID: <a75087f9-9c52-4f71-8dc6-5c8747b6aa7c@huawei.com>
Date: Wed, 13 Aug 2025 10:10:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/22] graph: fix stats query with no node xstats
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: Marat Khalili <marat.khalili@huawei.com>, <stable@dpdk.org>, Jerin Jacob
 <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, Nithin
 Dabilpuram <ndabilpuram@marvell.com>, Zhirun Yan <yanzhirun_163@163.com>,
 Robin Jarry <rjarry@redhat.com>, Pavan Nikhilesh <pbhagavatula@marvell.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250723133157.159825-1-david.marchand@redhat.com>
 <20250723133157.159825-14-david.marchand@redhat.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250723133157.159825-14-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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

Acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 7/23/2025 9:31 PM, David Marchand wrote:
> From: Marat Khalili <marat.khalili@huawei.com>
> 
> This was flagged by undefined behaviour sanitizer: memset should not be
> called with NULL first argument. (memset requires first argument to be
> pointer to a memory object, so passing NULL may result in an undefined
> behaviour including among other things optimizer potentially removing
> code paths depending on stat->xstat_count being NULL.)
> 
> Sanitizer message:
> 
>     lib/graph/graph_stats.c:473:2: runtime error: null pointer passed as
>     argument 1, which is declared to never be null
> 
> Add a check that stat->xstat_cntrs is not zero before the call, since
> stat->xstat_count can only be NULL when stat->xstat_cntrs is zero.
> 
> Fixes: 070db97e017b ("graph: support node xstats")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Marat Khalili <marat.khalili@huawei.com>

