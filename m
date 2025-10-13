Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D83ACCD183
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Oct 2025 08:15:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C4CF4021E;
	Mon, 13 Oct 2025 10:15:29 +0200 (CEST)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com
 [113.46.200.216])
 by mails.dpdk.org (Postfix) with ESMTP id 287044013F
 for <dev@dpdk.org>; Mon, 13 Oct 2025 10:15:26 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=dxNboTaF3LtJzex1xHHUYUZJzmE5sXqwPkAQ90i35Gk=;
 b=4hXXyvF3xS+EBsh7pc/lMY7Xg7zsowT4e92g1/cH4OIC7YoO4UJ4tvYttZ2JhkkDSxS0YwD+C
 ujGkN1NQy7JEWRoxh6qh3zvL3T5W5QWfBUBhXuH/QkgigbYbQbdSZ0sAAmS1N2JQJv6wPr2VFDC
 c3gFcBnR/zt4CZUeUruxd8Y=
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4clVWR1d3nz1T4Fs;
 Mon, 13 Oct 2025 16:14:43 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id DBAE7140203;
 Mon, 13 Oct 2025 16:15:24 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 13 Oct 2025 16:15:24 +0800
Message-ID: <f27f49b1-ec58-4b18-b5f0-872a409663ca@huawei.com>
Date: Mon, 13 Oct 2025 16:15:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/13] app/dma-perf: fix use-after-free
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <thomas@monjalon.net>, <honest.jiang@foxmail.com>, <dev@dpdk.org>,
 <liuyonglong@huawei.com>, <vattunuru@marvell.com>
References: <20250811105430.55791-1-fengchengwen@huawei.com>
 <20251013030236.3861-1-fengchengwen@huawei.com>
 <20251013030236.3861-2-fengchengwen@huawei.com>
 <aOywXJ5xJ5lcb11m@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <aOywXJ5xJ5lcb11m@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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

On 10/13/2025 3:55 PM, Bruce Richardson wrote:
> On Mon, Oct 13, 2025 at 11:02:24AM +0800, Chengwen Feng wrote:
>> The test_case->eal_args was pointer the entry of cfgfile, it will be
>> used later, but the cfgfile was closed in load_configs(). This commit
>> fix it by using strdup.
>>
>> Fixes: 623dc9364dc6 ("app/dma-perf: introduce DMA performance test")
>> Cc: stable@dpdk.org
>>
>> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
>> Acked-by: Vamsi Attunuru <vattunuru@marvell.com>
>> ---
>>  app/test-dma-perf/main.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/app/test-dma-perf/main.c b/app/test-dma-perf/main.c
>> index 0586b3e1d0..25a79d1d6c 100644
>> --- a/app/test-dma-perf/main.c
>> +++ b/app/test-dma-perf/main.c
>> @@ -480,6 +480,8 @@ load_configs(const char *path)
>>  					section_name, "test_seconds"));
>>  
>>  		test_case->eal_args = rte_cfgfile_get_entry(cfgfile, section_name, "eal_args");
>> +		if (test_case->eal_args != NULL)
>> +			test_case->eal_args = strdup(test_case->eal_args);
>>  		test_case->is_valid = true;
>>  	}
>>  
> Do we not need a matching free() for each strdup call? (Same comment applies
> to next patch too.)

Yes, free() should match for each strdup call, why not add free() based on:
this is a sample which run at limit time, the strdup just invoke several times
which couldn't lead to short of memory. so in order to simplifies programming, I
think currently impl is okay.

> 

