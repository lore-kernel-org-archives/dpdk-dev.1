Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FB9606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Nov 2026 18:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dressler.pro header.i=@dressler.pro header.a=rsa-sha256 header.s=uddkim-202310 header.b=addleOXC
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 383A34026F;
	Mon, 16 Nov 2026 19:53:59 +0100 (CET)
Received: from smtp05-ext.udag.de (smtp05-ext.udag.de [62.146.106.75])
 by mails.dpdk.org (Postfix) with ESMTPS id 0168340150;
 Mon, 16 Nov 2026 19:53:57 +0100 (CET)
Received: from [192.168.0.40] (unknown [37.228.226.247])
 by smtp05-ext.udag.de (Postfix) with ESMTPA id 75501E00C9;
 Mon, 16 Nov 2026 19:53:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dressler.pro;
 s=uddkim-202310; t=1794855236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YnBzrL25C1en/sAlXs4GtN10s/s0NS6ZVdLESCrnngQ=;
 b=addleOXCVz1KtrSLa5OaKPAjjsNuNhkfgF3MF/7I/BxmISchWVGM4U28Unyw9bi4LvUvvg
 lpI2n+TZnUYbtrxg0R+k0cyJMm1WtQMUnS79KCidcs7aZBw8lYM/Lyv89gPLzD5r1dDZt3
 vf1Qt+mabUKub/drQypHtFYeLy1Z0Pf7sYPKilIcuyu6TBMTLLACd37NWlB4oADVvaDHQc
 UwK56BYND3eKrJzj91wDI2ZCjqBoNRcOQ21o9Ti/kK/Bdev4AzuKmQWRCG9Wk974J6W1Ju
 cnPxa6eeRxQkSvZOmrwPyz9sPb/5Ji3tvsXFc7LPzK7ArkjftoENUeTmFH3UbQ==
Authentication-Results: smtp05-ext.udag.de;
 auth=pass smtp.auth=dressler-pro-0001 smtp.mailfrom=frank@dressler.pro
Message-ID: <1601da16-4251-4b44-8190-4503574abc83@dressler.pro>
Date: Mon, 16 Nov 2026 18:53:54 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/af_packet: fix accidental fanout group ID reuse
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, stable@dpdk.org
References: <20261110190626.519592-1-frank@dressler.pro>
 <20261111104536.248312-1-frank@dressler.pro>
 <20261116094125.239f7bee@phoenix.local>
Content-Language: en-US
From: Frank Dressler <frank@dressler.pro>
In-Reply-To: <20261116094125.239f7bee@phoenix.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	PDS_PRO_TLD,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/16/26 17:41, Stephen Hemminger wrote:
> On Wed, 11 Nov 2026 10:45:36 +0000
> Frank Dressler <frank@dressler.pro> wrote:
> 
>> This fix ensures that the queues of an AF_PACKET vdev do not
>> accidentally join an already existing fanout group in the same netns.
>> Joining such a group would make each member receive only a fraction of
>> the packets.
>>
>> It sets the PACKET_FANOUT_FLAG_UNIQUEID flag for the first queue which
>> asks the kernel to allocate a new, unique fanout group ID, then asks the
>> kernel for that queue's fanout configuration which includes this
>> generated ID but not the flag anymore (the flag is ephemeral) and then
>> uses it for subsequent queues to make them join the same fanout group.
>>
>> The bug exists since the PMD's introduction in 2014:
>>
>>    # 2014 DPDK:
>>    $ git show 364e08f2bb:lib/librte_pmd_af_packet/rte_eth_af_packet.c |
>>        grep getpid
>>      fanout_arg = (getpid() ^ (*internals)->if_index) & 0xffff;
>>
>>    # v26.07:
>>    $ git show v26.07:drivers/net/af_packet/rte_eth_af_packet.c |
>>        grep getpid
>>      return (getpid() ^ if_index) & 0xffff;
>>
>> The chance for a collision might look low initially as it requires PIDs
>> to be equal mod 65536. But the chance is high for applications running
>> in containers having individual pidns but a shared netns, which can be
>> the case in a k8s pod, or also with manually started containers, e.g.
>> `--network ns:<path>` in Podman. The individual pidns increase the
>> chance of different processes having the same PID.
>>
>> To quickly reproduce the issue, you can start multiple AF_PACKET DPDK
>> applications with qpairs greater than 1, prefixing them with
>> `unshare --fork -p` to have each one get the same PID as if they were
>> executed in a container. Each one then only receives a fraction of
>> the traffic.
>>
>> The used UNIQUEID fanout flag is available since Linux v4.12, while DPDK
>> currently requires Linux v5.4 or newer. The change is also compatible
>> with RHEL 8.
>>
>> Fixes: 364e08f2bbc0 ("af_packet: add PMD for AF_PACKET-based virtual devices")
>> Cc: stable@dpdk.org
>>
>> Signed-off-by: Frank Dressler <frank@dressler.pro>
>> ---
> 
> Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
> 
> The commit message is way to long though. Will chop it during merge.

Thank you.

> You need to tell you AI to be concise. I have started using multiple
> prompts to tell it to not repeat.
> 

I did try let AI generate the commit message but it was too short and 
did not give me the impression that a reader without my context could 
easily understand and review the issue. So I wrote my own message.

This is not the first time people think I used AI when I did not. It is 
always very demotivating. 
https://github.com/secdev/scapy/issues/4964#issuecomment-6124262531 But 
I understand when people think things are AI even when they are not 
given the amount of AI generated content.

I'll try writing more concise messages in the future.

> The kernel review prompt includes /kslop skill which has:
> https://github.com/masoncl/review-prompts/blob/main/kernel/slop-indicators.md
> 

It would feel weird applying AI-detection stuff to hand-written commits 
just to make sure people relying on it do not get confused by such 
broken tools that lead to miscategorizations.

> AI even flagged that:
> 

I started to run the AI patch review locally a while ago after noticing 
its horrible quality to prevent sending unnecessary patch versions. When 
I run it with just `./devtools/ai/review-patch.py <patch>` it says

	Error: API error: {'type': 'not_found_error', 'message': 'model: 
claude-sonnet-4-5-20250929'}

So I switched it to claude-sonnet-4-6 and that just outputs some very 
stupid comments that read like "I found a bug. ... Oh, no, it is not a 
bug. Actually, re-reading the logic carefully ... This is correct. There 
is one real issue: ... This is correct. No correctness errors found ... 
Warning: ... No issue. ... No Errors or Warnings found." With 
claude-opus-5-5 it becomes sane or broken because it just says "No 
issues found. Review-Result: CLEAN"

> 
> Logic is correct. The kernel clears PACKET_FANOUT_FLAG_UNIQUEID from
> the stored group flags after allocating the id, and PACKET_FANOUT
> getsockopt returns id | type << 16 | flags << 24, which is exactly
> the encoding fanout_add() needs for the later queues to pass the
> match->flags/type checks and join. DEFRAG, ROLLOVER and
> IGNORE_OUTGOING survive the round trip unchanged.
> 
> Info
> 
> The commit message is longer than it needs to be. The two git show
> transcripts repeat what the Fixes: tag already says; dropping them
> and the "This fix ensures" opener would leave something like:
> 
>    The fanout group id was derived from (getpid() ^ ifindex), so
>    processes in separate pid namespaces sharing a netns (e.g. a k8s
>    pod) can pick the same id. Their queues then join one fanout group
>    and each process sees only part of the traffic.
> 
>    Use PACKET_FANOUT_FLAG_UNIQUEID on the first queue so the kernel
>    allocates an unused id, then read it back with getsockopt and use
>    it for the remaining queues.
> 
>    PACKET_FANOUT_FLAG_UNIQUEID is available since Linux 4.12.
> 
> Worth one sentence: this also fixes two af_packet vdevs on the same
> interface in one process, which previously shared a group because
> pid and ifindex were identical.


How do I reproduce this output? Is it created with the review-patch.py tool?

