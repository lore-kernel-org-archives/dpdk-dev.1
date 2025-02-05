Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B264C02198
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 16:44:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C0DA402E4;
	Wed,  5 Feb 2025 17:44:04 +0100 (CET)
Received: from lf-1-19.ptr.blmpb.com (lf-1-19.ptr.blmpb.com [103.149.242.19])
 by mails.dpdk.org (Postfix) with ESMTP id EEE4F40651
 for <dev@dpdk.org>; Wed,  5 Feb 2025 17:44:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1738773830; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=5d5nfXEWc9IHVHB6Bu8tKib6hvzLwJatsyVQrpFYRvg=;
 b=jXeBeyqeRYCGJEVA/F6uylcdIVGR1xtdSPfP7ZrK1igDRIW0vA+77foxzSNjWg/VONN27B
 YaT68Gp15Xh+JD1GMkuTje/SNRWy2toEtIAXh8K1wwE3h1gFbujBKFDlzFzvMp+76CA1Fk
 AP4g62FiiUtcb0GYUBz6pwBiulixZgPF410UM5wruS03F8MCoeHdW+WG7Q73GEq78uzfa3
 KtTqxJCEIng08kLOSVqSsnDQnGM/UeMi22EDSPr7EYBrmozdlL+bs8XoOM1H+AC+cuPeYo
 fW05MUhc7K15/bnI6uO9jb5wD6xzC/4bTFZ95O/YhUZDr8TXUZ//XqD+4VUF5g==
Date: Thu, 6 Feb 2025 00:43:46 +0800
X-Lms-Return-Path: <lba+267a39544+bbc1c7+dpdk.org+wanry@yunsilicon.com>
User-Agent: Mozilla Thunderbird
References: <20250128144649.1956159-1-wanry@yunsilicon.com>
 <2040007.zToM8qfIzz@thomas>
 <cd6b3b85-1356-4b59-a36a-c5ddb6ab4f64@yunsilicon.com>
 <3203749.TQGk6oTFT5@thomas>
To: "Thomas Monjalon" <thomas@monjalon.net>
From: "Renyong Wan" <wanry@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <71be3e4f-6411-48d4-bace-d27be9b94c17@yunsilicon.com>
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
Content-Transfer-Encoding: 7bit
In-Reply-To: <3203749.TQGk6oTFT5@thomas>
Received: from [127.0.0.1] ([114.93.246.172]) by smtp.feishu.cn with ESMTPS;
 Thu, 06 Feb 2025 00:43:47 +0800
Cc: <dev@dpdk.org>, <ferruh.yigit@amd.com>, <stephen@networkplumber.org>, 
 <qianr@yunsilicon.com>, <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, 
 <xudw@yunsilicon.com>, <jacky@yunsilicon.com>, <weihg@yunsilicon.com>
Subject: Re: [PATCH v7 04/15] net/xsc: add xsc dev ops to support VFIO driver
Mime-Version: 1.0
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

On 2025/2/5 23:45, Thomas Monjalon wrote:
> 05/02/2025 16:37, Renyong Wan:
>> On 2025/2/5 22:43, Thomas Monjalon wrote:
>>> 05/02/2025 15:37, Renyong Wan:
>>>> On 2025/2/5 19:44, Thomas Monjalon wrote:
>>>>> 28/01/2025 15:46, Renyong Wan:
>>>>>> XSC PMD is designed to support both VFIO and private kernel drivers.
>>>>> What's the benefit of private kernel drivers?
>>>>> Why are they private?
>>>> Hello Thomas,
>>>>
>>>> Thanks for your review.
>>>>
>>>> It can support the bifurcation model without unbinding the kernel
>>>> driver, by utilizing our private kernel driver in conjunction with
>>>> rdma-core. Currently, our kernel driver is not open-source, so it is
>>>> considered a private kernel driver. This patch series only supports the
>>>> VFIO driver. Our kernel driver is currently in the process of being
>>>> open-sourced on kernel.org, and once it is available there, we also plan
>>>> to submit the code that supports our kernel driver to DPDK.
>>> OK that's interesting, thank you.
>>>
>>> I think it would be the first DPDK driver to support both VFIO or bifurcated model.
>>> How will we choose which one to use? With devargs?
>>>
>>>
>> That's how we designed it.
>> We designed a low-level device operations framework named xsc_dev_ops to
>> support both VFIO drivers and kernel drivers. Each xsc_dev_ops is
>> registered before the main function runs. During the PCI device probe
>> phase, the XSC PMD selects the corresponding xsc_dev_ops based on
>> rte_pci_device->driver, therefore, there is no need for devargs.
> I don't understand.
> If both VFIO and the kernel driver are loaded,
> we'll scan the device twice?
> Will it be probed 2 times?
>
>
No, it won't probe twice.
I suppose that each PCI device will only be bound to either the VFIO 
driver or a kernel driver. The drv_flags of the xsc_pmd PCI driver will 
not preset with RTE_PCI_DRV_NEED_MAPPING. Therefore, in the 
rte_pci_probe_one_driver function, rte_pci_map_device() will not be 
called. After entering the probe phase of the xsc PMD PCI driver, 
rte_pci_map_device() will be called in xsc_dev_ops->init() based on 
whether it is a VFIO driver.

Thank you.

-- 
Best regards,
Renyong Wan
