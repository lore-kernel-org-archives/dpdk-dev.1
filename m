Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C91BC36008
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 16:27:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94CBF40649;
	Wed, 26 Mar 2025 17:27:18 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 2D565402CD
 for <dev@dpdk.org>; Wed, 26 Mar 2025 17:27:17 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 1B25346482; Wed, 26 Mar 2025 17:27:17 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1683] use after on interrupt thread during EAL cleanup
Date: Wed, 26 Mar 2025 16:27:16 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
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
Message-ID: <bug-1683-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17430064360.b6528.2425440
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


--17430064360.b6528.2425440
Date: Wed, 26 Mar 2025 17:27:16 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1683

            Bug ID: 1683
           Summary: use after on interrupt thread during EAL cleanup
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: david.marchand@redhat.com
  Target Milestone: ---

This was caught with ASan in a CI run in my GHA:

+ devtools/test-null.sh
EAL: Detected CPU lcores: 4
EAL: Detected NUMA nodes: 1
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /run/user/1001/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'VA'
testpmd: create a new mbuf pool <mb_pool_0>: n=3D2048, size=3D2176, socket=
=3D0
testpmd: preferred mempool ops selected: ring_mp_mc
Interactive-mode selected
Auto-start selected
Configuring Port 0 (socket 0)
...

Shutting down port 1...
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D46768=3D=3DERROR: AddressSanitizer: heap-use-after-free on address 0x=
606000008e44
at pc 0x5613ec543091 bp 0x7f87065fd1d0 sp 0x7f87065fd1c8
READ of size 4 at 0x606000008e44 thread T1
    #0 0x5613ec543090 in rte_intr_fd_get
/home/runner/work/dpdk/dpdk/build/../lib/eal/common/eal_common_interrupts.c=
:210:22
    #1 0x5613ec5a350b in eal_alarm_callback
/home/runner/work/dpdk/dpdk/build/../lib/eal/linux/eal_alarm.c:125:19
    #2 0x5613ec5acef1 in eal_intr_process_interrupts
/home/runner/work/dpdk/dpdk/build/../lib/eal/linux/eal_interrupts.c:1026:5
    #3 0x5613ec5acef1 in eal_intr_handle_interrupts
/home/runner/work/dpdk/dpdk/build/../lib/eal/linux/eal_interrupts.c:1100:7
    #4 0x5613ec5aba06 in eal_intr_thread_main
/home/runner/work/dpdk/dpdk/build/../lib/eal/linux/eal_interrupts.c:1172:3
    #5 0x7f870b294ac2 in start_thread nptl/./nptl/pthread_create.c:442:8
    #6 0x7f870b32684f  misc/../sysdeps/unix/sysv/linux/x86_64/clone3.S:81

0x606000008e44 is located 4 bytes inside of 64-byte region
[0x606000008e40,0x606000008e80)
freed by thread T0 here:
    #0 0x5613eb24ba32 in free
(/home/runner/work/dpdk/dpdk/build/app/dpdk-testpmd+0xb8ca32) (BuildId:
1c1d93dcb4fec8b525f3ed4b97885f75ba17fcb1)
    #1 0x5613ec5a1b7f in rte_eal_cleanup
/home/runner/work/dpdk/dpdk/build/../lib/eal/linux/eal.c:1333:2
    #2 0x5613eb3bf7bc in main
/home/runner/work/dpdk/dpdk/build/../app/test-pmd/testpmd.c:4583:8
    #3 0x7f870b229d8f in __libc_start_call_main
csu/../sysdeps/nptl/libc_start_call_main.h:58:16

previously allocated by thread T0 here:
    #0 0x5613eb24bec8 in __interceptor_calloc
(/home/runner/work/dpdk/dpdk/build/app/dpdk-testpmd+0xb8cec8) (BuildId:
1c1d93dcb4fec8b525f3ed4b97885f75ba17fcb1)
    #1 0x5613ec542b56 in rte_intr_instance_alloc
/home/runner/work/dpdk/dpdk/build/../lib/eal/common/eal_common_interrupts.c=
:51:17
    #2 0x5613ec5a26ed in rte_eal_alarm_init
/home/runner/work/dpdk/dpdk/build/../lib/eal/linux/eal_alarm.c:66:16
    #3 0x5613ec59f5a3 in rte_eal_init
/home/runner/work/dpdk/dpdk/build/../lib/eal/linux/eal.c:1011:6
    #4 0x5613eb3be5b3 in main
/home/runner/work/dpdk/dpdk/build/../app/test-pmd/testpmd.c:4369:9
    #5 0x7f870b229d8f in __libc_start_call_main
csu/../sysdeps/nptl/libc_start_call_main.h:58:16

Thread T1 created by T0 here:
    #0 0x5613eb23515c in __interceptor_pthread_create
(/home/runner/work/dpdk/dpdk/build/app/dpdk-testpmd+0xb7615c) (BuildId:
1c1d93dcb4fec8b525f3ed4b97885f75ba17fcb1)
    #1 0x5613ec59d50c in rte_thread_create
/home/runner/work/dpdk/dpdk/build/../lib/eal/unix/rte_thread.c:199:8
    #2 0x5613ec56011b in rte_thread_create_control
/home/runner/work/dpdk/dpdk/build/../lib/eal/common/eal_common_thread.c:308=
:8
    #3 0x5613ec56096c in rte_thread_create_internal_control
/home/runner/work/dpdk/dpdk/build/../lib/eal/common/eal_common_thread.c:358=
:9
    #4 0x5613ec5ab811 in rte_eal_intr_init
/home/runner/work/dpdk/dpdk/build/../lib/eal/linux/eal_interrupts.c:1200:8
    #5 0x5613ec59f58a in rte_eal_init
/home/runner/work/dpdk/dpdk/build/../lib/eal/linux/eal.c:1006:6
    #6 0x5613eb3be5b3 in main
/home/runner/work/dpdk/dpdk/build/../app/test-pmd/testpmd.c:4369:9
    #7 0x7f870b229d8f in __libc_start_call_main
csu/../sysdeps/nptl/libc_start_call_main.h:58:16

SUMMARY: AddressSanitizer: heap-use-after-free
/home/runner/work/dpdk/dpdk/build/../lib/eal/common/eal_common_interrupts.c=
:210:22
in rte_intr_fd_get
Shadow bytes around the buggy address:
  0x0c0c7fff9170: fa fa fa fa fd fd fd fd fd fd fd fa fa fa fa fa
  0x0c0c7fff9180: fd fd fd fd fd fd fd fa fa fa fa fa 00 00 00 00
  0x0c0c7fff9190: 00 00 06 fa fa fa fa fa fd fd fd fd fd fd fd fa
  0x0c0c7fff91a0: fa fa fa fa fd fd fd fd fd fd fd fa fa fa fa fa
  0x0c0c7fff91b0: fd fd fd fd fd fd fd fd fa fa fa fa fd fd fd fd
=3D>0x0c0c7fff91c0: fd fd fd fa fa fa fa fa[fd]fd fd fd fd fd fd fd
  0x0c0c7fff91d0: fa fa fa fa 00 00 00 00 00 00 00 00 fa fa fa fa
  0x0c0c7fff91e0: fd fd fd fd fd fd fd fa fa fa fa fa fd fd fd fd
  0x0c0c7fff91f0: fd fd fd fd fa fa fa fa fd fd fd fd fd fd fd fd
  0x0c0c7fff9200: fa fa fa fa 00 00 00 00 00 00 00 00 fa fa fa fa
  0x0c0c7fff9210: 00 00 00 00 00 00 00 00 fa fa fa fa 00 00 00 00
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
=3D=3D46768=3D=3DABORTING


From a quick reading of the cleanup code, the reason is probably that the
interrupt thread was not killed before releasing the interrupt handler in
rte_eal_alarm_cleanup() call.

There may be a need for killing the interrupt thread or adding some
synchronisation point.

This issue probably affects all OS implementations.

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17430064360.b6528.2425440
Date: Wed, 26 Mar 2025 17:27:16 +0100
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
   title=3D"UNCONFIRMED - use after on interrupt thread during EAL cleanup"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1683">1683</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>use after on interrupt thread during EAL cleanup
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>unspecified
          </td>
        </tr>

        <tr>
          <th>Hardware</th>
          <td>All
          </td>
        </tr>

        <tr>
          <th>OS</th>
          <td>All
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
          <td>core
          </td>
        </tr>

        <tr>
          <th>Assignee</th>
          <td>dev&#64;dpdk.org
          </td>
        </tr>

        <tr>
          <th>Reporter</th>
          <td>david.marchand&#64;redhat.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">This was caught with ASan in a CI =
run in my GHA:

+ devtools/test-null.sh
EAL: Detected CPU lcores: 4
EAL: Detected NUMA nodes: 1
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /run/user/1001/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'VA'
testpmd: create a new mbuf pool &lt;mb_pool_0&gt;: n=3D2048, size=3D2176, s=
ocket=3D0
testpmd: preferred mempool ops selected: ring_mp_mc
Interactive-mode selected
Auto-start selected
Configuring Port 0 (socket 0)
...

Shutting down port 1...
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D46768=3D=3DERROR: AddressSanitizer: heap-use-after-free on address 0x=
606000008e44
at pc 0x5613ec543091 bp 0x7f87065fd1d0 sp 0x7f87065fd1c8
READ of size 4 at 0x606000008e44 thread T1
    #0 0x5613ec543090 in rte_intr_fd_get
/home/runner/work/dpdk/dpdk/build/../lib/eal/common/eal_common_interrupts.c=
:210:22
    #1 0x5613ec5a350b in eal_alarm_callback
/home/runner/work/dpdk/dpdk/build/../lib/eal/linux/eal_alarm.c:125:19
    #2 0x5613ec5acef1 in eal_intr_process_interrupts
/home/runner/work/dpdk/dpdk/build/../lib/eal/linux/eal_interrupts.c:1026:5
    #3 0x5613ec5acef1 in eal_intr_handle_interrupts
/home/runner/work/dpdk/dpdk/build/../lib/eal/linux/eal_interrupts.c:1100:7
    #4 0x5613ec5aba06 in eal_intr_thread_main
/home/runner/work/dpdk/dpdk/build/../lib/eal/linux/eal_interrupts.c:1172:3
    #5 0x7f870b294ac2 in start_thread nptl/./nptl/pthread_create.c:442:8
    #6 0x7f870b32684f  misc/../sysdeps/unix/sysv/linux/x86_64/clone3.S:81

0x606000008e44 is located 4 bytes inside of 64-byte region
[0x606000008e40,0x606000008e80)
freed by thread T0 here:
    #0 0x5613eb24ba32 in free
(/home/runner/work/dpdk/dpdk/build/app/dpdk-testpmd+0xb8ca32) (BuildId:
1c1d93dcb4fec8b525f3ed4b97885f75ba17fcb1)
    #1 0x5613ec5a1b7f in rte_eal_cleanup
/home/runner/work/dpdk/dpdk/build/../lib/eal/linux/eal.c:1333:2
    #2 0x5613eb3bf7bc in main
/home/runner/work/dpdk/dpdk/build/../app/test-pmd/testpmd.c:4583:8
    #3 0x7f870b229d8f in __libc_start_call_main
csu/../sysdeps/nptl/libc_start_call_main.h:58:16

previously allocated by thread T0 here:
    #0 0x5613eb24bec8 in __interceptor_calloc
(/home/runner/work/dpdk/dpdk/build/app/dpdk-testpmd+0xb8cec8) (BuildId:
1c1d93dcb4fec8b525f3ed4b97885f75ba17fcb1)
    #1 0x5613ec542b56 in rte_intr_instance_alloc
/home/runner/work/dpdk/dpdk/build/../lib/eal/common/eal_common_interrupts.c=
:51:17
    #2 0x5613ec5a26ed in rte_eal_alarm_init
/home/runner/work/dpdk/dpdk/build/../lib/eal/linux/eal_alarm.c:66:16
    #3 0x5613ec59f5a3 in rte_eal_init
/home/runner/work/dpdk/dpdk/build/../lib/eal/linux/eal.c:1011:6
    #4 0x5613eb3be5b3 in main
/home/runner/work/dpdk/dpdk/build/../app/test-pmd/testpmd.c:4369:9
    #5 0x7f870b229d8f in __libc_start_call_main
csu/../sysdeps/nptl/libc_start_call_main.h:58:16

Thread T1 created by T0 here:
    #0 0x5613eb23515c in __interceptor_pthread_create
(/home/runner/work/dpdk/dpdk/build/app/dpdk-testpmd+0xb7615c) (BuildId:
1c1d93dcb4fec8b525f3ed4b97885f75ba17fcb1)
    #1 0x5613ec59d50c in rte_thread_create
/home/runner/work/dpdk/dpdk/build/../lib/eal/unix/rte_thread.c:199:8
    #2 0x5613ec56011b in rte_thread_create_control
/home/runner/work/dpdk/dpdk/build/../lib/eal/common/eal_common_thread.c:308=
:8
    #3 0x5613ec56096c in rte_thread_create_internal_control
/home/runner/work/dpdk/dpdk/build/../lib/eal/common/eal_common_thread.c:358=
:9
    #4 0x5613ec5ab811 in rte_eal_intr_init
/home/runner/work/dpdk/dpdk/build/../lib/eal/linux/eal_interrupts.c:1200:8
    #5 0x5613ec59f58a in rte_eal_init
/home/runner/work/dpdk/dpdk/build/../lib/eal/linux/eal.c:1006:6
    #6 0x5613eb3be5b3 in main
/home/runner/work/dpdk/dpdk/build/../app/test-pmd/testpmd.c:4369:9
    #7 0x7f870b229d8f in __libc_start_call_main
csu/../sysdeps/nptl/libc_start_call_main.h:58:16

SUMMARY: AddressSanitizer: heap-use-after-free
/home/runner/work/dpdk/dpdk/build/../lib/eal/common/eal_common_interrupts.c=
:210:22
in rte_intr_fd_get
Shadow bytes around the buggy address:
  0x0c0c7fff9170: fa fa fa fa fd fd fd fd fd fd fd fa fa fa fa fa
  0x0c0c7fff9180: fd fd fd fd fd fd fd fa fa fa fa fa 00 00 00 00
  0x0c0c7fff9190: 00 00 06 fa fa fa fa fa fd fd fd fd fd fd fd fa
  0x0c0c7fff91a0: fa fa fa fa fd fd fd fd fd fd fd fa fa fa fa fa
  0x0c0c7fff91b0: fd fd fd fd fd fd fd fd fa fa fa fa fd fd fd fd
=3D&gt;0x0c0c7fff91c0: fd fd fd fa fa fa fa fa[fd]fd fd fd fd fd fd fd
  0x0c0c7fff91d0: fa fa fa fa 00 00 00 00 00 00 00 00 fa fa fa fa
  0x0c0c7fff91e0: fd fd fd fd fd fd fd fa fa fa fa fa fd fd fd fd
  0x0c0c7fff91f0: fd fd fd fd fa fa fa fa fd fd fd fd fd fd fd fd
  0x0c0c7fff9200: fa fa fa fa 00 00 00 00 00 00 00 00 fa fa fa fa
  0x0c0c7fff9210: 00 00 00 00 00 00 00 00 fa fa fa fa 00 00 00 00
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
=3D=3D46768=3D=3DABORTING


From a quick reading of the cleanup code, the reason is probably that the
interrupt thread was not killed before releasing the interrupt handler in
rte_eal_alarm_cleanup() call.

There may be a need for killing the interrupt thread or adding some
synchronisation point.

This issue probably affects all OS implementations.
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
?id=3D1683">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17430064360.b6528.2425440--
