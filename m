Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B74CAC5B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 02:57:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3F35402A2;
	Tue, 30 Sep 2025 04:57:33 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 30B4B4026D
 for <dev@dpdk.org>; Tue, 30 Sep 2025 04:57:32 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 030FD4886A; Tue, 30 Sep 2025 04:57:31 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/testpmd Bug 1797] [dpdk-25.11-rc0]
 rxtx_offload/txoffload_port_multi_segs: set multi segs failed
Date: Tue, 30 Sep 2025 02:57:31 +0000
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
Message-ID: <bug-1797-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1797

            Bug ID: 1797
           Summary: [dpdk-25.11-rc0]
                    rxtx_offload/txoffload_port_multi_segs: set multi segs
                    failed
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: FreeBSD
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: testpmd
          Assignee: dev@dpdk.org
          Reporter: hailinx.xu@intel.com
  Target Milestone: ---

ENV:=20
=3D=3D=3D=3D
DPDK version: dpdk25.11.0-rc0: 1d627ea13aeec2bcccf27246e6be2508370d171e
OS: FreeBSD 14.3-RELEASE/14.3-RELEASE
Compiler: gcc version 13.3.0 (FreeBSD Ports Collection)
Hardware platform: Intel(R) Xeon(R) Gold 6348 CPU @ 2.60GHz
NIC hardware:Intel Corporation Ethernet Controller E810-C for SFP
NIC firmware:=C2=A0
    Driver: ice-2.0.9
    NVM: nvm 4.90 etid 80020f02 netlist 4.4.2000-1.17.0.dfc6695b oem 1.3863=
.0
    DDP: ICE OS Default Package version 1.3.44.0

step:
=3D=3D=3D=3D=3D
1. bind ports to DPDK
kenv hw.nic_uio.bdfs=3D"75:0:0,75:0:1,75:0:2,75:0:3"
kldload ./x86_64-native-bsdapp-gcc/kmod/nic_uio.ko =C2=A02. exit testpmd

2. Launch testpmd x86_64-native-bsdapp-gcc/app/dpdk-testpmd -l 0,2,4,28 -n =
4 -a
0000:4b:00.0 -a 0000:4b:00.1 -a 0000:4b:00.2 -a 0000:4b:00.3  -- -i
port stop all
port config 0 tx_offload multi_segs on
port config 1 tx_offload multi_segs on
port config 2 tx_offload multi_segs on
port config 3 tx_offload multi_segs on
port start all
port start 0

output
=3D=3D=3D=3D=3D=3D
Configuring Port 0 (socket 0)
ETHDEV: id=3D0 offload clash, MULTI_SEGS vs MBUF_FAST_FREE
Fail to configure port 0

Expected Result
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
testpmd> show port 0 tx_offload configuration
Tx Offloading Configuration of port 0 :
  Port : MULTI_SEGS
  Queue[ 0] : MULTI_SEGS

bad commit
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
commit fdb840367cf0d6abeb17b05623679b8d1ea4c902
Author: Morten Br=C3=B8rup <mb@smartsharesystems.com>
Date:   Sun Aug 3 19:42:18 2025 +0000

    ethdev: reject conflicting Tx offload configurations

    When an ethdev port is configured for fast mbuf release, the driver can
    use a Tx burst function relying on the fast mbuf release preconditions.
    Thus, also configuring this port or a queue on the port for transmitting
    segmented packets is prohibited.
    Checks for these conflicting configurations have been added to the ethd=
ev
    library, so the drivers don't have to implement them.

    Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
    Acked-by: Bruce Richardson <bruce.richardson@intel.com>
    Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
    Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

--=20
You are receiving this mail because:
You are the assignee for the bug.=
