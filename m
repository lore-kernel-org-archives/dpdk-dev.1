Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529C8C79FB5
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Sep 2026 02:55:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CC8740272;
	Wed,  9 Sep 2026 04:55:40 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id BA76E40144
 for <dev@dpdk.org>; Wed,  9 Sep 2026 04:55:38 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 8B0B84CBBC; Wed,  9 Sep 2026 04:55:38 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 2032] bus/dpaa: crash when removing ethdev
 callbacks from a non-EAL thread
Date: Wed, 09 Sep 2026 02:55:38 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 24.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: gu.jiawei@e-quantum.com.cn
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-2032-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2032

            Bug ID: 2032
           Summary: bus/dpaa: crash when removing ethdev callbacks from a
                    non-EAL thread
           Product: DPDK
           Version: 24.11
          Hardware: ARM
                OS: Linux
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: gu.jiawei@e-quantum.com.cn
  Target Milestone: ---

DPDK version: 24.11.7

Environment:
- NXP LS1043A (aarch64)
- DPAA1 Ethernet device
- Two PMD threads
- Linux ANP 6.1.55-ASG1200-H #28 SMP PREEMPT Sun Sep 29 10:01:56 CST 2024
aarch64 GNU/Linux
- Packet capture implemented with ethdev RX/TX callbacks
- Callback registration and removal are performed by a non-PMD, non-EAL thr=
ead

Description:
The application crashes when a non-EAL thread removes ethdev RX/TX callbacks
that were registered for packet capture.

The capture thread registers callbacks with:
  rte_eth_add_rx_callback(...);
  rte_eth_add_tx_callback(...);

After the capture interval expires, the same non-EAL thread removes them wi=
th:
  rte_eth_remove_rx_callback(...);
  rte_eth_remove_tx_callback(...);

The crash occurs in dpaa_portal_finish() at:
  dpaa_portals[rte_lcore_id()] =3D NULL;

Because the callback removal is executed from a non-EAL thread, rte_lcore_i=
d()
returns LCORE_ID_ANY. This value is used as an index into dpaa_portals[],
causing an out-of-bounds access and a segmentation fault.

Steps to reproduce:
1. Start an application using a DPAA1 Ethernet device on LS1043A with two P=
MD
threads.
2. Start packet forwarding or packet processing.
3. From a non-EAL thread, register RX and TX callbacks for packet capture u=
sing
rte_eth_add_rx_callback() and rte_eth_add_tx_callback().
4. After a capture interval, remove the callbacks from the same thread using
rte_eth_remove_rx_callback() and rte_eth_remove_tx_callback().
5. Observe the application crash.

Actual result:
The application terminates with SIGSEGV in dpaa_portal_finish() because
LCORE_ID_ANY is used as an array index.

Expected result:
Removing ethdev callbacks from a non-EAL thread must not cause an out-of-bo=
unds
array access or application crash.

Backtrace:
Program terminated with signal SIGSEGV, Segmentation fault.
#0  dpaa_portal_finish (arg=3D0x2184242e80)
    at ../drivers/bus/dpaa/dpaa_bus.c:453
#1  0x0000ffff9283ed84 in ?? () from /lib64/libc.so.6
#2  0x0000ffff92841740 in ?? () from /lib64/libc.so.6
#3  0x0000ffff928976dc in ?? () from /lib64/libc.so.6

--=20
You are receiving this mail because:
You are the assignee for the bug.=
