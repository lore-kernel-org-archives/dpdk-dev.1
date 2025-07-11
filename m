Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A02C8303C
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Jul 2025 05:33:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2069F402A9;
	Fri, 11 Jul 2025 07:33:11 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 170D940156
 for <dev@dpdk.org>; Fri, 11 Jul 2025 07:33:09 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 04B8946B42; Fri, 11 Jul 2025 07:33:08 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/examples Bug 1751] [dpdk24.07]
 multiprocess_symmetric_mp_packet: exiting the symmetric_mp example results in
 a core dump
Date: Fri, 11 Jul 2025 05:33:08 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: examples
X-Bugzilla-Version: 25.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: songx.jiale@intel.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1751-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17522119880.fab0.442705
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


--17522119880.fab0.442705
Date: Fri, 11 Jul 2025 07:33:08 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1751

            Bug ID: 1751
           Summary: [dpdk24.07] multiprocess_symmetric_mp_packet: exiting
                    the symmetric_mp example results in a core dump
           Product: DPDK
           Version: 25.03
          Hardware: x86
                OS: Linux
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: examples
          Assignee: dev@dpdk.org
          Reporter: songx.jiale@intel.com
  Target Milestone: ---

Environment
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DPDK version: 9fe9c0b231c8da5435bfccb1963121b4277f961c version: dpdk25.07-r=
c3
OS: Ubuntu 24.04.2 LTS/6.8.0-60-generic
Compiler:  gcc version 13.3.0
Hardware platform: Intel(R) Xeon(R) Platinum 8380 CPU @ 2.30GHz
NIC hardware: Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connect=
ion
[8086:10fb] (rev 01)
NIC firmware:=20
  driver: vfio-pci
  kdriver: ixgbe-6.1.5
  firmware-version: 0x000161bf

Test Setup
Steps to reproduce
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1. compile dpdk
rm -rf x86_64-native-linuxapp-gcc
CC=3Dgcc meson -Denable_kmods=3DFalse -Dlibdir=3Dlib
-Dexamples=3D'multi_process/symmetric_mp' --default-library=3Dstatic
x86_64-native-linuxapp-gcc
ninja -C x86_64-native-linuxapp-gcc

2. bind port to vfio-pci
./usertools/dpdk-devbind.py -b vfio-pci 0000:b1:00.0 0000:b1:00.1

3. start testpmd
the first process=EF=BC=9A
x86_64-native-linuxapp-gcc/examples/dpdk-symmetric_mp -l 1 -n 4 -a 0000:b1:=
00.0
-a 0000:b1:00.1  --file-prefix=3Ddpdk_3722445_20250711093937     --proc-typ=
e=3Dauto
-- -p 0x3 --num-procs=3D2 --proc-id=3D0

the secondary process=EF=BC=9A
x86_64-native-linuxapp-gcc/examples/dpdk-symmetric_mp -l 2 -n 4 -a 0000:b1:=
00.0
-a 0000:b1:00.1  --file-prefix=3Ddpdk_3722445_20250711093937     --proc-typ=
e=3Dauto
-- -p 0x3 --num-procs=3D2 --proc-id=3D1

4. exit the first process
^C


Results:=20
=3D=3D=3D=3D=3D=3D=3D=3D
^C
the first process=EF=BC=9A Exiting on signal 2Port 0: RX - 0, TX - 1, Drop =
- 0
Port 1: RX - 1, TX - 0, Drop - 0
APP: Close ports.
EAL: Error - exiting with code: 1
Error closing ports
EAL: failed to send to
(/var/run/dpdk/dpdk_3722445_20250711093937/mp_socket_794973_148a6526e3624d)=
 due
to Bad file descriptor
EAL: Fail to send request
/var/run/dpdk/dpdk_3722445_20250711093937/mp_socket_794973_148a6526e3624d:m=
p_malloc_sync
EAL: Could not send sync request to secondary process=20

the secondary process=EF=BC=9A
EAL: Detected CPU lcores: 80
EAL: Detected NUMA nodes: 2
EAL: Auto-detected process type: SECONDARY
EAL: Detected static linkage of DPDK
EAL: Multi-process socket
/var/run/dpdk/dpdk_3722445_20250711093937/mp_socket_794279_148a2f16b62b59
EAL: Selected IOVA mode 'VA'
EAL: VFIO support initialized
EAL: Using IOMMU type 1 (Type 1)
APP: Finished Process Init.
Lcore 2 using ports 0 1
lcore 2 using queue 1 of each port
Segmentation fault (core dumped)

Expected Result:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
exit the symmetric_mp example normally.

bad commit:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
commit 4382d58097b41d1e1229ce5fc2943994bf44bd83
Author: Maayan Kashani <mkashani@nvidia.com>
Date:   Tue Jul 8 10:09:54 2025 +0300

    examples/multi_process: fix ports cleanup on exit

    Device was started but not stopped on exit signal.
    Added port stop and close on exit.

    Fixes: af75078fece3 ("first public release")
    Cc: stable@dpdk.org

    Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
    Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17522119880.fab0.442705
Date: Fri, 11 Jul 2025 07:33:08 +0200
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
   title=3D"UNCONFIRMED - [dpdk24.07] multiprocess_symmetric_mp_packet: exi=
ting the symmetric_mp example results in a core dump"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1751">1751</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>[dpdk24.07] multiprocess_symmetric_mp_packet: exiting the sym=
metric_mp example results in a core dump
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
          <td>songx.jiale&#64;intel.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">Environment
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DPDK version: 9fe9c0b231c8da5435bfccb1963121b4277f961c version: dpdk25.07-r=
c3
OS: Ubuntu 24.04.2 LTS/6.8.0-60-generic
Compiler:  gcc version 13.3.0
Hardware platform: Intel(R) Xeon(R) Platinum 8380 CPU &#64; 2.30GHz
NIC hardware: Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connect=
ion
[8086:10fb] (rev 01)
NIC firmware:=20
  driver: vfio-pci
  kdriver: ixgbe-6.1.5
  firmware-version: 0x000161bf

Test Setup
Steps to reproduce
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1. compile dpdk
rm -rf x86_64-native-linuxapp-gcc
CC=3Dgcc meson -Denable_kmods=3DFalse -Dlibdir=3Dlib
-Dexamples=3D'multi_process/symmetric_mp' --default-library=3Dstatic
x86_64-native-linuxapp-gcc
ninja -C x86_64-native-linuxapp-gcc

2. bind port to vfio-pci
./usertools/dpdk-devbind.py -b vfio-pci 0000:b1:00.0 0000:b1:00.1

3. start testpmd
the first process=EF=BC=9A
x86_64-native-linuxapp-gcc/examples/dpdk-symmetric_mp -l 1 -n 4 -a 0000:b1:=
00.0
-a 0000:b1:00.1  --file-prefix=3Ddpdk_3722445_20250711093937     --proc-typ=
e=3Dauto
-- -p 0x3 --num-procs=3D2 --proc-id=3D0

the secondary process=EF=BC=9A
x86_64-native-linuxapp-gcc/examples/dpdk-symmetric_mp -l 2 -n 4 -a 0000:b1:=
00.0
-a 0000:b1:00.1  --file-prefix=3Ddpdk_3722445_20250711093937     --proc-typ=
e=3Dauto
-- -p 0x3 --num-procs=3D2 --proc-id=3D1

4. exit the first process
^C


Results:=20
=3D=3D=3D=3D=3D=3D=3D=3D
^C
the first process=EF=BC=9A Exiting on signal 2Port 0: RX - 0, TX - 1, Drop =
- 0
Port 1: RX - 1, TX - 0, Drop - 0
APP: Close ports.
EAL: Error - exiting with code: 1
Error closing ports
EAL: failed to send to
(/var/run/dpdk/dpdk_3722445_20250711093937/mp_socket_794973_148a6526e3624d)=
 due
to Bad file descriptor
EAL: Fail to send request
/var/run/dpdk/dpdk_3722445_20250711093937/mp_socket_794973_148a6526e3624d:m=
p_malloc_sync
EAL: Could not send sync request to secondary process=20

the secondary process=EF=BC=9A
EAL: Detected CPU lcores: 80
EAL: Detected NUMA nodes: 2
EAL: Auto-detected process type: SECONDARY
EAL: Detected static linkage of DPDK
EAL: Multi-process socket
/var/run/dpdk/dpdk_3722445_20250711093937/mp_socket_794279_148a2f16b62b59
EAL: Selected IOVA mode 'VA'
EAL: VFIO support initialized
EAL: Using IOMMU type 1 (Type 1)
APP: Finished Process Init.
Lcore 2 using ports 0 1
lcore 2 using queue 1 of each port
Segmentation fault (core dumped)

Expected Result:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
exit the symmetric_mp example normally.

bad commit:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
commit 4382d58097b41d1e1229ce5fc2943994bf44bd83
Author: Maayan Kashani &lt;<a href=3D"mailto:mkashani&#64;nvidia.com">mkash=
ani&#64;nvidia.com</a>&gt;
Date:   Tue Jul 8 10:09:54 2025 +0300

    examples/multi_process: fix ports cleanup on exit

    Device was started but not stopped on exit signal.
    Added port stop and close on exit.

    Fixes: af75078fece3 (&quot;first public release&quot;)
    Cc: <a href=3D"mailto:stable&#64;dpdk.org">stable&#64;dpdk.org</a>

    Signed-off-by: Maayan Kashani &lt;<a href=3D"mailto:mkashani&#64;nvidia=
.com">mkashani&#64;nvidia.com</a>&gt;
    Acked-by: Anatoly Burakov &lt;<a href=3D"mailto:anatoly.burakov&#64;int=
el.com">anatoly.burakov&#64;intel.com</a>&gt;
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
?id=3D1751">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17522119880.fab0.442705--
