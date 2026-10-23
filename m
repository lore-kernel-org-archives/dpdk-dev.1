Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81511606A321
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 09:40:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C4F0840299;
	Fri, 23 Oct 2026 11:40:46 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 9A56740268
 for <dev@dpdk.org>; Fri, 23 Oct 2026 11:40:45 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 7F40E4D469; Fri, 23 Oct 2026 11:40:45 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 2072] [dpdk26.11-rc1] power_intel_uncore: start
 dpdk-l3fwd-power failed on Ubuntu26.04
Date: Fri, 23 Oct 2026 09:40:45 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 26.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: daxuex.gao@intel.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-2072-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2072

            Bug ID: 2072
           Summary: [dpdk26.11-rc1] power_intel_uncore: start
                    dpdk-l3fwd-power failed on Ubuntu26.04
           Product: DPDK
           Version: 26.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: daxuex.gao@intel.com
  Target Milestone: ---

Environment
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DPDK version: dpdk-v26.11-rc1 (9a45341f18a1a)
OS: Ubuntu 26.04.1 LTS/Linux 7.0.0-38-generic
Compiler: gcc version 15.2.0 (Ubuntu 15.2.0-16ubuntu1)
NIC hardware: Ethernet Controller E810-C for SFP 1593 [8086:1593 (rev 01)]
NIC firmware:=20
  driver: vfio-pci
  kdriver: ice-2.6.7
  fw: 5.01 0x80021f88 1.4031.0
  ddp: ICE OS Package version 1.3.59.0

Test Setup
Steps to reproduce
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1.Build dpdk=20
CC=3Dgcc meson -Dlibdir=3Dlib  --default-library=3Dstatic x86_64-native-lin=
uxapp-gcc
ninja -C x86_64-native-linuxapp-gcc
meson configure -Dexamples=3Dl3fwd-power x86_64-native-linuxapp-gcc
ninja -C x86_64-native-linuxapp-gcc

2.Start dpdk-l3fwd-power
x86_64-native-linuxapp-gcc/examples/dpdk-l3fwd-power  -l 1-2 -n 1 -- -p 0x1=
 -P
--config=3D"(0,0,2)" -U

Results:=20
=3D=3D=3D=3D=3D=3D=3D=3D
# x86_64-native-linuxapp-gcc/examples/dpdk-l3fwd-power  -l 1-2 -n 1 -- -p 0=
x1
-P --config=3D"(0,0,2)" -U
EAL: Detected CPU lcores: 224
EAL: Detected NUMA nodes: 8
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
EAL: VFIO support initialized: group mode, IOVA as VA
EAL: Selected IOVA mode 'VA'
Promiscuous mode selected
L3FWD_POWER: Operating mode not specified, probing frequency scaling suppor=
t...
L3FWD_POWER: Selected operation mode: legacy
POWER: Env isn't set yet!
POWER: Attempting to initialise acpi cpufreq power management...
POWER: acpi-cpufreq driver is not supported
POWER: Attempting to initialise amd-pstate cpufreq power management...
POWER: amd-pstate driver is not supported
POWER: Attempting to initialise cppc cpufreq power management...
POWER: cppc_cpufreq driver is not supported
POWER: Attempting to initialise intel-pstate cpufreq power management...
POWER: Initialized successfully for lcore 1 power management
POWER: Initialized successfully for lcore 2 power management
EAL: Error - exiting with code: 1
init_power_library failed


Expected Result:
Startup successful=20

Regression
Is this issue a regression: N

Bad commit:
commit 384d6f309cac7bc95ce8d515e8929b3cfd1b4a48 (HEAD)
Author: Huisong Li <lihuisong@huawei.com>
Date:   Wed Aug 12 17:49:54 2026 +0800
    examples/l3fwd-power: relocate uncore initialization
    Currently, the deinitialization of uncore is in deinit_power_library().
    But its initialization is located in the parameter parsing function,
    which is not good to maintain.
    So move this logic to init_power_library().
    Signed-off-by: Huisong Li <lihuisong@huawei.com>

--=20
You are receiving this mail because:
You are the assignee for the bug.=
