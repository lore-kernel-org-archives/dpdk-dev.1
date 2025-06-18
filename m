Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FA2C71157
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 02:07:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57B36410FD;
	Wed, 18 Jun 2025 04:07:19 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 4A25640279
 for <dev@dpdk.org>; Wed, 18 Jun 2025 04:07:18 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 306E4469E6; Wed, 18 Jun 2025 04:07:18 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/DTS Bug 1728] Segmentation fault in dpdk-test-compress-perf
 with compress_zlib vdev on Ubuntu 24.04 with GCC 14.2 and kernel 6.8.0
Date: Wed, 18 Jun 2025 02:07:17 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: DTS
X-Bugzilla-Version: 24.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: critical
X-Bugzilla-Who: Bala.MuraliKrishna@amd.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter cc
 target_milestone
Message-ID: <bug-1728-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17502124380.daeAa91.2682349
Content-Transfer-Encoding: 7bit
X-Bugzilla-URL: https://bugs.dpdk.org/
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


--17502124380.daeAa91.2682349
Date: Wed, 18 Jun 2025 04:07:18 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1728

            Bug ID: 1728
           Summary: Segmentation fault in dpdk-test-compress-perf with
                    compress_zlib vdev on Ubuntu 24.04 with GCC 14.2 and
                    kernel 6.8.0
           Product: DPDK
           Version: 24.11
          Hardware: All
                OS: Linux
            Status: UNCONFIRMED
          Severity: critical
          Priority: Normal
         Component: DTS
          Assignee: dev@dpdk.org
          Reporter: Bala.MuraliKrishna@amd.com
                CC: juraj.linkes@pantheon.tech, probb@iol.unh.edu
  Target Milestone: ---

Running dpdk-test-compress-perf with compress_zlib2 virtual device and a
specific set of compression parameters causes a segmentation fault in
main_loop() at comp_perf_test_cyclecount.c:384.


Steps to Reproduce:
Environment:
OS: Ubuntu 24.04 (VERSION_ID=3D"24.04")
Kernel: 6.8.0-60-generic
GCC: 14.2.0
DPDK: 24.11.2

run the below command line

sudo   build/app/dpdk-test-compress-perf --file-prefix=3Dcompress -l 3,4-7=
=20
--vdev=3Dcompress_zlib2 --no-pci -v   --socket-mem 0 -- --ptest pmd-cycleco=
unt=20
--driver-name compress_zlib --input-file /home/amd/dpdk/test.img
--extended-input-sz 1048576 --seg-sz 59460 --burst-sz 32 --pool-sz 8192
--max-num-sgl-segs 1 --num-iter 2 --operation comp_and_decomp --algo deflate
--huffman-enc fixed --lz4-flags 01 --compress-level 1:1:9 --window-sz 15
--cc-delay-us 500

amd@automation-vm6:~/dpdk/dpdk-stable-24.11.2$ sudo  gdb --args=20
build/app/dpdk-test-compress-perf --file-prefix=3Dcompress -l 3,4
--vdev=3Dcompress_zlib2 --no-pci -v   --socket-mem 0 -- --ptest pmd-cycleco=
unt=20
--driver-name compress_zlib --input-file /home/amd/dpdk/test.img
--extended-input-sz 1048576 --seg-sz 59460 --burst-sz 32 --pool-sz 8192
--max-num-sgl-segs 1 --num-iter 2 --operation comp_and_decomp --algo deflate
--huffman-enc fixed --lz4-flags 01 --compress-level 1:1:9 --window-sz 15
--cc-delay-us 500
[sudo] password for amd:
GNU gdb (Ubuntu 15.0.50.20240403-0ubuntu1) 15.0.50.20240403-git
Copyright (C) 2024 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.htm=
l>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "x86_64-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<https://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
    <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from build/app/dpdk-test-compress-perf...
(gdb) r
Starting program:
/home/amd/dpdk/dpdk-stable-24.11.2/build/app/dpdk-test-compress-perf
--file-prefix=3Dcompress -l 3,4 --vdev=3Dcompress_zlib2 --no-pci -v --socke=
t-mem 0
-- --ptest pmd-cyclecount --driver-name compress_zlib --input-file
/home/amd/dpdk/test.img --extended-input-sz 1048576 --seg-sz 59460 --burst-=
sz
32 --pool-sz 8192 --max-num-sgl-segs 1 --num-iter 2 --operation comp_and_de=
comp
--algo deflate --huffman-enc fixed --lz4-flags 01 --compress-level 1:1:9
--window-sz 15 --cc-delay-us 500
warning: could not find '.gnu_debugaltlink' file for
/lib/x86_64-linux-gnu/libmlx5.so.1
warning: could not find '.gnu_debugaltlink' file for
/lib/x86_64-linux-gnu/libmana.so.1
warning: could not find '.gnu_debugaltlink' file for
/lib/x86_64-linux-gnu/libmlx4.so.1
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
warning: could not find '.gnu_debugaltlink' file for
/lib/x86_64-linux-gnu/libcap.so.2
EAL: Detected CPU lcores: 8
EAL: Detected NUMA nodes: 1
EAL: RTE Version: 'DPDK 24.11.2'
EAL: Detected static linkage of DPDK
[New Thread 0x7ffff71d8400 (LWP 1042586)]
EAL: Multi-process socket /var/run/dpdk/compress/mp_socket
[New Thread 0x7ffff69d7400 (LWP 1042587)]
EAL: Selected IOVA mode 'PA'
[New Thread 0x7ffff51d5400 (LWP 1042588)]
[New Thread 0x7ffff49d4400 (LWP 1042589)]
USER1: 1048576 bytes read from file /home/amd/dpdk/test.img
App uses socket: 0
Burst size =3D 32
Input data size =3D 1048576
Cycle-count delay =3D 500 [us]

For the current input parameters (segment size =3D 59460, maximum segments =
per
SGL =3D 1):
        * Total number of buffers: 18
        * 17 buffer(s) 59460 bytes long, last buffer 65406 byte(s) long
        * Number of ops: 18
        * Total memory allocation: 1076226
        * 17 ops: 1 segment(s) in each, segment size 59460
        * 1 op (the last one): 1 segment 65406 byte(s) long


    lcore: 4, driver name: compress_zlib, device name: compress_zlib2, devi=
ce
id: 0, socket id: 0, queue pair id: 0

Thread 4 "dpdk-worker4" received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7ffff51d5400 (LWP 1042588)]
0x000000000053f182 in main_loop (ctx=3D0x1002f92c0, type=3DRTE_COMP_COMPRES=
S) at
../app/test-compress-perf/comp_perf_test_cyclecount.c:384
384                                                     m->data_len =3D
data_to_append;
(gdb) p data_to_append
$1 =3D 53534
(gdb) p m->data_len
Cannot access memory at address 0x28
(gdb)


Analysis:
The crash occurs while accessing m->data_len, indicating that the m pointer=
 (a
rte_mbuf*) is NULL or invalid.

Root cause appears to be a failure in allocation or initialization of the
rte_mbuf object before dereferencing.

The issue is reproducible consistently with the parameters provided.

As a temporary workaround, adding a NULL check on the m pointer bypasses the
crash, but it does not solve the underlying buffer allocation/management is=
sue.

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17502124380.daeAa91.2682349
Date: Wed, 18 Jun 2025 04:07:18 +0200
MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
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
   title=3D"UNCONFIRMED - Segmentation fault in dpdk-test-compress-perf wit=
h compress_zlib vdev on Ubuntu 24.04 with GCC 14.2 and kernel 6.8.0"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1728">1728</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>Segmentation fault in dpdk-test-compress-perf with compress_z=
lib vdev on Ubuntu 24.04 with GCC 14.2 and kernel 6.8.0
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>24.11
          </td>
        </tr>

        <tr>
          <th>Hardware</th>
          <td>All
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
          <td>critical
          </td>
        </tr>

        <tr>
          <th>Priority</th>
          <td>Normal
          </td>
        </tr>

        <tr>
          <th>Component</th>
          <td>DTS
          </td>
        </tr>

        <tr>
          <th>Assignee</th>
          <td>dev&#64;dpdk.org
          </td>
        </tr>

        <tr>
          <th>Reporter</th>
          <td>Bala.MuraliKrishna&#64;amd.com
          </td>
        </tr>

        <tr>
          <th>CC</th>
          <td>juraj.linkes&#64;pantheon.tech, probb&#64;iol.unh.edu
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">Running dpdk-test-compress-perf wi=
th compress_zlib2 virtual device and a
specific set of compression parameters causes a segmentation fault in
main_loop() at comp_perf_test_cyclecount.c:384.


Steps to Reproduce:
Environment:
OS: Ubuntu 24.04 (VERSION_ID=3D&quot;24.04&quot;)
Kernel: 6.8.0-60-generic
GCC: 14.2.0
DPDK: 24.11.2

run the below command line

sudo   build/app/dpdk-test-compress-perf --file-prefix=3Dcompress -l 3,4-7=
=20
--vdev=3Dcompress_zlib2 --no-pci -v   --socket-mem 0 -- --ptest pmd-cycleco=
unt=20
--driver-name compress_zlib --input-file /home/amd/dpdk/test.img
--extended-input-sz 1048576 --seg-sz 59460 --burst-sz 32 --pool-sz 8192
--max-num-sgl-segs 1 --num-iter 2 --operation comp_and_decomp --algo deflate
--huffman-enc fixed --lz4-flags 01 --compress-level 1:1:9 --window-sz 15
--cc-delay-us 500

amd&#64;automation-vm6:~/dpdk/dpdk-stable-24.11.2$ sudo  gdb --args=20
build/app/dpdk-test-compress-perf --file-prefix=3Dcompress -l 3,4
--vdev=3Dcompress_zlib2 --no-pci -v   --socket-mem 0 -- --ptest pmd-cycleco=
unt=20
--driver-name compress_zlib --input-file /home/amd/dpdk/test.img
--extended-input-sz 1048576 --seg-sz 59460 --burst-sz 32 --pool-sz 8192
--max-num-sgl-segs 1 --num-iter 2 --operation comp_and_decomp --algo deflate
--huffman-enc fixed --lz4-flags 01 --compress-level 1:1:9 --window-sz 15
--cc-delay-us 500
[sudo] password for amd:
GNU gdb (Ubuntu 15.0.50.20240403-0ubuntu1) 15.0.50.20240403-git
Copyright (C) 2024 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later &lt;<a href=3D"http://gnu.org/li=
censes/gpl.html">http://gnu.org/licenses/gpl.html</a>&gt;
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type &quot;show copying&quot; and &quot;show warranty&quot; for details.
This GDB was configured as &quot;x86_64-linux-gnu&quot;.
Type &quot;show configuration&quot; for configuration details.
For bug reporting instructions, please see:
&lt;<a href=3D"https://www.gnu.org/software/gdb/bugs/">https://www.gnu.org/=
software/gdb/bugs/</a>&gt;.
Find the GDB manual and other documentation resources online at:
    &lt;<a href=3D"http://www.gnu.org/software/gdb/documentation/">http://w=
ww.gnu.org/software/gdb/documentation/</a>&gt;.

For help, type &quot;help&quot;.
Type &quot;apropos word&quot; to search for commands related to &quot;word&=
quot;...
Reading symbols from build/app/dpdk-test-compress-perf...
(gdb) r
Starting program:
/home/amd/dpdk/dpdk-stable-24.11.2/build/app/dpdk-test-compress-perf
--file-prefix=3Dcompress -l 3,4 --vdev=3Dcompress_zlib2 --no-pci -v --socke=
t-mem 0
-- --ptest pmd-cyclecount --driver-name compress_zlib --input-file
/home/amd/dpdk/test.img --extended-input-sz 1048576 --seg-sz 59460 --burst-=
sz
32 --pool-sz 8192 --max-num-sgl-segs 1 --num-iter 2 --operation comp_and_de=
comp
--algo deflate --huffman-enc fixed --lz4-flags 01 --compress-level 1:1:9
--window-sz 15 --cc-delay-us 500
warning: could not find '.gnu_debugaltlink' file for
/lib/x86_64-linux-gnu/libmlx5.so.1
warning: could not find '.gnu_debugaltlink' file for
/lib/x86_64-linux-gnu/libmana.so.1
warning: could not find '.gnu_debugaltlink' file for
/lib/x86_64-linux-gnu/libmlx4.so.1
[Thread debugging using libthread_db enabled]
Using host libthread_db library &quot;/lib/x86_64-linux-gnu/libthread_db.so=
.1&quot;.
warning: could not find '.gnu_debugaltlink' file for
/lib/x86_64-linux-gnu/libcap.so.2
EAL: Detected CPU lcores: 8
EAL: Detected NUMA nodes: 1
EAL: RTE Version: 'DPDK 24.11.2'
EAL: Detected static linkage of DPDK
[New Thread 0x7ffff71d8400 (LWP 1042586)]
EAL: Multi-process socket /var/run/dpdk/compress/mp_socket
[New Thread 0x7ffff69d7400 (LWP 1042587)]
EAL: Selected IOVA mode 'PA'
[New Thread 0x7ffff51d5400 (LWP 1042588)]
[New Thread 0x7ffff49d4400 (LWP 1042589)]
USER1: 1048576 bytes read from file /home/amd/dpdk/test.img
App uses socket: 0
Burst size =3D 32
Input data size =3D 1048576
Cycle-count delay =3D 500 [us]

For the current input parameters (segment size =3D 59460, maximum segments =
per
SGL =3D 1):
        * Total number of buffers: 18
        * 17 buffer(s) 59460 bytes long, last buffer 65406 byte(s) long
        * Number of ops: 18
        * Total memory allocation: 1076226
        * 17 ops: 1 segment(s) in each, segment size 59460
        * 1 op (the last one): 1 segment 65406 byte(s) long


    lcore: 4, driver name: compress_zlib, device name: compress_zlib2, devi=
ce
id: 0, socket id: 0, queue pair id: 0

Thread 4 &quot;dpdk-worker4&quot; received signal SIGSEGV, Segmentation fau=
lt.
[Switching to Thread 0x7ffff51d5400 (LWP 1042588)]
0x000000000053f182 in main_loop (ctx=3D0x1002f92c0, type=3DRTE_COMP_COMPRES=
S) at
../app/test-compress-perf/comp_perf_test_cyclecount.c:384
384                                                     m-&gt;data_len =3D
data_to_append;
(gdb) p data_to_append
$1 =3D 53534
(gdb) p m-&gt;data_len
Cannot access memory at address 0x28
(gdb)


Analysis:
The crash occurs while accessing m-&gt;data_len, indicating that the m poin=
ter (a
rte_mbuf*) is NULL or invalid.

Root cause appears to be a failure in allocation or initialization of the
rte_mbuf object before dereferencing.

The issue is reproducible consistently with the parameters provided.

As a temporary workaround, adding a NULL check on the m pointer bypasses the
crash, but it does not solve the underlying buffer allocation/management is=
sue.
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
?id=3D1728">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17502124380.daeAa91.2682349--
