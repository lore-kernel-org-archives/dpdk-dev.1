Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70429606A31B
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 08:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=D1NhN3+R
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1CDF4026E;
	Wed,  4 Nov 2026 09:53:08 +0100 (CET)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com
 [113.46.200.217])
 by mails.dpdk.org (Postfix) with ESMTPS id 111EB40151
 for <dev@dpdk.org>; Wed,  4 Nov 2026 09:53:06 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=r50bIS5AMHXlgQPRQO5UPFq9oGaS/YE4ab7aPXKlGY4=;
 b=D1NhN3+R1q9LABhi1iyPcqu4KC8VRXEQ+KvAHIfUPkECHZeiD/vuCgl8JOfyfo34UxXE+69qY
 EVcy5dVNLWg5MfA0usyz6ftyG/0EVI3jFIVhqXgCIy5MiZ/58hlp8xAEjmptI9V0OnA6fxA+1eK
 aMucrRb7DQbZTsNscwC8SJA=
Received: from mail.maildlp.com (unknown [172.19.163.0])
 by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4jKK2W0KbRzcZy0;
 Wed,  4 Nov 2026 16:52:35 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id BB52040561;
 Wed,  4 Nov 2026 16:53:01 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 4 Nov 2026 16:53:01 +0800
Message-ID: <6f636a89-88f7-44c7-b87c-b55075bcff6c@huawei.com>
Date: Wed, 4 Nov 2026 16:53:00 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 001/227] eal: add NUMA-aware APIs
To: Stephen Hemminger <stephen@networkplumber.org>, Chengwen Feng
 <chengwen.feng@linux.dev>
CC: <thomas@monjalon.net>, <konstantin.v.ananyev@yandex.ru>, <dev@dpdk.org>
References: <20261103145306.487255-1-chengwen.feng@linux.dev>
 <20261103145306.487255-2-chengwen.feng@linux.dev>
 <20261104083332.54b44fd0@stephen-xps.local>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20261104083332.54b44fd0@stephen-xps.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/4/2026 3:33 PM, Stephen Hemminger wrote:
> On Tue,  3 Nov 2026 22:49:19 +0800
> Chengwen Feng <chengwen.feng@linux.dev> wrote:
> 
>> From: Chengwen Feng <fengchengwen@huawei.com>
>>
>> DPDK has long used socket_id terminology for NUMA allocation,
>> which conflates CPU sockets with NUMA memory nodes.
>>
>> Add NUMA-named APIs while keeping the legacy socket-named ones
>> as functional aliases (to be deprecated once the in-tree
>> migration completes):
>>
>> - rte_numa_id(), rte_numa_count(), rte_numa_id_by_idx()
>> - rte_lcore_to_numa_id()
>> - rte_cpu_numa_id() (renamed from experimental rte_cpu_socket_id())
>> - rte_malloc_numa(), rte_zmalloc_numa(), rte_calloc_numa(),
>>   rte_realloc_numa()
>> - rte_malloc_get_numa_stats() and struct rte_malloc_numa_stats
>> - rte_malloc_heap_get_numa_id(), rte_malloc_heap_numa_is_external()
>> - RTE_NUMA_ID_ANY constant (legacy SOCKET_ID_ANY kept as alias)
>>
>> Convert EAL internals, comments, log messages and telemetry keys
>> to the NUMA node terminology, and update the EAL programmer guide
>> accordingly.
>>
>> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> 
> Getting rid of socket as terminology looks like a good thing.
> One important step would to make sure DPDK usage matches other libraries
> like libnuma.  It would be good to avoid NIH as much as possible

Thanks for your feedback. I agree that aligning with libnuma conventions
is important and will help avoid NIH patterns.

I will check the semantics and naming of these new NUMA APIs against
libnuma, and adjust where needed to follow existing Linux NUMA practice.
