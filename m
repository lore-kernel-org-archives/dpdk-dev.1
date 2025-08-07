Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14F1C87FCB
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 02:43:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9836E4026A;
	Thu,  7 Aug 2025 04:43:15 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id 9DC1740264
 for <dev@dpdk.org>; Thu,  7 Aug 2025 04:43:13 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.162.254])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4byBD62w6Pz14MMn;
 Thu,  7 Aug 2025 10:38:14 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id EED3A18047F;
 Thu,  7 Aug 2025 10:43:10 +0800 (CST)
Received: from [10.67.121.193] (10.67.121.193) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 Aug 2025 10:43:10 +0800
Message-ID: <079a2899-b2c4-4e50-b67a-eaff5b04e9ec@huawei.com>
Date: Thu, 7 Aug 2025 10:43:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] eal: fix uncheck lcore ID and lcore role
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <david.marchand@redhat.com>,
 <roretzla@linux.microsoft.com>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>, <liuyonglong@huawei.com>
References: <20250321040316.104126-1-huangdengdui@huawei.com>
 <20250724112551.2502389-1-huangdengdui@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FDC0@smartserver.smartshare.dk>
Content-Language: en-US
From: huangdengdui <huangdengdui@huawei.com>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FDC0@smartserver.smartshare.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.193]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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


On 2025/7/24 22:44, Morten Brørup wrote:
>> From: Dengdui Huang [mailto:huangdengdui@huawei.com]
>> Sent: Thursday, 24 July 2025 13.26
>>
>> The worker_id may come from user input. So it is necessary to verify it.
>>
>> In addition, only the lcore whose role is ROLE_RTE or ROLE_SERVICE can
>> be
>> launched. This patch adds the lcore role check.
>>
>> Fixes: a95d70547c57 ("eal: factorize lcore main loop")
>> Cc: stable@dpdk.org
>>
>> Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
>> ---
>>  lib/eal/common/eal_common_launch.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/lib/eal/common/eal_common_launch.c
>> b/lib/eal/common/eal_common_launch.c
>> index a7deac6ecd..09366ea404 100644
>> --- a/lib/eal/common/eal_common_launch.c
>> +++ b/lib/eal/common/eal_common_launch.c
>> @@ -20,6 +20,9 @@ RTE_EXPORT_SYMBOL(rte_eal_wait_lcore)
>>  int
>>  rte_eal_wait_lcore(unsigned worker_id)
>>  {
>> +	if (unlikely(worker_id >= RTE_MAX_LCORE))
>> +		return -EINVAL;
>> +
>>  	while (rte_atomic_load_explicit(&lcore_config[worker_id].state,
>>  			rte_memory_order_acquire) != WAIT)
>>  		rte_pause();
>> @@ -37,6 +40,18 @@ int
>>  rte_eal_remote_launch(lcore_function_t *f, void *arg, unsigned int
>> worker_id)
>>  {
>>  	int rc = -EBUSY;
>> +	uint8_t role;
> 
> Use the correct type:
> enum rte_lcore_role_t role;

OK, I made a mistake, and I will fix it in the next version.

> 
>> +
>> +	if (unlikely(worker_id >= RTE_MAX_LCORE)) {
>> +		rc = -EINVAL;
>> +		goto finish;
>> +	}
>> +
>> +	role = lcore_config[worker_id].core_role;
>> +	if (role != ROLE_RTE && role != ROLE_SERVICE) {
>> +		rc = -EINVAL;
>> +		goto finish;
>> +	}
>>
>>  	/* Check if the worker is in 'WAIT' state. Use acquire order
>>  	 * since 'state' variable is used as the guard variable.
>> @@ -98,6 +113,9 @@ RTE_EXPORT_SYMBOL(rte_eal_get_lcore_state)
>>  enum rte_lcore_state_t
>>  rte_eal_get_lcore_state(unsigned lcore_id)
>>  {
>> +	if (unlikely(lcore_id >= RTE_MAX_LCORE))
>> +		return -EINVAL;
> 
> The return type of this function is enum rte_lcore_state_t, so it cannot return (int)-EINVAL.
> 
> Maybe it's better to update the function's documentation instead of its implementation.
> Like the documentation of the lcore_id parameter passed to rte_eal_lcore_role():
> https://elixir.bootlin.com/dpdk/v25.07/source/lib/eal/include/rte_lcore.h#L44
> 
> After further consideration, updating the documentation might also be a better solution for the other functions.

This is a better solution, and I will do it in the next version.

> 
> If you add a new return value (-EINVAL) to a function, it must be listed in function's documentation, and in the documentation of functions calling that function.


> 
>> +
>>  	return lcore_config[lcore_id].state;
>>  }
>>
>> --
>> 2.33.0
> 
> 
