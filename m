Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15466CA0EED
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 01:37:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A38740276;
	Fri, 29 Aug 2025 03:37:10 +0200 (CEST)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mails.dpdk.org (Postfix) with ESMTP id 7450140263
 for <dev@dpdk.org>; Fri, 29 Aug 2025 03:37:08 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.162.112])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cCgm119wdz1R93g;
 Fri, 29 Aug 2025 09:34:09 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 251DC140277;
 Fri, 29 Aug 2025 09:37:06 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 29 Aug 2025 09:37:05 +0800
Message-ID: <6f88d1bd-234d-494d-87e1-b571ea522d44@huawei.com>
Date: Fri, 29 Aug 2025 09:37:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dpdk: support quick jump to API definition
From: fengchengwen <fengchengwen@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <thomas@monjalon.net>, <david.marchand@redhat.com>, <dev@dpdk.org>
References: <20250828024631.30759-1-fengchengwen@huawei.com>
 <20250828074706.3f1087f8@hermes.local>
 <83849498-c22a-44d3-b0ab-fb2887bbf536@huawei.com>
Content-Language: en-US
In-Reply-To: <83849498-c22a-44d3-b0ab-fb2887bbf536@huawei.com>
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

add more info

On 8/29/2025 9:31 AM, fengchengwen wrote:
> On 8/28/2025 10:47 PM, Stephen Hemminger wrote:
>> On Thu, 28 Aug 2025 10:46:31 +0800
>> Chengwen Feng <fengchengwen@huawei.com> wrote:
>>
>>> Currently, the RTE_EXPORT_INTERNAL_SYMBOL, RTE_EXPORT_SYMBOL and
>>> RTE_EXPORT_EXPERIMENTAL_SYMBOL are placed at the beginning of APIs,
>>> but don't end with a semicolon. As a result, some IDEs cannot identify
>>> the APIs and cannot quickly jump to the definition.
>>>
>>> A semicolon is added to the end of above RTE_EXPORT_XXX_SYMBOL in this
>>> commit.
>>>
>>> And also change the gen-version-map.py to ensure it only identifies
>>> RTE_EXPORT_XXX_SYMBOL that end with a semicolon.
>>>
>>> Signed
>>
>> Semicolon after macro will cause scripts like checkpatch to complain?
> 
> No
> 
> This commit trigger a checkpatch error because the following function add two semicolon.
> 
> RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_mbuf_dynfield_register, 25.07);;
> 
> 
> Because the RTE_EXPORT_XXX_SYMBOL(XXX) macro do nothing, and this macro are placed out side
> of function, it will left one semicolon after pre-process. This is not strictly comply with
> C stand syntax.
> 
> In the V2 I will adopt following:
> 1\ #define RTE_EXPORT_XXX_SYMBOL(XXX) extern int __dummy_unused__ , this definition is comply
>    with C stand syntax.
> 2\ keep the gen-version-map.py un-touch, because some commit are in-process different branch.

Two step:
1\ keep the RTE_EXPORT_XXX_SYMBOL definition and gen-version-map.py un-touched, and fix all CI error.
2\ #define RTE_EXPORT_XXX_SYMBOL(XXX) extern int __dummy_unused__ and modify remains or new definitions.

> 
> Thanks.

