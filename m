Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1C9D6ACFB
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Dec 2025 13:18:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56EFB40275;
	Thu, 18 Dec 2025 14:18:47 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 354F44026A
 for <dev@dpdk.org>; Thu, 18 Dec 2025 14:18:46 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 0E6094707C; Thu, 18 Dec 2025 14:18:46 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/testpmd Bug 1851] Packets are not received when promisc off
Date: Thu, 18 Dec 2025 13:18:45 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: testpmd
X-Bugzilla-Version: 22.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sbadawi@nvidia.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1851-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1851

            Bug ID: 1851
           Summary: Packets are not received when promisc off
           Product: DPDK
           Version: 22.11
          Hardware: x86
                OS: Linux
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: testpmd
          Assignee: dev@dpdk.org
          Reporter: sbadawi@nvidia.com
  Target Milestone: ---

testpmd app running cmd:

install/bin/dpdk-testpmd -n 4 -a 0000:08:00.0,dv_flow_en=3D0 -a
0000:08:00.1,dv_flow_en=3D0 --iova-mode=3D"va" -- --mbcache=3D512 -i =C2=A0=
--nb-cores=3D2


repro cmds:
testpmd>stop
testpmd>set portmask 0x3
testpmd>start
testpmd>set promisc all off
testpmd>start
testpmd>mac_addr add 0 00:16:3e:50:e4:8c
testpmd>mac_addr add 1 00:16:3e:50:d7:b6


Scapy packet to send (from an interface connected back-to-back) with probed
device


packet =3D Ether(dst=3D'00:16:3e:50:e4:8c', src=3D'0c:42:a1:58:ab:e4',
type=3D34525)/IPv6()/TCP()/Raw(load=3D100*b'ss')=20

sendp(packet, iface =3D 'eth2', count =3D 2089, verbose=3DFalse)=20

OS: Ubuntu 22.04 (x86_64)
Kernel: 5.15.0-25-generic
OFED: MLNX_OFED_LINUX-5.8-7.0.6.1
DPDK: =C2=A0 04536b2
Device: ConnectX-6 DX
FW: 22.35.4554

--=20
You are receiving this mail because:
You are the assignee for the bug.=
