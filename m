Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA4EE9A02C
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 01:34:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F15B8402C6;
	Thu, 19 Feb 2026 02:33:59 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 9AA22402BD
 for <dev@dpdk.org>; Thu, 19 Feb 2026 02:33:58 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 8CEE14A667; Thu, 19 Feb 2026 02:33:58 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1888] dpaa/dpaa2: permanent tx errors cause caller
 to retry packets forever
Date: Thu, 19 Feb 2026 01:33:58 +0000
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
Message-ID: <bug-1888-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1888

            Bug ID: 1888
           Summary: dpaa/dpaa2: permanent tx errors cause caller to retry
                    packets forever
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

Both dpaa and dpaa2 transmit paths stop processing on any error and return
a short count without freeing the failing packet. For permanent errors
(unsupported segment count, missing buffer pool), this leaves the bad packet
as the first unconsumed entry and the caller retries it indefinitely.

## Affected functions

- `dpaa_eth_queue_tx()` in `drivers/net/dpaa/dpaa_rxtx.c`
- `dpaa2_dev_tx()` in `drivers/net/dpaa2/dpaa2_rxtx.c`
- `dpaa2_dev_tx_ordered()` in `drivers/net/dpaa2/dpaa2_rxtx.c`

## Description

All three functions prepare frame descriptors in a loop. When an error
occurs at position N, they jump to a `send_pkts` / `send_n_return` label
that enqueues packets 0 through N-1 and returns. The packet at position N
is neither enqueued nor freed =E2=80=94 it is returned to the caller as the=
 first
unconsumed packet.

For transient errors (allocation failure, HW backpressure) this is
tolerable since the caller can retry and succeed later. For permanent
errors the packet can never succeed and callers that re-submit unconsumed
packets spin forever:

```c
while (nb_pkts) {
    n =3D rte_eth_tx_burst(port, txq, mbufs, nb_pkts);
    mbufs +=3D n;
    nb_pkts -=3D n;
}
```

Permanent error conditions include:

- **dpaa**: `nb_segs > DPAA_SGT_MAX_ENTRIES` in `tx_on_dpaa_pool()`
- **dpaa2**: `nb_segs > 1` for non-hw-offload buffer pool
- **dpaa2**: no buffer pool attached (`!mp || !priv->bp_list`)

## Expected behavior

Per the rte_eth_tx_burst() contract, the driver should consume erroneous
packets (free the mbuf), count them in `tx_errors`, and continue processing
the remaining burst =E2=80=94 not stop at the first error.

## Note

The dpaa2 `sw_td` (software tail drop) path handles this correctly: it
frees all remaining packets and returns the full count. The same approach
should be applied to permanent errors in the normal transmit paths.

## Version

Found by code inspection against DPDK v25.03-rc1.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
