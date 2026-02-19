Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59379E9A02C
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 02:29:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 158E6402E3;
	Thu, 19 Feb 2026 03:29:04 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 8F77C402DE
 for <dev@dpdk.org>; Thu, 19 Feb 2026 03:29:02 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 7006F4A667; Thu, 19 Feb 2026 03:29:02 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1890] r8169: rtl_xmit_pkt corrupts TX descriptor
 ring on zero-length mid-chain segment
Date: Thu, 19 Feb 2026 02:29:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 25.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: minor
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
Message-ID: <bug-1890-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1890

            Bug ID: 1890
           Summary: r8169: rtl_xmit_pkt corrupts TX descriptor ring on
                    zero-length mid-chain segment
           Product: DPDK
           Version: 25.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: minor
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

This is not urgent bug, since giving a driver an mbuf like this is likely
an application bug.

`rtl_xmit_pkt()` in `drivers/net/r8169/r8169_rxtx.c` breaks out of its
segment loop when it encounters a zero-length segment in a multi-segment
mbuf. If earlier segments have already been written to the descriptor ring
(with `FirstFrag` set but no `LastFrag`), the ring is left in a corrupted
state with an incomplete packet owned by the hardware.


In `rtl_xmit_pkt()` (r8169_rxtx.c, line ~1624), the per-segment loop
breaks immediately when it encounters a segment with `data_len =3D=3D 0`:

```c
    for (m_seg =3D tx_pkt; m_seg; m_seg =3D m_seg->next) {
        opts1 =3D opts[0];
        opts2 =3D opts[1];

        len =3D m_seg->data_len;

        if (len =3D=3D 0)
            break;

        txd =3D &txq->hw_ring[tail];
        ...
        opts1 |=3D len;
        if (m_seg =3D=3D tx_pkt)
            opts1 |=3D FirstFrag;
        if (!m_seg->next)
            opts1 |=3D LastFrag;
        ...
        txd->opts1 =3D rte_cpu_to_le_32(opts1);

        tail =3D (tail + 1) % nb_tx_desc;
        desc_count++;
        ...
    }

    txq->tx_tail +=3D desc_count;
    txq->tx_free -=3D desc_count;
```

Consider a 3-segment mbuf where segment 2 (the middle one) has
`data_len =3D=3D 0`:

1. **Segment 1** (first): written to descriptor ring with `FirstFrag` set.
   `DescOwn` is set, so hardware considers it owned.
2. **Segment 2**: `data_len =3D=3D 0`, loop breaks.
3. **Segment 3** (last): never processed =E2=80=94 `LastFrag` is never writ=
ten.

The result is:

- The descriptor ring contains a partial packet: one or more descriptors
  with `DescOwn` and `FirstFrag` but no corresponding `LastFrag`.
- `txq->tx_tail` and `txq->tx_free` are updated to reflect the partial
  write (desc_count > 0).
- When the doorbell is rung in `rtl_xmit_pkts()`, the hardware will
  attempt to process these descriptors. The behavior is undefined =E2=80=94=
 the
  hardware may hang waiting for `LastFrag`, process garbage, or trigger
  a DMA error.
- The `tx_clean` path may also malfunction since the sw_ring entries and
  descriptor states are inconsistent.

This is a data path corruption bug that could cause the transmit queue to
hang or produce undefined hardware behavior.

## Steps to Reproduce

1. Construct a multi-segment mbuf (nb_segs >=3D 2) where a non-first
   segment has `data_len =3D=3D 0`.
2. Submit it via `rte_eth_tx_burst()` on an r8169 port.
3. The hardware receives an incomplete descriptor chain.

## Suggested Fix

The zero-length segment check should be handled before any descriptors
are written, or alternatively, zero-length segments should be skipped
with `continue` rather than aborting the entire packet.

**Option A =E2=80=94 reject the packet before writing any descriptors** (si=
mplest,
pairs with Bug #1 fix):

Validate all segments up front in `rtl_xmit_pkts()` before calling
`rtl_xmit_pkt()`:

```c
        /* Validate all segments before committing to descriptor ring */
        bool valid =3D true;
        for (struct rte_mbuf *seg =3D tx_pkt; seg; seg =3D seg->next) {
            if (seg->data_len =3D=3D 0) {
                valid =3D false;
                break;
            }
        }
        if (!valid) {
            rte_pktmbuf_free(tx_pkt);
            txq->sw_stats.tx_errors++;
            continue;
        }
```

**Option B =E2=80=94 skip zero-length segments** (if they are considered le=
gal):

```c
        if (len =3D=3D 0)
            continue;  /* skip empty segments instead of aborting */
```

However, Option B still needs to ensure `LastFrag` is set on the actual
last non-empty segment, which requires restructuring the `LastFrag` logic.
Option A is safer and more straightforward.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
