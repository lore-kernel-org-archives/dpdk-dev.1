Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80191CA1016
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Sep 2025 01:53:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4BE6340281;
	Tue,  9 Sep 2025 03:53:16 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mails.dpdk.org (Postfix) with ESMTP id E94AB40270
 for <dev@dpdk.org>; Tue,  9 Sep 2025 03:53:14 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.48])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cLRYb59GbzRkD2;
 Tue,  9 Sep 2025 09:48:35 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 9CA86180087;
 Tue,  9 Sep 2025 09:53:12 +0800 (CST)
Received: from [10.67.121.193] (10.67.121.193) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 9 Sep 2025 09:53:12 +0800
Message-ID: <a3541da6-780a-4e6a-a31e-31611032a961@huawei.com>
Date: Tue, 9 Sep 2025 09:53:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] net/hns3: fix inconsistent lock
To: Thomas Monjalon <thomas@monjalon.net>, Stephen Hemminger
 <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <lihuisong@huawei.com>, <fengchengwen@huawei.com>,
 <liuyonglong@huawei.com>
References: <20250813073317.1352274-1-huangdengdui@huawei.com>
 <3368264.aeNJFYEL58@thomas> <20250908125815.3dbbfaa0@hermes.local>
 <9500985.CDJkKcVGEf@thomas>
Content-Language: en-US
From: huangdengdui <huangdengdui@huawei.com>
In-Reply-To: <9500985.CDJkKcVGEf@thomas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.193]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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


On 2025/9/9 4:20, Thomas Monjalon wrote:
> 08/09/2025 21:58, Stephen Hemminger:
>> On Mon, 08 Sep 2025 13:53:38 +0200
>> Thomas Monjalon <thomas@monjalon.net> wrote:
>>
>>> 13/08/2025 23:06, Stephen Hemminger:
>>>> On Wed, 13 Aug 2025 15:33:15 +0800
>>>> Dengdui Huang <huangdengdui@huawei.com> wrote:
>>>>   
>>>>> The hns3 driver supports configuring RSS through both ops API and
>>>>> rte_flow API. The ops API uses spink lock, while the rte_flow API uses
>>>>> pthread mutex lock. When concurrent calls occur, issues may arise.
>>>>> This patch replaces the lock in the flow API with spink lock.
>>>>>
>>>>> Fixes: 1bdcca8006e4 ("net/hns3: fix flow director lock")
>>>>> Cc: stable@dpdk.org
>>>>>
>>>>> Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
>>>>> ---  
>>>>
>>>> With that mutex removed, you can also go farther and remove all references to pthread.  
>>>
>>> This patch was (probably by mistake) in the next-net/for-main branch.
>>> I've dropped it when pulling in main.
>>>
>>
>> I went ahead and fixed the original patch to drop pthread references
>> and fix wording in commit message; and put it back in next-net.
> 
> There are 2 other patches to consider in this series.
> We should not break series if no urgency.
> 
> 

I also found this patch in the next-net/for-main branch, and I created the V2 patch after reverting.
