Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30BBC54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 16:03:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB3B7402B3;
	Tue, 27 May 2025 18:03:11 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id DDF00402A0
 for <dev@dpdk.org>; Tue, 27 May 2025 18:03:10 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id C15D746806; Tue, 27 May 2025 18:03:10 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/examples Bug 1714] symmetric_mp termination failure with ASan
 (detected memory leaks)
Date: Tue, 27 May 2025 16:03:10 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: examples
X-Bugzilla-Version: 25.03
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
 target_milestone attachments.created
Message-ID: <bug-1714-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17483617900.44106c2cD.2406109
Content-Transfer-Encoding: 7bit
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


--17483617900.44106c2cD.2406109
Date: Tue, 27 May 2025 18:03:10 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1714

            Bug ID: 1714
           Summary: symmetric_mp termination failure with ASan (detected
                    memory leaks)
           Product: DPDK
           Version: 25.03
          Hardware: x86
                OS: Linux
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: examples
          Assignee: dev@dpdk.org
          Reporter: sbadawi@nvidia.com
  Target Milestone: ---

Created attachment 318
  --> https://bugs.dpdk.org/attachment.cgi?id=3D318&action=3Dedit
leakSanitizer_trace

$ ./build/examples/dpdk-symmetric_mp -n 4 -a 0000:08:00.0 -a 0000:08:00.1 -=
l 1
--proc-type=3Dprimary -- -p 0x3 --num-procs=3D8 --proc-id=3D0

EAL: Detected CPU lcores: 10
EAL: Detected NUMA nodes: 1
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'PA'
EAL: VFIO support initialized
# Initialising port 0... # Initialising port 1...=20

Checking link statusdone
Port 0 Link up at 100 Gbps FDX Autoneg
Port 1 Link up at 100 Gbps FDX Autoneg
APP: Finished Process Init.
Lcore 1 using ports 0 1
lcore 1 using queue 0 of each port
^C
Exiting on signal 2

Port 0: RX - 0, TX - 0, Drop - 0
Port 1: RX - 0, TX - 0, Drop - 0

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D1279169=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 11424 byte(s) in 14 object(s) allocated from:
    #0 0x7f4e90f67a37 in __interceptor_calloc
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:154
    #1 0x557c8add30a0 in mlx5_malloc
(./build/examples/dpdk-symmetric_mp+0xd140a0)
    #2 0x557c8b695525 in mlx5dr_action_template_create
(./build/examples/dpdk-symmetric_mp+0x15d6525)
    #3 0x557c8b58e03a in __flow_hw_actions_template_create
(./build/examples/dpdk-symmetric_mp+0x14cf03a)
    #4 0x557c8b58f6ec in flow_hw_create_ctrl_rx_rss_template
(./build/examples/dpdk-symmetric_mp+0x14d06ec)
    #5 0x557c8b5e3529 in mlx5_flow_hw_ctrl_flows
(./build/examples/dpdk-symmetric_mp+0x1524529)
    #6 0x557c8afcbde1 in mlx5_traffic_enable
(./build/examples/dpdk-symmetric_mp+0xf0cde1)
    #7 0x557c8a33e163 in mlx5_dev_start.cold
(./build/examples/dpdk-symmetric_mp+0x27f163)
    #8 0x557c8abb48e4 in rte_eth_dev_start
(./build/examples/dpdk-symmetric_mp+0xaf58e4)
    #9 0x557c8a3e0aa4 in smp_port_init
(./build/examples/dpdk-symmetric_mp+0x321aa4)
    #10 0x557c8a3cb24f in main (./build/examples/dpdk-symmetric_mp+0x30c24f)
    #11 0x7f4e90639d8f in __libc_start_call_main
../sysdeps/nptl/libc_start_call_main.h:58

Direct leak of 8960 byte(s) in 140 object(s) allocated from:
    #0 0x7f4e90f67a37 in __interceptor_calloc
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:154
    #1 0x557c8add30a0 in mlx5_malloc
(./build/examples/dpdk-symmetric_mp+0xd140a0)
    #2 0x557c8b6686c0 in mlx5dr_match_template_create
(./build/examples/dpdk-symmetric_mp+0x15a96c0)
    #3 0x557c8b5938de in flow_hw_pattern_template_create
(./build/examples/dpdk-symmetric_mp+0x14d48de)
    #4 0x557c8b59c156 in __flow_hw_configure
(./build/examples/dpdk-symmetric_mp+0x14dd156)
    #5 0x557c8b5a4f0f in flow_hw_init
(./build/examples/dpdk-symmetric_mp+0x14e5f0f)
    #6 0x557c8a33b2ed in mlx5_dev_start.cold
(./build/examples/dpdk-symmetric_mp+0x27c2ed)
    #7 0x557c8abb48e4 in rte_eth_dev_start
(./build/examples/dpdk-symmetric_mp+0xaf58e4)
    #8 0x557c8a3e0aa4 in smp_port_init
(./build/examples/dpdk-symmetric_mp+0x321aa4)
    #9 0x557c8a3cb24f in main (./build/examples/dpdk-symmetric_mp+0x30c24f)
    #10 0x7f4e90639d8f in __libc_start_call_main
../sysdeps/nptl/libc_start_call_main.h:58
[..]

Environment info:
OS: Ubuntu22.04 (x86_64)
Kernel: 5.15.0-25-generic
Device: ConnectX-6 DX
gcc: 11.2.0

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17483617900.44106c2cD.2406109
Date: Tue, 27 May 2025 18:03:10 +0200
MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

<html>
    <head>
      <base href=3D"https://bugs.dpdk.org/">
    </head>
    <body><table border=3D"1" cellspacing=3D"0" cellpadding=3D"8" class=3D"=
bz_new_table">
        <tr>
          <th>Bug ID</th>
          <td><a class=3D"bz_bug_link=20
          bz_status_UNCONFIRMED "
   title=3D"UNCONFIRMED - symmetric_mp termination failure with ASan (detec=
ted memory leaks)"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1714">1714</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>symmetric_mp termination failure with ASan (detected memory l=
eaks)
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>25.03
          </td>
        </tr>

        <tr>
          <th>Hardware</th>
          <td>x86
          </td>
        </tr>

        <tr>
          <th>OS</th>
          <td>Linux
          </td>
        </tr>

        <tr>
          <th>Status</th>
          <td>UNCONFIRMED
          </td>
        </tr>

        <tr>
          <th>Severity</th>
          <td>normal
          </td>
        </tr>

        <tr>
          <th>Priority</th>
          <td>Normal
          </td>
        </tr>

        <tr>
          <th>Component</th>
          <td>examples
          </td>
        </tr>

        <tr>
          <th>Assignee</th>
          <td>dev&#64;dpdk.org
          </td>
        </tr>

        <tr>
          <th>Reporter</th>
          <td>sbadawi&#64;nvidia.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">Created <span class=3D""><a href=
=3D"attachment.cgi?id=3D318" name=3D"attach_318" title=3D"leakSanitizer_tra=
ce">attachment 318</a> <a href=3D"attachment.cgi?id=3D318&amp;action=3Dedit=
" title=3D"leakSanitizer_trace">[details]</a></span>
leakSanitizer_trace

$ ./build/examples/dpdk-symmetric_mp -n 4 -a 0000:08:00.0 -a 0000:08:00.1 -=
l 1
--proc-type=3Dprimary -- -p 0x3 --num-procs=3D8 --proc-id=3D0

EAL: Detected CPU lcores: 10
EAL: Detected NUMA nodes: 1
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'PA'
EAL: VFIO support initialized
# Initialising port 0... # Initialising port 1...=20

Checking link statusdone
Port 0 Link up at 100 Gbps FDX Autoneg
Port 1 Link up at 100 Gbps FDX Autoneg
APP: Finished Process Init.
Lcore 1 using ports 0 1
lcore 1 using queue 0 of each port
^C
Exiting on signal 2

Port 0: RX - 0, TX - 0, Drop - 0
Port 1: RX - 0, TX - 0, Drop - 0

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D1279169=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 11424 byte(s) in 14 object(s) allocated from:
    #0 0x7f4e90f67a37 in __interceptor_calloc
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:154
    #1 0x557c8add30a0 in mlx5_malloc
(./build/examples/dpdk-symmetric_mp+0xd140a0)
    #2 0x557c8b695525 in mlx5dr_action_template_create
(./build/examples/dpdk-symmetric_mp+0x15d6525)
    #3 0x557c8b58e03a in __flow_hw_actions_template_create
(./build/examples/dpdk-symmetric_mp+0x14cf03a)
    #4 0x557c8b58f6ec in flow_hw_create_ctrl_rx_rss_template
(./build/examples/dpdk-symmetric_mp+0x14d06ec)
    #5 0x557c8b5e3529 in mlx5_flow_hw_ctrl_flows
(./build/examples/dpdk-symmetric_mp+0x1524529)
    #6 0x557c8afcbde1 in mlx5_traffic_enable
(./build/examples/dpdk-symmetric_mp+0xf0cde1)
    #7 0x557c8a33e163 in mlx5_dev_start.cold
(./build/examples/dpdk-symmetric_mp+0x27f163)
    #8 0x557c8abb48e4 in rte_eth_dev_start
(./build/examples/dpdk-symmetric_mp+0xaf58e4)
    #9 0x557c8a3e0aa4 in smp_port_init
(./build/examples/dpdk-symmetric_mp+0x321aa4)
    #10 0x557c8a3cb24f in main (./build/examples/dpdk-symmetric_mp+0x30c24f)
    #11 0x7f4e90639d8f in __libc_start_call_main
../sysdeps/nptl/libc_start_call_main.h:58

Direct leak of 8960 byte(s) in 140 object(s) allocated from:
    #0 0x7f4e90f67a37 in __interceptor_calloc
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:154
    #1 0x557c8add30a0 in mlx5_malloc
(./build/examples/dpdk-symmetric_mp+0xd140a0)
    #2 0x557c8b6686c0 in mlx5dr_match_template_create
(./build/examples/dpdk-symmetric_mp+0x15a96c0)
    #3 0x557c8b5938de in flow_hw_pattern_template_create
(./build/examples/dpdk-symmetric_mp+0x14d48de)
    #4 0x557c8b59c156 in __flow_hw_configure
(./build/examples/dpdk-symmetric_mp+0x14dd156)
    #5 0x557c8b5a4f0f in flow_hw_init
(./build/examples/dpdk-symmetric_mp+0x14e5f0f)
    #6 0x557c8a33b2ed in mlx5_dev_start.cold
(./build/examples/dpdk-symmetric_mp+0x27c2ed)
    #7 0x557c8abb48e4 in rte_eth_dev_start
(./build/examples/dpdk-symmetric_mp+0xaf58e4)
    #8 0x557c8a3e0aa4 in smp_port_init
(./build/examples/dpdk-symmetric_mp+0x321aa4)
    #9 0x557c8a3cb24f in main (./build/examples/dpdk-symmetric_mp+0x30c24f)
    #10 0x7f4e90639d8f in __libc_start_call_main
../sysdeps/nptl/libc_start_call_main.h:58
[..]

Environment info:
OS: Ubuntu22.04 (x86_64)
Kernel: 5.15.0-25-generic
Device: ConnectX-6 DX
gcc: 11.2.0
          </pre>
        </div>
      </p>


      <hr>
      <span>You are receiving this mail because:</span>

      <ul>
          <li>You are the assignee for the bug.</li>
      </ul>
      <div itemscope itemtype=3D"http://schema.org/EmailMessage">
        <div itemprop=3D"action" itemscope itemtype=3D"http://schema.org/Vi=
ewAction">
=20=20=20=20=20=20=20=20=20=20
          <link itemprop=3D"url" href=3D"https://bugs.dpdk.org/show_bug.cgi=
?id=3D1714">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17483617900.44106c2cD.2406109--
