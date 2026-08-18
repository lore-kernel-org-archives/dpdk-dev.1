Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2249CC5B572
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 02:23:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6223D40294;
	Tue, 18 Aug 2026 04:23:17 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id 3AEAA4028E
 for <dev@dpdk.org>; Tue, 18 Aug 2026 04:23:16 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-384930ca5e2so4593097a91.3
 for <dev@dpdk.org>; Mon, 17 Aug 2026 19:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787019795;
 x=1787624595; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EJsXn3KPtYHNg8MfKKF5GxTRjFkq6lHINKtltsIHQFY=;
 b=vBSWhcszGTgZ7bbuxn7cRXpc2FZSl3+SYooVchE0ZHFTDUwTz06m1k8w2M/gdbdPw5
 VpcZ3o4eGafK0qM3Wwi1ri74Xs32PIXxKXMfDWgCycNzmLdg9W9ZnailQmAiEjEjKX0F
 PfbYV6NTSV2PO6eQCsU4UmDeFfx2R2ZHbnxGUqNIbL/39I21GxWVtZgDkjejR+192uUP
 M7YeTj4ygT3vOQN5tjuuJREcrQUGmmoK3jW1P6Yri2NSQgz7aO6ZDrQVlLbe/b5SafDG
 xMwBXu5taNq4RZFWtId58w1lAlEesdkiYe6/Y0DUc/NGm09WkzfQTSBTWjXyozMDTWlr
 nkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787019795; x=1787624595;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EJsXn3KPtYHNg8MfKKF5GxTRjFkq6lHINKtltsIHQFY=;
 b=BUvwxDezwx0QJtOr8JfW3h9kbJYoYTw0q3nWDlJXSpMdwv6DybCU6q8ZMj1gLXKoUP
 bsCfe39719iJ+8oQfLHbiEigggzcJywJ9ZW9+w7C9pycJ2Ejb45nnVZXOuSIxA5GBqdA
 4pXgroOG89n/vIzevPf8yzYgGvFg7e1izu1QOEyxdnWjV9gViL5Q+xn1t8xZjKCTFa1h
 FEFN1sMT4rFa+HpYM74uPiqgTKMxTT2GS1ocbSFEIWQqnkUpZlppb0EbutRWPXG7Ae/y
 uMWGdEdL+2a3s2Ot0XSGXjzKFu+FhyajSixeuB0ohtENuEf35x/YG+KWp9BnfHNndFrK
 OLAQ==
X-Gm-Message-State: AOJu0YxfsG/kDqIN9iL+ScQNktH/unI/xU1ueSqe1EnfF7J4wb4TYxad
 rDtd4ksDEnHAS1MSUYgy1DR5crvVrL3NDexSDy9JWxFwhf7FqPGw77fu0mYnXacX4iQ=
X-Gm-Gg: AR+sD13mk68VVw0zn/+4yIOS+QPxjz/0W73Os7rpmE0XvUeoR3wX9c8ESfjfjcthIjz
 /aawfGiU5I3idXkvtAhIM/aWvIPQnxabhOHegy+gn0OO0fSbMVZHKQLSX61jaXNM2biP6ERTWGb
 SuNo/hCSraLCJztqPtlsSKHyUav0GVOVYf2NQst1ElUX1O7enaPKflVAxRkkEwscbTAUeivm9N9
 5ZvNSXmpiY1OYM47bKegvNcF3x8NgyKH4eJYuvThCxx1Mh81cgkDuLVgDu9vjefpnXyPlKoISk8
 kidNFXhmxz3YJiyYAnGzwp39GrLhMvj8xwmTjwOT6eeJz1iXaw4G6dShZPkJlbbW+b+S9Xc+1JR
 8WfcGl0y9kEuWkcin3ovC+QkzjD/Sk3uuYfW2lTEGcCdeRgDDKYCcRh/88s+t2Ec4ElTZvhfAk3
 5bv0rZr7wE/C9jvcvqd1hopn2NOulbGdDcMLBUPja8xEueC6bYUiRPr0XlnmHrpzo/R98CZ0cBS
 O233WrRaULnv61YBcnr2qTz7U7sgMs/eRa0dSNJ
X-Received: by 2002:a17:90b:2e8f:b0:38f:5869:387b with SMTP id
 98e67ed59e1d1-3933cb718fcmr31763239a91.9.1787019795226; 
 Mon, 17 Aug 2026 19:23:15 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141530442c1sm10034853c88.2.2026.08.17.19.23.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 19:23:15 -0700 (PDT)
Date: Mon, 17 Aug 2026 19:23:05 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Rajesh Kumar <rajesh3.kumar@intel.com>
Cc: dev@dpdk.org, thomas@monjalon.net, bruce.richardson@intel.com,
 andrew.rybchenko@oktetlabs.ru
Subject: Re: [RFC 0/1] ethdev: per-packet Tx timestamp slot management
Message-ID: <20260817192305.00608c9a@phoenix.local>
In-Reply-To: <20260817192417.3009990-1-rajesh3.kumar@intel.com>
References: <20260817192417.3009990-1-rajesh3.kumar@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 18 Aug 2026 00:54:14 +0530
Rajesh Kumar <rajesh3.kumar@intel.com> wrote:

> The current DPDK ethdev time synchronization framework is architected
> around a single, shared hardware latch. The existing API,
> `rte_eth_timesync_read_tx_timestamp()`, assumes a serialization model
> where only one TX timestamp is outstanding at any given time.
> 
> This model creates severe limitations for modern high-throughput network
> interface cards (NICs). When multiple packets requiring precise
> transmit timestamps are sent concurrently, the shared latch becomes a
> race-condition bottleneck. It makes timestamp retrieval unreliable and
> drops accuracy. Furthermore, Poll Mode Drivers (PMDs) backed by
> hardware that supports independent, per-packet timestamping slots have
> no way to expose this capability to the user.
> 
> To solve this, this RFC introduces a formal slot-based lifecycle API
> for per-packet Tx timestamp management. The API decouples timestamp
> tracking from the global latch model, enabling true asynchronous,
> parallel hardware timestamping.


Lots of reasonable AI feedback to the design.

Review of the RFC. Design issues first since that's what they're asking for, then code defects.

Design

    No capability discovery or exhaustion semantics. Nothing reports how many slots exist, whether they're per-port or per-queue, and slot_alloc() doesn't document what it returns when slots run out (-ENOSPC? -EAGAIN?). That's the first thing an application hits. Needs a rte_eth_dev_info field or query, and a defined out-of-slots errno.
    Queue asymmetry: alloc() takes tx_queue_id but read() and release() don't. Either slot_id is port-global (then why does alloc need the queue?) or it's per-queue (then read/release are ambiguous). Pick one and document it. Also tx_queue_id is never validated against nb_tx_queues in the ethdev layer.
    Interaction with the existing mechanism is undefined. Does the app still set RTE_MBUF_F_TX_IEEE1588_TMST? Can the legacy latch API and the slot API coexist on one port? PMDs today key tx timestamping off that flag; the RFC needs to say what supersedes what.
    Fast-path cost contradicts the stated motivation. The cover letter argues high-throughput concurrent timestamping, but the lifecycle is three dev_ops indirect calls plus a dynfield write per packet, all through the slow path. Fine for PTP rates; if the claim is more than that, alloc/release want burst variants or the intended rate should be stated.
    cycles_ns is self-contradictory: is it raw counter cycles or nanoseconds from the free-running clock? If cycles, drop the _ns and expose the frequency; if ns, call it raw_ns or free_ns. Also this struct switches to int64 ns while every other timesync call uses struct timespec; probably the right move but justify it in the cover letter.
    PMDs can't consume the dynfield as written. The offset and flag are static in rte_ethdev.c and not exposed to drivers. A PMD has to re-lookup by name, and the dynflag name only exists as a string concat inside the .c file, so drivers would hardcode "..._flag". Define the flag name macro in the header and provide a lookup helper, following the RTE_MBUF_DYNFIELD_TIMESTAMP_NAME pattern.
    Naming: rte_eth_timesync_tx_timestamp_stamp_mbuf stutters. ..._tx_slot_set_mbuf or similar.

Defects

    Silent dynflag failure in rte_eth_timesync_tx_slot_dynfield_register(). If both rte_mbuf_dynflag_register() and the lookup fail, rte_eth_timesync_tx_slot_dynflag stays 0, the function returns 0, and stamp_mbuf() ORs 0 into ol_flags and reports success. The PMD never sees the request. Must return error. Worse, the early return on offset >= 0 means the flag is never retried on subsequent calls, so one transient failure is permanent.
    Likely doesn't compile as posted: the diff adds no includes, but uses struct rte_mbuf_dynfield, rte_mbuf_dynflag_register() (needs rte_mbuf_dyn.h) and alignof (needs stdalign.h pre-C23). Check whether rte_ethdev.c already pulls those in; I don't believe it does.
    stamp_mbuf() takes port_id and ignores it, documented as "reserved for future PMD use". Either validate it or drop it; a parameter whose semantics arrive later is an API trap. Dropping it also removes the false implication that the call is port-scoped.

Nits

    stamp_mbuf() doxygen deviates from the file's param style, omits the -EINVAL return the code actually produces, and contains an em-dash. The dual_domain_timestamp struct fields lack doxygen comments.
    v1 needs rel_notes and prog_guide (ptp section) updates; RFC is fine without.
