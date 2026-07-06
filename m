Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC11C43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 06:48:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F7194027B;
	Mon,  6 Jul 2026 08:48:19 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 49AFF4021E
 for <dev@dpdk.org>; Mon,  6 Jul 2026 08:48:18 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 308464B818; Mon,  6 Jul 2026 08:48:18 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/examples Bug 1963] hotplug_mp: attach the share device failed
 in secondary processe
Date: Mon, 06 Jul 2026 06:48:17 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: examples
X-Bugzilla-Version: 25.07
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yex.chen@intel.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1963-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1963

            Bug ID: 1963
           Summary: hotplug_mp: attach the share device failed in
                    secondary processe
           Product: DPDK
           Version: 25.07
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: examples
          Assignee: dev@dpdk.org
          Reporter: yex.chen@intel.com
  Target Milestone: ---

Environment
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DPDK version: f77bc8767a952cf833fc9c85d6b5b8d77d39a5da=20
version: 26.07.0-rc2
OS: Rhel9.6 (Plow)/5.14.0-570.12.1.el9_6.x86_64
Compiler: gcc version 11.5.0 20240719
Hardware platform: Intel(R) Xeon(R) 6767P
NIC hardware: Intel Corporation Ethernet Controller XL710 for 40GbE QSFP+
[8086:1583]
NIC firmware:=20
  driver: vfio-pci
  kdriver: i40e-2.30.18
  firmware-version: 9.57 0x8001037b 1.4002.0

Test Setup
Steps to reproduce
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1. Build hotplug_mp=20=20=20
CC=3Dgcc meson -Dlibdir=3Dlib --default-library=3Dstatic x86_64-native-linu=
xapp-gcc
-Dmax_lcores=3D256=20=20=20=20
ninja -C x86_64-native-linuxapp-gcc=20
meson configure -Dexamples=3Dmulti_process/hotplug_mp x86_64-native-linuxap=
p-gcc
ninja -C x86_64-native-linuxapp-gcc

2. bind pf to i40e=20
usertools/dpdk-devbind.py --force --bind=3Di40e 0000:da:00.0=20

3. Start dpdk-hotplug_mp as primary then secondary
x86_64-native-linuxapp-gcc/examples/dpdk-hotplug_mp  -l 1-2 -n 4 -a
0000:da:00.0 --proc-type=3Dauto

4. Bind the port to vfio-pci
usertools/dpdk-devbind.py --force --bind=3Dvfio-pci 0000:da:00.0

5. Attach the physical device from primary, check primary and secondary
processes attach the share device
example> attach 0000:da:00.0=20=20=20=20=20
example> list=20=20=20

Results:=20
=3D=3D=3D=3D=3D=3D=3D=3D
the primary processe attach the share device successfully,
but the secondary processe attach the share device failed
example> list=20=20=20=20=20
list all etherdev

Expected Result:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
the primary and secondary processes attach the share device successfully
example> list=20=20=20=20=20=20
list all etherdev=20=20=20=20=20=20
0       0000:da:00.0


bad commit:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
commit: 1a2e26d8701d36c82fc2e405abb5e80d73df54bb

Author: David Marchand <david.marchand@redhat.com>
Date:   Wed Jun 24 14:07:56 2026 +0200

    dev: skip multi-process in hotplug

    If multi-process is disabled ({}no-shconf/{-}-in-memory),
    there is no need to build a multi-process message.

    Signed-off-by: David Marchand <david.marchand@redhat.com>
    Acked-by: Chengwen Feng <fengchengwen@huawei.com>

--=20
You are receiving this mail because:
You are the assignee for the bug.=
