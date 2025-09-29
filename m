Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AB3CAC5B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 07:46:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECF564028C;
	Mon, 29 Sep 2025 09:46:36 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id C676D4026D
 for <dev@dpdk.org>; Mon, 29 Sep 2025 09:46:35 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id AB9C348860; Mon, 29 Sep 2025 09:46:35 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/other Bug 1796] Segfault in mlx5 cleanup
Date: Mon, 29 Sep 2025 07:46:35 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: other
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: david.marchand@redhat.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1796-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1796

            Bug ID: 1796
           Summary: Segfault in mlx5 cleanup
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: other
          Assignee: dev@dpdk.org
          Reporter: david.marchand@redhat.com
  Target Milestone: ---

This was caught by GHA when running fast-tests.

FWIW, I saw no recent change on the mlx5 driver.
A small update was done in the order of cleanup operations for multi process
support: 4bc53f8f0d64 ("eal: fix MP socket cleanup").


00:46:34 MALLOC_PERTURB_=3D64 DPDK_TEST=3Ddebug_autotest
/home/runner/work/dpdk/dpdk/build/app/dpdk-test --no-huge -m 2048 -d
/home/runner/work/dpdk/dpdk/build/drivers
----------------------------------- output --------------------------------=
---
stdout:
RTE>>debug_autotest
Child process terminated as expected - Test passed!
Child process status: 256
Child process terminated with incorrect status (expected =3D 0)!
Test Failed
RTE>>
stderr:
EAL: Detected CPU lcores: 4
EAL: Detected NUMA nodes: 1
EAL: Detected shared linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'VA'
APP: HPET is not enabled, using TSC as default timer
0: /home/runner/work/dpdk/dpdk/build/app/dpdk-test (backtrace+0x5b)
[55f713d1815b]
1: /home/runner/work/dpdk/dpdk/build/app/../lib/librte_eal.so.26
(rte_dump_stack+0x18d) [7feaba88887d]
2: /home/runner/work/dpdk/dpdk/build/app/dpdk-test (55f713ad9000+0x68df5a)
[55f714166f5a]
3: /home/runner/work/dpdk/dpdk/build/app/dpdk-test (55f713ad9000+0x2c12a1)
[55f713d9a2a1]
4: /home/runner/work/dpdk/dpdk/build/app/../lib/librte_cmdline.so.26
(cmdline_parse+0x3b9) [7feaba9e6c59]
5: /home/runner/work/dpdk/dpdk/build/app/../lib/librte_cmdline.so.26
(7feaba9dd000+0x6bf8) [7feaba9e3bf8]
6: /home/runner/work/dpdk/dpdk/build/app/../lib/librte_cmdline.so.26
(rdline_char_in+0x75d) [7feaba9ec0ed]
7: /home/runner/work/dpdk/dpdk/build/app/../lib/librte_cmdline.so.26
(cmdline_in+0x9f) [7feaba9e3fdf]
8: /home/runner/work/dpdk/dpdk/build/app/dpdk-test (55f713ad9000+0x2c22ab)
[55f713d9b2ab]
9: /lib/x86_64-linux-gnu/libc.so.6 (7feab9000000+0x29d90) [7feab9029d90]
10: /lib/x86_64-linux-gnu/libc.so.6 (__libc_start_main+0x80) [7feab9029e40]
11: /home/runner/work/dpdk/dpdk/build/app/dpdk-test (55f713ad9000+0x203625)
[55f713cdc625]
EAL: PANIC in test_panic():
Test Debug
0: /home/runner/work/dpdk/dpdk/build/app/dpdk-test (backtrace+0x5b)
[55f713d1815b]
1: /home/runner/work/dpdk/dpdk/build/app/../lib/librte_eal.so.26
(rte_dump_stack+0x18d) [7feaba88887d]
2: /home/runner/work/dpdk/dpdk/build/app/../lib/librte_eal.so.26
(__rte_panic+0x144) [7feaba822a44]
3: /home/runner/work/dpdk/dpdk/build/app/dpdk-test (55f713ad9000+0x68e3aa)
[55f7141673aa]
4: /home/runner/work/dpdk/dpdk/build/app/dpdk-test (55f713ad9000+0x2c12a1)
[55f713d9a2a1]
5: /home/runner/work/dpdk/dpdk/build/app/../lib/librte_cmdline.so.26
(cmdline_parse+0x3b9) [7feaba9e6c59]
6: /home/runner/work/dpdk/dpdk/build/app/../lib/librte_cmdline.so.26
(7feaba9dd000+0x6bf8) [7feaba9e3bf8]
7: /home/runner/work/dpdk/dpdk/build/app/../lib/librte_cmdline.so.26
(rdline_char_in+0x75d) [7feaba9ec0ed]
8: /home/runner/work/dpdk/dpdk/build/app/../lib/librte_cmdline.so.26
(cmdline_in+0x9f) [7feaba9e3fdf]
9: /home/runner/work/dpdk/dpdk/build/app/dpdk-test (55f713ad9000+0x2c22ab)
[55f713d9b2ab]
10: /lib/x86_64-linux-gnu/libc.so.6 (7feab9000000+0x29d90) [7feab9029d90]
11: /lib/x86_64-linux-gnu/libc.so.6 (__libc_start_main+0x80) [7feab9029e40]
12: /home/runner/work/dpdk/dpdk/build/app/dpdk-test (55f713ad9000+0x203625)
[55f713cdc625]
test_exit_valAddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D49020=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x7feaa95=
42e00 (pc
0x7feab4f8583e bp 0x7ffc251774c0 sp 0x7ffc251774b0 T0)
=3D=3D49020=3D=3DThe signal is caused by a READ memory access.
    #0 0x7feab4f8583e in mlx5_devx_cmd_destroy
/home/runner/work/dpdk/dpdk/build/../drivers/common/mlx5/mlx5_devx_cmds.c:4=
85:42
    #1 0x7feaaf286a01 in mlx5_devx_tir_destroy
/home/runner/work/dpdk/dpdk/build/../drivers/net/mlx5/mlx5_devx.c:1025:2
    #2 0x7feaaf286a01 in mlx5_devx_drop_action_destroy
/home/runner/work/dpdk/dpdk/build/../drivers/net/mlx5/mlx5_devx.c:1216:3
    #3 0x7feaaf452c5f in mlx5_drop_action_destroy
/home/runner/work/dpdk/dpdk/build/../drivers/net/mlx5/mlx5_rxq.c:3229:2
    #4 0x7feaaf277356 in mlx5_dev_close
/home/runner/work/dpdk/dpdk/build/../drivers/net/mlx5/mlx5.c:2436:3
    #5 0x7feaba46f001 in rte_eth_dev_close
/home/runner/work/dpdk/dpdk/build/../lib/ethdev/rte_ethdev.c:2024:13
    #6 0x7feaaf27c774 in mlx5_net_remove
/home/runner/work/dpdk/dpdk/build/../drivers/net/mlx5/mlx5.c:3742:11
    #7 0x7feab4fa47ac in drivers_remove
/home/runner/work/dpdk/dpdk/build/../drivers/common/mlx5/mlx5_common.c:938:=
16
    #8 0x7feab4fa47ac in mlx5_common_dev_remove
/home/runner/work/dpdk/dpdk/build/../drivers/common/mlx5/mlx5_common.c:1100=
:8
    #9 0x7feaba3e4359 in pci_cleanup
/home/runner/work/dpdk/dpdk/build/../drivers/bus/pci/pci_common.c:439:9
    #10 0x7feaba824070 in eal_bus_cleanup
/home/runner/work/dpdk/dpdk/build/../lib/eal/common/eal_common_bus.c:110:7
    #11 0x7feaba890291 in rte_eal_cleanup
/home/runner/work/dpdk/dpdk/build/../lib/eal/linux/eal.c:1336:2
    #12 0x7feaba82535f in rte_exit
/home/runner/work/dpdk/dpdk/build/../lib/eal/common/eal_common_debug.c:48:6
    #13 0x55f7141673f4 in test_exit_val
/home/runner/work/dpdk/dpdk/build/../app/test/test_debug.c:80:3
    #14 0x55f7141673f4 in test_exit
/home/runner/work/dpdk/dpdk/build/../app/test/test_debug.c:101:7
    #15 0x55f7141673f4 in test_debug
/home/runner/work/dpdk/dpdk/build/../app/test/test_debug.c:134:6
    #16 0x55f713d9a2a0 in cmd_autotest_parsed
/home/runner/work/dpdk/dpdk/build/../app/test/commands.c:68:10
    #17 0x7feaba9e6c58 in __cmdline_parse
/home/runner/work/dpdk/dpdk/build/../lib/cmdline/cmdline_parse.c:296:3
    #18 0x7feaba9e6c58 in cmdline_parse
/home/runner/work/dpdk/dpdk/build/../lib/cmdline/cmdline_parse.c:305:9
    #19 0x7feaba9e3bf7 in cmdline_valid_buffer
/home/runner/work/dpdk/dpdk/build/../lib/cmdline/cmdline.c:25:8
    #20 0x7feaba9ec0ec in rdline_char_in
/home/runner/work/dpdk/dpdk/build/../lib/cmdline/cmdline_rdline.c:456:5
    #21 0x7feaba9e3fde in cmdline_in
/home/runner/work/dpdk/dpdk/build/../lib/cmdline/cmdline.c:154:9
    #22 0x55f713d9b2aa in main
/home/runner/work/dpdk/dpdk/build/../app/test/test.c:231:15
    #23 0x7feab9029d8f in __libc_start_call_main
csu/../sysdeps/nptl/libc_start_call_main.h:58:16
    #24 0x7feab9029e3f in __libc_start_main csu/../csu/libc-start.c:392:3
    #25 0x55f713cdc624 in _start
(/home/runner/work/dpdk/dpdk/build/app/dpdk-test+0x203624) (BuildId:
df2a2ee4fcca99362e31a795e220e8c82025f46b)

AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV
/home/runner/work/dpdk/dpdk/build/../drivers/common/mlx5/mlx5_devx_cmds.c:4=
85:42
in mlx5_devx_cmd_destroy
=3D=3D49020=3D=3DABORTING
---------------------------------------------------------------------------=
---

--=20
You are receiving this mail because:
You are the assignee for the bug.=
