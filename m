Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C34CAC586
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 12:43:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0412040156;
	Mon,  8 Sep 2025 14:43:19 +0200 (CEST)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mails.dpdk.org (Postfix) with ESMTP id A59BB4003C
 for <dev@dpdk.org>; Mon,  8 Sep 2025 14:43:16 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.17])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cL63j1Jtyz2TTKl;
 Mon,  8 Sep 2025 20:40:01 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id AD1E11A0190;
 Mon,  8 Sep 2025 20:43:14 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 8 Sep 2025 20:43:14 +0800
Message-ID: <7c15f99a-1f00-4347-888d-57b7fcdab57d@huawei.com>
Date: Mon, 8 Sep 2025 20:43:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] add semicolon when export any symbol
To: David Marchand <david.marchand@redhat.com>
CC: <thomas@monjalon.net>, <stephen@networkplumber.org>, <dev@dpdk.org>, Bruce
 Richardson <bruce.richardson@intel.com>
References: <20250828025957.30917-1-fengchengwen@huawei.com>
 <20250903020547.12347-1-fengchengwen@huawei.com>
 <CAJFAV8yTwKR3oBJ-N68je_=aUL5Dg4_h_H8zgB3ZvLzrLbQtNQ@mail.gmail.com>
 <abd687d3-acb9-4692-98a4-73ec03154efe@huawei.com>
 <CAJFAV8xY-hNK2yYoo7_KD5TAOxgPJt4RkR+kRnHDNh1jYuTHTQ@mail.gmail.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <CAJFAV8xY-hNK2yYoo7_KD5TAOxgPJt4RkR+kRnHDNh1jYuTHTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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

Hello,

On 9/8/2025 3:54 PM, David Marchand wrote:
> Hello,
> 
> On Thu, 4 Sept 2025 at 02:24, fengchengwen <fengchengwen@huawei.com> wrote:
>> On 9/3/2025 3:04 PM, David Marchand wrote:
>>> The current positionning should be seen as an additional info on the
>>> return type, in the definition of the symbol.
>>> Does it mean that this IDE would fail if we add any kind of
>>> macros/attribute involving the symbol name?
>>
>> I tried vscode and SI (source insight), and found user could use "token macro" in SI
>> to make the IDE skip such symbol (so use ctrl+ will quick jump to definition), but
>> I can't find such setting for vscode.
> 
> I asked someone who is more familiar with vscode than me (though she
> is not used to C language).
> Out of the box, this IDE could not understand C language, so she
> installed the C/C++ extension pack (version 1.3.1, on some Ubuntu).
> 
> And it seems the symbols are correctly found with current main branch.
> For example, opening only testpmd.c, rte_eal_init() mouse over shows
> the header content.
> In the same context, ctrl+clicking on rte_eal_init() in testpmd.c
> proposes to open lib/eal/linux/eal.c, with the focus on the symbol
> itself (and the RTE_EXPORT_SYMBOL macro is skipped).
> 
> Are you trying something different?

Thanks, I will check my IDE configuration.

This patchset could close I think, I will do it at patchwork later.

> 
> 
>>>
>>> Afaics, ctags can be taught to skip those macros and just behaves
>>> correctly by adding in its config file:
>>> -DRTE_EXPORT_EXPERIMENTAL_SYMBOL(a)=
>>> -DRTE_EXPORT_INTERNAL_SYMBOL(a)=
>>> -DRTE_EXPORT_SYMBOL(a)=
>>
>> How about add note in DPDK document if don't apply this commit?
> 
> We can add a generic mention that it might be necessary to configure
> the IDE, and give an example for ctags.

It could be better if have.

> 
> 

