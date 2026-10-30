Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062EF606A337
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 10:52:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0F5C40299;
	Fri, 30 Oct 2026 11:52:05 +0100 (CET)
Received: from forward501d.mail.yandex.net (forward501d.mail.yandex.net
 [31.44.14.17]) by mails.dpdk.org (Postfix) with ESMTPS id AF97440285
 for <dev@dpdk.org>; Fri, 30 Oct 2026 11:52:04 +0100 (CET)
Received: from mail-nwsmtp-smtp-production-main-54
 (mail-nwsmtp-smtp-production-main-54.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:6543:0:640:e955:0])
 by forward501d.mail.yandex.net (postfix) with ESMTPS id C738B806EB;
 Fri, 30 Oct 2026 13:52:03 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-54 with ESMTPSA id
 0qhDWLaew8c0-emrdnbmW; Fri, 30 Oct 2026 13:52:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1793357523; bh=e9FF2+Dfu48zi7EqloUit00wHqakW0dQyyX5miWCTvE=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=EbQQu4izq8fXysswbiBGO5389dog7XwfDQQ+V7ntEo3jg6ttri5RCA5ASnlQU0fYY
 CREHgC5+GsjUCnpBh0987mVkHA5vJr6ILDO+LLSs4owctuNZnQqIVheSGZ5CaK1P86
 MZyh8HDcxRUHnwZvswNYoormGOa1VB6+aQ9a28T8=
Authentication-Results: mail-nwsmtp-smtp-production-main-54;
 dkim=pass header.i=@yandex.ru
Message-ID: <01008a9c-7217-4a3a-a633-b89ee4c97d65@yandex.ru>
Date: Fri, 30 Oct 2026 10:52:00 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] examples/l3fwd: dynamic NUMA-aware alloc lcore_conf
To: fengchengwen <fengchengwen@huawei.com>, thomas@monjalon.net,
 stephen@networkplumber.org
Cc: dev@dpdk.org
References: <20260623032301.17570-1-fengchengwen@huawei.com>
 <20261029025428.36644-1-fengchengwen@huawei.com>
 <18de0d12-a133-4097-abdb-36a86ea02402@yandex.ru>
 <c42caa92-ecd7-4e78-a864-a0ef451a9f61@huawei.com>
Content-Language: en-US, ru
From: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
In-Reply-To: <c42caa92-ecd7-4e78-a864-a0ef451a9f61@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> On 10/29/2026 5:19 PM, Konstantin Ananyev wrote:
>>
>>
>>> Currently lcore_conf is a global static array. When multiple
>>> ports/lcores are distributed across different NUMA nodes, datapath
>>> suffers from severe cross-NUMA memory access penalty.
>>>
>>> On Kunpeng platform, sizeof(struct lcore_conf) reaches 133760 bytes.
>>> Such a huge per-lcore structure significantly amplifies cross-NUMA
>>> overhead in multi-port multi-NUMA deployment scenarios.
>>>
>>> This commit refactors lcore_conf to pointer array and implements
>>> per-lcore NUMA-aware hugepage allocation, allocating each lcore's
>>> configuration on its local socket to eliminate remote memory access.
>>>
>>> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
>>>
>>> ---
...
>>> +}
>>> +
>>> +static int
>>> +init_lcore_conf(void)
>>> +{
>>> +    unsigned int lcore_id;
>>> +    int socketid;
>>> +
>>> +    for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
>>> +        if (rte_lcore_is_enabled(lcore_id) == 0)
>>> +            continue;
>>> +
>>> +        socketid = numa_on ? rte_lcore_to_socket_id(lcore_id) : 0;
>> Shouldn't it be SOCKET_ID_ANY (-1) instead of zero, when NUMA is disabled?
> OK, already fix in v4
>
> BTW: SOCKET_ID_ANY seemed need redefined as RTE_SOCKET_ID_ANY, If there is no
>       objection, I will make the changes in the next independent patch.

Yep, that's probably a good thing to do, and probably 26.11 is a good 
time to do that.
BTW, I think it was discussed before, but I can't remember why we didn't 
fix it so far.
Konstantin

>
> Thanks,
> Chengwen
>
>
