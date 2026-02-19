Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746BDE9A03B
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 01:46:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C35A402C6;
	Thu, 19 Feb 2026 02:46:43 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id A4ED7402BD
 for <dev@dpdk.org>; Thu, 19 Feb 2026 02:46:41 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 96E974A667; Thu, 19 Feb 2026 02:46:41 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1889] r8169: rtl_xmit_pkts breaks tx_burst
 ownership contract on invalid mbufs
Date: Thu, 19 Feb 2026 01:46:41 +0000
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
Message-ID: <bug-1889-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1889

            Bug ID: 1889
           Summary: r8169: rtl_xmit_pkts breaks tx_burst ownership
                    contract on invalid mbufs
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

`rtl_xmit_pkts()` in `drivers/net/r8169/r8169_rxtx.c` returns a short
count when it encounters an invalid mbuf, violating the `rte_eth_tx_burst()`
ownership contract. This can cause callers to retry an unfixable packet
indefinitely.


## Description

In `rtl_xmit_pkts()` (r8169_rxtx.c, line ~1974), the mbuf validation
check uses `break` to exit the transmit loop when it encounters an invalid
packet:

```c
    for (nb_tx =3D 0; nb_tx < nb_pkts; nb_tx++) {
        tx_pkt =3D *tx_pkts++;

        if (txq->tx_free < tx_pkt->nb_segs)
            break;

        /* Check mbuf is valid */
        if (tx_pkt->nb_segs =3D=3D 0 || tx_pkt->pkt_len =3D=3D 0 ||
            (tx_pkt->nb_segs > 1 && tx_pkt->next =3D=3D NULL))
            break;

        rtl_xmit_pkt(hw, txq, tx_pkt);
    }
```

The `rte_eth_tx_burst()` contract requires:

- `tx_pkts[0..n-1]`: ownership transferred to the driver (consumed).
- `tx_pkts[n..nb_pkts-1]`: untouched, still owned by the caller.

When the driver encounters an invalid mbuf at index `nb_tx` and breaks,
that invalid packet becomes the first "unconsumed" packet returned to the
caller. Applications using the standard retry pattern will attempt to
re-transmit the unfixable packet indefinitely:

```c
    /* Common application pattern that becomes an infinite loop */
    do {
        n =3D rte_eth_tx_burst(port, txq, &mbufs[sent], nb_pkts - sent);
        sent +=3D n;
    } while (sent < nb_pkts);
```

Per the clarified `rte_eth_tx_burst()` semantics: if a packet cannot be
transmitted due to an error, the driver must still consume it, free the
mbuf, and count it via `tx_errors`. Stopping at the error packet is
incorrect.

Note: the `txq->tx_free < tx_pkt->nb_segs` check (ring full) correctly
uses `break` =E2=80=94 the driver genuinely cannot accept the packet, and t=
he
caller should retry later.

## Steps to Reproduce

1. Construct an mbuf with `pkt_len =3D=3D 0` or `nb_segs =3D=3D 0` or a
   multi-segment mbuf with a NULL `next` pointer.
2. Submit it in the middle of a burst to `rte_eth_tx_burst()` on an r8169
   port.
3. Observe that the return value leaves the invalid mbuf as the first
   unconsumed packet.
4. A retry loop will stall forever on that packet.

## Suggested Fix

Replace the `break` on invalid mbufs with consume-and-continue:

```c
        /* Check mbuf is valid */
        if (tx_pkt->nb_segs =3D=3D 0 || tx_pkt->pkt_len =3D=3D 0 ||
            (tx_pkt->nb_segs > 1 && tx_pkt->next =3D=3D NULL)) {
            rte_pktmbuf_free(tx_pkt);
            txq->sw_stats.tx_errors++;
            continue;
        }
```

This ensures the erroneous packet is consumed (freed), counted in
statistics, and does not block subsequent valid packets in the burst.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
