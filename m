Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C27CA0EC4
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 02:00:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9226F4025D;
	Wed, 13 Aug 2025 04:00:35 +0200 (CEST)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mails.dpdk.org (Postfix) with ESMTP id 885F4400EF
 for <dev@dpdk.org>; Wed, 13 Aug 2025 04:00:34 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.163])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c1s2m3bBDz2TT1M;
 Wed, 13 Aug 2025 09:57:52 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 415021800B2;
 Wed, 13 Aug 2025 10:00:32 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 Aug 2025 10:00:31 +0800
Message-ID: <7e2a7b7f-3219-43dc-8a7d-2e60cc52168e@huawei.com>
Date: Wed, 13 Aug 2025 10:00:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/22] stack: fix unaligned accesses on 128-bit
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: Bruce Richardson <bruce.richardson@intel.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Olivier Matz <olivier.matz@6wind.com>, Gage
 Eads <gage.eads@intel.com>, Honnappa Nagarahalli
 <honnappa.nagarahalli@arm.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250723133157.159825-1-david.marchand@redhat.com>
 <20250723133157.159825-10-david.marchand@redhat.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250723133157.159825-10-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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

Acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 7/23/2025 9:31 PM, David Marchand wrote:
> Caught by UBSan:
> 
> ../lib/eal/x86/include/rte_atomic_64.h:206:21: runtime error:
> 	member access within misaligned address 0x7ffd9c67f228 for
> 	type 'const rte_int128_t', which requires 16 byte alignment
> 	0x7ffd9c67f228: note: pointer points here
>  00 00 00 00  c0 5d 3e 00 01 00 00 00  01 00 00 00 00 00 00 00
>               ^
>  00 00 00 00 00 00 00 00  00 00 00 00
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
> 	../lib/eal/x86/include/rte_atomic_64.h:206:21 in
> 	../lib/eal/x86/include/rte_atomic_64.h:206:21: runtime error:
> 	member access within misaligned address 0x7ffd9c67f228 for type
> 	'const union rte_int128_t::(anonymous at
> 	../lib/eal/include/generic/rte_atomic.h:1102:2)', which requires
> 	16 byte alignment
> 0x7ffd9c67f228: note: pointer points here
>  00 00 00 00  c0 5d 3e 00 01 00 00 00  01 00 00 00 00 00 00 00
>               ^
>  00 00 00 00 00 00 00 00  00 00 00 00
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
> 	../lib/eal/x86/include/rte_atomic_64.h:206:21 in
> 	../lib/eal/x86/include/rte_atomic_64.h:206:16: runtime error:
> 	load of misaligned address 0x7ffd9c67f228 for type
> 	'const uint64_t' (aka 'const unsigned long'), which requires
> 	16 byte alignment
> 0x7ffd9c67f228: note: pointer points here
>  00 00 00 00  c0 5d 3e 00 01 00 00 00  01 00 00 00 00 00 00 00
>               ^
>  00 00 00 00 00 00 00 00  00 00 00 00
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
> 	../lib/eal/x86/include/rte_atomic_64.h:206:21 in
> 
> Rather than explicitly set alignment in callers, mark the structure
> itself with an alignment constraint.
> 
> Fixes: 3340202f5954 ("stack: add lock-free implementation")
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

