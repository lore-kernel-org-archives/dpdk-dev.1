Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFA8C36010
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 15:47:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2186B40A89;
	Mon,  7 Apr 2025 17:47:35 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 14CF140273
 for <dev@dpdk.org>; Mon,  7 Apr 2025 17:47:34 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id E3EFC4652A; Mon,  7 Apr 2025 17:47:33 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1694] mlx5: ASAN reports memory leaks with
 send_to_kernel
Date: Mon, 07 Apr 2025 15:47:33 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 24.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: brian90013@gmail.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1694-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17440408530.bCD0.3877941
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


--17440408530.bCD0.3877941
Date: Mon, 7 Apr 2025 17:47:33 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1694

            Bug ID: 1694
           Summary: mlx5: ASAN reports memory leaks with send_to_kernel
           Product: DPDK
           Version: 24.11
          Hardware: x86
                OS: Linux
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: brian90013@gmail.com
  Target Milestone: ---

Hello,

I am very pleased with the extensive DPDK flow support available with the m=
lx5
driver. However, when testing my own code compiled with ASAN, I notice many
(limited to 5000) reports of indirect memory leaks from libmlx5.so whenever=
 the
send_to_kernel action is used. I can use other actions like DROP, QUEUE, JU=
MP,
and COUNT without seeing any leaks. I've repeated the test multiple times w=
ith
the same total volume of leaked memory each time.

Hardware:
* 42:00.0 Ethernet controller: Mellanox Technologies MT2892 Family [Connect=
X-6
Dx]

Software stack:
* Debian 12.9 kernel 6.1.0-32-amd64
* DOCA-roce 2.10.0=20
* DPDK 24.11.1
    * Configured with: meson build -Denable_kmods=3Dtrue -Db_sanitize=3Dadd=
ress
-Db_lundef=3Dfalse -Dbuildtype=3Ddebug


Test case:
* Using flow rule described in commit:
https://mails.dpdk.org/archives/dev/2022-September/251470.html

$ sudo dpdk-testpmd --in-memory -- -i
EAL: Detected CPU lcores: 48
EAL: Detected NUMA nodes: 1
EAL: Detected static linkage of DPDK
EAL: Selected IOVA mode 'VA'
EAL: No free 2048 kB hugepages reported on node 0
EAL: 16 hugepages of size 1073741824 reserved, but no mounted hugetlbfs fou=
nd
for that size
Interactive-mode selected
Warning: NUMA should be configured manually by using --port-numa-config and
--ring-numa-config parameters along with --numa.
testpmd: Flow tunnel offload support might be limited or unavailable on por=
t 0
testpmd: Flow tunnel offload support might be limited or unavailable on por=
t 1
testpmd: create a new mbuf pool <mb_pool_0>: n=3D523456, size=3D2176, socke=
t=3D0
testpmd: preferred mempool ops selected: ring_mp_mc
Configuring Port 0 (socket 0)
Port 0: XX:XX:XX:XX:XX:XX
Configuring Port 1 (socket 0)
Port 1: XX:XX:XX:XX:XX:XX
Checking link statuses...
Done
testpmd> flow create 0 ingress priority 0 group 1 pattern eth type spec 0x0=
800
type mask 0xffff / end actions send_to_kernel / end
Flow rule #0 created
testpmd> testpmd> quit

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
=3D=3D16057=3D=3DERROR: LeakSanitizer: detected memory leaks

Too many leaks! Only the first 5000 leaks encountered will be reported.
Indirect leak of 262184 byte(s) in 21 object(s) allocated from:
    #0 0x7f91436b83b7 in __interceptor_calloc
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x7f914350693e  (/lib/x86_64-linux-gnu/libmlx5.so.1+0x2493e)

Indirect leak of 4184 byte(s) in 21 object(s) allocated from:
    #0 0x7f91436b83b7 in __interceptor_calloc
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x7f914350698e  (/lib/x86_64-linux-gnu/libmlx5.so.1+0x2498e)

Indirect leak of 1792 byte(s) in 28 object(s) allocated from:
    #0 0x7f91436b83b7 in __interceptor_calloc
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x7f9143541fed  (/lib/x86_64-linux-gnu/libmlx5.so.1+0x5ffed)

Indirect leak of 1536 byte(s) in 24 object(s) allocated from:
    #0 0x7f91436b83b7 in __interceptor_calloc
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x7f914350af81  (/lib/x86_64-linux-gnu/libmlx5.so.1+0x28f81)

Indirect leak of 672 byte(s) in 14 object(s) allocated from:
    #0 0x7f91436b83b7 in __interceptor_calloc
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x7f9143540ebf  (/lib/x86_64-linux-gnu/libmlx5.so.1+0x5eebf)

Indirect leak of 560 byte(s) in 14 object(s) allocated from:
    #0 0x7f91436b83b7 in __interceptor_calloc
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x7f91435417a3  (/lib/x86_64-linux-gnu/libmlx5.so.1+0x5f7a3)
    #2 0x7f9143523ab4  (/lib/x86_64-linux-gnu/libmlx5.so.1+0x41ab4)

Indirect leak of 560 byte(s) in 14 object(s) allocated from:
    #0 0x7f91436b83b7 in __interceptor_calloc
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x7f91435417a3  (/lib/x86_64-linux-gnu/libmlx5.so.1+0x5f7a3)
    #2 0x7f9143523ade  (/lib/x86_64-linux-gnu/libmlx5.so.1+0x41ade)

Indirect leak of 288 byte(s) in 4 object(s) allocated from:
    #0 0x7f91436b83b7 in __interceptor_calloc
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x7f9143524bae  (/lib/x86_64-linux-gnu/libmlx5.so.1+0x42bae)
    #2 0x7ffc1f4f9bbf  ([stack]+0x1ebbf)

Indirect leak of 288 byte(s) in 4 object(s) allocated from:
    #0 0x7f91436b83b7 in __interceptor_calloc
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x7f9143524ea6  (/lib/x86_64-linux-gnu/libmlx5.so.1+0x42ea6)

Indirect leak of 256 byte(s) in 4 object(s) allocated from:
    #0 0x7f91436b83b7 in __interceptor_calloc
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x7f914350b6b7  (/lib/x86_64-linux-gnu/libmlx5.so.1+0x296b7)

Indirect leak of 192 byte(s) in 4 object(s) allocated from:
    #0 0x7f91436b83b7 in __interceptor_calloc
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x7f9143540ebf  (/lib/x86_64-linux-gnu/libmlx5.so.1+0x5eebf)
    #2 0xbffffffff  (<unknown module>)

Indirect leak of 112 byte(s) in 14 object(s) allocated from:
    #0 0x7f91436b7ffd in __interceptor_posix_memalign
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:145
    #1 0x7f9143523a85  (/lib/x86_64-linux-gnu/libmlx5.so.1+0x41a85)

Indirect leak of 72 byte(s) in 1 object(s) allocated from:
    #0 0x7f91436b83b7 in __interceptor_calloc
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x7f9143524bae  (/lib/x86_64-linux-gnu/libmlx5.so.1+0x42bae)
    #2 0x607000006f4f  (<unknown module>)


.... text removed for length


Indirect leak of 8 byte(s) in 1 object(s) allocated from:
    #0 0x7f91436b83b7 in __interceptor_calloc
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x7f914350f19e in mlx5dv_dr_domain_create
(/lib/x86_64-linux-gnu/libmlx5.so.1+0x2d19e)

SUMMARY: AddressSanitizer: 631608 byte(s) leaked in 5154 allocation(s).

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17440408530.bCD0.3877941
Date: Mon, 7 Apr 2025 17:47:33 +0200
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
   title=3D"UNCONFIRMED - mlx5: ASAN reports memory leaks with send_to_kern=
el"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1694">1694</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>mlx5: ASAN reports memory leaks with send_to_kernel
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
          <td>ethdev
          </td>
        </tr>

        <tr>
          <th>Assignee</th>
          <td>dev&#64;dpdk.org
          </td>
        </tr>

        <tr>
          <th>Reporter</th>
          <td>brian90013&#64;gmail.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">Hello,

I am very pleased with the extensive DPDK flow support available with the m=
lx5
driver. However, when testing my own code compiled with ASAN, I notice many
(limited to 5000) reports of indirect memory leaks from libmlx5.so whenever=
 the
send_to_kernel action is used. I can use other actions like DROP, QUEUE, JU=
MP,
and COUNT without seeing any leaks. I've repeated the test multiple times w=
ith
the same total volume of leaked memory each time.

Hardware:
* 42:00.0 Ethernet controller: Mellanox Technologies MT2892 Family [Connect=
X-6
Dx]

Software stack:
* Debian 12.9 kernel 6.1.0-32-amd64
* DOCA-roce 2.10.0=20
* DPDK 24.11.1
    * Configured with: meson build -Denable_kmods=3Dtrue -Db_sanitize=3Dadd=
ress
-Db_lundef=3Dfalse -Dbuildtype=3Ddebug


Test case:
* Using flow rule described in commit:
<a href=3D"https://mails.dpdk.org/archives/dev/2022-September/251470.html">=
https://mails.dpdk.org/archives/dev/2022-September/251470.html</a>

$ sudo dpdk-testpmd --in-memory -- -i
EAL: Detected CPU lcores: 48
EAL: Detected NUMA nodes: 1
EAL: Detected static linkage of DPDK
EAL: Selected IOVA mode 'VA'
EAL: No free 2048 kB hugepages reported on node 0
EAL: 16 hugepages of size 1073741824 reserved, but no mounted hugetlbfs fou=
nd
for that size
Interactive-mode selected
Warning: NUMA should be configured manually by using --port-numa-config and
--ring-numa-config parameters along with --numa.
testpmd: Flow tunnel offload support might be limited or unavailable on por=
t 0
testpmd: Flow tunnel offload support might be limited or unavailable on por=
t 1
testpmd: create a new mbuf pool &lt;mb_pool_0&gt;: n=3D523456, size=3D2176,=
 socket=3D0
testpmd: preferred mempool ops selected: ring_mp_mc
Configuring Port 0 (socket 0)
Port 0: XX:XX:XX:XX:XX:XX
Configuring Port 1 (socket 0)
Port 1: XX:XX:XX:XX:XX:XX
Checking link statuses...
Done
testpmd&gt; flow create 0 ingress priority 0 group 1 pattern eth type spec =
0x0800
type mask 0xffff / end actions send_to_kernel / end
Flow rule #0 created
testpmd&gt; testpmd&gt; quit

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
=3D=3D16057=3D=3DERROR: LeakSanitizer: detected memory leaks

Too many leaks! Only the first 5000 leaks encountered will be reported.
Indirect leak of 262184 byte(s) in 21 object(s) allocated from:
    #0 0x7f91436b83b7 in __interceptor_calloc
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x7f914350693e  (/lib/x86_64-linux-gnu/libmlx5.so.1+0x2493e)

Indirect leak of 4184 byte(s) in 21 object(s) allocated from:
    #0 0x7f91436b83b7 in __interceptor_calloc
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x7f914350698e  (/lib/x86_64-linux-gnu/libmlx5.so.1+0x2498e)

Indirect leak of 1792 byte(s) in 28 object(s) allocated from:
    #0 0x7f91436b83b7 in __interceptor_calloc
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x7f9143541fed  (/lib/x86_64-linux-gnu/libmlx5.so.1+0x5ffed)

Indirect leak of 1536 byte(s) in 24 object(s) allocated from:
    #0 0x7f91436b83b7 in __interceptor_calloc
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x7f914350af81  (/lib/x86_64-linux-gnu/libmlx5.so.1+0x28f81)

Indirect leak of 672 byte(s) in 14 object(s) allocated from:
    #0 0x7f91436b83b7 in __interceptor_calloc
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x7f9143540ebf  (/lib/x86_64-linux-gnu/libmlx5.so.1+0x5eebf)

Indirect leak of 560 byte(s) in 14 object(s) allocated from:
    #0 0x7f91436b83b7 in __interceptor_calloc
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x7f91435417a3  (/lib/x86_64-linux-gnu/libmlx5.so.1+0x5f7a3)
    #2 0x7f9143523ab4  (/lib/x86_64-linux-gnu/libmlx5.so.1+0x41ab4)

Indirect leak of 560 byte(s) in 14 object(s) allocated from:
    #0 0x7f91436b83b7 in __interceptor_calloc
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x7f91435417a3  (/lib/x86_64-linux-gnu/libmlx5.so.1+0x5f7a3)
    #2 0x7f9143523ade  (/lib/x86_64-linux-gnu/libmlx5.so.1+0x41ade)

Indirect leak of 288 byte(s) in 4 object(s) allocated from:
    #0 0x7f91436b83b7 in __interceptor_calloc
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x7f9143524bae  (/lib/x86_64-linux-gnu/libmlx5.so.1+0x42bae)
    #2 0x7ffc1f4f9bbf  ([stack]+0x1ebbf)

Indirect leak of 288 byte(s) in 4 object(s) allocated from:
    #0 0x7f91436b83b7 in __interceptor_calloc
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x7f9143524ea6  (/lib/x86_64-linux-gnu/libmlx5.so.1+0x42ea6)

Indirect leak of 256 byte(s) in 4 object(s) allocated from:
    #0 0x7f91436b83b7 in __interceptor_calloc
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x7f914350b6b7  (/lib/x86_64-linux-gnu/libmlx5.so.1+0x296b7)

Indirect leak of 192 byte(s) in 4 object(s) allocated from:
    #0 0x7f91436b83b7 in __interceptor_calloc
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x7f9143540ebf  (/lib/x86_64-linux-gnu/libmlx5.so.1+0x5eebf)
    #2 0xbffffffff  (&lt;unknown module&gt;)

Indirect leak of 112 byte(s) in 14 object(s) allocated from:
    #0 0x7f91436b7ffd in __interceptor_posix_memalign
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:145
    #1 0x7f9143523a85  (/lib/x86_64-linux-gnu/libmlx5.so.1+0x41a85)

Indirect leak of 72 byte(s) in 1 object(s) allocated from:
    #0 0x7f91436b83b7 in __interceptor_calloc
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x7f9143524bae  (/lib/x86_64-linux-gnu/libmlx5.so.1+0x42bae)
    #2 0x607000006f4f  (&lt;unknown module&gt;)


.... text removed for length


Indirect leak of 8 byte(s) in 1 object(s) allocated from:
    #0 0x7f91436b83b7 in __interceptor_calloc
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x7f914350f19e in mlx5dv_dr_domain_create
(/lib/x86_64-linux-gnu/libmlx5.so.1+0x2d19e)

SUMMARY: AddressSanitizer: 631608 byte(s) leaked in 5154 allocation(s).
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
?id=3D1694">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17440408530.bCD0.3877941--
