Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77E5CCF9EB
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 21:06:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95648402AE;
	Wed, 29 Oct 2025 22:06:19 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id B185D402A6
 for <dev@dpdk.org>; Wed, 29 Oct 2025 22:06:18 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 909CE48A05; Wed, 29 Oct 2025 22:06:18 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/other Bug 1816] bpf ethdev tx filtering semantic issues
Date: Wed, 29 Oct 2025 21:06:18 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: other
X-Bugzilla-Version: 25.07
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: major
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
Message-ID: <bug-1816-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1816

            Bug ID: 1816
           Summary: bpf ethdev tx filtering semantic issues
           Product: DPDK
           Version: 25.07
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: major
          Priority: Normal
         Component: other
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

If the function rte_bpf_eth_tx_elf_load() is used to load a filter on a que=
ue
can cause duplicate mbuf usage issues.

For normal PMD transmit if rte_eth_tx_burst() returns a value smaller than =
the
request number of packets; then the application will assume that this is
because the transmit descriptor queue in the PMD is full. The unsent buffers
will not be freed by the PMD, and is up to the application to either free (=
or
resend) those mbufs.

The issue is that the transmit call back filter can return a smaller value =
than
requested if some packets were filtered. The BPF filter code drops the filt=
ered
out packets.

In the simplest case, a common practice will cause duplicate free:
    sent =3D rte_eth_tx_burst(port, queue, pkts, nb_pkts);
    if (sent < nb_pkts)
        rte_pktmbuf_free_bulk(pkts + sent, nb_pkts - sent);

Alternatives are:
   - redefining the meaning of tx_burst such that rte_eth_tx_burst frees
     major application impact
   - treat filtered packets as if sent

--=20
You are receiving this mail because:
You are the assignee for the bug.=
