Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F190E606A31C
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Nov 2026 17:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JFPQWIZs
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA4F6402DC;
	Sun,  8 Nov 2026 18:11:01 +0100 (CET)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by mails.dpdk.org (Postfix) with ESMTPS id 4AC7A40264
 for <dev@dpdk.org>; Sun,  8 Nov 2026 18:11:00 +0100 (CET)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-3ac91ac8924so86609a91.1
 for <dev@dpdk.org>; Sun, 08 Nov 2026 09:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794157858;
 x=1794762658; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SoF/z1u1OgmQxupfqlwPNIiEEHF48dRQBpFok/q2jpI=;
 b=JFPQWIZsadu98mR02ASAeFqUlDDeTIIK0/5K/xm0yJh0vptUCHZ7lRwD5STn//FxCq
 Ov8qlIBqplKG9h2hwZphEenlbYrCLeZTLWoBxVtJMKfgGY9zpH2+8IxSvD0oOB1xqNGv
 20tgMFa8E0jA1cthWGUIoz7ja4mseUN057grNxekscu1xwa/XA9xEQP/bSeDCHAYj3tA
 AlyvAgZ/O9RKhpH5PtSZ6ziTtt1CNrXkYJH70yYP0ywG/gxXlKLMpfJS8hkWi7EYteYr
 FsD7jhpDl2WYigR/YSijry1bFZyp9PM/ATeTZ5gIuMLDtehNyQQxsD72r6zRc3DU9HVw
 EuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794157858; x=1794762658;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SoF/z1u1OgmQxupfqlwPNIiEEHF48dRQBpFok/q2jpI=;
 b=GYlWmgNvavg1gLbpjdyZs+6FCGN0xp65rSQMuTwPmz1OR1cCBLnOkWE89RMmw5OWwn
 tMnlMVo1jdotyTSLXnFX57l4I0skWNQ6NEfBWNIpkUFDjHFV/wGCdh5woignEXLNg5Yy
 0oS2C7sw4bRMrRIpS+2Ytb2AkGxy/HeIiRFjrR9Ssvx1U3KzSSH9qOjv3vZ18/NCtfk1
 pZ0OgSB3gjWMjMtJ2UtRPXOOVDKrPzQnRpqZR1fP5U+xN/A8gflZtuzO3kUTVrY6mkfw
 gBtJpqDUQ8NNSpFAll1nggk+PUsR1iWB5B6J0F9zHqf09G7PLmxG6ghY/TkewbPpsXZP
 ipFw==
X-Forwarded-Encrypted: i=1;
 AL+hErErRn+ByIQTpmS5rUzdsAF9C8o0Rcs1gyc1fmmI6n5e0xHBFKE6NGstdV7fXK6YpINJEPk=@dpdk.org
X-Gm-Message-State: APuU4Z80ej246T3R1+kk4Rr+NHMqDYOp+0JhqZqkimtIZG4BHjTz3sR7
 McTD9dXn85TFvx/Rt/FQcvHZLlSxFq2bqX13KpNFjOW/cfG/3BBZbRrV94H9dtNRgSs=
X-Gm-Gg: AYBFou01IFlbed2Y+Ar3RSEUmgz+ucaukUN8eQekovI/FjHQ3isnNsNOB21lM8rMCpI
 AJiYPPGwZ1N+NGSZY3am1mUiyve47iByBJAwv7Mt5v37aG+yLg1a+Tjg1Yahbk3Gmvqmrxe2Eos
 FKRAq9uAJeGeAsaptRD3N+s+1IPU0619jy8n/8f4bxC0JMjHTqew9iMEIVbjGelVktH5YtKwec3
 wEb/n3omx4Sd3CecKuSdpISbbMKBiz+bSdlYeqi/tItWOsK//jOYztS+V6SGLHobR4/lIj7EIrm
 NhD0u2Fje5fkKgYthAD/NuZULhUHxv4Learqon/Gu135xQlwa/Sfubs2+t8yY/B212T7DQChdTD
 2DBbov4fx8qoHs6C+Db2k68OQJPks4AO5XcYPu2RhRGn5Rb5WKhN4Mt7IcYHGv3FGdZKzY7zpr/
 MPl4FklBqZsPi6qL/kicq8sTdpr2aSCZOsj1XUieLTl02QCrWewsrJci5/P15Yi7tHHnMCZFMUd
 nLZQxAXq2tAF9W2GnbXlShLhqApCpfAkcbOwauDdBKp0DWmcHY3I25yUwIh+fIpdAL/4Sv4wsY/
 mp6V2bumCqW7gj//grpm7RB3Qtce8yvtW9Hcgco0gXCwp2ENnUXNtLH/BNsHjS9fn9G69uxAdhZ
 NJKj1yMhsUovSCiQ=
X-Received: by 2002:a17:90b:224e:b0:3a7:82ef:bcdd with SMTP id
 98e67ed59e1d1-3b12d340af3mr1604452a91.41.1794157858250; 
 Sun, 08 Nov 2026 09:10:58 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b127fad1d3sm3564718a91.11.2026.11.08.09.10.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 09:10:58 -0800 (PST)
Date: Sun, 8 Nov 2026 09:10:56 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jerin Jacob <jerinjacobk@gmail.com>
Cc: Pravin Pathak <pravinpathakdev@gmail.com>,
 mattias.ronnblom@ericcson.com, dev@dpdk.org, jerinj@marvell.com,
 mike.ximing.chen@intel.com, bruce.richardson@intel.com,
 thomas@monjalon.net, david.marchand@redhat.com, nipun.gupta@amd.com,
 chenbox@nvidia.com, tirthendu.sarkar@intel.com, Pravin Pathak
 <pravin.pathak.dev@gmail.com>
Subject: Re: [PATCH v1 0/8] event/slb: introducing software load balancer
 eventdev PMD
Message-ID: <20261108091056.7f303a82@phoenix.local>
In-Reply-To: <CALBAE1NduwOw_4wfYt088jhwmR_nxuApepuyYYus+P-=3L=cOw@mail.gmail.com>
References: <20261107013011.2443138-1-pravinpathakdev@gmail.com>
 <CALBAE1NduwOw_4wfYt088jhwmR_nxuApepuyYYus+P-=3L=cOw@mail.gmail.com>
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

On Sat, 7 Nov 2026 12:59:18 +0530
Jerin Jacob <jerinjacobk@gmail.com> wrote:

> > Design Overview
> > ---------------
> > `event_slb` is a distributed (`RTE_EVENT_DEV_CAP_DISTRIBUTED_SCHED`),
> > maintenance-free (`RTE_EVENT_DEV_CAP_MAINTENANCE_FREE`) software eventdev
> > PMD that supports Atomic, Ordered, Parallel, and Single-Link queues:  
> 
> @mattias.ronnblom@ericcson.com  - drivers/event/dsw/
> @liangma@liangbit.com - drivers/event/opdl/
> NO MAINTAINER for drivers/event/sw/
> 
> Hi Pravin,
> Creating new flavours. of evendev SW drivers is a maintenance burden,
> If this is close to DSW then please introduce mode in DSW driver and
> have function pointer switches for fastpath,
> Also claim should be backed by performance test values. Use
> testeventdev test cases and share the numbers to prove one way or
> another.

I ran AI review with Fable and the current AGENTS guidelines.
Short answer: it agrees with Jerin

Review: [PATCH v1 0/8] event/slb: introducing software load balancer
eventdev PMD

Applied cleanly on 26.11-rc2 (a13c105). Builds per-commit with
-Dwerror=true; bisect is clean. Line numbers below are in the
post-apply tree.

Cover / series-level
--------------------

Jerin's question (new PMD vs. a DSW mode) is the right one, and the
code supports it. The credit pool (slb_port_acquire_credits,
slb_port_return_credits, credits_on_loan, the max_inflight formula
in slb_configure, the RTE_VERIFY on pending_releases), the log
macros, and all of slb_xstats.c are DSW code with the prefix
changed; the comment at slb_evdev.h:30 is verbatim dsw_evdev.h:62.
What is new is the queue-side scheduling: atomic queues use a main
MP/SC ring plus per-port SP/SC rings filled by whichever port finds
its ring empty, under a per-queue spinlock; ordered queues use the
ring slot index as the sequence number into a per-queue reorder
buffer, drained under a second per-queue spinlock. Both are
serialised per queue, so "distributed" means "whichever core takes
the lock", and the atomic refill does an O(SLB_ATOMIC_FLOWS)+O(ring)
scan on every migration trigger. The scaling claim needs
testeventdev numbers against sw and dsw, as Jerin asked.

Patches 7 and 8 are fix-ups to patches 1-6 (patch 8 also deletes
code added by patch 6). Squash them; the bullet-list commit messages
describe the diff, not the change.

The cover letter says the self-test covers priority, backpressure,
and multi-core atomic migration. slb_selftest.c is single-threaded,
4 ports, no priorities, no backpressure, and never triggers a
migration. None of the concurrency paths below are exercised.

No release notes. Patch 6 says it adds a 26.11 entry and patch 7
says it edits it; neither touches doc/guides/rel_notes/. A new
driver after rc2 is 27.03 material anyway.

Patch 1: introduce software load balancer PMD
---------------------------------------------

Error:

- slb_evdev.c:781, slb_dump(): NULL dereference.
      uint32_t count = rte_event_ring_count(q->q_ring);
  The loop runs i < slb->num_queues, which is set by configure, but
  q_ring is NULL for any queue not yet set up. rte_event_dev_dump()
  after configure and before queue_setup segfaults. Guard with
  if (q->q_ring == NULL) continue;  (same loop at :782).

- slb_evdev.c:197, slb_queue_setup(): double free. q_ring is
  assigned before the atomic/ordered allocations:
      queue->q_ring = ring;
  and the failure paths at :212 and :239 do
      rte_event_ring_free(ring);
      return -ENOMEM;
  leaving queue->q_ring dangling. The next slb_queue_release()
  (close, or re-setup) frees it again. Set queue->q_ring = NULL on
  those paths, or assign q_ring only after all allocations succeed.

Warning:

- slb_evdev.c:167, slb_queue_setup() on an already-linked queue
  frees q_ring and any per_port_rings via slb_queue_release(), but
  the linked ports' q_entries[][].dq_ring (set at :374) and
  single_linked_ring (:319) still point at the freed rings. The
  API allows queue_setup on a stopped device without unlinking
  first, so the next dequeue is a use-after-free. Either return
  -EBUSY when serving_ports_mask != 0, or re-resolve the entries.

- slb_event.c:661, new_event_threshold is compared against
  credits_on_loan, which includes every port's idle cache:
      if (unlikely(rte_atomic_load_explicit(&slb->credits_on_loan,
                                            rte_memory_order_relaxed) >
                   source_port->new_event_threshold))
              return 0;
  This is the DSW check, but patch 7 raises SLB_MIN_CREDIT_LOAN to
  256 (DSW: 64), so a port that only dequeues and releases holds
  256..511 credits forever (slb_port_return_credits keeps
  SLB_PORT_MIN_CREDITS). With K terminating ports the floor on
  credits_on_loan is 256*K regardless of events in flight. The
  default threshold from slb_port_def_conf is min(4096,
  nb_events_limit): nb_events_limit=1024 with 4 consumer ports, or
  the default with 16 workers, rejects every NEW enqueue once the
  caches fill, and nothing ever lowers them. Either go back to the
  DSW quantum, or let the port use its own cache before applying
  the global check (acquire first, check the pool only when
  borrowing).

Info:

- slb_configure() logs its -EINVAL causes with SLB_LOG_DP_LINE(INFO,
  ...). Control path; use SLB_LOG_LINE(ERR, ...).

- drivers/event/meson.build:18: 'slb' added after 'sw'; list is
  alphabetical.

Patch 2: add support for ordered queues
---------------------------------------

Error:

- slb_event.c:993 / :1021, reorder slot reuse. The sequence number
  is the ring slot:
      *start_slot = cons_head & r->r.mask;
      h->seq_slot = (start_slot + j) & ring_mask;
  but the ring slot is freed at dequeue (__rte_ring_update_tail,
  :998) while the reorder slot is freed only when slb_reorder_drain
  passes it. The two are only in step if the producer can never
  advance r.size positions while a slot is outstanding. Credits do
  not guarantee that: RELEASE returns the credit immediately
  (slb_event.c:673, and :1139 for implicit release) even though the
  slot stays RELEASED until drained. So: worker A dequeues slot S
  and is slow; drain stops at S; other workers dequeue and release
  (or implicit-release) r.size more events, all returning credits;
  the producer wraps to slot S; worker B dequeues the new event with
  seq_slot S. B's forward writes reorder_buffer[S] and drain
  delivers it past A's event; when A then forwards, its event lands
  in a slot drain has already passed and is delivered r.size events
  late, and if A releases while B's event is still READY the state
  is overwritten and B's event is lost with its credit. For
  max_inflight=4096 r.size is 8192, i.e. one stalled worker plus a
  few ms of traffic. Fix: hold the credit for an ordered event
  until its slot is drained (return it in slb_reorder_drain when a
  RELEASED slot is reclaimed, and skip ordered releases in the
  :673/:1139 returns). Then occupied slots + ring entries <=
  max_inflight < r.size and the ring cannot wrap onto a live slot.

- slb_event.c:114, lost wakeup in slb_reorder_drain():
      if (!rte_spinlock_trylock(&queue->reorder_lock))
              return;
  The holder exits when it reads EMPTY at drain_idx (:125). A second
  port that marks that very slot READY and then fails the trylock
  returns too. The slot stays READY until some later forward or
  release on the same ordered queue happens to call drain; nothing
  in the dequeue path does. At the end of a burst the last events
  are stranded in the reorder buffer. Re-check after unlock:
      rte_spinlock_unlock(&queue->reorder_lock);
      rte_atomic_thread_fence(rte_memory_order_seq_cst);
      if (rte_atomic_load_explicit(&buf[drain_idx].state,
                                   rte_memory_order_acquire) !=
          SLB_REORDER_EMPTY)
              goto retry;   /* back to the trylock */

Warning:

- slb_event.c:987-998, slb_ordered_ring_dequeue_burst() calls
  __rte_ring_move_cons_head(), __rte_ring_dequeue_elems() and
  __rte_ring_update_tail() directly. No other driver uses the ring
  private API; it is not a stable contract. If the slot index is
  the design, add an exported helper to lib/ring (or
  rte_event_ring) that returns the consumer head, in its own patch.
  Same for slb_event.c:198, which assumes the data array follows
  struct rte_ring at (r + 1).

Patch 3: add support for atomic queues
--------------------------------------

Warning:

- slb_event.c:826, :845, :1172 write q_returned from the consuming
  port with a plain increment:
      orig_q->atomic_state->port_stats[ep].q_returned++;
  and slb_event.c:406 (patch 4) reads it from whichever core holds
  the refill lock, with a plain load, to decide the flow mapping
  can be switched. Single writer, but cross-core and load-bearing
  (the enq==ret test is what makes migration order-preserving).
  Make q_returned RTE_ATOMIC(uint64_t), store with
  rte_memory_order_release, load with rte_memory_order_acquire so
  the application's last access to the flow on the old port is
  ordered before the new port can see events for it.

Info:

- slb_event.c:166:
      return (flow_id * 2654435761U) & SLB_ATOMIC_FLOWS_MASK;
  The multiplier is odd, so the low 11 bits of the product are a
  permutation of the low 11 bits of flow_id; flow_id and
  flow_id+2048 always collide. Fibonacci hashing takes the high
  bits: (flow_id * 2654435761U) >> (32 - 11).

- slb_history_entry.flow_id is written at slb_event.c:1024 and
  never read.

Patch 4: add dynamic flow migration for atomic queues
-----------------------------------------------------

Warning:

- struct slb_port fields is_loaded (slb_evdev.h:146),
  last_migrated_time, flow_migrations, migrations_in,
  migrations_out (:164-167) are per port but written under the
  refill_lock of whichever atomic queue is migrating
  (slb_event.c:269, :327-328, :337-339, :343, :420) and read by
  every other atomic queue's refill (:249, :290, :364). Two atomic
  queues sharing ports race on them: lost increments, and both
  queues can pick the same port as migration source. Either make
  them per (queue, port) inside slb_atomic_state (port_stats is
  already there), or make them atomic. is_loaded also sits in the
  port's hot cacheline next to inflight_credits and history_head,
  so a remote refill write bounces that line under the owning
  core.

Info:

- The hold buffer is per queue, not per port. Once one linked port
  stops draining, SLB_HOLD_BUFFER_SIZE - 3*128 held events later
  slb_atomic_refill returns at :501 without touching the main ring
  and every other port on that queue starves. Worth stating in the
  Limitations section of slb.rst.

Patch 5: add extended statistics and diagnostics
------------------------------------------------

Warning:

- slb_xstats.c:105 exposes port_%u_queue_%u_dequeued from
  slb_port.queue_dequeued[], which nothing increments. Either count
  it in slb_port_dequeue() or drop the stat.

Info:

- Leftovers: slb_port.total_dequeues, enqueue_calls (printed by
  slb_dump, never incremented), credits_drained (only ever cleared),
  flow_migrations (incremented, never read); SLB_MAX_FLOWS_BITS and
  SLB_MAX_FLOWS_MASK unused.

Patch 6: add self-test and documentation
----------------------------------------

Warning:

- doc/guides/eventdevs/features/slb.ini:14 has
  runtime_port_link = Y but slb_info_get() does not set
  RTE_EVENT_DEV_CAP_RUNTIME_PORT_LINK. Patch 7 says it removed this
  from the feature matrix; it removed it from the .rst only.

- slb.rst (as of patch 7) says "link up to eight queues per port at
  each priority"; SLB_PORT_MAX_Q_MAP_PER_PRIO is SLB_MAX_QUEUES
  (64).

- Self-test does not use TEST_ASSERT / unit_test_suite_runner and
  never runs more than one lcore. At minimum add a multi-core
  ordered test with one deliberately slow worker and an atomic test
  that forces a migration (SLB_MIGRATION_LOAD_THRESHOLD is 16 full
  per-port rings); both of the Errors above would show up.
