Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FCBD6ACFB
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Dec 2025 13:27:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18EB540275;
	Thu, 18 Dec 2025 14:27:13 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id B697B4026A
 for <dev@dpdk.org>; Thu, 18 Dec 2025 14:27:11 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 88A4C4707C; Thu, 18 Dec 2025 14:27:11 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/testpmd Bug 1852] [asan] detected memory leaks on quit
Date: Thu, 18 Dec 2025 13:27:11 +0000
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
Message-ID: <bug-1852-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1852

            Bug ID: 1852
           Summary: [asan] detected memory leaks on quit
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

install/bin/dpdk-testpmd -n 4  -a 0000:08:00.0,dv_flow_en=3D2  -a
0000:08:00.1,dv_flow_en=3D2 --iova-mode=3D"va" -- --mbcache=3D512 -i  --nb-=
cores=3D7=20
--

repro cmds:
testpmd>stop
testpmd>port stop all
testpmd>flow configure 0 queues_number 16 queues_size 256 aging_counters_nu=
mber
0
testpmd>flow configure 1 queues_number 16 queues_size 256 aging_counters_nu=
mber
0
testpmd>port start all
testpmd>start
testpmd>flow pattern_template 0 create ingress pattern_template_id 4 relaxe=
d no
template eth / ipv6 proto mask 0xff / end
testpmd>flow actions_template 0 create ingress actions_template_id 4 templa=
te
modify_field op set dst_type ipv6_dst dst_offset 0 src_type mac_dst src_off=
set
31 width 2 / rss / end mask modify_field op set dst_type ipv6_dst dst_level
0xffffffff dst_offset 0xffffffff src_type mac_dst src_offset 0xffffffff
src_level 0xffffffff width 0xffffffff / rss / end
testpmd>flow template_table 0 create table_id 8 group 155 priority 0 ingress
rules_number 64 pattern_template 4 actions_template 4
testpmd>flow template_table 0 destroy table 8
testpmd>flow pattern_template 0 destroy pattern_template 4
testpmd>flow actions_template 0 destroy actions_template 4
testpmd>quit

log on quit:
testpmd> quit
Telling cores to stop...
Waiting for lcores to finish...
  ---------------------- Forward statistics for port 0  -------------------=
---
  RX-packets: 0              RX-dropped: 0             RX-total: 0
  TX-packets: 0              TX-dropped: 0             TX-total: 0
  -------------------------------------------------------------------------=
---
  ---------------------- Forward statistics for port 1  -------------------=
---
  RX-packets: 0              RX-dropped: 0             RX-total: 0
  TX-packets: 0              TX-dropped: 0             TX-total: 0
  -------------------------------------------------------------------------=
---
  +++++++++++++++ Accumulated forward statistics for all ports+++++++++++++=
++
  RX-packets: 0              RX-dropped: 0             RX-total: 0
  TX-packets: 0              TX-dropped: 0             TX-total: 0
  +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++
Done.
Primary: Sending 'stop_req' request to secondary...
Stopping port 0...
Stopping ports...
Done
Stopping port 1...
Stopping ports...
Done
Shutting down port 0...
Closing ports...
Port 0 is closed
Done
Shutting down port 1...
Closing ports...
Port 1 is closed
Done
Bye...
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D394529=3D=3DERROR: LeakSanitizer: detected memory leaks
Direct leak of 16 byte(s) in 1 object(s) allocated from:
    #0 0x7f4845a0b867 in __interceptor_malloc
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:145
    #1 0x564ddf25e3bf in mlx5_malloc (install/bin/dpdk-testpmd+0xa8f3bf)
    #2 0x564ddf81587f in mlx5dr_cmd_header_modify_pattern_create
(install/bin/dpdk-testpmd+0x104687f)
    #3 0x564ddf8378b8 in mlx5dr_pat_arg_create_modify_header
(install/bin/dpdk-testpmd+0x10688b8)
    #4 0x564ddf80a330 in mlx5dr_action_create_modify_header
(install/bin/dpdk-testpmd+0x103b330)
    #5 0x564ddf76c99d in __flow_hw_actions_translate
(install/bin/dpdk-testpmd+0xf9d99d)
    #6 0x564ddf7746f8 in flow_hw_table_create
(install/bin/dpdk-testpmd+0xfa56f8)
    #7 0x564ddf77527b in flow_hw_template_table_create
(install/bin/dpdk-testpmd+0xfa627b)
    #8 0x564ddf2c1ee4 in mlx5_flow_table_create
(install/bin/dpdk-testpmd+0xaf2ee4)
    #9 0x564ddf161206 in rte_flow_template_table_create
(install/bin/dpdk-testpmd+0x992206)
    #10 0x564ddeb5eaf1 in port_flow_template_table_create
(install/bin/dpdk-testpmd+0x38faf1)
    #11 0x564ddeb0a170 in cmd_flow_cb (install/bin/dpdk-testpmd+0x33b170)
    #12 0x564ddf122737 in __cmdline_parse (install/bin/dpdk-testpmd+0x95373=
7)
    #13 0x564ddf11fa73 in cmdline_valid_buffer
(install/bin/dpdk-testpmd+0x950a73)
    #14 0x564ddf128795 in rdline_char_in (install/bin/dpdk-testpmd+0x959795)
    #15 0x564ddf11fb6d in cmdline_in (install/bin/dpdk-testpmd+0x950b6d)
    #16 0x564ddf11ff9f in cmdline_interact (install/bin/dpdk-testpmd+0x950f=
9f)
    #17 0x564ddeb00aee in prompt (install/bin/dpdk-testpmd+0x331aee)
    #18 0x564ddeade217 in main (install/bin/dpdk-testpmd+0x30f217)
    #19 0x7f48450e1d8f in __libc_start_call_main
../sysdeps/nptl/libc_start_call_main.h:58
Indirect leak of 48 byte(s) in 1 object(s) allocated from:
    #0 0x7f4845a0ba37 in __interceptor_calloc
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:154
    #1 0x7f48457adf22  (/lib/x86_64-linux-gnu/libmlx5.so.1+0x67f22)
SUMMARY: AddressSanitizer: 64 byte(s) leaked in 2 allocation(s).



OS: Ubuntu 22.04 (x86_64)
Kernel: 5.15.0-25-generic
OFED: MLNX_OFED_LINUX-5.8-7.0.6.1
DPDK: =C2=A0 04536b2
Device: ConnectX-6 DX
FW: 22.35.4554

--=20
You are receiving this mail because:
You are the assignee for the bug.=
