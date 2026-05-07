Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38913CD342C
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 03:12:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5209340265;
	Thu,  7 May 2026 05:12:20 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id E46A0400D7
 for <dev@dpdk.org>; Thu,  7 May 2026 05:12:18 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id C71564B152; Thu,  7 May 2026 05:12:18 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1942] Primary shutdown not caught by all secondaries
Date: Thu, 07 May 2026 03:12:18 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 26.03
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
Message-ID: <bug-1942-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1942

            Bug ID: 1942
           Summary: Primary shutdown not caught by all secondaries
           Product: DPDK
           Version: 26.03
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

The fix to send message when primary exits was wrong approach.
It doesn't work with other applications like dumpcap, pdump or customer
applications.

This is shown by:
 - run test pmd
 - start dpdk dump (secondary)
 - exit test pmd
The shutdown process hangs and eventually times out.

Primary: Sending 'stop_req' request to secondary...
EAL: Fail to recv reply for request
/var/run/dpdk/rte/mp_socket_130405_3692c058749:mp_testpmd

Stopping port 0...
Stopping ports...
Done

Shutting down port 0...
Closing ports...
Port 0 is closed
Done

And in dumpcap:
# ./build/app/dpdk-dumpcap
File: /tmp/dpdk-dumpcap_0_net_tap0_20260506195857.pcapng
Capturing on 'net_tap0'
Packets captured: 29 EAL: Cannot find action: mp_testpmd
Primary process is no longer active, exiting...

Testpmd should not assume secondary is testpmd!

--=20
You are receiving this mail because:
You are the assignee for the bug.=
