Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03DAC61DBD
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 17:29:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BEF14025A;
	Fri, 28 Aug 2026 19:29:05 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 2333D40151
 for <dev@dpdk.org>; Fri, 28 Aug 2026 19:29:04 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 0E9D04CAB4; Fri, 28 Aug 2026 19:29:04 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 2010] memif: rx ues peer-controlled descriptor
Date: Fri, 28 Aug 2026 17:29:04 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 26.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: critical
X-Bugzilla-Who: stephen@networkplumber.org
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone bug_group attachments.created
Message-ID: <bug-2010-3@https.bugs.dpdk.org/>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
X-Bugzilla-URL: https://bugs.dpdk.org/
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2010

            Bug ID: 2010
           Summary: memif: rx ues peer-controlled descriptor
           Product: DPDK
           Version: 26.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: critical
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---
             Group: security

Created attachment 365
  --> https://bugs.dpdk.org/attachment.cgi?id=3D365&action=3Dedit
Original Adalogic report

Memif server trusts the request from server (and should not).
Long winded AI description...

memif connects two processes over shared memory, commonly across a
container boundary. The trust between the two roles is not symmetric and
the asymmetry is intrinsic to the protocol: the client creates the shared
memory and passes the region file descriptors to the server, so the
client necessarily trusts the server. The server must not trust the
client. DPDK has never written this model down, which is part of why the
gap below was never treated as a defect.

On the receive path the driver reads each descriptor's region index,
offset and length straight from the peer-writable ring and uses them
with no validation.

memif_get_buffer() in drivers/net/memif/rte_eth_memif.c resolves a
descriptor to a host pointer:

    return ((uint8_t *)proc_private->regions[d->region]->addr + d->offset);

d->region is a uint16_t indexing a 256-entry regions[] array
(ETH_MEMIF_MAX_REGION_NUM) and is not checked against
proc_private->regions_num, nor is regions[d->region] checked for NULL.
d->offset is a uint32_t and is not checked against the region size.

eth_memif_rx() then takes the peer's length and copies from the resolved
pointer into a receive mbuf:

    cp_len =3D d0->length;
    ...
    rte_memcpy(rte_pktmbuf_mtod(mbuf, void *),
        (uint8_t *)memif_get_buffer(proc_private, d0), cp_len);

with no check of cp_len against the mbuf data room, which is
rte_pktmbuf_data_room_size(mq->mempool) - RTE_PKTMBUF_HEADROOM, typically
around 2 KB.

A malicious peer therefore controls both the copy source and the copy
length:

  - a region index or offset outside the mapping makes the resolved
    pointer point outside the mapped region, giving an out-of-bounds
    read whose result is copied into the mbuf and forwarded;
  - a length up to 65535 into a ~2 KB mbuf gives an out-of-bounds write
    into the host mempool, past the mbuf and into adjacent objects.

Both sides of a memif link receive peer-produced descriptors on their Rx
path, so both roles are exposed, but the server is the case that matters:
it is the side that is not supposed to trust its peer.

The descriptor lives in the peer-writable ring and is re-read on each
use, so the values are also subject to change by the peer after any
check. Validation must be done on a single private snapshot of each
field, not by re-reading the ring.

That this is an omission rather than a design decision is visible in the
control plane, which does validate a region index before accepting it,
in memif_msg_receive_add_region() in drivers/net/memif/memif_socket.c.

Two further paths share the root cause and should be covered by the same
fix:

  - the non-zero-copy transmit path computes its copy destination from
    the same unvalidated peer fields;
  - the zero-copy receive path has not been audited against this; it
    should be checked as part of the fix rather than assumed safe.


Reported by Arthur Chan <arthur.chan@adalogics.com> (Ada Logics). The
data-path defect was discovered by Claude, Anthropic's AI assistant, and
triaged manually by Ada Logics in collaboration with Anthropic Research.

---------------- to here ----------------

See attached for submitter's full report.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
