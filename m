Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C3ACA9EDE
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 18:13:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E12F540272;
	Mon, 12 Oct 2026 20:13:30 +0200 (CEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id A25594026D
 for <dev@dpdk.org>; Mon, 12 Oct 2026 20:13:29 +0200 (CEST)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2e8246b13cbso16435175ad.2
 for <dev@dpdk.org>; Mon, 12 Oct 2026 11:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791828808;
 x=1792433608; darn=dpdk.org; 
 h=content-type:mime-version:message-id:subject:cc:to:from:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MlgXdYFAzhrAojkr3eoAa+dy/ZxnHB+WRfWwQfTOKwA=;
 b=0EEbytkqY/7QAvBQ7quzIj+KD3zDddggcwp8cfhyVjsNN6jkO8s4t5y9+iVNuAg4CA
 iChZ52xmEtW/HzXiAJkhdI9xFBDXX5a1+RpdnQUfUlobRCU5O+FTZoc0EXbQDzCyggKU
 7kyEgip2NfV5KNKt0NTMrZzDpgIGdBaZVpilxQmsI9Z2OOEqKxyiNv2B277AxWN8p3vz
 ayDUuyxqRZJrDpRi5CgooFF2voYmiBzSL0NEzD09u5zjJWpPIZuLQjkEevBMQuS/QP5n
 kB+NI65LDqcYphyax59LPKuRKXhDT6f8DqDfkAZQO9jXsvWVKKacxN/2nmq5mWGvQS3h
 TNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791828808; x=1792433608;
 h=content-type:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MlgXdYFAzhrAojkr3eoAa+dy/ZxnHB+WRfWwQfTOKwA=;
 b=WfunTbwx9Be2uA0gcGzFRMZIQpmz43oYT8woWsSqpJKSHLkuZu5YVy/hMRlisTj6AY
 tHNhK1p/+uCzZ3BMPOfNtYcHT1w/JtqOx7YHNgizRQohNnWhJfFLqI/iGXeQ6JPJOlN1
 PcSwL1B2SibeYQex1+YiOdgp8kuUOx4gedEPl5umq1RNyaqvQQLmL5VA/3rNzIHcJ9qc
 ZcRPedVGs75PHgPu7qmogJpMWiFCEFAnoC6M/QSduUeMHtOcCLBqAHu8E/VxCZ5KlgKw
 uYe3gQEbZW5PXBS2/bpkO+6kvnT+0wbvYQ4MwggdoLKnDIyQXT0lwjsLDzpdhi+ZhzLn
 CjIw==
X-Gm-Message-State: AFq9FYKsW7jUOp7SjYepcGkSUhbYWZU8UnSMa4pp9VE9rUloHB85qwyu
 wlKu1X+991pOSriahEftuwP4OVuWk85GhxlEGpLgNBeXN2Hcegfd0UNH3EpnigEJD3I=
X-Gm-Gg: AYBFou2AXP3s5dMNHQ4K4Mrcivduu4+5vfeJ2gh+tRT8+u9yqjlonQzbx+lSu4WSVBt
 XlFGiAGLSJ5PvzrVlElLWnYv63O52+yH/mpB2cSyedpEXfFG61qvew4oDNIH1xFtViJkzqtcY7y
 X5VR+0y0+1T6VhceSsalKtjxY+9OiU24+J2ElZpDwj28Ac1EbaO8syCQd4klEEin1q4ae9Uos9P
 7sS0JqsinhyotdUUcmBNLH0TL0DI/uHorU66wR12TW5xbO7Sn/z7xQBsNNhv+hWRe/ND64ek0nB
 SGn1zB85Ikj+EgenX/zN2i2onlUf9SPN3xkQbYOt6foXQJYT0oschEN9G7Ov9F34cjq1h4Q2QrH
 53bbQljz9RfyNQyf//kK6TooJnUSOMMQSmHkeAi3cVDfDRo4MyiHp5+Ie/PqIyf89lMs/RwCp6U
 vtyWNxgW3LYZeTEuPp1AZSF3hwQLxY2gUsjprFPe1sDH0rbGICDQLVAgzmSKsL+AoNthWKjysMS
 3wOj3vH0IhJAUgflULCqJ9dOSDEWqKxwmrG/7Ir
X-Received: by 2002:a17:903:950:b0:2e6:1c21:158d with SMTP id
 d9443c01a7336-2e842cd128cmr102978235ad.50.1791828808479; 
 Mon, 12 Oct 2026 11:13:28 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e84219f2bfsm46799135ad.21.2026.10.12.11.13.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 11:13:27 -0700 (PDT)
Date: Mon, 12 Oct 2026 11:13:24 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <qm2k21@gmail.com>, Konstantin Ananyev
 <konstantin.v.ananyev@yandex.ru>, Akhil Goyal <gakhil@marvell.com>, Fan
 Zhang <fanzhang.oss@gmail.com>, Honnappa Nagarahalli
 <honnappa.nagarahalli@arm.com>
Cc: dev@dpdk.org
Subject: Proposal using RCU for callbacks
Message-ID: <20261012111324.6db17de9@phoenix.local>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/lO1WiWALBlND=.EfO7wkvg1"
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

--MP_/lO1WiWALBlND=.EfO7wkvg1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


The BPF and packet capture Rx/Tx callbacks use a per-queue use counter
so that removal can wait for the datapath. In BPF that costs a locked
instruction per burst. The code would be faster and cleaner if RCU
could be used, but DPDK RCU is limited to the QSBR model, which
requires application opt-in.

The userspace RCU library (liburcu) supports other models, so I did a
brief investigation into whether something similar could be done in
DPDK. As expected, it also turned up pre-existing issues: the counters
are wrong with MT_LOCKFREE Tx, the pdump one is not safe as written,
and cryptodev callback removal never waits.

I used Claude to write it up in more detail (attached). It is all from
code reading; nothing has been reproduced or prototyped yet.
This is too big to go into 26.11 at this point, will try and have something
for 27.03

--MP_/lO1WiWALBlND=.EfO7wkvg1
Content-Type: text/html
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=rcu-ethdev-callback-removal.html

# RCU for ethdev Rx/Tx callback removal (pdump, bpf_pkt)

2026-10-12, Stephen Hemminger

Proposal: replace the per-queue use counters in bpf_pkt and pdump with an RCU
read section inside the ethdev callback walker, using a membarrier-based
flavor so the reader needs no full barrier. The Rx/Tx path then has no
lock-prefixed instruction for callback protection, removal is safe with
MT_LOCKFREE Tx, and BPF programs and callback handles can be freed after a
stop.

## Today

`rte_eth_remove_rx_callback()` and `rte_eth_remove_tx_callback()` unlink the
callback and return. They do not wait for threads already inside it and do not
free it. The API text tells the caller to free it "after a short delay" or to
use RCU. Each in-tree user has its own workaround.

| User | Mechanism | Per-burst cost (x86-64) | Problem |
| --- | --- | --- | --- |
| bpf_pkt | Per-queue use counter, `rte_smp_mb()` at entry, recheck of `cbi->cb` | One `lock addl $0,(%rsp)`, two writes to the cbi cache line | Wrong with two threads on one queue. Callback handle never freed. |
| pdump | Per-queue use counter, release/acquire fences | None for the counter. Four lock-prefixed stats updates. Ring CAS when packets are captured. | Counter is unsound. Filter never destroyed. Callback handle never freed. |

### bpf_pkt

- `bpf_eth_cbi_inuse()` does `cbi->use++` then `rte_smp_mb()`. The callback
  then rechecks `cbi->cb != NULL`.
- Unload sets `cb = NULL`, does `rte_smp_mb()`, and waits while `use` is odd.
- This is correct with one thread per queue.
- With `RTE_ETH_TX_OFFLOAD_MT_LOCKFREE` two threads can be in the callback for
  one queue. Both increment `use` non-atomically. Two threads inside give an
  even count, so unload proceeds and destroys the program under them.
- cnxk, octeontx, dpaa, dpaa2 and null advertise that offload.
- The comment above `bpf_eth_cbi_unload()` already says there is no safe
  generic way to remove a callback while IO is active, and that the handle is
  not freed for that reason.

### pdump

Two independent holes, each enough on its own.

First, there is no recheck after taking the counter. The list head is loaded
in `rte_eth_rx_burst()` before the callback runs:

```
datapath lcore                       control thread
--------------                       --------------
cb = load(queue callback list)
                                     rte_eth_remove_rx_callback()
                                     pdump_cb_wait(): count even, return
                                     reply sent; dumpcap frees ring, mempool
pdump_rx(): use_count++ (odd)
copy into freed ring and mempool
```

Second, `pdump_cb_hold()` is a store followed by a release fence, and
`pdump_cb_wait()` is an acquire fence followed by a load. That is the
store-buffer pattern and needs a full barrier on both sides. On x86 both
fences compile to nothing.

The window is a few instructions wide unless the reader is preempted inside
it.

## Goals and decisions

Goals:

- No lock-prefixed instruction or full barrier on the Rx/Tx path for callback
  protection.
- No application changes. QSBR-style quiescent state calls are not acceptable.
- Correct with `MT_LOCKFREE` Tx.
- Correct for Rx/Tx from the EAL interrupt thread. Bonding mode 4 sends LACP
  from an alarm callback.
- Free what is leaked today: the callback handle, and in pdump the filter.

Decisions already taken:

- Stop and unload cost is not a concern. A few extra syscalls are fine, a
  sleep is not.
- Sync calls `membarrier()` twice, as liburcu does. It is not on the fast
  path.
- Rx/Tx from an unregistered thread is an application bug, since
  `rte_thread_register()` exists. The interrupt thread is the one exception
  and is handled inside the rcu code.
- ethdev, pdump, bpf, eal and rcu may all change.

Out of scope for now:

- Fixing the cryptodev enqueue/dequeue callbacks. The findings are recorded
  below.
- The multi-producer ring CAS in capture.

## Reader side

The reader marks itself in a per-thread slot with plain stores. Only a
compiler barrier follows the entry store. The hardware barrier is forced from
the writer side, as in liburcu's memb flavor.

Why not what DPDK has: `rte_rcu_qsbr` needs the application to report
quiescent states. Its `thread_online()`/`thread_offline()` pair works without
application changes, but online is a store plus a seq_cst fence. That is the
same lock per burst bpf_pkt pays now.

liburcu flavors for reference
([README](https://github.com/urcu/userspace-rcu/blob/master/README.md)):

| Flavor | Reader | Application change |
| --- | --- | --- |
| qsbr | Nothing | Periodic quiescent call |
| mb | Store plus full barrier | Register thread |
| memb | Store only, writer calls `membarrier()` | Register thread |
| bp | As memb, registers itself on first use | None |
| signal | As memb, via a signal | Removed upstream |

The proposal takes memb's barrier scheme and replaces thread registration with
fixed slots. liburcu is LGPL-2.1, so this is a reimplementation of the
algorithm, not a port.

Sketch, names are placeholders:

```c
struct rte_rcu_reader {			/* one per slot, cache aligned */
	RTE_ATOMIC(uint64_t) ctr;	/* 0 idle, else token seen at entry */
	uint32_t depth;			/* nesting, owner only */
};

struct rte_rcu_domain {
	RTE_ATOMIC(uint64_t) token;	/* bumped by each sync */
	bool membarrier;		/* false: readers must fence */
	struct rte_rcu_reader reader[RTE_MAX_LCORE + 1];
};

static inline void
rcu_enter(struct rte_rcu_domain *d, unsigned int slot)
{
	struct rte_rcu_reader *r = &d->reader[slot];
	uint64_t t;

	if (r->depth++ != 0)
		return;

	t = rte_atomic_load_explicit(&d->token, rte_memory_order_relaxed);
	rte_atomic_store_explicit(&r->ctr, t, rte_memory_order_relaxed);

	if (unlikely(!d->membarrier))
		rte_atomic_thread_fence(rte_memory_order_seq_cst);
	else
		rte_compiler_barrier();
}

static inline void
rcu_exit(struct rte_rcu_domain *d, unsigned int slot)
{
	struct rte_rcu_reader *r = &d->reader[slot];

	if (--r->depth != 0)
		return;

	rte_compiler_barrier();
	rte_atomic_store_explicit(&r->ctr, 0, rte_memory_order_release);
}
```

- On x86-64 this is two `mov` at entry and one at exit. On arm64 it should be
  `ldr`, `str`, then `stlr`, with no `dmb`. The arm64 code has not been
  compiled.
- The exit store is a release so the fenced fallback needs no second fence.
  With `membarrier()` a plain store would do.
- Each slot is written only by its owner, so no shared cache line is written
  on the fast path.
- Nesting is needed because an Rx callback that transmits enters the Tx chain
  on the same thread.
- Slot index is `rte_lcore_id()`. Index `RTE_MAX_LCORE` is reserved for the
  interrupt thread.

## Writer side

The writer unlinks, calls sync, then frees. Sync calls `membarrier()` twice,
before and after waiting for readers, in the same places liburcu does.

```c
static void
rcu_mb_all(struct rte_rcu_domain *d)
{
	if (d->membarrier)
		membarrier(MEMBARRIER_CMD_PRIVATE_EXPEDITED, 0, 0);
	else
		rte_atomic_thread_fence(rte_memory_order_seq_cst);
}

void
rcu_sync(struct rte_rcu_domain *d)
{
	uint64_t t, c;
	unsigned int i;

	/* caller has already unlinked the object */
	rcu_mb_all(d);		/* readers now see the unlink */

	t = rte_atomic_fetch_add_explicit(&d->token, 1,
			rte_memory_order_seq_cst) + 1;

	for (i = 0; i <= RTE_MAX_LCORE; i++) {
		for (;;) {
			c = rte_atomic_load_explicit(&d->reader[i].ctr,
					rte_memory_order_acquire);
			if (c == 0 || c >= t)
				break;
			rte_pause();
		}
	}

	rcu_mb_all(d);		/* readers' accesses are complete */
}
```

### Why two calls

`membarrier()` makes every running thread of the process execute a full
barrier at some point between the call and its return.

1. First call, after the unlink and before the token bump. A reader that
   stored its `ctr` before this point is visible to the writer. A reader that
   stores it afterwards also loads the list head afterwards, so it sees the
   unlink and never holds the removed entry.
2. The wait. A slot reading 0 is idle or entered after the first call. A slot
   at `t` or above loaded the token after the bump, so also after the first
   call. A slot below `t` may hold the old pointer and is waited for.
3. Second call, after the wait. On weakly ordered CPUs the exit store can
   become visible before the reader's last loads have completed. The second
   call forces them to finish before the caller frees.

liburcu places its two calls the same way, at the start and end of
`synchronize_rcu()`. The difference here is a 64-bit token in place of
liburcu's parity bit and double wait. That substitution still needs review.

### membarrier

- Linux: `MEMBARRIER_CMD_PRIVATE_EXPEDITED` and its register command exist
  since 4.14 ([man
  page](https://man7.org/linux/man-pages/man2/membarrier.2.html)). DPDK
  requires 5.4. The process registers once at init.
- FreeBSD: since 14.1 ([man
  page](https://cgit-dev.freebsd.org/src/plain/lib/libsys/membarrier.2)).
- Windows: `FlushProcessWriteBuffers()` is the equivalent.
- The kernel delivers it as an IPI to each CPU running a thread of the
  process. Every busy-polling lcore takes two interrupts per sync.
- It is per process. The primary and each secondary sync their own callback
  lists.
- If the syscall is missing or filtered by seccomp, the domain flag is false
  and readers do the full fence. That costs what bpf_pkt costs today.

## ethdev

The read section goes in the callback walker, not in each callback.
`rte_eth_rx_burst()` loads the list head inline and only then calls
`rte_eth_call_rx_callbacks()`. A section opened inside the callback starts
after the pointer was fetched. That is why bpf_pkt needs its recheck and a
context that is never freed.

The walker enters the section, reloads the head, walks, and exits. Tracepoints
omitted:

```c
uint16_t
rte_eth_call_rx_callbacks(uint16_t port_id, uint16_t queue_id,
	struct rte_mbuf **rx_pkts, uint16_t nb_rx, uint16_t nb_pkts,
	void *opaque __rte_unused)
{
	const struct rte_eth_rxtx_callback *cb;
	unsigned int slot = eth_cb_slot();

	if (unlikely(slot == ETH_CB_NO_SLOT))
		return nb_rx;

	rcu_enter(&eth_cb_rcu, slot);
	cb = rte_atomic_load_explicit(
		&rte_eth_fp_ops[port_id].rxq.clbk[queue_id],
		rte_memory_order_relaxed);
	while (cb != NULL) {
		nb_rx = cb->fn.rx(port_id, queue_id, rx_pkts, nb_rx,
				nb_pkts, cb->param);
		cb = cb->next;
	}
	rcu_exit(&eth_cb_rcu, slot);

	return nb_rx;
}
```

- The walker is out of line and reached only when a callback is installed. A
  queue without callbacks pays nothing.
- The inline burst functions and `rte_eth_fp_ops` do not change.
- New experimental `rte_eth_callback_sync(void)`: returns once no thread is
  still in a chain it entered before the call.
- It must not be called from inside a callback. A debug check on the nesting
  depth catches that.
- `rte_eth_remove_rx_callback()` and `rte_eth_remove_tx_callback()` do not
  change. The documented contract holds: remove, sync, then `rte_free()` the
  handle.
- The domain is per process, like the callback lists.

Dependency: ethdev gains a dependency on rcu. rcu is always enabled, needs
only eal and ring, and is built before ethdev. bpf and pdump call the ethdev
function and need no direct rcu dependency. A test build with rcu added to
ethdev, bpf and pdump configured and linked.

## Thread model

Every thread that calls the burst functions needs a slot. Lcores and
registered threads use their lcore id, and the interrupt thread gets a
reserved one.

| Thread | Slot | Notes |
| --- | --- | --- |
| EAL lcore, service lcore | `rte_lcore_id()` | |
| Non-EAL thread after `rte_thread_register()` | `rte_lcore_id()` | |
| EAL interrupt thread (alarms, interrupt callbacks) | `RTE_MAX_LCORE` | Found with `rte_thread_is_intr()`, only on the `LCORE_ID_ANY` branch |
| Any other unregistered thread | None | Application bug. The walker skips the callback chain. |

- `MT_LOCKFREE` Tx works because each thread has its own slot, whatever queue
  it uses.
- Bonding mode 4 with dedicated queues calls `rte_eth_rx_burst()` and
  `rte_eth_tx_burst()` on member ports from `bond_mode_8023ad_periodic_cb()`,
  an alarm callback. It is the only in-tree driver found calling the public
  burst API off an lcore.
- For a slotless thread, skipping the chain means a Tx filter is not applied
  and capture misses its packets. Running the chain unprotected would keep the
  removal race.

Debug check: under `RTE_ETHDEV_DEBUG_RX` and `RTE_ETHDEV_DEBUG_TX` the burst
functions verify `rte_lcore_id() != LCORE_ID_ANY || rte_thread_is_intr()`. The
checks already in those blocks log and return 0.

Documentation: the EAL guide currently lists unregistered non-EAL threads as
supported with limitations. It needs a line saying ethdev Rx/Tx requires a
registered thread.

Possible separate bonding bug, not confirmed: `rx_burst_8023ad()` can call
`bond_mode_8023ad_handle_slow_pkt()` on an lcore, which for a marker frame
transmits on the dedicated Tx queue the alarm thread also uses.

## bpf_pkt changes

The use counter, its three helpers, the `cb != NULL` recheck and every barrier
in `bpf_pkt.c` go away. Unload keeps its current behavior: it returns with the
program destroyed.

Callbacks, all eight variants the same way:

```c
/* today */
bpf_eth_cbi_inuse(cbi);		/* cbi->use++; rte_smp_mb(); */
rc = (cbi->cb != NULL) ?
	pkt_filter_vm(cbi->bpf, pkt, nb_pkts, 1) :
	nb_pkts;
bpf_eth_cbi_unuse(cbi);		/* rte_smp_rmb(); cbi->use++; */
return rc;

/* proposed */
return pkt_filter_vm(cbi->bpf, pkt, nb_pkts, 1);
```

Unload:

```c
/* today */
rte_eth_remove_rx_callback(port, queue, bc->cb);
bc->cb = NULL;
rte_smp_mb();
bpf_eth_cbi_wait(bc);		/* spin on bc->use */
rte_bpf_destroy(bc->bpf);
bpf_eth_cbi_cleanup(bc);

/* proposed */
cb = bc->cb;
rte_eth_remove_rx_callback(port, queue, cb);
rte_eth_callback_sync();
rte_free((void *)(uintptr_t)cb);
rte_bpf_destroy(bc->bpf);
bpf_eth_cbi_cleanup(bc);
bc->cb = NULL;
```

- `struct bpf_eth_cbi` loses `use`. The datapath then only reads the cbi;
  today it writes that cache line twice per burst.
- The callback handle is freed. Today it is leaked on every unload.
- JIT code is unmapped by `rte_bpf_destroy()` only after sync, so no thread
  can still be executing it.
- `MT_LOCKFREE` Tx is fixed with no bpf-specific code.
- Unchanged: the cbi list, `cbh->lock`, callback selection, the public API.
- `cbh->lock` is held across the sync, as it is held across the busy wait
  today. The difference is that sync makes a syscall.
- Installing over an existing program still unloads then adds, so the window
  with no filter stays as it is today.
- Patch 01/30 of the `rte_smp_mb` removal series converts the barriers in this
  same code to C11 fences. This proposal deletes that code.

## pdump changes

`use_count` and its hold, release and wait helpers go away. Disable becomes
remove on every requested queue, one sync, then free.

- After the sync, `rte_free()` each callback handle and destroy the filter.
  One enable request shares a single filter across its queues, so it is
  destroyed once.
- The MP reply flow does not change. The reply is sent after
  `set_pdump_rxtx_cbs()` returns, so after the sync. dumpcap frees the ring
  and mempool only once readers are out.
- In the primary the request already runs from an alarm on the interrupt
  thread. Sync there is fine: that thread's own slot is idle.
- One grace period covers the whole request. Today there is one wait per
  queue.

Stats: `pdump_copy_burst()` has four lock-prefixed updates. `accepted` and
`ringfull` are per burst, `filtered` and `nombuf` per packet. They become
single-writer counters (relaxed load, add, store). That is exact with one
thread per queue. With `MT_LOCKFREE` Tx they can undercount unless made
per-lcore.

Left alone: `rte_ring_enqueue_burst()` on the multi-producer ring is one
`lock cmpxchg` per burst that captured packets.

## cryptodev findings

cryptodev already brackets its enqueue and dequeue callbacks with RCU, but
removal never waits and the read side costs a full barrier per burst. These
are from code reading only; nothing was reproduced.

How it works today:

- One `rte_rcu_qsbr` variable per queue pair and direction, created with
  `max_threads = 1`.
- `rte_cryptodev_enqueue_burst()` and `rte_cryptodev_dequeue_burst()` call
  `rte_rcu_qsbr_thread_online(qsbr, 0)`, reload the list head, walk the chain,
  then call `rte_rcu_qsbr_thread_offline(qsbr, 0)`.
- Remove unlinks, calls
  `rte_rcu_qsbr_synchronize(qsbr, RTE_QSBR_THRID_INVALID)`, then frees the
  callback.

| # | Finding | Where | Effect |
| --- | --- | --- | --- |
| 1 | Reader is never registered | No `rte_rcu_qsbr_thread_register()` call for these variables in lib/cryptodev, drivers/crypto, app/test or examples | `rte_rcu_qsbr_check()` scans the registered-thread bitmap, finds none and returns at once. Remove frees the callback while a thread can still be inside it. |
| 2 | Full barrier per burst | `rte_rcu_qsbr_thread_online()` is a store plus a seq_cst fence | Same locked instruction per burst as bpf_pkt, on both enqueue and dequeue, whenever a callback is installed |
| 3 | One reader slot per queue pair | Thread id 0 for every caller | Same one-thread-per-queue assumption as the use counters |
| 4 | Global spinlock held across synchronize | `rte_cryptodev_callback_lock` in both remove functions | No effect today because the wait never happens. Once fixed, add and remove on every device stall behind one removal. |
| 5 | Reconfigure frees all callbacks | `rte_cryptodev_configure()` calls `cryptodev_cb_cleanup()` | Handles the application still holds dangle. A later remove reads `cb->fn` for its tracepoint before looking the handle up. |
| 6 | Close does not free | `rte_cryptodev_close()` never calls `cryptodev_cb_cleanup()` | Lists, QSBR variables and callbacks stay allocated until the next configure |
| 7 | Wrong pointer checked | `rte_cryptodev_remove_deq_callback()` tests `dev->enq_cbs == NULL` | Harmless, both arrays are allocated together |

One thing it gets right: the list head is reloaded after going online. That is
the placement the ethdev walker needs.

Fix options, both deferred until bpf and pdump are done:

- Minimal: register thread 0 on each variable in `cryptodev_cb_init()`. That
  makes the synchronize real and keeps the barrier.
- Later: move cryptodev to the same reader domain as ethdev. That removes the
  barrier and the per-queue-pair variables.

## Cost

The per-burst lock for callback protection goes away, and a stop pays two
syscalls instead. Nothing here was measured; the instruction lists come from
disassembly of the current code and from the sketches above.

| Path | Today | Proposed |
| --- | --- | --- |
| bpf callback, per burst | `lock addl`, two stores to the cbi line | Nothing in bpf_pkt |
| pdump callback, per burst | Two stores for the counter, up to four lock-prefixed stats updates, ring CAS if packets were captured | Plain adds for stats, ring CAS unchanged |
| ethdev walker, per burst, queue with a callback | List walk | Adds: lcore id read, depth inc and dec, one load, two stores to the thread's own line |
| Queue without callbacks | Nothing | Nothing |
| bpf unload, pdump disable | Spin on the counter | Two `membarrier()` calls, so two IPIs per busy lcore, with a spin between |

The spin is bounded by one burst unless a reader is preempted inside a
callback, as with `RTE_WAIT_UNTIL_MASKED` today.

## Patch series and tests

Four patches, each usable on its own once the one before it is in.

1. rcu: reader domain, `rcu_sync()`, membarrier detection and the fenced
   fallback. Unit test covering nesting, concurrent sync and the fallback path
   forced on.
2. ethdev: the domain, the walker change, `rte_eth_callback_sync()`, the debug
   check. Doc updates for the remove-callback text and the EAL guide, plus a
   release note.
3. bpf: convert `bpf_pkt.c` as shown above.
4. pdump: convert, free the handle and filter, make the stats single-writer.

Tests:

- net/null advertises `MT_LOCKFREE`. Several lcores transmit on one queue
  while a control thread loops bpf load/unload and pdump enable/disable, built
  with ASan to catch a use after free.
- Bonding mode 4 with dedicated queues, capture started and stopped on a
  member port.
- Existing bpf and pdump autotests.
- A run on arm64.
- The same stress run against current main first, to confirm the bpf_pkt and
  pdump problems before changing anything.

## Open questions

For the BPF side:

1. Is it acceptable to hold `cbh->lock`, a spinlock, across
   `rte_eth_callback_sync()` now that it makes a syscall? The alternatives are
   dropping the lock around the sync or making it a mutex.
2. Keep `bpf_eth_cbi` entries on the list forever as today, or free them on
   unload now that it is safe?
3. Installing over an existing program: keep unload then add, or add a swap so
   there is no window without a filter?
4. Does anyone run bpf Tx filters from unregistered threads? Under this
   proposal such a thread bypasses the filter.
5. Patch 01/30 of the `rte_smp_mb` series touches the same code. Take it as
   the interim fix, or drop it if this goes first?

General:

6. Review of the ordering argument, in particular the 64-bit token used in
   place of liburcu's parity bit and double wait.
7. Names for the rcu API and for `rte_eth_callback_sync()`.
8. Debug check: assert, or log and return 0 like the checks already there.
9. Stable branches: a minimal pdump fix (recheck plus real fences) adds a lock
   per burst. Backport that, the recheck alone, or nothing.

## What was checked

Everything here comes from reading code and one test build. No race was
reproduced and there is no prototype.

- Trees: DPDK main at d129414711aa (2026-09-24), liburcu master at
  645fdc9b7206.
- By code reading only: the bpf_pkt `MT_LOCKFREE` problem, both pdump holes,
  the leaks, the cryptodev findings, the bonding paths.
- Disassembly: x86-64, gcc 13.3, default build options. This is where the
  lock-prefixed instruction lists come from.
- Build: rcu added as a dependency of ethdev, bpf and pdump. Meson configured
  and the libraries linked.
- Not done: no measurements, no arm64 build, no run of `membarrier()` under
  DPDK. Its behavior is taken from the man pages. IPI delivery is how the
  Linux kernel implements it and is not stated there.

## References

- [liburcu
  README](https://github.com/urcu/userspace-rcu/blob/master/README.md): the
  flavors and their trade-offs
- [Linux
  membarrier(2)](https://man7.org/linux/man-pages/man2/membarrier.2.html)
- [FreeBSD
  membarrier(2)](https://cgit-dev.freebsd.org/src/plain/lib/libsys/membarrier.2)
- DPDK sources: `lib/bpf/bpf_pkt.c`, `lib/pdump/rte_pdump.c`,
  `lib/ethdev/ethdev_private.c`, `lib/ethdev/rte_ethdev.h`,
  `lib/rcu/rte_rcu_qsbr.h`, `lib/cryptodev/rte_cryptodev.c`,
  `drivers/net/bonding/rte_eth_bond_8023ad.c`

--MP_/lO1WiWALBlND=.EfO7wkvg1--
