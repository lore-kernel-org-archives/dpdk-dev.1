Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2712FC87FCA
	for <dpdk-dev@archiver.kernel.org>; Sat, 26 Jul 2025 00:55:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D92C340144;
	Sat, 26 Jul 2025 02:55:23 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id AEC27400D5
 for <dev@dpdk.org>; Sat, 26 Jul 2025 02:55:21 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.48])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bpmRR2nNqz13Mhr;
 Sat, 26 Jul 2025 08:52:19 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id C1575180064;
 Sat, 26 Jul 2025 08:55:19 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 26 Jul 2025 08:55:19 +0800
Message-ID: <315e032d-c022-4ea2-b734-3d3a07f5ebc2@huawei.com>
Date: Sat, 26 Jul 2025 08:55:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] [PATCH] doc: announce DMA configuration structure
 changes
To: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>, Thomas Monjalon
 <thomas@monjalon.net>, Amit Prakash Shukla <amitprakashs@marvell.com>
CC: Jerin Jacob <jerinj@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>, Vamsi
 Krishna Attunuru <vattunuru@marvell.com>, "g.singh@nxp.com"
 <g.singh@nxp.com>, "sachin.saxena@nxp.com" <sachin.saxena@nxp.com>,
 "hemant.agrawal@nxp.com" <hemant.agrawal@nxp.com>,
 "bruce.richardson@intel.com" <bruce.richardson@intel.com>,
 "kevin.laatz@intel.com" <kevin.laatz@intel.com>, "conor.walsh@intel.com"
 <conor.walsh@intel.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>, Vidya Sagar Velumuri <vvelumuri@marvell.com>,
 "anatoly.burakov@intel.com" <anatoly.burakov@intel.com>
References: <20250416110541.10358-1-pbhagavatula@marvell.com>
 <SJ4PPF0C545507BB640772878BB9BAC8D6EC878A@SJ4PPF0C545507B.namprd18.prod.outlook.com>
 <3307880.vfdyTQepKt@thomas>
 <PH0PR18MB40865EFFF34A38C49079F979DE59A@PH0PR18MB4086.namprd18.prod.outlook.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <PH0PR18MB40865EFFF34A38C49079F979DE59A@PH0PR18MB4086.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
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

On 2025/7/25 14:04, Pavan Nikhilesh Bhagavatula wrote:
>>> Deprecate rte_dma_conf structure to allow for a more flexible
>>> configuration of DMA devices.
>>> The new structure will have a flags field instead of multiple
>>> boolean fields for each feature.
>>>
>>> Signed-off-by: Pavan Nikhilesh <mailto:pbhagavatula@marvell.com>
>>> ---
>>> +* dmadev: The ``rte_dma_conf`` structure is updated to include a new field
>>> +  ``rte_dma_conf::flags`` that should be used to configure dmadev features.
>>> +  The existing field ``rte_dma_conf::enable_silent`` is removed and replaced
>>> +  with the new flag ``RTE_DMA_CFG_FLAG_SILENT``, to configure silent mode
>>> +  the flag should be set in ``rte_dma_conf::flags`` during device configuration.
>>>
>>> Acked-by: Amit Prakash Shukla <amitprakashs@marvell.com>
>>
>> There is only 1 ack.
>> Per our policy, it will miss the release 25.07.
>>
>> You can probably do this change anyway,
>> and keep ABI compatibility by versioning the function.
> 
> Hi Fengchengwen,
> 
> Are you ok with this change? If so please ack it so that I can work on getting
> an exception from techboard to merge this without deprecation notice in 25.11.
> 
> Thanks,
> Pavan.
> 

