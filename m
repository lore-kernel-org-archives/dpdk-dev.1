Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C9ACCF9E0
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 07:49:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F6944021E;
	Mon, 27 Oct 2025 08:49:42 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 5FAA84003C
 for <dev@dpdk.org>; Mon, 27 Oct 2025 08:49:40 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 3932C48A01; Mon, 27 Oct 2025 08:49:40 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/testpmd Bug 1813] [dpdk25.11]
 vxlan/vxlan_ipv6_checksum_offload: get incorrect checksum value for the inner
 L4
Date: Mon, 27 Oct 2025 07:49:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: testpmd
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: zhiminx.huang@intel.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1813-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1813

            Bug ID: 1813
           Summary: [dpdk25.11] vxlan/vxlan_ipv6_checksum_offload: get
                    incorrect checksum value for the inner L4
           Product: DPDK
           Version: unspecified
          Hardware: x86
                OS: Linux
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: testpmd
          Assignee: dev@dpdk.org
          Reporter: zhiminx.huang@intel.com
  Target Milestone: ---

Environment=EF=BC=9A
 DPDK version: dpdk-25.11-rc1:39b54f2dcf44ad1f91eabc7080cd5dea763607fd
 OS: Ubuntu 24.04.3 LTS/6.8.0-60-generic
 Compiler: gcc version 13.3.0
 Hardware platform: Intel(R) Xeon(R) Platinum 8380 CPU @ 2.30GHz
 NIC hardware: Intel Corporation Ethernet Controller X710 for 10GbE SFP+=20
 [8086:1572]
 NIC firmware:=20
   i40e: 6.8.0-60-generic
   firmware: 9.55 0x8000fdf4 1.3862.0

Steps to reproduce=EF=BC=9A

 1.bind pf to vfio-pci
 usertools/dpdk-devbind.py --force --bind=3Dvfio-pci 0000:31:00.0

 2.start testpmd
 ./x86_64-native-linuxapp-clang/app/dpdk-testpmd  -l 1-5 -n 4 -a 0000:31:00=
.0
--=20
 force-max-simd-bitwidth=3D64   -- -i --enable-rx-cksum

 vlan set filter off 0
 set fwd csum
 port stop all
 csum set outer-ip hw 0
 csum set udp hw 0
 csum set outer-udp hw 0
 csum set tcp hw 0
 csum set sctp hw 0
 csum parse-tunnel on 0
 port start all
 rx_vxlan_port add 4789 0
 start

 3.launch the tcpdump
 tcpdump -i ens3f0  'ether[12:2] !=3D 0x88cc'  -Q in -w /tmp/test.pcap

 4.send packet
 sendp([Ether(src=3D'00:00:10:00:00:00',=20
 dst=3D'3c:fd:fe:b2:44:c8')/IPv6(src=3D'fe80::',dst=3D'fe80::1')/UDP(sport=
=3D63,=20
 dport=3D4789)/VXLAN(vni=3D1)/Ether(src=3D'00:00:20:00:00:00',=20
 dst=3D'00:00:20:00:00:01')/IP(src=3D'192.168.2.1',=20
dst=3D'192.168.2.2')/UDP(chksum=3D1)/Raw(load=3Db'XXXXXXXXXXXXXXXXXX')],ifa=
ce=3D"ens3f0",count=3D1,inter=3D0,verbose=3DFalse)

 5.use scapy to check the checksum value for capture packet
 p =3D rdpcap("/tmp/test.pcap")
 p[0].show2()

Show the output from the previous commands=EF=BC=9A
 the inner udp checksum incorrect
 ###[ UDP ]###
                     sport     =3D domain
                     dport     =3D domain
                     len       =3D 26
                     chksum    =3D 0x1

 Expected Result=EF=BC=9A
 ###[ UDP ]###
                     sport     =3D domain
                     dport     =3D domain
                     len       =3D 26
                     chksum    =3D 0x5ee1=20
Regression=EF=BC=9A
 Is this issue a regression: (Y/N) Y

 commit 496159613ffc7b6ba592432a1ba4d1a38f6935de
 Author: Dengdui Huang <huangdengdui@huawei.com>
 Date:   Sat Aug 30 09:29:13 2025 +0800

     app/testpmd: fix L4 protocol retrieval from L3 header

     Currently, when retrieving the L4 protocol from the L3 header,
     the case of IPv6 with extension headers is not handled correctly.
     This patch fixes it.

     Fixes: 76730c7b9b5a ("app/testpmd: use packet type parsing API")
     Cc: stable@dpdk.org

     Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>

  app/test-pmd/csumonly.c | 39 ++++++++++++++++-----------------------
  1 file changed, 16 insertions, 23 deletions

--=20
You are receiving this mail because:
You are the assignee for the bug.=
