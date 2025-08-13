Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399D5CA0EC4
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 01:07:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90D6F40670;
	Wed, 13 Aug 2025 03:07:25 +0200 (CEST)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mails.dpdk.org (Postfix) with ESMTP id A51BB4025D;
 Wed, 13 Aug 2025 03:07:23 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.162.112])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c1qsR0pqTz2Dc0c;
 Wed, 13 Aug 2025 09:04:43 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 5C2AB1401F2;
 Wed, 13 Aug 2025 09:07:22 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 Aug 2025 09:07:21 +0800
Message-ID: <4b82c78e-02db-4de7-976c-b670cb8bfd51@huawei.com>
Date: Wed, 13 Aug 2025 09:07:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/22] eal: fix plugin dir walk
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: <stable@dpdk.org>, Bruce Richardson <bruce.richardson@intel.com>, Tyler
 Retzlaff <roretzla@linux.microsoft.com>, Timothy Redaelli
 <tredaelli@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250723133157.159825-1-david.marchand@redhat.com>
 <20250723133157.159825-5-david.marchand@redhat.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250723133157.159825-5-david.marchand@redhat.com>
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

Acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 7/23/2025 9:31 PM, David Marchand wrote:
> For '.' and '..' directories (or any short file name),
> a out of bound issue occurs.
> 
> Caught by UBSan:
> 
> EAL: Detected shared linkage of DPDK
> ../lib/eal/common/eal_common_options.c:420:15: runtime error: index -2
> 	out of bounds for type 'char[256]'
>     #0 0x7f867eedf206 in eal_plugindir_init
> 	eal_common_options.c
>     #1 0x7f867eede58a in eal_plugins_init
> 	(build/lib/librte_eal.so.25+0xde58a)
> 	(BuildId: e7e4a1935e4bacb51c82ab1a84098a27decf3b4c)
>     #2 0x7f867efb8587 in rte_eal_init
> 	(build/lib/librte_eal.so.25+0x1b8587)
> 	(BuildId: e7e4a1935e4bacb51c82ab1a84098a27decf3b4c)
>     #3 0x55b62360861e in main
> 	(/home/runner/work/dpdk/dpdk/build/app/dpdk-testpmd+0x9e061e)
> 	(BuildId: d821ec918612c83fad8b5ccb6cc518e66bee48cd)
>     #4 0x7f8667429d8f in __libc_start_call_main
> 	csu/../sysdeps/nptl/libc_start_call_main.h:58:16
>     #5 0x7f8667429e3f in __libc_start_main
> 	csu/../csu/libc-start.c:392:3
>     #6 0x55b622d9d444 in _start
> 	(/home/runner/work/dpdk/dpdk/build/app/dpdk-testpmd+0x175444)
> 	(BuildId: d821ec918612c83fad8b5ccb6cc518e66bee48cd)
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
> 	../lib/eal/common/eal_common_options.c:420:15 in
> 	../lib/eal/common/eal_common_options.c:421:15:
> 	runtime error: index 18446744073709551609 out of bounds
> 	for type 'char[256]'
> 
> Fixes: c57f6e5c604a ("eal: fix plugin loading")
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

