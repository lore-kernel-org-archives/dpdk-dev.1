Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8685EC02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 14:37:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 443E74029A;
	Wed,  5 Feb 2025 15:37:39 +0100 (CET)
Received: from lf-2-19.ptr.blmpb.com (lf-2-19.ptr.blmpb.com [101.36.218.19])
 by mails.dpdk.org (Postfix) with ESMTP id 5E04240270
 for <dev@dpdk.org>; Wed,  5 Feb 2025 15:37:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1738766246; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=fxP2DWzHS6UnIWzDtbSb3GT0LohrkiYS2rA5ZC+OMRM=;
 b=HIPrB5SLM+Tclq1CAJW9iUA+BggJZjh9xJh2PJ5CpWIW27DnWPSL0IABF5zMpszJ+pRh9h
 SQKh/hHBFgTuMEyqUdtBg9HOer00LLKqt59Mh5Xk9ZPa0sZvDYxoyqCcdn1ZE9TtDOmUsj
 Yb7TN/tTaaWOPFgMjqmie+PhXQ7Y2lZdxlUsgDdC+3t52msKwb9hEq6mpzFgx0ElsxFB5Y
 u2HYhpHh1Dm43hKVw48RoBjjI0+KCFojRNy8cP9qTKVEODT/Lg62FYSsGUgKW3wfJO56si
 rOnZnog9d7zD96/TbMGF4tUVLxbZy6hlb/v+dexfgoSuPwZe7NTTi8EhpyRi2Q==
Message-Id: <8fcb134d-3d79-447b-b673-6dae8186744a@yunsilicon.com>
References: <20250128144649.1956159-1-wanry@yunsilicon.com>
 <20250128144655.1956159-5-wanry@yunsilicon.com> <1873236.BzM5BlMlMQ@thomas>
Cc: <dev@dpdk.org>, <ferruh.yigit@amd.com>, <stephen@networkplumber.org>, 
 <qianr@yunsilicon.com>, <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, 
 <xudw@yunsilicon.com>, <jacky@yunsilicon.com>, <weihg@yunsilicon.com>
Subject: Re: [PATCH v7 04/15] net/xsc: add xsc dev ops to support VFIO driver
Content-Type: text/plain; charset=UTF-8
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
To: "Thomas Monjalon" <thomas@monjalon.net>
Date: Wed, 5 Feb 2025 22:37:25 +0800
User-Agent: Mozilla Thunderbird
X-Lms-Return-Path: <lba+267a377a4+6a8993+dpdk.org+wanry@yunsilicon.com>
In-Reply-To: <1873236.BzM5BlMlMQ@thomas>
From: "Renyong Wan" <wanry@yunsilicon.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from [127.0.0.1] ([114.93.246.172]) by smtp.feishu.cn with ESMTPS;
 Wed, 05 Feb 2025 22:37:23 +0800
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

On 2025/2/5 19:44, Thomas Monjalon wrote:
> 28/01/2025 15:46, Renyong Wan:
>> XSC PMD is designed to support both VFIO and private kernel drivers.
> What's the benefit of private kernel drivers?
> Why are they private?
>
>
>
Hello Thomas,

Thanks for your review.

It can support the bifurcation model without unbinding the kernel 
driver, by utilizing our private kernel driver in conjunction with 
rdma-core. Currently, our kernel driver is not open-source, so it is 
considered a private kernel driver. This patch series only supports the 
VFIO driver. Our kernel driver is currently in the process of being 
open-sourced on kernel.org, and once it is available there, we also plan 
to submit the code that supports our kernel driver to DPDK.

-- 
Best regards,
Renyong Wan
