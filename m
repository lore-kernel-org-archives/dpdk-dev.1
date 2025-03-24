Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610B6C36001
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Mar 2025 03:42:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A09184066F;
	Mon, 24 Mar 2025 04:42:56 +0100 (CET)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by mails.dpdk.org (Postfix) with ESMTP id 1BE3B40608
 for <dev@dpdk.org>; Mon, 24 Mar 2025 04:42:54 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.88.105])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ZLf1h0yqXzHrFj;
 Mon, 24 Mar 2025 11:39:36 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 58AAA140132;
 Mon, 24 Mar 2025 11:42:52 +0800 (CST)
Received: from [10.67.121.193] (10.67.121.193) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 24 Mar 2025 11:42:51 +0800
Message-ID: <1190b231-dfb3-4553-89d5-dd86bd2d964e@huawei.com>
Date: Mon, 24 Mar 2025 11:42:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fix the problem of dma-perf infinite loop
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <honest.jiang@foxmail.com>, <fengchengwen@huawei.com>,
 <roretzla@linux.microsoft.com>, <lihuisong@huawei.com>, <haijie1@huawei.com>, 
 <liuyonglong@huawei.com>, <stephen@networkplumber.org>
References: <20250321040316.104126-1-huangdengdui@huawei.com>
 <CAJFAV8ygEGSfwb0Pc4hf-QM8dHTYNyD64craGxu0ptamvHqBKg@mail.gmail.com>
Content-Language: en-US
From: huangdengdui <huangdengdui@huawei.com>
In-Reply-To: <CAJFAV8ygEGSfwb0Pc4hf-QM8dHTYNyD64craGxu0ptamvHqBKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.193]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemo500011.china.huawei.com (7.202.195.194)
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


On 2025/3/21 15:49, David Marchand wrote:
> On Fri, Mar 21, 2025 at 5:03 AM Dengdui Huang <huangdengdui@huawei.com> wrote:
>>
>> After CPU isolation is configured, an infinite loop occurs when
>> dma-perf is executed using the default config file.
>>
>> This patchset fix it.
>>
>> Dengdui Huang (2):
>>   eal: fix wake a incorrect lcore
>>   app/dma-perf: fix infinite loop
>>
>>  app/test-dma-perf/benchmark.c  | 5 ++++-
>>  lib/eal/unix/eal_unix_thread.c | 3 +++
>>  lib/eal/windows/eal_thread.c   | 3 +++
>>  3 files changed, 10 insertions(+), 1 deletion(-)
> 
> We can make EAL launch API more resilient, but the dma-perf
> application should not post jobs on non sense lcore id, in the first
> place.
> parse_lcore() should be validating that the requested lcore_id is valid.
> 
> 

OK, I'll add a check to make sure dma-perf uses the correct lcore.
