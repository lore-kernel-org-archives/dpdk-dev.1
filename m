Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A159D606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 03:28:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9398A40151;
	Mon, 26 Oct 2026 04:28:29 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTPS id B7EBF40150
 for <dev@dpdk.org>; Mon, 26 Oct 2026 04:28:28 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 7F67A4D26C; Mon, 26 Oct 2026 04:28:28 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/testpmd Bug 2074] [26.11]i40e:
 mac_filter/test_add_remove_mac_address, remove_mac the change did not take
 effect.
Date: Mon, 26 Oct 2026 03:28:27 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: testpmd
X-Bugzilla-Version: 26.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: hailinx.gou@intel.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-2074-3@https.bugs.dpdk.org/>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

https://bugs.dpdk.org/show_bug.cgi?id=3D2074

            Bug ID: 2074
           Summary: [26.11]i40e: mac_filter/test_add_remove_mac_address,
                    remove_mac the change did not take effect.
           Product: DPDK
           Version: 26.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: testpmd
          Assignee: dev@dpdk.org
          Reporter: hailinx.gou@intel.com
  Target Milestone: ---

Environment
Fill in all the following as completely as possible. Use "Unknown" or "N/A"=
 if
required. Use {{braces}} to create fixed width text like this: braces.



DPDK version: Use make showversion or for a non-released version: git remot=
e -v
&& git show-ref --heads
dpdk-26.11-rc1: 9a45341f18a1ab47af7123e63d942b90c1b79f38
Other software versions: name/version for QEMU, OVS, etc. Repeat as require=
d.
OS: Use uname -a
Ubuntu 26.04.1 LTS
Compiler: Use gcc --version or similar
gcc (Ubuntu 15.2.0-16ubuntu1) 15.2.0
Hardware platform: Purley/IceLake etc.
NIC hardware: Niantic/Fortville etc.
NIC firmware: if applicable
driver: i40e
version: 2.30.18
firmware-version: 6.51 0x80004430 1.4002.0
Test Setup
Steps to reproduce
List the steps to reproduce the issue.

x86_64-native-linuxapp-gcc/app/dpdk-testpmd -l 1-2 -n 4 -a 0000:1f:00.0 -a
0000:1f:00.1 --file-prefix=3Ddpdk_1862818_20261018044623    -- -i --portmas=
k=3D0x1

set verbose 1

set fwd rxonly

start

show port info 0

set promisc 0 off

clear port stats all

mac_addr add 0 00:01:01:00:00:00=20

start scapy:
sendp([Ether(dst=3D'00:01:01:00:00:00',
src=3D'52:00:00:00:00:00')/IP()/UDP()/Raw(load=3Db'XXXXXXXXXXXXXXXXXX')],if=
ace=3D"ens64f0",count=3D4,inter=3D0,verbose=3DFalse)=20
Show the output from the previous commands.

 tester_scapy: sendp([Ether(dst=3D'00:01:01:00:00:00',
src=3D'52:00:00:00:00:00')/IP()/UDP()/Raw(load=3Db'XXXXXXXXXXXXXXXXXX')],if=
ace=3D"ens2f0",count=3D4,inter=3D0,verbose=3DFalse)
 tester_scapy:
       dut.10.239.252.191:6022:  port 0/queue 0: received 1 packets
  src=3D52:00:00:00:00:00 - dst=3D00:01:01:00:00:00 - pool=3Dmb_pool_0 - ty=
pe=3D0x0800
- length=3D60 - nb_segs=3D1 - hw ptype: L2_ETHER L3_IPV4_EXT_UNKNOWN L4_UDP=
  - sw
ptype: L2_ETHER L3_IPV4 L4_UDP  - l2_len=3D14 - l3_len=3D20 - l4_len=3D8 -
Destination UDP port=3D53 - Receive queue=3D0x0
  ol_flags: RTE_MBUF_F_RX_L4_CKSUM_GOOD RTE_MBUF_F_RX_IP_CKSUM_GOOD
RTE_MBUF_F_RX_OUTER_L4_CKSUM_UNKNOWN
port 0/queue 0: received 1 packets
  src=3D52:00:00:00:00:00 - dst=3D00:01:01:00:00:00 - pool=3Dmb_pool_0 - ty=
pe=3D0x0800
- length=3D60 - nb_segs=3D1 - hw ptype: L2_ETHER L3_IPV4_EXT_UNKNOWN L4_UDP=
  - sw
ptype: L2_ETHER L3_IPV4 L4_UDP  - l2_len=3D14 - l3_len=3D20 - l4_len=3D8 -
Destination UDP port=3D53 - Receive queue=3D0x0
  ol_flags: RTE_MBUF_F_RX_L4_CKSUM_GOOD RTE_MBUF_F_RX_IP_CKSUM_GOOD
RTE_MBUF_F_RX_OUTER_L4_CKSUM_UNKNOWN
port 0/queue 0: received 1 packets
  src=3D52:00:00:00:00:00 - dst=3D00:01:01:00:00:00 - pool=3Dmb_pool_0 - ty=
pe=3D0x0800
- length=3D60 - nb_segs=3D1 - hw ptype: L2_ETHER L3_IPV4_EXT_UNKNOWN L4_UDP=
  - sw
ptype: L2_ETHER L3_IPV4 L4_UDP  - l2_len=3D14 - l3_len=3D20 - l4_len=3D8 -
Destination UDP port=3D53 - Receive queue=3D0x0
  ol_flags: RTE_MBUF_F_RX_L4_CKSUM_GOOD RTE_MBUF_F_RX_IP_CKSUM_GOOD
RTE_MBUF_F_RX_OUTER_L4_CKSUM_UNKNOWN
port 0/queue 0: received 1 packets
  src=3D52:00:00:00:00:00 - dst=3D00:01:01:00:00:00 - pool=3Dmb_pool_0 - ty=
pe=3D0x0800
- length=3D60 - nb_segs=3D1 - hw ptype: L2_ETHER L3_IPV4_EXT_UNKNOWN L4_UDP=
  - sw
ptype: L2_ETHER L3_IPV4 L4_UDP  - l2_len=3D14 - l3_len=3D20 - l4_len=3D8 -
Destination UDP port=3D53 - Receive queue=3D0x0
  ol_flags: RTE_MBUF_F_RX_L4_CKSUM_GOOD RTE_MBUF_F_RX_IP_CKSUM_GOOD
RTE_MBUF_F_RX_OUTER_L4_CKSUM_UNKNOWN                 TestMacFilter: Test Ca=
se
test_add_remove_mac_address Result FAILED: 'Packet has been received on a n=
ew
MAC address that has been removed from the port'

Expected Result
Explain what is the expected result in text or as an example output:

Unable to receive packets=20
Regression
Is this issue a regression: (Y)

Bad commit:

commit 74533d1a8b28d297e70cc0ade3e6c79962d9cff3 (HEAD)
Author: David Marchand <david.marchand@redhat.com>
Date:   Mon Aug 24 13:42:06 2026 +0200



    ethdev: skip VMDq pools unless configured

    The mac_addr_add API describes that only the 0 pool should be passed
    unless VMDq has been enabled, though there was no validation so far.
    Add such a check, then cleanup the MAC related operations (adding,
    removing, restoring).

    As a side effect, the net/cnxk does not need to manually reset the
    mac_pool_sel[] array.

    Signed-off-by: David Marchand <david.marchand@redhat.com>
    Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

Version the regression was introduced: Specify git id if known.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
