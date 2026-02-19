Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2BDE9A02C
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 01:23:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7BE97402C6;
	Thu, 19 Feb 2026 02:23:56 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id D0AB2402BD
 for <dev@dpdk.org>; Thu, 19 Feb 2026 02:23:55 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id B7C304A667; Thu, 19 Feb 2026 02:23:55 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1886] net/avp: tx_burst callbacks free mbufs then
 return short count, causing double-free
Date: Thu, 19 Feb 2026 01:23:55 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 25.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: stephen@networkplumber.org
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1886-3@http.bugs.dpdk.org/>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All
MIME-Version: 1.0
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1886

            Bug ID: 1886
           Summary: net/avp: tx_burst callbacks free mbufs then return
                    short count, causing double-free
           Product: DPDK
           Version: 25.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

Recent audit of how tx_pkt_burst is (or is not) being handled in drivers fo=
und
this.

The AVP PMD tx_burst callbacks (`avp_xmit_pkts` and `avp_xmit_scattered_pkt=
s`)
violate the `rte_eth_tx_burst()` mbuf ownership contract.  Both functions f=
ree
all mbufs they process, but return the result of `avp_fifo_put()` which may=
 be
smaller.  When the caller follows the standard pattern:

```c
n =3D rte_eth_tx_burst(port, txq, mbufs, nb_pkts);
for (i =3D n; i < nb_pkts; i++)
    rte_pktmbuf_free(mbufs[i]);
```

any mbufs that were freed by the driver but not reported as consumed will be
freed a second time by the caller.

There are several additional bugs in the same code paths, listed below.

### Bug 1: Double-free in avp_xmit_pkts (avp_ethdev.c ~line 1917 vs 1926)

The function frees each mbuf at line 1917 (`rte_pktmbuf_free(m)`) inside the
processing loop which runs for `count` packets.  At line 1924 it calls
`avp_fifo_put()` and returns the FIFO result `n` at line 1926.  If the FIFO
fills between the earlier free-count check and the put, `n < count`, and
`tx_pkts[n..count-1]` get double-freed.

Fix: return `count` instead of `n`, since all `count` mbufs have already be=
en
consumed.

### Bug 2: Double-free in avp_xmit_scattered_pkts (line 1793 vs 1809)

Same pattern.  All `nb_pkts` mbufs are freed in the loop (line 1793) but
`avp_fifo_put()` result is returned (line 1809).

Fix: return `nb_pkts` instead of `n`.

### Bug 3: AVP host buffer leak on partial avp_fifo_get (lines 1862-1866)

```c
n =3D avp_fifo_get(alloc_q, (void **)&avp_bufs, count);
if (unlikely(n !=3D count)) {
    txq->errors++;
    return 0;
}
```

If `avp_fifo_get()` returns a partial result (0 < n < count), those `n` AVP
buffers have been dequeued from the allocation queue but are never returned.
They are permanently leaked.  The same pattern exists in
`avp_xmit_scattered_pkts` at lines 1769-1774.

Fix: return partial buffers to alloc_q before returning:

```c
if (unlikely(n !=3D count)) {
    if (n > 0)
        avp_fifo_put(alloc_q, (void **)&avp_bufs[0], n);
    return 0;
}
```

### Bug 4: Wrong variable in error comparison (line 1806)

```c
if (unlikely(n !=3D orig_nb_pkts))
    txq->errors +=3D (orig_nb_pkts - n);
```

`n` is the result of putting `nb_pkts` entries, but it is compared against
`orig_nb_pkts` which is the original caller count before clamping by
`AVP_MAX_TX_BURST` and resource limits.  These values differ whenever the
burst was clamped, so the error count is wrong.

Fix: compare against `nb_pkts`.

### Bug 5: Spurious error counting for unconsumed packets

Both TX functions increment `txq->errors` for all `nb_pkts` when returning 0
due to resource exhaustion or detach (lines 1714, 1761, 1832, 1855).  Since
the function returns 0, no mbufs were consumed =E2=80=94 the caller still o=
wns all of
them.  These are not transmission errors; they are backpressure.  Inflating
`oerrors` is misleading.

Fix: remove the error increments on the early-return-zero paths.

### Bug 6: Oversized packets silently truncated (lines 1886-1899)

When a packet exceeds both `guest_mbuf_size` and `host_mbuf_size`,
`avp_xmit_pkts` truncates it to the smaller buffer size and transmits a
corrupt frame.  Per the tx_burst contract, the driver should consume and
free the mbuf and count it in tx_errors, not send garbage.

Fix: set the AVP buffer length to 0 (skip the copy) and count the error.

## Steps to Reproduce

Code inspection of `drivers/net/avp/avp_ethdev.c` at tag v26.03-rc1.

The double-free (bugs 1-2) can trigger when the tx FIFO fills between the
`avp_fifo_free_count()` check and the `avp_fifo_put()` call.  This is a race
against the host consumer and is timing-dependent.

The buffer leak (bug 3) triggers when `avp_fifo_get()` from the alloc queue
returns a partial result, which can occur under host-side memory pressure.

## Suggested Patch

A patch addressing all six issues is available.  The key changes are:

- Return the number of mbufs freed (consumed) rather than the FIFO put count
- Return partially dequeued AVP buffers on allocation failure
- Remove error counting for unconsumed packets (backpressure is not an erro=
r)
- Drop oversized packets instead of truncating
- Fix the orig_nb_pkts vs nb_pkts comparison

--=20
You are receiving this mail because:
You are the assignee for the bug.=
