Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1D8CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 06:50:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3355F400D6;
	Mon, 10 Nov 2025 07:50:40 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id EECEC400D5
 for <dev@dpdk.org>; Mon, 10 Nov 2025 07:50:38 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id BEC5F48AC7; Mon, 10 Nov 2025 07:50:38 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/other Bug 1825] The DPDK memif driver fails to connect a
 second zero-copy client port from the same process, logging an "mmap failed:
 No such device" error.
Date: Mon, 10 Nov 2025 06:50:38 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: other
X-Bugzilla-Version: 23.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: major
X-Bugzilla-Who: staryyuuwx@gmail.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1825-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1825

            Bug ID: 1825
           Summary: The DPDK memif driver fails to connect a second
                    zero-copy client port from the same process, logging
                    an "mmap failed: No such device" error.
           Product: DPDK
           Version: 23.11
          Hardware: All
                OS: Linux
            Status: UNCONFIRMED
          Severity: major
          Priority: Normal
         Component: other
          Assignee: dev@dpdk.org
          Reporter: staryyuuwx@gmail.com
  Target Milestone: ---

Linux localhost 5.10.0-136.12.0.86.h1032.eulerosv2r12.aarch64 #1 SMP Wed Ju=
n 28
18:34:50 UTC 2023 aarch64 aarch64 aarch64 GNU/Linux

1. start two server memifs
./dpdk-testpmd -l 1-2 --file-prefix=3Dpmd1
--vdev=3Dnet_memif0,socket=3D/run/memif_wx0,role=3Dserver
--vdev=3Dnet_memif1,socket=3D/run/memif_wx1,role=3Dserver -- -i

2. start one client memif
./dpdk-testpmd -l 3-4 -m 4096 --file-prefix=3Dpmd2
--vdev=3Dnet_memif0,socket=3D/run/memif_wx0,role=3Dclient,zero-copy=3Dyes
--single-file-segments -- -i

port 0 is up
testpmd> show port info 0

********************* Infos for port 0  *********************
MAC address: 72:5C:61:5A:E9:75
Device name: net_memif0
Driver name: net_memif
Firmware-version: not available
Devargs: socket=3D/run/memif_wx0,role=3Dclient,zero-copy=3Dyes
Connect to socket: 0
memory allocation on the socket: 0
Link status: up
Link speed: 100 Gbps
Link duplex: full-duplex
......

3. add and start 2nd client memif, print "mmap failed: No such device"
client:
testpmd> port attach net_memif1,socket=3D/run/memif_wx1,role=3Dclient,zero-=
copy=3Dyes
Attaching a new port...
Port 1 is attached. Now total ports is 2
Done
testpmd> port start 1
Configuring Port 1 (socket 0)
Port 1: 96:75:EE:3F:B7:AA
Checking link statuses...
Done

server:
testpmd> memif_connect(): mmap failed: No such device
testpmd> show port info 1

********************* Infos for port 1  *********************
MAC address: C6:84:F6:36:9F:72
Device name: net_memif1
Driver name: net_memif
Firmware-version: not available
Devargs: socket=3D/run/memif_wx1,role=3Dserver
Connect to socket: 0
memory allocation on the socket: 0
Link status: down
Link speed: 100 Gbps
Link duplex: full-duplex
Autoneg status: On

--=20
You are receiving this mail because:
You are the assignee for the bug.=
