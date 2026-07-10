Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7001C43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 07:57:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB58040274;
	Fri, 10 Jul 2026 09:57:53 +0200 (CEST)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com
 [113.46.200.222])
 by mails.dpdk.org (Postfix) with ESMTP id 22AE24026A
 for <dev@dpdk.org>; Fri, 10 Jul 2026 09:57:52 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=vb+UBgKP7T1V5vG3U3jZK9ID6rRxzwkJKlhoo8h23s0=;
 b=qUTQ/fAwZye0RlWfaiBahs0iSVlyN/5MRUND09pRL5E5yyrIKb1plMwAJLsCRJ5UeAGgWCLRT
 w6FAT9zslMWrbrQkQ9Ly+hf+FXY+r8HyejUYuuuXj6DP43gBfbXhtwoy9O1Q4syGg0UQP3pNm+d
 KqixRGpjN2UHJ0DVYTsocEY=
Received: from mail.maildlp.com (unknown [172.19.162.92])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gxP8f0tClzLlXD;
 Fri, 10 Jul 2026 15:48:34 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id 5632F40586;
 Fri, 10 Jul 2026 15:57:49 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 10 Jul 2026 15:57:48 +0800
Message-ID: <c5331090-0d39-4479-8de5-44b95d364b55@huawei.com>
Date: Fri, 10 Jul 2026 15:57:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] dma/ae4dma: add data path operations
To: Raghavendra Ningoji <raghavendra.ningoji@amd.com>, <dev@dpdk.org>
CC: David Marchand <david.marchand@redhat.com>, Bruce Richardson
 <bruce.richardson@intel.com>, <Selwin.Sebastian@amd.com>, Bhagyada Modali
 <bhagyada.modali@amd.com>, Robin Jarry <rjarry@redhat.com>, Thomas Monjalon
 <thomas@monjalon.net>
References: <aa1b5a05-976f-4dfa-89bc-4cea18b56d33@huawei.com>
 <20260710072250.3034265-2-raghavendra.ningoji@amd.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260710072250.3034265-2-raghavendra.ningoji@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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

On 7/10/2026 3:22 PM, Raghavendra Ningoji wrote:
> On Mon, 7 Jul 2026 at 06:49, fengchengwen <fengchengwen@huawei.com> wrote:
>>
>>> +	if (last_idx != NULL)
>>> +		*last_idx = (uint16_t)(cmd_q->next_read - 1);
>>
>> 1\ the last_idx always non-NULL for driver, so no need for
>>    'if (last_idx != NULL)'
>> 2\ last_idx should be the last success completed index
> 
> Both fixed in v5. The NULL check is dropped, and last_idx now reports
> the ring_idx of the last *successfully* completed op.
> 
>> Consider four reqests, the hardware mark each request as following:
>>     req1   success
>>     req2   err
>>     req3   success
>>     req4   err
>> the cpl_count will be 4, and err_count will be 2
>> It will return 2 in current impl, and last_idx will be the req4's
>> But in this function, it should return 1, and last_idx should be req1's
> 
> Agreed - thanks for the clear example. rte_dma_completed() is reworked
> in v5 to stop at the first failed descriptor: it returns only the run of
> successful ops preceding the error (1 in your example), sets *has_error,
> and leaves the failed op in place with last_idx pointing at the last
> success (req1). The failed op and everything after it are then drained
> and reported by rte_dma_completed_status().
> 
> On a related note, while implementing the above I found the last_idx
> documentation for rte_dma_completed() and rte_dma_completed_status()
> to be identical:
> 
>     @param[out] last_idx
>       The last completed operation's ring_idx.
> 
> Since rte_dma_completed() only reports operations that completed
> *successfully* (it stops at the first error), its last_idx is really the
> last successfully completed operation's ring_idx, whereas for
> rte_dma_completed_status() it is the last completed operation regardless
> of status. Would a small doc clarification along these lines be welcome
> (as a separate patch)?

I think it is necessary to update.
Please also update rte_dma_completed_status, both in a separate patch

Thanks

> 
>     rte_dma_completed():
>     @param[out] last_idx
>       The last successfully completed operation's ring_idx.
> 
> I'm happy to send that as a separate dmadev doc patch if you agree.
> 
> Thanks,
> Raghavendra

