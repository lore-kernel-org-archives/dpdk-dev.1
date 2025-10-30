Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C8ECCF9F8
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 16:34:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC5C94026F;
	Thu, 30 Oct 2025 17:34:55 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id EC57540150
 for <dev@dpdk.org>; Thu, 30 Oct 2025 17:34:54 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id DC7AF48A14; Thu, 30 Oct 2025 17:34:54 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/eventdev Bug 1817] tx eventdev test fails if mbuf debug enabled
Date: Thu, 30 Oct 2025 16:34:54 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: eventdev
X-Bugzilla-Version: 25.07
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
Message-ID: <bug-1817-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1817

            Bug ID: 1817
           Summary: tx eventdev test fails if mbuf debug enabled
           Product: DPDK
           Version: 25.07
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: eventdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

I built DPDK with MBUF debug enabled to test some other features.
When running the functional tests, discovered that Tx Evnetdev test fails.

EAL: Detected CPU lcores: 32
EAL: Detected NUMA nodes: 1
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'VA'
APP: HPET is not enabled, using TSC as default timer
RTE>>event_eth_tx_adapter_autotest
 + ------------------------------------------------------- +
 + Test Suite : tx event eth adapter test suite
Port 0 MAC: 00 00 00 00 00 00
Port 1 MAC: 00 00 00 00 00 00
Failed to find a valid event device, testing with event_sw0 device
 + ------------------------------------------------------- +
 + TestCase [ 0] : tx_adapter_create_free succeeded
ETHDEV: Invalid port_id=3D2
 + TestCase [ 1] : tx_adapter_queue_add_del succeeded
 + TestCase [ 2] : tx_adapter_start_stop succeeded
EAL: PANIC in rte_mbuf_sanity_check():
bad mbuf pool


Looks like the test is making bogus dummy mbufs and then expects to be able=
 to
safely transmit them. The test needs to be modified to use a normal mbuf po=
ol.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
