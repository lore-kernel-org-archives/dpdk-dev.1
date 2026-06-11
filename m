Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A52CD8CB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 06:17:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B1DE40E2B;
	Thu, 11 Jun 2026 08:16:59 +0200 (CEST)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com
 [113.46.200.219])
 by mails.dpdk.org (Postfix) with ESMTP id 186C340288
 for <dev@dpdk.org>; Thu, 11 Jun 2026 08:16:56 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=DQqkwzQKBqRAi4fNYX6dNW/SJaX+h8W1p4FQo7qQZHE=;
 b=U459ySfVeVPVY598FE1GRGX36gLrw+lUHKXWwl2Pvw/WEi0yK45+n1Zs6zsEGNrtW7OquPmt7
 WJ5/b6T878vz9ws4Vb5hCsL0KZ8Vc1g5TyzejEUfBr3YxAMMLcnit3kmwRdVXghUmn7jNqeZQwJ
 z5hQ6e4IpvL3/GhvghfdS1I=
Received: from mail.maildlp.com (unknown [172.19.162.197])
 by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gbXK11wKGz1prkT;
 Thu, 11 Jun 2026 14:08:53 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
 by mail.maildlp.com (Postfix) with ESMTPS id 8E39E40576;
 Thu, 11 Jun 2026 14:16:50 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemo100005.china.huawei.com
 (7.202.195.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 11 Jun
 2026 14:16:49 +0800
Message-ID: <e616b775-d447-47c3-bc79-e67b2efad636@huawei.com>
Date: Thu, 11 Jun 2026 14:16:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] eal: add interface to check if lcore is EAL
 managed
To: Thomas Monjalon <thomas@monjalon.net>
CC: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>, <dev@dpdk.org>, 
 <stephen@networkplumber.org>, <fengchengwen@huawei.com>,
 <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>
References: <20260522041110.2023062-1-lihuisong@huawei.com>
 <20260522041110.2023062-2-lihuisong@huawei.com>
 <vMlZoeDqTD6UrHS2wuWBKw@monjalon.net>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <vMlZoeDqTD6UrHS2wuWBKw@monjalon.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.59]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo100005.china.huawei.com (7.202.195.212)
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

Hi Thomas,

Thanks for your review.


On 6/11/2026 7:28 AM, Thomas Monjalon wrote:
> 22/05/2026 06:11, Huisong Li:
>> Add a new helper function rte_lcore_is_eal_managed() to determine
>> if a logical core is managed by EAL.
>>
>> This interface returns true if the lcore role is either ROLE_RTE
>> (standard worker/main cores) or ROLE_SERVICE (service cores).
> [...]
>> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_lcore_is_eal_managed, 26.07)
>> +int rte_lcore_is_eal_managed(unsigned int lcore_id)
>> +{
>> +	struct rte_config *cfg = rte_eal_get_configuration();
>> +
>> +	if (lcore_id >= RTE_MAX_LCORE)
>> +		return 0;
>> +	return cfg->lcore_role[lcore_id] == ROLE_RTE ||
>> +		cfg->lcore_role[lcore_id] == ROLE_SERVICE;
>> +}
> I'm not sure about adding this function in the API.
> We already have rte_eal_lcore_role()
> and I feel having this explicit ROLE_RTE || ROLE_SERVICE
> in the code where needed may be less confusing.

Ack.

>
> Note: we should prefix these constants with RTE_LCORE_

Yeah, it's good.

This will break API. And we can do this in 26.11.

>
>
