Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B1ECD98DA
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 09:25:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93ADC436E2;
	Mon, 15 Jun 2026 11:25:22 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id B4D5C436DF
 for <dev@dpdk.org>; Mon, 15 Jun 2026 11:25:21 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 9FBA04B69A; Mon, 15 Jun 2026 11:25:21 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1955] [dpdk26.07-rc1] power_intel_uncore: start
 dpdk-l3fwd-power failed on Ubuntu26.04
Date: Mon, 15 Jun 2026 09:25:21 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 26.07
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
Message-ID: <bug-1955-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1955

            Bug ID: 1955
           Summary: [dpdk26.07-rc1] power_intel_uncore: start
                    dpdk-l3fwd-power failed on Ubuntu26.04
           Product: DPDK
           Version: 26.07
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
DPDK version: dpdk-26.07-rc1 (c429b06df56788795f8)
OS: Ubuntu 26.04 LTS/Linux 7.0.0-14-generic
Compiler: gcc version 15.2.0 (Ubuntu 15.2.0-16ubuntu1)
NIC hardware: Ethernet Controller E810-C for SFP 1593 [8086:1593 (rev 01)]
NIC firmware:=20
  driver: vfio-pci
  kdriver: ice-2.6.4
  fw: 5.00 0x80021c11 1.4002.0
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
usertools/dpdk-devbind.py --force --bind=3Dvfio-pci 0000:38:00.0 0000:38:00=
.1
/root/dpdk/x86_64-native-linuxapp-gcc/examples/dpdk-l3fwd-power  -l 1-2 -n =
1 --
-p 0x1 -P --config=3D"(0,0,2)" -u

Results:=20
=3D=3D=3D=3D=3D=3D=3D=3D
# /root/dpdk/x86_64-native-linuxapp-gcc/examples/dpdk-l3fwd-power  -l 1-2 -=
n 1
-- -p 0x1 -P --config=3D"(0,0,2)" -u
EAL: Detected CPU lcores: 112
EAL: Detected NUMA nodes: 8
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'VA'
EAL: VFIO support initialized
Promiscuous mode selected
/root/dpdk/x86_64-native-linuxapp-gcc/examples/dpdk-l3fwd-power [EAL option=
s]
-- -p PORTMASK -P  [--config (port,queue,lcore)[,(port,queue,lcore]]=20
[--high-perf-cores CORELIST  [--perf-config
(port,queue,hi_perf,lcore_index)[,(port,queue,hi_perf,lcore_index]]=20
[--max-pkt-len PKTLEN]
  -p PORTMASK: hexadecimal bitmask of ports to configure
  -P: enable promiscuous mode
  -u: set min/max frequency for uncore to minimum value
  -U: set min/max frequency for uncore to maximum value
  -i (frequency index): set min/max frequency for uncore to specified frequ=
ency
index
  --config (port,queue,lcore): rx queues configuration
  --eth-link-speed: force link speed
  --cpu-resume-latency LATENCY: set CPU resume latency to control C-state
selection, 0 : just allow to enter C0-state
  --high-perf-cores CORELIST: list of high performance cores
  --perf-config: similar as config, cores specified as indices for bins
containing high or regular performance cores
  --no-numa: optional, disable numa awareness
  --max-pkt-len PKTLEN: maximum packet length in decimal (64-9600)
  --parse-ptype: parse packet type by software
  --legacy: use legacy interrupt-based scaling
 --telemetry: enable telemetry mode, to update empty polls, full polls, and
core busyness to telemetry
 --interrupt-only: enable interrupt-only mode
 --pmd-mgmt MODE: enable PMD power management mode. Currently supported mod=
es:
baseline, monitor, pause, scale
  --max-empty-polls MAX_EMPTY_POLLS: number of empty polls to wait before
entering sleep state
  --pause-duration DURATION: set the duration, in microseconds, of the pause
callback
  --scale-freq-min FREQ_MIN: set minimum frequency for scaling mode for all
application lcores (FREQ_MIN must be in kHz, in increments of 100MHz)
  --scale-freq-max FREQ_MAX: set maximum frequency for scaling mode for all
application lcores (FREQ_MAX must be in kHz, in increments of 100MHz)
EAL: Error - exiting with code: 1
Invalid L3FWD parameters


Expected Result:
Startup successful=20

Regression
Is this issue a regression: (Y/N)Y

--=20
You are receiving this mail because:
You are the assignee for the bug.=
