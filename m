Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24440C02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 09:28:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3EC03402CE;
	Thu,  6 Feb 2025 10:28:53 +0100 (CET)
Received: from lf-1-37.ptr.blmpb.com (lf-1-37.ptr.blmpb.com [103.149.242.37])
 by mails.dpdk.org (Postfix) with ESMTP id E10FA4026C
 for <dev@dpdk.org>; Thu,  6 Feb 2025 10:28:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1738834126; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Tbi8erE5JgfP6pMWt8xAfSTps0BJdrA7sjrXhnZEJh4=;
 b=H+YF13PENvm0kVrb2aEJu1bqtWAUJ5O48Po+I+nEmsPBtI5kbK9qKpSp31MfNyzuC9Xt8+
 el3TA/XpNm1dayomumsjM/hJfH47tWlgeg9J1hDaU7N5FfnjJAJtal9PMiEsKq7xvZXF7k
 MSW56yjRiXIoUBQhsCesZluSuALFlyylZWRLh6ZnkuzPFQmj2Leo+plFTMojq59RU5b2SV
 NhZhGvYzHwXr+68ZEixBrJ+8YQL5C0YHEimF8YY5/+rDl3D72csAeyFuuLKfB+YMgJHkuP
 slt+orMiRIjMCof2zka6XdW7Vmu4N7Bv1gEjSiCpfAUdIfA2vwKUJ6VUwcjoDw==
In-Reply-To: <CAJFAV8yYnCP5AKJdPYQ5PcXR4vX135QbOxfqMqKA2hyREf=Y5A@mail.gmail.com>
User-Agent: Mozilla Thunderbird
To: "David Marchand" <david.marchand@redhat.com>
Content-Type: text/plain; charset=UTF-8
References: <20250128144649.1956159-1-wanry@yunsilicon.com>
 <2040007.zToM8qfIzz@thomas>
 <cd6b3b85-1356-4b59-a36a-c5ddb6ab4f64@yunsilicon.com>
 <3203749.TQGk6oTFT5@thomas>
 <71be3e4f-6411-48d4-bace-d27be9b94c17@yunsilicon.com>
 <CAJFAV8yYnCP5AKJdPYQ5PcXR4vX135QbOxfqMqKA2hyREf=Y5A@mail.gmail.com>
Cc: "Thomas Monjalon" <thomas@monjalon.net>, <dev@dpdk.org>, 
 <ferruh.yigit@amd.com>, <stephen@networkplumber.org>, 
 <qianr@yunsilicon.com>, <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, 
 <xudw@yunsilicon.com>, <jacky@yunsilicon.com>, <weihg@yunsilicon.com>
Message-Id: <ae275da8-8a26-473a-a447-902c30cd6e39@yunsilicon.com>
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
X-Lms-Return-Path: <lba+267a480cc+32aa5e+dpdk.org+wanry@yunsilicon.com>
Received: from [127.0.0.1] ([114.93.246.172]) by smtp.feishu.cn with ESMTPS;
 Thu, 06 Feb 2025 17:28:43 +0800
Content-Transfer-Encoding: 7bit
From: "Renyong Wan" <wanry@yunsilicon.com>
Subject: Re: [PATCH v7 04/15] net/xsc: add xsc dev ops to support VFIO driver
Date: Thu, 6 Feb 2025 17:28:42 +0800
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

On 2025/2/6 0:54, David Marchand wrote:
>> No, it won't probe twice.
>> I suppose that each PCI device will only be bound to either the VFIO
>> driver or a kernel driver. The drv_flags of the xsc_pmd PCI driver will
>> not preset with RTE_PCI_DRV_NEED_MAPPING. Therefore, in the
>> rte_pci_probe_one_driver function, rte_pci_map_device() will not be
>> called. After entering the probe phase of the xsc PMD PCI driver,
>> rte_pci_map_device() will be called in xsc_dev_ops->init() based on
>> whether it is a VFIO driver.
> (side note, this means that this driver should probably call
> rte_pci_unmap_device() in its release path, though I see none)
Hello David,

You're absolutely right, thank you very much for the notice, it does 
seem like an oversight that rte_pci_unmap_device() is missing in the 
driver's release path, I will fix it in the next submission.

-- 
Best regards,
Renyong Wan
