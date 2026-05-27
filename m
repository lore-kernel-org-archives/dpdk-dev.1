Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5975CD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 09:54:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCF9140285;
	Wed, 27 May 2026 11:54:19 +0200 (CEST)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com
 [113.46.200.222])
 by mails.dpdk.org (Postfix) with ESMTP id EE4584026C
 for <dev@dpdk.org>; Wed, 27 May 2026 11:54:18 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=7a/i3qYuzU3i9aatCzOP7mip8hS+4KNzp9Ojo1LksxU=;
 b=oOA74eUS4Zcb5T9ry2/LgsxuBy23HdKvZuF8e6/W19fGLzBax61+xPatKE/EoLSF4kU2bJkr2
 sj8w3snDOwJt6PA7FJ0eg3ujApQlRZ1QxscGEB422AO4ZlJ+M++482YooAZNm3+pmAxAZiJZanE
 kHrdk/GM3wgXb7kxbZeIx0g=
Received: from mail.maildlp.com (unknown [172.19.163.214])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gQPs20r7BzLlT6;
 Wed, 27 May 2026 17:46:30 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 6802E4056F;
 Wed, 27 May 2026 17:54:15 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 27 May 2026 17:54:13 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 27 May
 2026 17:54:12 +0800
Message-ID: <5d303b47-aae9-4e0c-ba6c-e1d5ab607f74@huawei.com>
Date: Wed, 27 May 2026 17:54:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 00/15] power: unify and improve lcore ID verification
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>, <dev@dpdk.org>, 
 <thomas@monjalon.net>, <fengchengwen@huawei.com>, <yangxingui@huawei.com>, 
 <zhanjie9@hisilicon.com>
References: <20260416030612.2379407-1-lihuisong@huawei.com>
 <20260507024230.1198111-1-lihuisong@huawei.com>
 <20260518105954.2309f802@phoenix.local>
 <a7483ea3-1ad7-4bb5-91d5-fa8539331c98@huawei.com>
 <20260526121813.0e15163e@phoenix.local>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20260526121813.0e15163e@phoenix.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.59]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemn100009.china.huawei.com (7.202.194.112)
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


On 5/27/2026 3:18 AM, Stephen Hemminger wrote:
> On Tue, 19 May 2026 21:09:47 +0800
> "lihuisong (C)" <lihuisong@huawei.com> wrote:
>
>> Thanks for giving me this AI review feedback.
>> Some of them are still acceptable. will fix it in next version.
>>
>> Is this summary from AI generated for each patche series?
>> May ask where you obtained this information about AI review?
> There is automated review from CI which is done after CI tests runs pass.
> But it is using older version of AGENTS.md and missing tool skills support.
> I use Claude AI project with current version of AGENTS.md.
> It gives the best reviews since it is willing to go look at the existing code.
> Other methods just look at the patch itself.
Got it. Thanks for your AI review.
