Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410ABC83013
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 07:26:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1894240285;
	Wed,  2 Jul 2025 09:26:31 +0200 (CEST)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mails.dpdk.org (Postfix) with ESMTP id 355F440269
 for <dev@dpdk.org>; Wed,  2 Jul 2025 09:26:30 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.163])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4bXBHC6wkbz2Bcng;
 Wed,  2 Jul 2025 15:24:39 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id C9B3B18001B;
 Wed,  2 Jul 2025 15:26:26 +0800 (CST)
Received: from [10.67.121.193] (10.67.121.193) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 2 Jul 2025 15:26:26 +0800
Message-ID: <10d16ad5-24c5-4708-8f35-c27fd5dc6477@huawei.com>
Date: Wed, 2 Jul 2025 15:26:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Does rte_net_get_ptype() support processing packets with two
 0x8100 VLAN tags?
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <jasvinder.singh@intel.com>,
 <thomas@monjalon.net>, <aman.deep.singh@intel.com>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>, liuyonglong <liuyonglong@huawei.com>
References: <e158a8b8-74d1-4df9-ada7-7485ac58336b@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD80@smartserver.smartshare.dk>
Content-Language: en-US
From: huangdengdui <huangdengdui@huawei.com>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FD80@smartserver.smartshare.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.193]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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


On 2025/7/2 13:56, Morten Brørup wrote:
>> From: huangdengdui [mailto:huangdengdui@huawei.com]
>> Sent: Wednesday, 2 July 2025 04.38
>>
>> Hi everyone,
>>
>> The current rte_net_get_ptype() only supports parsing packets with  a
>> single 0x8100 VLAN tag and two 0x88a8 VLAN tags,
>> but does not support processing packets with two 0x8100 VLAN tags.
>>
>> Some network cards (e.g., hns3) do support parsing packets with two
>> 0x8100 VLAN tags.
>> Can this API be extended to support such packets?
> 
> It already does; the layers parameter must have RTE_PTYPE_INNER_L2_MASK set.

Yes, by setting RTE_PTYPE_INNER_L2_MASK, packets with two 0x8100 VLAN tags can be parsed,
but they will be recognized as tunnel packets even though they are not actually tunnel packets.

The current branch that parses the 0x8100 VLAN tag only handles a single VLAN tag[1][2].
Should we extend it to support parsing two or more 0x8100 VLAN tags?

[1]https://elixir.bootlin.com/dpdk/v25.07-rc2/source/lib/net/rte_net.c#L348
[2]https://elixir.bootlin.com/dpdk/v25.07-rc2/source/lib/net/rte_net.c#L500

> 
>>
>> I understand that two 0x8100 VLAN tag packets aren't commonly used, so
>> I'm uncertain whether adding support is necessary.
> 
> AFAIR, it's called "VLAN Stacking".
> Stacking two 0x8100 VLAN tags is commonly used.
> E.g. the majority of consumer fiber internet connections in Denmark use VLAN Stacking (not QinQ) at the network owners' Points-of-Interconnect for the service providers to identify individual homes.

Oh, I'm not very familiar with this. If stacking two 0x8100 VLAN tags is a commonly used, it would make sense for rte_net_get_ptype() to support parsing such packets.

> 
>>
>> Anyone is welcome to discuss this and share their opinions.
>>
>> Thanks,
>> /Dengdui
