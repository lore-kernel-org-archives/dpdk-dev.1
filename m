Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654CB606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 18:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=tG/e6v7j
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4E90402BF;
	Tue, 17 Nov 2026 19:47:02 +0100 (CET)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by mails.dpdk.org (Postfix) with ESMTPS id 353E5402A4
 for <dev@dpdk.org>; Tue, 17 Nov 2026 19:47:01 +0100 (CET)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-3b179528d56so5892a91.3
 for <dev@dpdk.org>; Tue, 17 Nov 2026 10:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794941219;
 x=1795546019; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uQv0jang5Ezn34jDFfDWzRS86UXWS5PwAYw0z6DpnkE=;
 b=tG/e6v7jFTc1MXFiMrKNRA4Mo7o9Zmg+T/RCkpximyziysWGPWZhaYN4ZU+YQzsz1O
 EnrOGmPxv9a6LE4PqqDeI3OK+dKuf1Yd/xKFxejLxvXEZRKg5x+8Xxi14aH+CqspRjGm
 5jaTMkj41iPrBWjSp8LY2Vb2XyqruHxXxgMiz8AAdER4n904fHpHFKPv5Xiy+T4Xm1xb
 aTTUf36362rFtDUbho8TPR/ksOa1BqIj4/cPdlXkuwb9wzbP4JQ31eWmt8FzSgu8p/ud
 EBwBEfpnKUhUtEUFf2qyyKTCh7sCi/0CMlZv0qLaOi+fhIT1CFR8vzEru8hI7VmPirFm
 4AHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794941219; x=1795546019;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uQv0jang5Ezn34jDFfDWzRS86UXWS5PwAYw0z6DpnkE=;
 b=aiaR85sweY5enSOOAuaqrJsu2fYuC7R5YjAhDRGBGfjm8zpMoqb0kCXbcfVQPvmkqO
 oUQE0SuINhv3T7dReplt8W9LpGvHkxbvbx3c7hIWXWDQivfqNoTQgYaJLjk2OQhX/yxi
 2Y4/RqrccHH4aC0PpeznF1VtQzScG9VE2/Cr5jJgUyA0mtiWksKcNWOH1JTKWGEYYI/Z
 d11QGt+SZsRBi1QKqoungU1lSS9ydCx6zC3sXlsnAaq0F/OWoOGpa8LOcojsEV/Bltbq
 PaxppAdKKL91ni09ewVEdaz1gi30wL3cccid1/65Ajpt0uOX5QPOXJnoEUxRGDJPmlyW
 MANQ==
X-Gm-Message-State: APuU4Z8GtbF06N1VKl6ITnWc/4DchvOKSB8ab+vtYqJTOIx0mZ/e8HpA
 1vJF+5zlbK/h3/XsWAN8p/7vUDyFI+vuUIUrh/RAB7zK+yB0rbHrjqeJhReQQUlXuyQ=
X-Gm-Gg: AZFdTZffrCkcnWNREBwy0rgLA+U8+ycSMRFEprvRCM4gvupZlahUvogynGM6gHamkhc
 KNZVVUk5i7BNNx/10OgFV9/KMImXb1UXEIgAaLzIjYODfMKS2Gv6I9RbOspQ+A84F2tl4ia1OLR
 hT4z10BXBZOjQgNkbYForIVLSsoSy63skxHq3kv3nDnUFqDYE6QvuaaaVMSXaMrjE50vYf9VjtT
 OnprZlScgDfQJ8aNrzb3tqwKpbFGyjnpRWRAuNwZ7pkPqcXHlGBnuf1XP3jdMo1w6MRoQLt9oBP
 6FYNKVShS1OfcCsO/9Yobp1UJHSGuxqa3zOjH33T0NaBR/JFC2aazsJuvnScTRjmikhikhqJgX8
 tbHdCsh9PGoqCW3k5oslbF66mVKqzSjh+0pBMzgAoE69bQRaYzCkeKnqW4gbVW+cb+rYeeKEYEi
 TaYaqfAk9G7Rv1+lUASYq6bNDaGl8l+yak89/7bLxrj5SwiXGdDoV+QVE191dFRIiiCWaUTTY8j
 C8PfVjZieQtVd5T1fs9Wwizeb2ETvq8nkeaGnFCyMU6q26+jE5CP1i5jAqzg/yF3JRjOpLFwRn5
 CuguOjo1IIVHLVOtqntKwrviRXDFXvv5rjpZ0iMaEce4WHSNE104MU7sfZa8j5EKJw5uT51C1Q=
 =
X-Received: by 2002:a17:90b:5890:b0:3ac:ffb8:1809 with SMTP id
 98e67ed59e1d1-3b3d07d40d6mr266834a91.39.1794941219339; 
 Tue, 17 Nov 2026 10:46:59 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3d1cbdaa6sm83923a91.1.2026.11.17.10.46.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 10:46:59 -0800 (PST)
Date: Tue, 17 Nov 2026 10:46:57 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Pravin Pathak <pravinpathakdev@gmail.com>
Cc: dev@dpdk.org, jerinj@marvell.com, bruce.richardson@intel.com,
 thomas@monjalon.net, david.marchand@redhat.com, nipun.gupta@amd.com,
 chenbox@nvidia.com, tirthendu.sarkar@intel.com,
 mattias.ronnblom@ericsson.com, Pravin Pathak <pravin.pathak.dev@gmail.com>
Subject: Re: [PATCH v2 0/8] event/slb: introducing software load balancer
 eventdev PMD
Message-ID: <20261117104657.4c11285c@phoenix.local>
In-Reply-To: <20261117175709.2346400-1-pravinpathakdev@gmail.com>
References: <20261107013011.2443138-9-pravinpathakdev@gmail.com>
 <20261117175709.2346400-1-pravinpathakdev@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 17 Nov 2026 12:57:00 -0500
Pravin Pathak <pravinpathakdev@gmail.com> wrote:

> From: Pravin Pathak <pravin.pathak.dev@gmail.com>
> 
> This series introduces the Software Load Balancer (SLB) Eventdev PMD
> (`event_slb`) supporting parallel, atomic and ordered queues. It is 
> a distributed software scheduler that scales well.
> 
> v2:
> 	- Fixed ARM64 build issue
> 	- Fixed reorder queue early credit release
> 	- Made all internal functions static
> 	- Fixed all AI review feedback

Lots more AI review feedback

Subject: Re: [PATCH v2 0/8] event/slb: software load balancer PMD

Series applies to main; each commit builds with gcc -Werror (x86),
tip also builds with clang.

Series
======

Warning: patches 7 and 8 are fixups to code added earlier in this
same series. For a new driver, fold them into the patches that
introduce the code. As posted:
  - patches 1-7 do not build on arm64 (abs() without <stdlib.h>,
    per the patch 8 log), which breaks bisect;
  - patches 2-7 abort via RTE_VERIFY() on application misuse in
    the enqueue fast path;
  - patches 1-6 advertise RUNTIME_PORT_LINK;
  - the Ericsson copyright for DSW-derived code only shows up in 8.
The patch 7 log also contradicts itself on single-link sched_type
("force ATOMIC" and "preserve sched_type").


Patch 1/8 event/slb: introduce software load balancer PMD
==========================================================

Error: enqueue never clamps events_len to the port enqueue depth.
Patch 2 then adds stack arrays sized SLB_MAX_PORT_ENQUEUE_DEPTH
(dest_queues[], enq_events[], sorted_events[]), so a burst of more
than 128 events overflows the stack. The eventdev layer checks
this only in debug builds. Clamp it in the three wrappers, before
the counts are passed down, as dsw does:

	if (unlikely(events_len > source_port->enqueue_depth))
		events_len = source_port->enqueue_depth;

Error: slb_port_setup() overwrites the whole port, including
q_entries and single_linked_q. Queues still have the port bit set
in serving_ports_mask, and atomic queues still hold
per_port_rings[port_id]. rte_event_port_setup() then calls
unlink(NULL) from links_map. slb_port_unlink_one() cannot find the
slot and returns -EINVAL, so nothing is unlinked and links_map
stays stale. After a reconfigure:
  - a single-link queue cannot be relinked (serving_ports_mask
    != 0 returns -EINVAL);
  - slb_start() passes on the stale mask, and atomic refill can
    pin flows to a port that no longer dequeues that queue. Those
    events sit in its per-port ring forever.
Drop the port from all queues before resetting it:

	for (int q = 0; q < SLB_MAX_QUEUES; q++) {
		struct slb_queue *queue = &slb->queues[q];

		if (!(queue->serving_ports_mask & RTE_BIT64(port_id)))
			continue;
		queue->serving_ports_mask &= ~RTE_BIT64(port_id);
		queue->num_serving_ports =
			rte_popcount64(queue->serving_ports_mask);
		if (queue->per_port_rings[port_id] != NULL) {
			rte_event_ring_free(queue->per_port_rings[port_id]);
			queue->per_port_rings[port_id] = NULL;
		}
	}

Also make slb_port_unlink_one() return 0 for a queue that is not
linked, so the library's unlink-all clears links_map.

Warning: credit caching can starve producers. Each port can cache
up to SLB_PORT_MAX_CREDITS - 1 (511) credits, and nothing reclaims
idle caches. max_inflight is capped at SLB_MAX_EVENTS (16384), so
with more than 32 ports the caches can hold the whole pool while
no events are in flight. NEW enqueue then fails forever. Raising
the pool above nb_events_limit (documented in patch 8) also breaks
the nb_events_limit contract. Size the loan from the configuration
instead:

	slb->credit_loan = RTE_MIN(SLB_MIN_CREDIT_LOAN,
		RTE_MAX(1, conf->nb_events_limit /
			   (2 * conf->nb_event_ports)));

then use slb->credit_loan and 2 * slb->credit_loan in place of
SLB_PORT_MIN_CREDITS and SLB_PORT_MAX_CREDITS, and set
max_inflight = nb_events_limit.

Info: slb_dump() calls slb_pmd_priv(dev) before checking dev for
NULL. The eventdev layer never passes NULL, so drop the check.


Patch 2/8 event/slb: add support for ordered queues
====================================================

Error: in the general enqueue path, RELEASE events update
queue_enqueued[ev->queue_id]. A RELEASE event only has to carry a
valid impl_opaque. queue_id can be any value up to 255, but the
array has 64 entries, so this writes past it into the port struct.
It also counts releases as enqueues. Remove
slb_port_queue_enqueue_stats() from the RELEASE branch, and in the
ordered branch call it only for FORWARD.

Warning: slb_ordered_ring_dequeue_burst() uses ring internals
(__rte_ring_move_cons_head, __rte_ring_dequeue_elems,
__rte_ring_update_tail from rte_ring_elem_pvt.h). These are not
API and can change with any ring rework. Patch 4 does the same in
slb_find_lightest_flow_on_port() by reading slots through
(struct rte_event *)(r + 1). That also races with the consumer,
which can move past those slots during the scan. Either add a
public ring dequeue that returns the starting index, or keep an
explicit sequence counter for ordered queues.

Warning: the queue_dequeued[] update was removed here, so the
port_N_queue_M_dequeued xstat (patch 5) always reads 0. The same
goes for total_dequeues. enqueue_calls is never incremented either,
but slb_dump() prints it.


Patch 3/8 event/slb: add support for atomic queues
===================================================

Warning: port_stats[ep].q_returned is a plain uint64_t that the
worker port increments with no lock. slb_atomic_refill() reads it
under refill_lock to decide when migration is safe. That is a data
race (64-bit tearing on 32-bit targets, and the load may be
hoisted). Use RTE_ATOMIC(uint64_t): the worker should do a release
fetch_add and refill an acquire load.


Patch 4/8 event/slb: add dynamic flow migration for atomic queues
==================================================================

Warning: slb_port.is_loaded, last_migrated_time and
migrations_in/out are per port, but they are written from the
refill path of each atomic queue under that queue's own
refill_lock. Two atomic queues refilling at the same time race on
them, and one queue's migration marks the port loaded for every
queue. Move is_loaded and last_migrated_time into
slb_atomic_port_stats so the queue's refill_lock protects them.

Info: slb_find_lightest_flow_on_port() picks the flow with the
fewest events in the congested ring. That is usually a flow with
zero queued events, so migrating it does not relieve the port.
Either pick the heaviest eligible flow, or explain why the
lightest is chosen. When every candidate is in cooldown,
slb_find_migration_target_port() falls back to one of them anyway,
which defeats the cooldown.


Patch 6/8 event/slb: add self-test and documentation
=====================================================

Info: test_parallel_queue() releases all 32 events on PORT_W1
even if some were dequeued on PORT_W2. It only passes because W1
gets all 32 in its first call. Release each event on the port it
was dequeued from. There is no coverage for implicit release
disabled, migration, credit exhaustion, or reconfigure; a
reconfigure test would have caught the port setup bug above.


Patch 7/8 event/slb: fine tuning and fixes
===========================================

Warning: queue rings are sized from max_inflight at queue setup.
If the device is reconfigured with a larger nb_events_limit and
the queues are not set up again, the invariant that q_ring can
never be full no longer holds. RTE_ASSERT is compiled out, so
events would be dropped while enqueue still returns events_len.
Either re-create the rings in slb_configure() when max_inflight
grows, or return -EINVAL from slb_start() when a queue's ring
capacity is less than max_inflight.


Patch 8/8 event/slb: address ARM64 build and all code reviews
==============================================================

Warning: the lost-wakeup fix in slb_reorder_drain() is one-sided.
The marking side does a release store of the state and then a
trylock (an acquire load). C11 allows those to reorder, so both
threads can still miss each other. A seq_cst fence is needed on
the marking side too, at function entry before the trylock:

	rte_atomic_thread_fence(rte_memory_order_seq_cst);
	if (!rte_spinlock_trylock(&queue->reorder_lock)) {

Info: slb.rst says SLB_MAX_PRIORITIES is configurable at compile
time, but this patch removes the #ifndef override.

Info: leftovers to remove: credits_drained, total_dequeues,
empty_dequeues (written, never read), flow_migrations (duplicates
migrations_out), slb_history_entry.flow_id (written, never read),
SLB_PORT_MAX_Q_MAP, SLB_MAX_FLOWS_MASK, and the #include of
rte_bitset.h.
