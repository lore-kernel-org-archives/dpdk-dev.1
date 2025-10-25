Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95DACCD1BF
	for <dpdk-dev@archiver.kernel.org>; Sat, 25 Oct 2025 01:07:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B66A4402D3;
	Sat, 25 Oct 2025 03:07:48 +0200 (CEST)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com
 [113.46.200.221])
 by mails.dpdk.org (Postfix) with ESMTP id 7D5F040268
 for <dev@dpdk.org>; Sat, 25 Oct 2025 03:07:46 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=uEN3ylH7CmI8RfwR2RCQstkeGsQLck7p7YTW1B4YJBM=;
 b=VyHp8kjMSP7pMmUax2UftgV0PXg/BnzEyQlnRxX5AewN9y1Z9ycF47OfQ/JPLMOwB934/H1kM
 m6/M/b+LjSq7PW7RfO3Leq9Jy3/PhPN2kpY/PNjM9ff7/eUBGQENGjVHpUjzIEZePYxt1kWgcHC
 IVE/PaQErkVW7xy+7tSn29A=
Received: from mail.maildlp.com (unknown [172.19.162.254])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4cthSj5WB1zRhrq;
 Sat, 25 Oct 2025 09:07:17 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 3918A18048F;
 Sat, 25 Oct 2025 09:07:44 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 25 Oct 2025 09:07:43 +0800
Message-ID: <58e442dd-077a-4e9b-8297-eb33b7c025ce@huawei.com>
Date: Sat, 25 Oct 2025 09:07:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] dma/acc: add doc
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>, <liuyonglong@huawei.com>
References: <20250827092729.10719-1-fengchengwen@huawei.com>
 <6737235.31tnzDBltd@thomas> <91af2066-2501-0864-f5f4-68037a8515b8@huawei.com>
 <6737262.UjTJXf6HLC@thomas>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <6737262.UjTJXf6HLC@thomas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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

On 10/15/2025 10:09 PM, Thomas Monjalon wrote:
> 15/10/2025 14:55, fengchengwen:
>> On 2025/10/15 20:01, Thomas Monjalon wrote:
>>> 15/10/2025 13:10, fengchengwen:
>>>> On 2025/10/15 18:05, Thomas Monjalon wrote:
>>>>> 13/10/2025 11:11, Chengwen Feng:
>>>>>> +HISILICON Accelerator DMA Driver
>>>>>> +================================
>>>>>> +
>>>>>> +Kunpeng SoC has an internal accelerator unit which includes zip function, and
>>>>>> +the zip also supports data copy and fill. This driver exposes this capability to
>>>>>> +DPDK application.
>>>>> How is it different of drivers/dma/hisilicon/ ?
>>>>>
>>>>> "
>>>>> Kunpeng SoC has an internal DMA unit which can be used by application
>>>>> to accelerate data copies.
>>>>> "
>>>>>
>>>>> If it is the same hardware (Kunpeng),
>>>>> I recommend having a single driver, or a single directory.
>>>>> Also we already have a driver named "acc" in baseband.
>>>>
>>>> they belong to different hardware IP of Kunpeng platform, /dma/hisilicon
>>>> is the PCIE subsystem DMA's driver, while this acc is the
>>>> Accelerator(ZIP) subsystem DMA's driver.  they don't exist in the same
>>>> specific Kunpeng Soc.
>>>>
>>>> a single driver will add complex.
>>>>
>>>> as for a single directory, should we do for all vendor?  I see there
>>>> are  dpaa and dpaa2, ioat and idxd both belong to vendor platform.
>>> When it is really different driver, it is OK to keep them separate.
>>>
>>>> if there are no rule to have same name with different subsystem driver,
>>>> I prefer keep it.
>>> OK but why it does not contain HiSilicon or Kunpeng in its name?
>>> "acc" is a really short name, and already used.
>>> Please find something else.
>>
>> how about hacc and kacc ?   Hisilicon / Kunpeng accelerator DMA
> 
> You already have one DMA driver in drivers/dma/hisilicon/
> Can you build around that? like hisilicon_something?
> hisil_acc?

The v6 has sent and named with hisi_acc.
In addition, the original HiSilicon driver has rename to hisi_pciep because the hardware ip is integrated endpoint of pci subsystem.

> 
> 

