Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C96C021B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 09:23:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1DE9840652;
	Mon, 24 Feb 2025 10:23:26 +0100 (CET)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mails.dpdk.org (Postfix) with ESMTP id 1937540299
 for <dev@dpdk.org>; Mon, 24 Feb 2025 10:23:23 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.162.254])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Z1ZvH5sfyzCs81;
 Mon, 24 Feb 2025 17:19:55 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 92C69180331;
 Mon, 24 Feb 2025 17:23:21 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 24 Feb 2025 17:23:21 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 24 Feb
 2025 17:23:20 +0800
Message-ID: <683e3919-ec47-7918-92f5-fc805952ae75@huawei.com>
Date: Mon, 24 Feb 2025 17:23:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] power: use hugepage memory for queue list entry structure
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "thomas@monjalon.net"
 <thomas@monjalon.net>, "david.hunt@intel.com" <david.hunt@intel.com>,
 "anatoly.burakov@intel.com" <anatoly.burakov@intel.com>,
 "sivaprasad.tummala@amd.com" <sivaprasad.tummala@amd.com>, liuyonglong
 <liuyonglong@huawei.com>, Stephen Hemminger <stephen@networkplumber.org>
References: <20241219075319.8874-1-lihuisong@huawei.com>
 <01d163c6-6d18-03e8-ac67-e7907d27bd08@huawei.com>
 <60199571d93a4cf88d7ab9aa6a79611e@huawei.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <60199571d93a4cf88d7ab9aa6a79611e@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.59]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemn100009.china.huawei.com (7.202.194.112)
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


在 2025/2/20 17:41, Konstantin Ananyev 写道:
> Hi
>
>> Hi all,
>>
>> Kindly ping for review.
>>
>>
>> 在 2024/12/19 15:53, Huisong Li 写道:
>>> The queue_list_entry structure data is used in rx_callback of io path
>>> when enable PMD Power Management. However its memory is currently from
>>> normal heap memory. For better performance, use hugepage memory to
>>> replace it.
> Make sense to me.
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
>
> I  suppose it would also help if you can provide some numbers:
> i.e.: how much exactly it is 'better'?
> Did you see any changes in throughput/latency numbers, etc.

This patch is just from my knowledge of DPDK.

I don't what is the good way to evaluate the performance of l3fwd-power.

But I did a test for this after you said.

I found that the throughput of using malloc is better than rte_malloc in 
continuous packet flow case.😮

Can you test this patch on your platform?

>
>>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>>> ---
>>>    lib/power/rte_power_pmd_mgmt.c | 10 +++++-----
>>>    1 file changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/lib/power/rte_power_pmd_mgmt.c b/lib/power/rte_power_pmd_mgmt.c
>>> index a2fff3b765..c7bf57a910 100644
>>> --- a/lib/power/rte_power_pmd_mgmt.c
>>> +++ b/lib/power/rte_power_pmd_mgmt.c
>>> @@ -97,7 +97,7 @@ queue_list_find(const struct pmd_core_cfg *cfg, const union queue *q)
>>>    }
>>>
>>>    static int
>>> -queue_list_add(struct pmd_core_cfg *cfg, const union queue *q)
>>> +queue_list_add(struct pmd_core_cfg *cfg, const union queue *q, unsigned int lcore_id)
>>>    {
>>>    	struct queue_list_entry *qle;
>>>
>>> @@ -105,10 +105,10 @@ queue_list_add(struct pmd_core_cfg *cfg, const union queue *q)
>>>    	if (queue_list_find(cfg, q) != NULL)
>>>    		return -EEXIST;
>>>
>>> -	qle = malloc(sizeof(*qle));
>>> +	qle = rte_zmalloc_socket(NULL, sizeof(*qle), RTE_CACHE_LINE_SIZE,
>>> +				 rte_lcore_to_socket_id(lcore_id));
>>>    	if (qle == NULL)
>>>    		return -ENOMEM;
>>> -	memset(qle, 0, sizeof(*qle));
>>>
>>>    	queue_copy(&qle->queue, q);
>>>    	TAILQ_INSERT_TAIL(&cfg->head, qle, next);
>>> @@ -570,7 +570,7 @@ rte_power_ethdev_pmgmt_queue_enable(unsigned int lcore_id, uint16_t port_id,
>>>    		goto end;
>>>    	}
>>>    	/* add this queue to the list */
>>> -	ret = queue_list_add(lcore_cfg, &qdata);
>>> +	ret = queue_list_add(lcore_cfg, &qdata, lcore_id);
>>>    	if (ret < 0) {
>>>    		POWER_LOG(DEBUG, "Failed to add queue to list: %s",
>>>    				strerror(-ret));
>>> @@ -664,7 +664,7 @@ rte_power_ethdev_pmgmt_queue_disable(unsigned int lcore_id,
>>>    	 * callbacks can be freed. we're intentionally casting away const-ness.
>>>    	 */
>>>    	rte_free((void *)(uintptr_t)queue_cfg->cb);
>>> -	free(queue_cfg);
>>> +	rte_free(queue_cfg);
>>>
>>>    	return 0;
>>>    }
