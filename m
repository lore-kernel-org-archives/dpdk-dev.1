Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60168606A31B
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 11:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=qDhCc5pe
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0987400D5;
	Wed, 21 Oct 2026 13:51:25 +0200 (CEST)
Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net
 [31.44.14.16]) by mails.dpdk.org (Postfix) with ESMTP id 3DCBC40041
 for <dev@dpdk.org>; Wed, 21 Oct 2026 13:51:24 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-68.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-68.yp-c.yandex.net)
 by forward500d.mail.yandex.net (postfix) with ESMTPS id DAE12812EC;
 Wed, 21 Oct 2026 14:51:22 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-68 with ESMTPSA id
 BpZxIa8pUKo0-M719IqLV; Wed, 21 Oct 2026 14:51:22 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1792583482; bh=Blj+GaK5u+SkITJdGRZo4iqgt2JQpuLgeTJmLf+Rkt8=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=qDhCc5peef1Sc+l60MeDo2QzAVlNB1N1fNcbzKCbLJmSEpHiO0PlWajc4ardtVQtE
 GERo20cWv0JRpBsbhfKtViumcZIxoDWriUneUmxP5kgJceFwoASbN1EddqOnd2YZJl
 R6vgFxzklZzqfb28dYvL+gNXQqn7g5xuLmbcF6q8=
Authentication-Results: mail-nwsmtp-smtp-production-main-68;
 dkim=pass header.i=@yandex.ru
Message-ID: <163e4df8-ffd1-4f1d-b4ce-b0886f7ee524@yandex.ru>
Date: Wed, 21 Oct 2026 12:51:11 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Proposal using RCU for callbacks
To: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <qm2k21@gmail.com>
Cc: dev@dpdk.org, Akhil Goyal <gakhil@marvell.com>,
 Fan Zhang <fanzhang.oss@gmail.com>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
References: <20261012111324.6db17de9@phoenix.local>
 <332e7685-e72b-48bb-b03d-9cbf71455660@gmail.com>
 <20261012150455.1ea77c99@phoenix.local>
Content-Language: en-US, ru
From: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
In-Reply-To: <20261012150455.1ea77c99@phoenix.local>
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
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> On Mon, 12 Oct 2026 21:27:08 +0100
> Marat Khalili <qm2k21@gmail.com> wrote:
>
>> On 12/10/2026 19:13, Stephen Hemminger wrote:
>>
>>> The BPF and packet capture Rx/Tx callbacks use a per-queue use counter
>>> so that removal can wait for the datapath. In BPF that costs a locked
>>> instruction per burst. The code would be faster and cleaner if RCU
>>> could be used, but DPDK RCU is limited to the QSBR model, which
>>> requires application opt-in.
>>>
>>> The userspace RCU library (liburcu) supports other models, so I did a
>>> brief investigation into whether something similar could be done in
>>> DPDK. As expected, it also turned up pre-existing issues: the counters
>>> are wrong with MT_LOCKFREE Tx, the pdump one is not safe as written,
>>> and cryptodev callback removal never waits.
>>>
>>> I used Claude to write it up in more detail (attached). It is all from
>>> code reading; nothing has been reproduced or prototyped yet.
>>> This is too big to go into 26.11 at this point, will try and have something
>>> for 27.03
>> Maybe it's just me, but the document is a little hard to read without
>> knowing all of the context. Nevertheless, there is no doubt the sync
>> mechanism in bpf_pkt.c can be improved. It done today, it would probably
>> be written differently, very likely with RCU.
>>
>> I would argue for incremental approach however. I'm currently aware of
>> the following problems, in the order of decreasing priority and gain/effort:
>> * Deprecated rte_smp barrier functions being used.
>> * BPF inuse counter is not safe when using lockfree transmit (Bug 2051)
>> * Code needs cleanup and documenting to make discussions more productive.
>> * Possibly additional safety issues listed above (which I don't yet
>> fully understand).
>> * Missing features: multi-threaded data planes, multiple callbacks, BPF
>> program reuse etc.
>> * On the very last place, performance; as usual, benchmarks are
>> mandatory for it to have any meaning.
>>
>> I think we need to resist the temptation to just rewrite everything,
>> especially with AI. Some recent research shows that productivity gains
>> from AI are very limited particularly because code review becomes
>> bottleneck (tbh it always was). Test coverage is also clearly
>> insufficient for any major rewrites of this code. A patch solving
>> everything at once risks getting stuck in review for very long time.
>> Perhaps we arrive at RCU solution eventually, but I'd start with first
>> items in the list.
>>
> Short form: BPF and pdump could use RCU to manage callback lifetime;
> cryptodev already uses QSBR, but incorrectly. I would like to see
> one usage pattern across all of DPDK that is fast and correct.
Yep, in general I do agree with your analysis
Yes cryptodev CB add/remove uses RCU incorrectly and needs to be fixed.
ethdev CB add/remove doesn't contain any sync mechanism at all,
which is a problem.
Agree that both should use the same mechanism and then we can simply
remove current one in bpf_pkt.c and rely on one in ethdev.

About further enhancements, i.e. using something better/smarter then our
current QSBR-based RCU ny position is simple: let's fix the problems
above first before starting to do any further enhancements.

In particular, regarding membarrier() - consider using it for BPF CBs
instead of smb_mb, but decided not to. The main reasons:
- with membarrier() - all threads in the process will be affected.
   Also, AFAIK it is implemented via IPI - which is quite heavy.
- current smp_mb (at least on modern x86_64) is quite fast
(it uses lock-ed instruction on thread's stack, and last time I measured it,
takes ¬30-50 cycles). As we usually doing it for a bulk (32+) of packets,
the overhead is quite small: 1-1.5 cycle per packet.

But again, if you have some smart ideas how to improve our RCU lib with 
membarrier() -
would be really interested to hear.
>
> DPDK RCU only does QSBR, which needs the application to report when
> each thread has passed a quiescent state. That restriction is why it is underused.
>
> Other RCU flavors avoid this. With membarrier, the reader side needs
> no fence, only a compiler barrier, and the writer pays with a syscall.
> Reader state can hang off EAL thread registration, so no application
> change is needed.
>
> Today the BPF callback does a full memory barrier per burst. RCU would
> replace that with a compiler barrier. Benchmarks will be needed to
> show it matters.
>
> This is not "let's use AI to rewrite it". AI was useful for the what-if
> analysis; the real fixes will be real code, done incrementally.
> Agree the barrier conversion and Bug 2051 come first.
>
> See:
>   - https://man7.org/linux/man-pages/man2/membarrier.2.html
>   - https://liburcu.org/
>   - https://github.com/nmraz/simplercu (toy implementation)
>   - https://lwn.net/Articles/369018/ (original 2010 RFC)

