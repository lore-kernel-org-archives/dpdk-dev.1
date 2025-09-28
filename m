Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E66CAC5B5
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Sep 2025 07:27:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D4FD40655;
	Sun, 28 Sep 2025 09:27:14 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 74EDC402EA
 for <dev@dpdk.org>; Sun, 28 Sep 2025 09:27:12 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 57E7C48851; Sun, 28 Sep 2025 09:27:12 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/testpmd Bug 1795] [dpdk-25.11-rc0]
 checksum_offload/do_not_insert_checksum_on_the_transmit_packet: core dumped
 occurred when send packets
Date: Sun, 28 Sep 2025 07:27:11 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: testpmd
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: hailinx.xu@intel.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1795-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1795

            Bug ID: 1795
           Summary: [dpdk-25.11-rc0]
                    checksum_offload/do_not_insert_checksum_on_the_transmi
                    t_packet: core dumped occurred when send packets
           Product: DPDK
           Version: unspecified
          Hardware: x86
                OS: FreeBSD
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: testpmd
          Assignee: dev@dpdk.org
          Reporter: hailinx.xu@intel.com
  Target Milestone: ---

Step:
=3D=3D=3D=3D=3D
1. bind ports to DPDK
kenv hw.nic_uio.bdfs=3D"75:0:0,75:0:1,75:0:2,75:0:3"
kldload ./x86_64-native-bsdapp-gcc/kmod/nic_uio.ko  2. exit testpmd

2. Launch testpmd
x86_64-native-bsdapp-gcc/app/dpdk-testpmd -l 0,28 -n 4 -a 0000:4b:00.0 -a
0000:4b:00.1 -a 0000:4b:00.2 -a 0000:4b:00.3     -- -i --portmask=3D0x1
--enable-rx-cksum --port-topology=3Dloop
set verbose 1
set fwd csum
csum mac-swap off 0
start

3. send packets
sendp([Ether(dst=3D"52:00:00:00:00:01",
src=3D"52:00:00:00:00:00")/IP(src=3D"10.0.0.1",chksum=3D0x0)/UDP(chksum=3D0=
xf)/("X"*46),Ether(dst=3D"52:00:00:00:00:01",
src=3D"52:00:00:00:00:00")/IP(src=3D"10.0.0.1",chksum=3D0x0)/TCP(chksum=3D0=
xf)/("X"*46),Ether(dst=3D"52:00:00:00:00:01",
src=3D"52:00:00:00:00:00")/IPv6(src=3D"::1")/UDP(chksum=3D0xf)/("X"*46),Eth=
er(dst=3D"52:00:00:00:00:01",
src=3D"52:00:00:00:00:00")/IPv6(src=3D"::1")/TCP(chksum=3D0xf)/("X"*46)],if=
ace=3D"ens801f0",count=3D4)

Output:=20
=3D=3D=3D=3D=3D=3D=3D
Segmentation fault (core dumped)

Bad commit:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
commit 066f3d9cc21ccaf15be29dddc63891c43aac06f4
Author: Sunil Kumar Kori <skori@marvell.com>
Date:   Mon Aug 4 13:16:24 2025 +0530

    ethdev: remove callback checks from fast path

    rte_eth_fp_ops contains ops for fast path APIs. Each API
    validates availability of callback and then invoke it.
    These checks impact data path performance.

    Hence removing these NULL checks instead using dummy
    callbacks.

    Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
    Acked-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
    Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

--=20
You are receiving this mail because:
You are the assignee for the bug.=
