Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22E8C54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 09:06:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2BB10402D6;
	Tue, 27 May 2025 11:06:27 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id AFD8C402B9
 for <dev@dpdk.org>; Tue, 27 May 2025 11:06:25 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 86EBE46803; Tue, 27 May 2025 11:06:25 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/examples Bug 1712] secondary symmetric_mp startup failure with
 ASan (stack-buffer-overflow)
Date: Tue, 27 May 2025 09:06:25 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: examples
X-Bugzilla-Version: 25.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ahmedi@nvidia.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1712-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17483367850.9D16A9.2196726
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


--17483367850.9D16A9.2196726
Date: Tue, 27 May 2025 11:06:25 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1712

            Bug ID: 1712
           Summary: secondary symmetric_mp startup failure with ASan
                    (stack-buffer-overflow)
           Product: DPDK
           Version: 25.03
          Hardware: ARM
                OS: Linux
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: examples
          Assignee: dev@dpdk.org
          Reporter: ahmedi@nvidia.com
  Target Milestone: ---

./build/examples/dpdk-symmetric_mp -n 4  -a 0000:03:00.0  -a 0000:03:00.1 -=
l 1
--proc-type=3Dprimary  -- -p 0xa --num-procs=3D7 --proc-id=3D0=20
./build/examples/dpdk-symmetric_mp -n 4  -a 0000:03:00.0 -a 0000:03:00.1 -l=
 2
--proc-type=3Dsecondary  -- -p 0xa --num-procs=3D7 --proc-id=3D1


Attempt 1: Process exited with status None, output: EAL: Detected CPU lcore=
s: 8
EAL: Detected NUMA nodes: 1
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket_486544_7286ede6c03
EAL: Selected IOVA mode 'VA'
EAL: Cannot get a virtual area at requested address: 0xfffb85e00000 (got
0xfffb790e0000)
EAL: Cannot reserve 17179869184 bytes at [0xfffb85e00000] - please use
'--base-virtaddr' option
EAL: Cannot preallocate VA space for hugepage memory
EAL: FATAL: Cannot init memory
EAL: Cannot init memory
EAL: Error - exiting with code: 1
  Cause: Cannot init EAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D486544=3D=3DERROR: AddressSanitizer: stack-buffer-overflow on address
0xffff798ed4ac at pc 0xffff83ef2254 bp 0xffff798ecc00 sp 0xffff798ecc48
WRITE of size 24 at 0xffff798ed4ac thread T16777215
    #0 0xffff83ef2250 in __interceptor_sigaltstack
../../../../src/libsanitizer/sanitizer_common/sanitizer_common_interceptors=
.inc:9986
    #1 0xffff83f68674 in __sanitizer::UnsetAlternateSignalStack()
../../../../src/libsanitizer/sanitizer_common/sanitizer_posix_libcdep.cpp:1=
95
    #2 0xffff83f58f94 in __asan::AsanThread::Destroy()
../../../../src/libsanitizer/asan/asan_thread.cpp:104
    #3 0xffff836fa3c0 in __GI___nptl_deallocate_tsd
nptl/nptl_deallocate_tsd.c:73
    #4 0xffff836fd480 in start_thread nptl/pthread_create.c:453
    #5 0xffff83765ed8  (/lib/aarch64-linux-gnu/libc.so.6+0xe5ed8)

Address 0xffff798ed4ac is located in stack of thread T3 at offset 1100 in f=
rame
    #0 0xaaaac8ce476c in mp_handle ([..]/examples/dpdk-symmetric_mp+0x70476=
c)

  This frame has 6 object(s):
    [32, 48) 'iov'
    [64, 120) 'msgh'
    [160, 270) 'sa' (line 392)
    [304, 664) 'dummy' (line 374)
    [736, 1100) 'msg' (line 391) <=3D=3D Memory access at offset 1100 overf=
lows
this variable
    [1168, 1216) 'control'
HINT: this may be a false positive if your program uses some custom stack
unwind mechanism, swapcontext or vfork
      (longjmp and C++ exceptions *are* supported)
Thread T3 created by T0 here:
    #0 0xffff83ef6188 in __interceptor_pthread_create
../../../../src/libsanitizer/asan/asan_interceptors.cpp:216
    #1 0xaaaac8cc86a0 in rte_ctrl_thread_create
([..]/examples/dpdk-symmetric_mp+0x6e86a0)
    #2 0xaaaac8ce685c in rte_mp_channel_init
([..]/examples/dpdk-symmetric_mp+0x70685c)
    #3 0xaaaac8cfc688 in rte_eal_init
([..]/examples/dpdk-symmetric_mp+0x71c688)
    #4 0xaaaac87a898c in main ([..]/examples/dpdk-symmetric_mp+0x1c898c)
    #5 0xffff836a73f8 in __libc_start_call_main
../sysdeps/nptl/libc_start_call_main.h:58
    #6 0xffff836a74c8 in __libc_start_main_impl ../csu/libc-start.c:392
    #7 0xaaaac87b406c in _start ([..]/examples/dpdk-symmetric_mp+0x1d406c)

SUMMARY: AddressSanitizer: stack-buffer-overflow
../../../../src/libsanitizer/sanitizer_common/sanitizer_common_interceptors=
.inc:9986
in __interceptor_sigaltstack
Shadow bytes around the buggy address:
  0x200fef31da40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x200fef31da50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f2
  0x200fef31da60: f2 f2 f2 f2 f2 f2 f2 f2 00 00 00 00 00 00 00 00
  0x200fef31da70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x200fef31da80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=3D>0x200fef31da90: 00 00 00 00 00[04]f2 f2 f2 f2 f2 f2 f2 f2 00 00
  0x200fef31daa0: 00 00 00 00 f3 f3 f3 f3 00 00 00 00 00 00 00 00
  0x200fef31dab0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x200fef31dac0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x200fef31dad0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x200fef31dae0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07=20
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
  Shadow gap:              cc
=3D=3D486544=3D=3DABORTING


Environment info:
OS: Ubuntu 22.04 (aarch64)
Kernel: Kernel: 5.15.0-1065-bluefield
Device: Bluefield-2
gcc: 11.2.0

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17483367850.9D16A9.2196726
Date: Tue, 27 May 2025 11:06:25 +0200
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
   title=3D"UNCONFIRMED - secondary symmetric_mp startup failure with ASan =
(stack-buffer-overflow)"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1712">1712</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>secondary symmetric_mp startup failure with ASan (stack-buffe=
r-overflow)
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
          <td>ARM
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
          <td>ahmedi&#64;nvidia.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">./build/examples/dpdk-symmetric_mp=
 -n 4  -a 0000:03:00.0  -a 0000:03:00.1 -l 1
--proc-type=3Dprimary  -- -p 0xa --num-procs=3D7 --proc-id=3D0=20
./build/examples/dpdk-symmetric_mp -n 4  -a 0000:03:00.0 -a 0000:03:00.1 -l=
 2
--proc-type=3Dsecondary  -- -p 0xa --num-procs=3D7 --proc-id=3D1


Attempt 1: Process exited with status None, output: EAL: Detected CPU lcore=
s: 8
EAL: Detected NUMA nodes: 1
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket_486544_7286ede6c03
EAL: Selected IOVA mode 'VA'
EAL: Cannot get a virtual area at requested address: 0xfffb85e00000 (got
0xfffb790e0000)
EAL: Cannot reserve 17179869184 bytes at [0xfffb85e00000] - please use
'--base-virtaddr' option
EAL: Cannot preallocate VA space for hugepage memory
EAL: FATAL: Cannot init memory
EAL: Cannot init memory
EAL: Error - exiting with code: 1
  Cause: Cannot init EAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D486544=3D=3DERROR: AddressSanitizer: stack-buffer-overflow on address
0xffff798ed4ac at pc 0xffff83ef2254 bp 0xffff798ecc00 sp 0xffff798ecc48
WRITE of size 24 at 0xffff798ed4ac thread T16777215
    #0 0xffff83ef2250 in __interceptor_sigaltstack
../../../../src/libsanitizer/sanitizer_common/sanitizer_common_interceptors=
.inc:9986
    #1 0xffff83f68674 in __sanitizer::UnsetAlternateSignalStack()
../../../../src/libsanitizer/sanitizer_common/sanitizer_posix_libcdep.cpp:1=
95
    #2 0xffff83f58f94 in __asan::AsanThread::Destroy()
../../../../src/libsanitizer/asan/asan_thread.cpp:104
    #3 0xffff836fa3c0 in __GI___nptl_deallocate_tsd
nptl/nptl_deallocate_tsd.c:73
    #4 0xffff836fd480 in start_thread nptl/pthread_create.c:453
    #5 0xffff83765ed8  (/lib/aarch64-linux-gnu/libc.so.6+0xe5ed8)

Address 0xffff798ed4ac is located in stack of thread T3 at offset 1100 in f=
rame
    #0 0xaaaac8ce476c in mp_handle ([..]/examples/dpdk-symmetric_mp+0x70476=
c)

  This frame has 6 object(s):
    [32, 48) 'iov'
    [64, 120) 'msgh'
    [160, 270) 'sa' (line 392)
    [304, 664) 'dummy' (line 374)
    [736, 1100) 'msg' (line 391) &lt;=3D=3D Memory access at offset 1100 ov=
erflows
this variable
    [1168, 1216) 'control'
HINT: this may be a false positive if your program uses some custom stack
unwind mechanism, swapcontext or vfork
      (longjmp and C++ exceptions *are* supported)
Thread T3 created by T0 here:
    #0 0xffff83ef6188 in __interceptor_pthread_create
../../../../src/libsanitizer/asan/asan_interceptors.cpp:216
    #1 0xaaaac8cc86a0 in rte_ctrl_thread_create
([..]/examples/dpdk-symmetric_mp+0x6e86a0)
    #2 0xaaaac8ce685c in rte_mp_channel_init
([..]/examples/dpdk-symmetric_mp+0x70685c)
    #3 0xaaaac8cfc688 in rte_eal_init
([..]/examples/dpdk-symmetric_mp+0x71c688)
    #4 0xaaaac87a898c in main ([..]/examples/dpdk-symmetric_mp+0x1c898c)
    #5 0xffff836a73f8 in __libc_start_call_main
../sysdeps/nptl/libc_start_call_main.h:58
    #6 0xffff836a74c8 in __libc_start_main_impl ../csu/libc-start.c:392
    #7 0xaaaac87b406c in _start ([..]/examples/dpdk-symmetric_mp+0x1d406c)

SUMMARY: AddressSanitizer: stack-buffer-overflow
../../../../src/libsanitizer/sanitizer_common/sanitizer_common_interceptors=
.inc:9986
in __interceptor_sigaltstack
Shadow bytes around the buggy address:
  0x200fef31da40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x200fef31da50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f2
  0x200fef31da60: f2 f2 f2 f2 f2 f2 f2 f2 00 00 00 00 00 00 00 00
  0x200fef31da70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x200fef31da80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=3D&gt;0x200fef31da90: 00 00 00 00 00[04]f2 f2 f2 f2 f2 f2 f2 f2 00 00
  0x200fef31daa0: 00 00 00 00 f3 f3 f3 f3 00 00 00 00 00 00 00 00
  0x200fef31dab0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x200fef31dac0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x200fef31dad0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x200fef31dae0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07=20
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
  Shadow gap:              cc
=3D=3D486544=3D=3DABORTING


Environment info:
OS: Ubuntu 22.04 (aarch64)
Kernel: Kernel: 5.15.0-1065-bluefield
Device: Bluefield-2
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
?id=3D1712">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17483367850.9D16A9.2196726--
