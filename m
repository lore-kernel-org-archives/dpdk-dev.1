Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9947CC5CFEB
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 23:21:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B44F4025A;
	Sat, 21 Feb 2026 00:21:24 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 49C2D40150
 for <dev@dpdk.org>; Sat, 21 Feb 2026 00:21:23 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 3B2F54A683; Sat, 21 Feb 2026 00:21:23 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1892] hash_crc: unaligned access
Date: Fri, 20 Feb 2026 23:21:23 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 25.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: stephen@networkplumber.org
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1892-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1892

            Bug ID: 1892
           Summary: hash_crc: unaligned access
           Product: DPDK
           Version: 25.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

Building DPDK with clang and -Db_sanitize=3Dundef finds the following.

# DPDK_TEST=3Dipsec_sad_autotest
MSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:print=
_stacktrace=3D1
UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:prin=
t_stacktrace=3D1
MESON_TEST_ITERATION=3D1
ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1
LD_LIBRARY_PATH=3D/home/shemminger/DPDK/pcapng/build/lib:/home/shemminger/D=
PDK/pcapng/build/drivers
MALLOC_PERTURB_=3D111 /home/shemminger/DPDK/pcapng/build/app/dpdk-test --no=
-huge
-m 2048 -d /home/shemminger/DPDK/pcapng/build/drivers
EAL: Detected CPU lcores: 32
EAL: Detected NUMA nodes: 1
EAL: Detected shared linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'VA'
APP: HPET is not enabled, using TSC as default timer
RTE>>ipsec_sad_autotest
 + ------------------------------------------------------- +
 + Test Suite : ipsec sad autotest
 + ------------------------------------------------------- +
RING: Cannot reserve memory
HASH: ring creation failed: Invalid argument
 + TestCase [ 0] : test_create_invalid succeeded
 + TestCase [ 1] : test_find_existing succeeded
 + TestCase [ 2] : test_multiple_create succeeded
 + TestCase [ 3] : test_add_invalid succeeded
 + TestCase [ 4] : test_delete_invalid succeeded
 + TestCase [ 5] : test_lookup_invalid succeeded
 + TestCase [ 6] : test_lookup_basic succeeded
../lib/hash/rte_hash_crc.h:131:33: runtime error: load of misaligned address
0x7ffdd714e69c for type 'const uint64_t' (aka 'const unsigned long'), which
requires 8 byte alignment
0x7ffdd714e69c: note: pointer points here
  ad 0b 00 00 ad de 00 00  ef be 00 00 0d f0 00 00  00 00 00 00 00 00 00 00=
  20
ed 14 d7 fd 7f 00 00
              ^=20
    #0 0x7f37159163df in rte_hash_crc ipsec_sad.c
    #1 0x7f37159167ef in add_specific ipsec_sad.c
    #2 0x7f3715916331 in rte_ipsec_sad_add
(/home/shemminger/DPDK/pcapng/build/lib/librte_ipsec.so.26+0x139331) (Build=
Id:
d4b6d8e8c10878518e32725e7b66311bc8f96b4c)
    #3 0x555f23d4d740 in __test_lookup_adv test_ipsec_sad.c
    #4 0x555f23d4b750 in test_lookup_adv test_ipsec_sad.c
    #5 0x555f2281a852 in unit_test_suite_runner
(/home/shemminger/DPDK/pcapng/build/app/dpdk-test+0x4d6852) (BuildId:
e18ec1531409b30bbe3715a1a31504a2799f386b)
    #6 0x555f23d4a637 in test_ipsec_sad test_ipsec_sad.c
    #7 0x555f22817a88 in cmd_autotest_parsed commands.c
    #8 0x7f3717116b62 in __cmdline_parse cmdline_parse.c
    #9 0x7f3717116279 in cmdline_parse
(/home/shemminger/DPDK/pcapng/build/lib/librte_cmdline.so.26+0x1c279) (Buil=
dId:
580131adb0230d128a91d9676217d98c1d9bf7a5)
    #10 0x7f371710db59 in cmdline_valid_buffer cmdline.c
    #11 0x7f371712298d in rdline_char_in
(/home/shemminger/DPDK/pcapng/build/lib/librte_cmdline.so.26+0x2898d) (Buil=
dId:
580131adb0230d128a91d9676217d98c1d9bf7a5)
    #12 0x7f371710e269 in cmdline_in
(/home/shemminger/DPDK/pcapng/build/lib/librte_cmdline.so.26+0x14269) (Buil=
dId:
580131adb0230d128a91d9676217d98c1d9bf7a5)
    #13 0x555f22819a71 in main
(/home/shemminger/DPDK/pcapng/build/app/dpdk-test+0x4d5a71) (BuildId:
e18ec1531409b30bbe3715a1a31504a2799f386b)
    #14 0x7f3714d94f74 in __libc_start_call_main
csu/../sysdeps/nptl/libc_start_call_main.h:58:16
    #15 0x7f3714d95026 in __libc_start_main csu/../csu/libc-start.c:360:3
    #16 0x555f227e9f70 in _start
(/home/shemminger/DPDK/pcapng/build/app/dpdk-test+0x4a5f70) (BuildId:
e18ec1531409b30bbe3715a1a31504a2799f386b)

SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
../lib/hash/rte_hash_crc.h:131:33=20
Aborted                    DPDK_TEST=3Dipsec_sad_autotest
MSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:print=
_stacktrace=3D1
UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:prin=
t_stacktrace=3D1
MESON_TEST_ITERATION=3D1
ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1
LD_LIBRARY_PATH=3D/home/shemminger/DPDK/pcapng/build/lib:/h

--=20
You are receiving this mail because:
You are the assignee for the bug.=
