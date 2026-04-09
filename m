Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DD9F364B1
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Apr 2026 20:02:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CECE74028D;
	Thu,  9 Apr 2026 22:02:17 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 9D8DB40276
 for <dev@dpdk.org>; Thu,  9 Apr 2026 22:02:16 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 8D46D4AE70; Thu,  9 Apr 2026 22:02:16 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1932] cn10k/cn20k: IPv6 header parsing bugs
Date: Thu, 09 Apr 2026 20:02:16 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 26.03
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
 target_milestone
Message-ID: <bug-1932-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1932

            Bug ID: 1932
           Summary: cn10k/cn20k: IPv6 header parsing bugs
           Product: DPDK
           Version: 26.03
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: critical
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

The code in net/cnxk and crypto/cnxk is buggy in face of malicious IPv6
headers.
TLDR; IPV6 headers may contain bogus data (bad length) bad options and there
maybe a DoS attack with multiple extension headers.

Setting the severity of this to critical since it is the kind of bug securi=
ty
researchers like to target.

Longer AI generated full report:
Title: net/cnxk: IPv6 extension header parsing lacks bounds checks and error
handling

Component: ethdev
Version: current main
Hardware: Marvell cn9k/cn10k/cn20k
Severity: normal

Description:

The IPv6 extension header walking loops in the cnxk drivers have
several related issues that can be triggered by crafted packets.
The loops use rte_ipv6_get_next_ext() which reads the extension
header length directly from packet data without any validation.

Affected files:
  - drivers/crypto/cnxk/cn9k_ipsec_la_ops.h  (ipsec_po_out_rlen_get)
  - drivers/net/cnxk/cn10k_rx.h  (nix_sec_reass_first_frag_update)
  - drivers/net/cnxk/cn20k_rx.h  (nix_sec_reass_first_frag_update)

--- Issue 1: No iteration limit ---

All three loops use "while (nh !=3D -EINVAL)" with no cap on the
number of iterations.  A packet with a pathological chain of
syntactically valid extension headers can burn CPU cycles in the
fast path.  By comparison, rte_net_skip_ip6_ext() in lib/net caps
iterations at 5.

--- Issue 2: No bounds checking on extension length ---

rte_ipv6_get_next_ext() returns the length byte from the packet
without checking it against the mbuf data.  All three callers then
advance a raw pointer (nxt_hdr +=3D ext_len) without verifying that
the pointer stays within the first mbuf segment.  A bogus length
byte causes out-of-bounds reads.

In cn9k this corrupts adj_len, which feeds into the output buffer
length passed to hardware.  In cn10k/cn20k this corrupts *ihl and
tot_len, which are used as rte_memcpy offsets.

--- Issue 3: Unconditional fragment header removal ---

In cn10k and cn20k, nix_sec_reass_first_frag_update() unconditionally
executes the fragment-header removal path (rte_memcpy to shift
headers forward by 8 bytes, data_off +=3D 8, data_len -=3D 8) regardless
of whether the extension header walk actually found IPPROTO_FRAGMENT.

If the walk exits early (malformed packet, bounds check, iteration
limit, or simply no fragment header present), the memcpy uses a
wrong offset (tot_len may be 0 or incomplete) and the mbuf metadata
is corrupted by the unconditional 8-byte adjustment.

The function has a void return type, so callers have no way to
detect the failure.

--- Issue 4: Return type prevents error handling ---

nix_sec_reass_first_frag_update() returns void.  Even if the above
issues are fixed by breaking out of the loop, the callers
(nix_sec_reass_resolve and the inline reassembly path) cannot
distinguish success from failure and will continue processing a
corrupted mbuf.  The function should return an error indicator so
callers can drop the packet.

--- Suggested approach ---

1. Add an iteration cap (e.g., 5) to all three loops.
2. Add a bounds check (nxt_hdr + ext_len vs segment end) before
   each pointer advance.
3. Track whether IPPROTO_FRAGMENT was found; skip the memcpy and
   data_off/data_len adjustment if not.
4. Change the return type to int and update callers to handle errors.

The cn10k and cn20k loops are nearly identical and could share a
common helper, but that is a cleanup to consider separately.

Note: the correct error-handling behavior in the callers (free the
mbuf chain, set RTE_MBUF_F_RX_SEC_OFFLOAD_FAILED, bump a counter,
etc.) depends on the hardware behavior and driver conventions, and
should be decided by the maintainer with access to test hardware.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
