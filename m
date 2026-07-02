Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCCCC43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Jul 2026 01:35:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52190402D1;
	Thu,  2 Jul 2026 03:35:41 +0200 (CEST)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com
 [113.46.200.227])
 by mails.dpdk.org (Postfix) with ESMTP id B435240285
 for <dev@dpdk.org>; Thu,  2 Jul 2026 03:35:39 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=zG0wrjtgnA6HJAMO/K/NP2HOY1JB90PSIi43YlVKE1Y=;
 b=57U8it4cixi3DxnlvLC5oQ0NdKdRSq1QqeQkQzO8PGjBcL3OkZkaH+i39t+uBnS1sgrDhpOI3
 cyypZPZPLYP17THi4/XurEFlcfYQdPcn27Qc2m6GAtcgHshWQt+NZdgHKYIofV49sXBGWfUpHCD
 hO0kcritPBdxNgMsK2t0c98=
Received: from mail.maildlp.com (unknown [172.19.163.214])
 by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4grK3x0P87znTVw;
 Thu,  2 Jul 2026 09:26:53 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id A1D344058B;
 Thu,  2 Jul 2026 09:35:32 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 2 Jul 2026 09:35:32 +0800
Message-ID: <257fb8fd-2850-4b31-aa9f-c1ef42897e7b@huawei.com>
Date: Thu, 2 Jul 2026 09:35:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fix dmadev incomplete ABI validation
To: David Marchand <david.marchand@redhat.com>, <datshan@qq.com>
CC: <thomas@monjalon.net>, <dev@dpdk.org>, Stephen Hemminger
 <stephen@networkplumber.org>, Bruce Richardson <bruce.richardson@intel.com>
References: <tencent_FD79B9DBEB2FD074BFAAACCC6DD7A6EBB906@qq.com>
 <CAJFAV8wOpRcDPip62f4EuAv_HDK_PuoGf75ZdqiKX3Er14OQXA@mail.gmail.com>
 <CAJFAV8z1qo-C7jvoUAWSuaysiB-7Lud+XkPgUEED_uAMGGAuuw@mail.gmail.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <CAJFAV8z1qo-C7jvoUAWSuaysiB-7Lud+XkPgUEED_uAMGGAuuw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo500009.china.huawei.com (7.202.194.199)
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

On 7/2/2026 1:01 AM, David Marchand wrote:
> On Wed, 1 Jul 2026 at 10:11, David Marchand <david.marchand@redhat.com> wrote:
>> On Tue, 30 Jun 2026 at 15:24, <datshan@qq.com> wrote:
>>>
>>> From: datshan <datshan@qq.com>
>>>
>>> Fix dmadev incomplete ABI validation.
>>>
>>> Chengwen Feng (2):
>>>   dmadev: fix incomplete configuration validation
>>>   test/dmadev: add config and vchan validation tests
>>>
>>>  app/test/test_dmadev_api.c | 186 ++++++++++++++++++++++++++++++++++---
>>>  lib/dmadev/rte_dmadev.c    | 156 +++++++++++++++++++++----------
>>>  2 files changed, 283 insertions(+), 59 deletions(-)
>>>
>>
>> This series is not versionned, but I guess this is a new revision.
>> Don't forget to flag your submissions with a version number in the future.
>> I marked the previous patches as superseded in patchwork.
>>
>> Also provide a high level summary of the differences between versions.
>>
>> All of those steps are listed in the contributing guide, I suggest
>> (re-)reading the whole guide, with a highlight on:
>> https://doc.dpdk.org/guides/contributing/patches.html#steps-to-getting-your-patch-merged
>>
>> Thanks, I'll try to find some time to review this week.
> 
> Well, enforcing *now* that some fields are 0 is actually breaking ABI
> for existing applications.
> This change should be deferred to 26.11, and backporting to a LTS is
> not possible.

OK
BTW: Should I submit another version in 26.11 cycle or do nothing?

> 
> Opinions?
> 
> 

