Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E20CA1010
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Sep 2025 00:24:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2508840609;
	Thu,  4 Sep 2025 02:24:53 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mails.dpdk.org (Postfix) with ESMTP id 4462440270
 for <dev@dpdk.org>; Thu,  4 Sep 2025 02:24:51 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cHKw84YM0ztScW;
 Thu,  4 Sep 2025 08:23:52 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id DF2B7140278;
 Thu,  4 Sep 2025 08:24:48 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 4 Sep 2025 08:24:48 +0800
Message-ID: <abd687d3-acb9-4692-98a4-73ec03154efe@huawei.com>
Date: Thu, 4 Sep 2025 08:24:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] add semicolon when export any symbol
To: David Marchand <david.marchand@redhat.com>
CC: <thomas@monjalon.net>, <stephen@networkplumber.org>, <dev@dpdk.org>, Bruce
 Richardson <bruce.richardson@intel.com>
References: <20250828025957.30917-1-fengchengwen@huawei.com>
 <20250903020547.12347-1-fengchengwen@huawei.com>
 <CAJFAV8yTwKR3oBJ-N68je_=aUL5Dg4_h_H8zgB3ZvLzrLbQtNQ@mail.gmail.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <CAJFAV8yTwKR3oBJ-N68je_=aUL5Dg4_h_H8zgB3ZvLzrLbQtNQ@mail.gmail.com>
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

Hi David,

On 9/3/2025 3:04 PM, David Marchand wrote:
> Hello,
> 
> On Wed, 3 Sept 2025 at 04:05, Chengwen Feng <fengchengwen@huawei.com> wrote:
>>
>> Currently, the RTE_EXPORT_INTERNAL_SYMBOL, RTE_EXPORT_SYMBOL and
>> RTE_EXPORT_EXPERIMENTAL_SYMBOL are placed at the beginning of APIs,
>> but don't end with a semicolon. As a result, some IDEs cannot identify
>> the APIs and cannot quickly jump to the definition.
>>
>> A semicolon is added to the end of above RTE_EXPORT_XXX_SYMBOL in this
>> commit.
>>
>> And also redefine RTE_EXPORT_XXX_SYMBOL:
>> #define RTE_EXPORT_XXX_SYMBOL(x, x) extern int dummy_rte_export_symbol
>>
>> Chengwen Feng (5):
>>   lib: add semicolon when export symbol
>>   lib: add semicolon when export experimental symbol
>>   lib: add semicolon when export internal symbol
>>   drivers: add semicolon when export any symbol
>>   doc: update ABI versioning guide
> 
> I am skeptical about this series.
> 
> The current positionning should be seen as an additional info on the
> return type, in the definition of the symbol.
> Does it mean that this IDE would fail if we add any kind of
> macros/attribute involving the symbol name?

I tried vscode and SI (source insight), and found user could use "token macro" in SI
to make the IDE skip such symbol (so use ctrl+ will quick jump to definition), but
I can't find such setting for vscode.

> 
> Afaics, ctags can be taught to skip those macros and just behaves
> correctly by adding in its config file:
> -DRTE_EXPORT_EXPERIMENTAL_SYMBOL(a)=
> -DRTE_EXPORT_INTERNAL_SYMBOL(a)=
> -DRTE_EXPORT_SYMBOL(a)=

How about add note in DPDK document if don't apply this commit?

> 
> I think another option would be to move the call to export macros
> after the whole definition of the symbol, though I prefer the current
> position for readability.

If not add a semi, it will affect next API:
int A()
RTE_EXPORT_SYMBOL(A)

int B()

> 
> 

