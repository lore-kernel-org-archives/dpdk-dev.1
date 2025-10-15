Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D77CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 12:55:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 97DC140A6E;
	Wed, 15 Oct 2025 14:55:47 +0200 (CEST)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com
 [113.46.200.226])
 by mails.dpdk.org (Postfix) with ESMTP id 8F36340273
 for <dev@dpdk.org>; Wed, 15 Oct 2025 14:55:46 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=adzSE+ujSrSGDhMYXxHk6FAuS0ARU3PqAssMBwhdAVo=;
 b=Pg0yBopGUEj57R+U0/n0Xc7gih6IVvBLKyRvR4r9psPbX8WzvrtlzWGs2oZoGPVa0iObrA3z1
 9T5fhYUCZRWG5InMSul9Z7JbPpY59F91XMMQtwbAoQviaFBrZhuIjeUFnewN0+s+tpxFK0W+JJN
 NKwcnivSjrW5Zry4RPWmtHk=
Received: from mail.maildlp.com (unknown [172.19.88.214])
 by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cmrfN0FjjzKm6X;
 Wed, 15 Oct 2025 20:55:24 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 4DD481A016C;
 Wed, 15 Oct 2025 20:55:44 +0800 (CST)
Received: from [10.82.20.40] (10.82.20.40) by kwepemk500009.china.huawei.com
 (7.202.194.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 15 Oct
 2025 20:55:43 +0800
Message-ID: <91af2066-2501-0864-f5f4-68037a8515b8@huawei.com>
Date: Wed, 15 Oct 2025 20:55:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v4 4/4] dma/acc: add doc
Content-Language: en-US
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>, <liuyonglong@huawei.com>
References: <20250827092729.10719-1-fengchengwen@huawei.com>
 <4548489.fW5hKsROvD@thomas> <57df6dc3-aa82-3c2d-3980-7c5ef7b900fb@huawei.com>
 <6737235.31tnzDBltd@thomas>
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <6737235.31tnzDBltd@thomas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.82.20.40]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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

On 2025/10/15 20:01, Thomas Monjalon wrote:
> 15/10/2025 13:10, fengchengwen:
>> On 2025/10/15 18:05, Thomas Monjalon wrote:
>>> 13/10/2025 11:11, Chengwen Feng:
>>>> +HISILICON Accelerator DMA Driver
>>>> +================================
>>>> +
>>>> +Kunpeng SoC has an internal accelerator unit which includes zip function, and
>>>> +the zip also supports data copy and fill. This driver exposes this capability to
>>>> +DPDK application.
>>> How is it different of drivers/dma/hisilicon/ ?
>>>
>>> "
>>> Kunpeng SoC has an internal DMA unit which can be used by application
>>> to accelerate data copies.
>>> "
>>>
>>> If it is the same hardware (Kunpeng),
>>> I recommend having a single driver, or a single directory.
>>> Also we already have a driver named "acc" in baseband.
>>
>> they belong to different hardware IP of Kunpeng platform, /dma/hisilicon
>> is the PCIE subsystem DMA's driver, while this acc is the
>> Accelerator(ZIP) subsystem DMA's driver.  they don't exist in the same
>> specific Kunpeng Soc.
>>
>> a single driver will add complex.
>>
>> as for a single directory, should we do for all vendor?  I see there
>> are  dpaa and dpaa2, ioat and idxd both belong to vendor platform.
> When it is really different driver, it is OK to keep them separate.
>
>> if there are no rule to have same name with different subsystem driver,
>> I prefer keep it.
> OK but why it does not contain HiSilicon or Kunpeng in its name?
> "acc" is a really short name, and already used.
> Please find something else.

how about hacc and kacc ?   Hisilicon / Kunpeng accelerator DMA

I will send v5 with one of them

>
>
