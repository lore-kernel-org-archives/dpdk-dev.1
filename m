Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98253C36001
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Mar 2025 03:42:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7EF774029A;
	Mon, 24 Mar 2025 04:42:46 +0100 (CET)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mails.dpdk.org (Postfix) with ESMTP id B003140277
 for <dev@dpdk.org>; Mon, 24 Mar 2025 04:42:44 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.163.44])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZLdzx6zFzz1j99J;
 Mon, 24 Mar 2025 11:38:05 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 47C22140118;
 Mon, 24 Mar 2025 11:42:42 +0800 (CST)
Received: from [10.67.121.193] (10.67.121.193) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 24 Mar 2025 11:42:41 +0800
Message-ID: <379f3a4d-9e1b-4130-ac20-37dfef22763b@huawei.com>
Date: Mon, 24 Mar 2025 11:42:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] app/dma-perf: fix infinite loop
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <honest.jiang@foxmail.com>, <fengchengwen@huawei.com>,
 <roretzla@linux.microsoft.com>, <lihuisong@huawei.com>, <haijie1@huawei.com>, 
 <liuyonglong@huawei.com>
References: <20250321040316.104126-1-huangdengdui@huawei.com>
 <20250321040316.104126-3-huangdengdui@huawei.com>
 <20250321085831.09215a83@hermes.local>
Content-Language: en-US
From: huangdengdui <huangdengdui@huawei.com>
In-Reply-To: <20250321085831.09215a83@hermes.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.193]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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


On 2025/3/21 23:58, Stephen Hemminger wrote:
> On Fri, 21 Mar 2025 12:03:16 +0800
> Dengdui Huang <huangdengdui@huawei.com> wrote:
> 
>> When a core that is not used by the rte is specified in the config
>> for testing, the problem of infinite loop occurs. The root cause
>> is that the program waits for the completion of the test task when
>> the test worker fails to be started on the lcore. This patch fix it.
>>
>> Fixes: 533d7e7f66f3 ("app/dma-perf: support config per device")
>> Cc: stable@dpdk.org
>>
>> Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
>> ---
>>  app/test-dma-perf/benchmark.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/app/test-dma-perf/benchmark.c b/app/test-dma-perf/benchmark.c
>> index 6d617ea200..351c1c966e 100644
>> --- a/app/test-dma-perf/benchmark.c
>> +++ b/app/test-dma-perf/benchmark.c
>> @@ -751,7 +751,10 @@ mem_copy_benchmark(struct test_configure *cfg)
>>  				goto out;
>>  		}
>>  
>> -		rte_eal_remote_launch(get_work_function(cfg), (void *)(lcores[i]), lcore_id);
>> +		if (rte_eal_remote_launch(get_work_function(cfg), (void *)(lcores[i]), lcore_id)) {
>> +			printf("Error: Fail to start the test on lcore %d\n", lcore_id);
> 
> Convention is to log errors on stderr and lcore_id is unsigned not signed value.

OK, I'll fix it for the next version.
