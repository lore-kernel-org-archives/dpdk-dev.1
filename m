Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88B4C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 15:37:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12A0940289;
	Wed,  5 Feb 2025 16:37:15 +0100 (CET)
Received: from lf-2-19.ptr.blmpb.com (lf-2-19.ptr.blmpb.com [101.36.218.19])
 by mails.dpdk.org (Postfix) with ESMTP id 77ABB40270
 for <dev@dpdk.org>; Wed,  5 Feb 2025 16:37:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1738769822; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=MHM9jgvBUkJfsyIWi91gCuVLonEQCpUUlf0Ta5k4aNQ=;
 b=Cfy6Zw0D/Qi+m/YvL22O8MZfj/bVQcJ8lInmZ3PI0pS1y/BODVtpA5AKXWh9mkuYw+YElk
 vr5btfrEnuHlG7ADPvUht7L9lkgOuw8q6VB51EN6PKlzS7uxDRtXajJNXIKUx+Fk70M3t3
 QD0rekhcsaGTL8H6gVLBB7ApHi+EBM8NlpLQowDZC103Zgf21ahuvEUq6ZT6ivbuu4wgJU
 g15BKPd4cIdZMRIXJPEQ4ZdUIbcovX9trQdgT05q8T4faauzzcLPNHgz1TwrZkI5QVBuI0
 UnJG1sOmALIGz7JRXmBwYDsYfH1zoPKjha48XL7hEv+eqtA+rVlWmS0Wan+PjQ==
Message-Id: <cd6b3b85-1356-4b59-a36a-c5ddb6ab4f64@yunsilicon.com>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
X-Lms-Return-Path: <lba+267a3859c+c992f4+dpdk.org+wanry@yunsilicon.com>
References: <20250128144649.1956159-1-wanry@yunsilicon.com>
 <1873236.BzM5BlMlMQ@thomas>
 <8fcb134d-3d79-447b-b673-6dae8186744a@yunsilicon.com>
 <2040007.zToM8qfIzz@thomas>
To: "Thomas Monjalon" <thomas@monjalon.net>
Cc: <dev@dpdk.org>, <ferruh.yigit@amd.com>, <stephen@networkplumber.org>, 
 <qianr@yunsilicon.com>, <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, 
 <xudw@yunsilicon.com>, <jacky@yunsilicon.com>, <weihg@yunsilicon.com>
Subject: Re: [PATCH v7 04/15] net/xsc: add xsc dev ops to support VFIO driver
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
From: "Renyong Wan" <wanry@yunsilicon.com>
Date: Wed, 5 Feb 2025 23:37:01 +0800
Content-Transfer-Encoding: 7bit
In-Reply-To: <2040007.zToM8qfIzz@thomas>
Received: from [127.0.0.1] ([114.93.246.172]) by smtp.feishu.cn with ESMTPS;
 Wed, 05 Feb 2025 23:36:59 +0800
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

On 2025/2/5 22:43, Thomas Monjalon wrote:
> 05/02/2025 15:37, Renyong Wan:
>> On 2025/2/5 19:44, Thomas Monjalon wrote:
>>> 28/01/2025 15:46, Renyong Wan:
>>>> XSC PMD is designed to support both VFIO and private kernel drivers.
>>> What's the benefit of private kernel drivers?
>>> Why are they private?
>> Hello Thomas,
>>
>> Thanks for your review.
>>
>> It can support the bifurcation model without unbinding the kernel
>> driver, by utilizing our private kernel driver in conjunction with
>> rdma-core. Currently, our kernel driver is not open-source, so it is
>> considered a private kernel driver. This patch series only supports the
>> VFIO driver. Our kernel driver is currently in the process of being
>> open-sourced on kernel.org, and once it is available there, we also plan
>> to submit the code that supports our kernel driver to DPDK.
> OK that's interesting, thank you.
>
> I think it would be the first DPDK driver to support both VFIO or bifurcated model.
> How will we choose which one to use? With devargs?
>
>
That's how we designed it.
We designed a low-level device operations framework named xsc_dev_ops to 
support both VFIO drivers and kernel drivers. Each xsc_dev_ops is 
registered before the main function runs. During the PCI device probe 
phase, the XSC PMD selects the corresponding xsc_dev_ops based on 
rte_pci_device->driver, therefore, there is no need for devargs.

Thank you.

-- 
Best regards,
Renyong Wan
