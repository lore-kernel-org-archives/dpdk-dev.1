Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D550DE9A02C
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 01:26:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC4B2402C6;
	Thu, 19 Feb 2026 02:26:01 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 34AF1402BD
 for <dev@dpdk.org>; Thu, 19 Feb 2026 02:26:01 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id A3F7A4A667; Thu, 19 Feb 2026 02:26:00 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1887] bnxt: single bad packet in tx burst stalls
 transmission of remaining valid packets
Date: Thu, 19 Feb 2026 01:26:00 +0000
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
Message-ID: <bug-1887-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1887

            Bug ID: 1887
           Summary: bnxt: single bad packet in tx burst stalls
                    transmission of remaining valid packets
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

Recent audit of tx_pkt_burst semantics in drivers found this bug.

he bnxt scalar transmit path (`_bnxt_xmit_pkts` in `bnxt_txr.c`) has two
error handling problems that violate the `rte_eth_tx_burst()` contract.

## Bug 1: break-on-error stops processing valid packets

When `bnxt_start_xmit()` returns `-EINVAL` for a malformed packet (bad IOVA,
mismatched `nb_segs`, zero `data_len`, too many TSO segments), the driver
frees the mbuf and increments a drop counter, but then breaks out of the
transmit loop. The dropped packet is correctly included in the return value,
so the immediate caller won't leak or double-free it. However, every valid
packet after the bad one is returned as unconsumed even though there may be
plenty of ring space. The caller must re-submit them in a subsequent call.
In a burst of 32 packets where packet 2 is malformed, 29 valid packets get
needlessly bounced back.

The `break` should be `continue` for the `-EINVAL` case. The `break` is only
appropriate for `-EIO` (device error) and `-ENOMEM` (ring full), where
continuing would be pointless.

```c
/* current code */
if (unlikely(rc)) {
    if (rc =3D=3D -EINVAL) {
        rte_atomic_fetch_add_explicit(&txq->tx_mbuf_drop, 1,
                                       rte_memory_order_relaxed);
        dropped++;
    }
    break;
}

/* proposed fix */
if (unlikely(rc)) {
    if (rc =3D=3D -EINVAL) {
        rte_atomic_fetch_add_explicit(&txq->tx_mbuf_drop, 1,
                                       rte_memory_order_relaxed);
        dropped++;
        continue;
    }
    break;
}
```

## Bug 2: partial descriptor ring state on multi-segment drop

`bnxt_start_xmit()` writes transmit descriptors and advances `tx_raw_prod`
incrementally as it walks a multi-segment packet. If validation fails partw=
ay
through the segment chain (the zero `data_len` check at line 474), execution
jumps to `drop:` which frees the mbuf but does not roll back `tx_raw_prod` =
or
clean up the descriptors already written for the earlier segments of that
packet. This leaves orphaned descriptors in the ring that reference a
now-freed mbuf's memory.

This second issue is harder to hit in practice since the failing check
(`data_len =3D=3D 0` on a middle segment) is unusual, but when it does occu=
r the
consequences =E2=80=94 stale DMA addresses in the descriptor ring =E2=80=94=
 are severe.

## Scope

Both bugs are in the scalar path only. The vector paths (`bnxt_xmit_pkts_ve=
c`
and AVX2 variant) skip per-packet validation entirely and are not affected.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
