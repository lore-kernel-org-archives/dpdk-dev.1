Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C958CC36002
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Mar 2025 09:00:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD2BB40655;
	Mon, 24 Mar 2025 10:00:58 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id BA552402DA
 for <dev@dpdk.org>; Mon, 24 Mar 2025 10:00:56 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 92BE346465; Mon, 24 Mar 2025 10:00:56 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1679] rte_ipv6_hdr.version is encoded in the wrong
 byte on little-endian platforms
Date: Mon, 24 Mar 2025 09:00:55 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 24.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: maxime@leroys.fr
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone attachments.created
Message-ID: <bug-1679-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17428068560.Fe374f.3283473
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


--17428068560.Fe374f.3283473
Date: Mon, 24 Mar 2025 10:00:56 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1679

            Bug ID: 1679
           Summary: rte_ipv6_hdr.version is encoded in the wrong byte on
                    little-endian platforms
           Product: DPDK
           Version: 24.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: maxime@leroys.fr
  Target Milestone: ---

Created attachment 304
  --> https://bugs.dpdk.org/attachment.cgi?id=3D304&action=3Dedit
patch to reproduce the issue with testpmd

When setting the version field in a struct rte_ipv6_hdr, the compiler-gener=
ated
code stores the value in the wrong byte of the vtc_flow field on little-end=
ian
architectures such as x86_64. As a result, the encoded IPv6 version value is
not in the expected network byte order, and version checks (such as
rte_ipv6_check_version()) fail.

I encountered this issue while writing new unit tests for the DPDK Grout
project, which exposed the incorrect version encoding. The issue is
reproducible with GCC 13 and 14 and Clang 15, 16, and 18 on Ubuntu 24.04
(x86_64), but it does not reproduce on ARM.

Example output with the patch provided:

$ ./build/app/dpdk-testpmd
version is bad
0 0 0 60

This suggests that 0x60 (i.e., version =3D 6) is incorrectly stored in the =
4th
byte of vtc_flow (i.e., ((uint8_t *)&vtc_flow)[3]), whereas the 1st byte ([=
0],
the MSB in network byte order) should hold the version field.

Assembly dump with objdump:

memset(&ip, 0, sizeof(ip));
movzbl -0x9d(%rbp), %eax  ; =E2=86=90 accesses byte offset +3 from ip
and    $0xf, %eax
or     $0x60, %eax
mov    %al, -0x9d(%rbp)   ; =E2=86=90 stores version into 4th byte

If ip is located at -0xa0(%rbp), then the offset -0x9d(%rbp) corresponds to
byte 3 (i.e., ip + 3).
But the version field should be encoded in the first byte (ip + 0) to follow
network byte order.


This problem appears since we added bitfield for the version field in
rte_ipv6_hdr in : https://git.dpdk.org/dpdk/commit/?id=3Dcba27998dc8

The behavior of bitfield layout in C is implementation-defined, as stated in
WG14/N1256 (C99 draft standard), section 6.7.2.1, paragraphs 10 and 11:

    =E2=80=9CThe order of allocation of bit-fields within a unit (high-orde=
r to
low-order or low-order to high-order) is implementation-defined.=E2=80=9D

Grout PR demonstrating the issue:
- https://github.com/DPDK/grout/pull/189

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17428068560.Fe374f.3283473
Date: Mon, 24 Mar 2025 10:00:56 +0100
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
   title=3D"UNCONFIRMED - rte_ipv6_hdr.version is encoded in the wrong byte=
 on little-endian platforms"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1679">1679</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>rte_ipv6_hdr.version is encoded in the wrong byte on little-e=
ndian platforms
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
          <td>maxime&#64;leroys.fr
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
=3D"attachment.cgi?id=3D304" name=3D"attach_304" title=3D"patch to reproduc=
e the issue with testpmd">attachment 304</a> <a href=3D"attachment.cgi?id=
=3D304&amp;action=3Dedit" title=3D"patch to reproduce the issue with testpm=
d">[details]</a></span>
patch to reproduce the issue with testpmd

When setting the version field in a struct rte_ipv6_hdr, the compiler-gener=
ated
code stores the value in the wrong byte of the vtc_flow field on little-end=
ian
architectures such as x86_64. As a result, the encoded IPv6 version value is
not in the expected network byte order, and version checks (such as
rte_ipv6_check_version()) fail.

I encountered this issue while writing new unit tests for the DPDK Grout
project, which exposed the incorrect version encoding. The issue is
reproducible with GCC 13 and 14 and Clang 15, 16, and 18 on Ubuntu 24.04
(x86_64), but it does not reproduce on ARM.

Example output with the patch provided:

$ ./build/app/dpdk-testpmd
version is bad
0 0 0 60

This suggests that 0x60 (i.e., version =3D 6) is incorrectly stored in the =
4th
byte of vtc_flow (i.e., ((uint8_t *)&amp;vtc_flow)[3]), whereas the 1st byt=
e ([0],
the MSB in network byte order) should hold the version field.

Assembly dump with objdump:

memset(&amp;ip, 0, sizeof(ip));
movzbl -0x9d(%rbp), %eax  ; =E2=86=90 accesses byte offset +3 from ip
and    $0xf, %eax
or     $0x60, %eax
mov    %al, -0x9d(%rbp)   ; =E2=86=90 stores version into 4th byte

If ip is located at -0xa0(%rbp), then the offset -0x9d(%rbp) corresponds to
byte 3 (i.e., ip + 3).
But the version field should be encoded in the first byte (ip + 0) to follow
network byte order.


This problem appears since we added bitfield for the version field in
rte_ipv6_hdr in : <a href=3D"https://git.dpdk.org/dpdk/commit/?id=3Dcba2799=
8dc8">https://git.dpdk.org/dpdk/commit/?id=3Dcba27998dc8</a>

The behavior of bitfield layout in C is implementation-defined, as stated in
WG14/N1256 (C99 draft standard), section 6.7.2.1, paragraphs 10 and 11:

    =E2=80=9CThe order of allocation of bit-fields within a unit (high-orde=
r to
low-order or low-order to high-order) is implementation-defined.=E2=80=9D

Grout PR demonstrating the issue:
- <a href=3D"https://github.com/DPDK/grout/pull/189">https://github.com/DPD=
K/grout/pull/189</a>
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
?id=3D1679">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17428068560.Fe374f.3283473--
