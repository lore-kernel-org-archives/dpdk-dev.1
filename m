Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0B2C61DCB
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 17:42:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E24134025A;
	Fri, 28 Aug 2026 19:42:05 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 0CD5F40151
 for <dev@dpdk.org>; Fri, 28 Aug 2026 19:42:05 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id EA38E4CFAA; Fri, 28 Aug 2026 19:42:04 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 2016] memif: no connectivity or negative tests
Date: Fri, 28 Aug 2026 17:42:05 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 26.11
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
 target_milestone attachments.created
Message-ID: <bug-2016-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2016

            Bug ID: 2016
           Summary: memif: no connectivity or negative tests
           Product: DPDK
           Version: 26.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: minor
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

Created attachment 366
  --> https://bugs.dpdk.org/attachment.cgi?id=3D366&action=3Dedit
memif test script

memif has no test in CI. Nothing checks that a server and a client can
connect and forward traffic, and nothing checks that a malformed peer is
rejected rather than crashing or corrupting the server.

The driver takes its input from another process over shared memory, so
the second of those matters more here than it would for a NIC driver.

Two pieces of work, which can be separate patches:

1. Connectivity baseline

A black box test that launches a memif server and a memif client as two
testpmd processes connected over a shared socket, and checks that
traffic flows in both directions. This exercises the connection path
over a real link without depending on any internal driver API, and gives
a two-instance harness that an adversarial peer can be driven from
later. Skipping with exit 77 when fewer than four cores are online keeps
it usable in constrained CI, since two primary processes need two cores
each.

A candidate script is attached. Two things to settle before it lands:

  - It greps the logs for a "bad descriptor" line that nothing currently
    emits. That log only exists once descriptor validation is added, so
    the check is either premature or should be dropped.
  - It assumes the server and client must be separate processes. Worth
    checking whether a server vdev and a client vdev can be instantiated
    in a single testpmd process. If they can, the whole thing becomes a
    plain unit test with no core requirement and no process
    orchestration.

2. Negative test

A standalone client that speaks the control protocol over the socket
directly and sends malformed messages, asserting that the server
disconnects cleanly and does not crash. Written that way it needs no VPP
dependency and no second DPDK process, and it can cover every
control-channel case: wrong-direction messages, oversized rings, rings
outside their region, repeated ring indices, regions whose fd is smaller
than the claimed size.

The negative test is the more valuable of the two, and it is the natural
place for a fuzz driver to be attached later.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
