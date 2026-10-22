Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13C7606A329
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 07:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=o4H3FfDe
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1144640299;
	Thu, 22 Oct 2026 09:38:30 +0200 (CEST)
Received: from forward504d.mail.yandex.net (forward504d.mail.yandex.net
 [31.44.14.20]) by mails.dpdk.org (Postfix) with ESMTP id 4B0634003C
 for <dev@dpdk.org>; Thu, 22 Oct 2026 09:38:28 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-63.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-63.yp-c.yandex.net)
 by forward504d.mail.yandex.net (postfix) with ESMTPS id 986201003AB;
 Thu, 22 Oct 2026 10:38:27 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63 with ESMTPSA id
 FcWSAJCdI0U0-XWfoBQTy; Thu, 22 Oct 2026 10:38:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1792654707; bh=JxIXly7rLIqqx6rpBxy7BUNJbLiJ11O4MbPPjIWI4o8=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=o4H3FfDeZqLxljKr9n+0FfZ8ABiLHey5GEW9beLRV92cmpOsyzhNpC3sPrPwst2GA
 4f0HQYKyqdekcjvBUbIXPlbhXPo7fCSfbl6/uvaHWSd5JPFlNSWfPlwCYT1Z+Z0+v0
 CHTtL0B3sUJ79JgDPvsRN8ZHeulqoRHSYiej6th0=
Authentication-Results: mail-nwsmtp-smtp-production-main-63;
 dkim=pass header.i=@yandex.ru
Message-ID: <dc9e6eef-090e-4d85-b025-2890a2395838@yandex.ru>
Date: Thu, 22 Oct 2026 08:38:13 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Proposal using RCU for callbacks
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Marat Khalili <qm2k21@gmail.com>, dev@dpdk.org,
 Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
References: <20261012111324.6db17de9@phoenix.local>
 <332e7685-e72b-48bb-b03d-9cbf71455660@gmail.com>
 <20261012150455.1ea77c99@phoenix.local>
 <163e4df8-ffd1-4f1d-b4ce-b0886f7ee524@yandex.ru>
 <20261021080945.19a6993f@phoenix.local>
Content-Language: en-US, ru
From: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
In-Reply-To: <20261021080945.19a6993f@phoenix.local>
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
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1




> On Wed, 21 Oct 2026 12:51:11 +0100
> Konstantin Ananyev <konstantin.v.ananyev@yandex.ru> wrote:
>
>> In particular, regarding membarrier() - consider using it for BPF CBs
>> instead of smb_mb, but decided not to. The main reasons:
>> - with membarrier() - all threads in the process will be affected.
>>     Also, AFAIK it is implemented via IPI - which is quite heavy.
>> - current smp_mb (at least on modern x86_64) is quite fast
>> (it uses lock-ed instruction on thread's stack, and last time I measured it,
>> takes ¬30-50 cycles). As we usually doing it for a bulk (32+) of packets,
>> the overhead is quite small: 1-1.5 cycle per packet.
>>
>> But again, if you have some smart ideas how to improve our RCU lib with
>> membarrier() -
>> would be really interested to hear.
> There is a version in current wireshark extcap patch series.
> The membarrier is expensive but only happens when capture is stopped.
> We can afford a system call there.
Probably I didn't explain my concern regarding membarrier() well enough.
Let me try again:
AFAIU, when you issue a membarrier() on one thread, all other threads in 
that process
(in case of MP - on all processes) will be synchronized.
I.E: all of them (all CPUs they run on) will receive an IPI, that they 
have to handle.
So, for each CB add/remove - all DP threads doing packet RX/TX will be 
interrupted.
That probably not what user wants.
Once again - why do you think that current librcu mechanism is not fast 
enough?
As I said before: one thread_fence(seq_cst) per burst doesn't look like 
a huge slowdown to me.

>
> The read side (in callback) is:
>
> static inline void
> capture_rcu_enter(unsigned int slot)
> {
> 	struct capture_rcu_reader *r = &capture_rcu.reader[slot];
> 	uint64_t t;
>
> 	if (r->depth++ != 0)
> 		return;
>
> 	t = rte_atomic_load_explicit(&capture_rcu.token, rte_memory_order_relaxed);
> 	rte_atomic_store_explicit(&r->ctr, t, rte_memory_order_relaxed);
>
> 	/*
> 	 * The loads that follow must not move above the store of ctr. The
> 	 * writer forces that on every CPU with membarrier, so no fence is
> 	 * needed here; capture is refused if membarrier does not work.
> 	 */
> 	rte_compiler_barrier();
> }
>
> static inline void
> capture_rcu_exit(unsigned int slot)
> {
> 	struct capture_rcu_reader *r = &capture_rcu.reader[slot];
>
> 	if (--r->depth != 0)
> 		return;
>
> 	/* release: prior loads complete before the slot reads idle */
> 	rte_atomic_store_explicit(&r->ctr, 0, rte_memory_order_release);
> }

