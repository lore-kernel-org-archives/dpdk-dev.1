Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636F7C87FCF
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 03:57:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3FA164026A;
	Thu,  7 Aug 2025 05:57:36 +0200 (CEST)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mails.dpdk.org (Postfix) with ESMTP id AA0CE40264
 for <dev@dpdk.org>; Thu,  7 Aug 2025 05:57:34 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.17])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4byCtg4Czbz2Cfrn;
 Thu,  7 Aug 2025 11:53:15 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 6060C1A0188;
 Thu,  7 Aug 2025 11:57:32 +0800 (CST)
Received: from [10.67.121.193] (10.67.121.193) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 Aug 2025 11:57:31 +0800
Message-ID: <16cd59c0-15ba-441c-ace6-8741c7586a3a@huawei.com>
Date: Thu, 7 Aug 2025 11:57:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] eal: fix uncheck lcore role
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <mb@smartsharesystems.com>, <david.marchand@redhat.com>,
 <roretzla@linux.microsoft.com>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>, <liuyonglong@huawei.com>
References: <20250724112551.2502389-1-huangdengdui@huawei.com>
 <20250807024936.2039379-1-huangdengdui@huawei.com>
 <20250806201545.514def16@hermes.local>
Content-Language: en-US
From: huangdengdui <huangdengdui@huawei.com>
In-Reply-To: <20250806201545.514def16@hermes.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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


On 2025/8/7 11:15, Stephen Hemminger wrote:
> On Thu, 7 Aug 2025 10:49:36 +0800
> Dengdui Huang <huangdengdui@huawei.com> wrote:
> 
>> diff --git a/lib/eal/common/eal_common_launch.c b/lib/eal/common/eal_common_launch.c
>> index a7deac6ecd..be7226e4b6 100644
>> --- a/lib/eal/common/eal_common_launch.c
>> +++ b/lib/eal/common/eal_common_launch.c
>> @@ -36,8 +36,15 @@ RTE_EXPORT_SYMBOL(rte_eal_remote_launch)
>>  int
>>  rte_eal_remote_launch(lcore_function_t *f, void *arg, unsigned int worker_id)
>>  {
>> +	enum rte_lcore_role_t role;
>>  	int rc = -EBUSY;
>>  
>> +	role = lcore_config[worker_id].core_role;
>> +	if (role != ROLE_RTE && role != ROLE_SERVICE) {
>> +		rc = -EINVAL;
>> +		goto finish;
>> +	}
> 
> worker_id could be any value, if it was out of the range of the array
> you would end up reading junk.

The lcore should not exceed the RTE_MAX_LCORE range, which should be a common understanding everyone.
I believe checking it in the code is redundant, updating the documentation be a better solution.

Moreover, in some interfaces[1], if the lore exceeds the RTE_MAX_LCORE range, it is difficult to determine what value should be returned.

[1] https://elixir.bootlin.com/dpdk/v25.07/source/lib/eal/include/rte_launch.h#L112
