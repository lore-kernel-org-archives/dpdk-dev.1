Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F975C83013
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 08:02:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0724B40285;
	Wed,  2 Jul 2025 10:02:45 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 33E5B40269
 for <dev@dpdk.org>; Wed,  2 Jul 2025 10:02:44 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 2C0BC46AD0; Wed,  2 Jul 2025 10:02:44 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: =?UTF-8?B?W0RQREsvbWVzb24gQnVnIDE3MzZdIGJ1aWxkaW5nIERQREsgW3Yy?=
 =?UTF-8?B?NS4wNy1yYzJdIGVycm9yOiBpbmxpbmluZyBmYWlsZWQgaW4gY2FsbCB0byBh?=
 =?UTF-8?B?bHdheXNfaW5saW5lIOKAmF9tbTUxMl9jbG11bGVwaTY0X2VwaTEyOOKAmTog?=
 =?UTF-8?B?dGFyZ2V0IHNwZWNpZmljIG9wdGlvbiBtaXNtYXRjaCAgX21tNTEyX2NsbXVs?=
 =?UTF-8?B?ZXBpNjRfZXBpMTI4IChfX201MTJpIF9fQSwgX19tNTEyaSBfX0IsIGNvbnN0?=
 =?UTF-8?B?IGludCBfX0Mp?=
Date: Wed, 02 Jul 2025 08:02:43 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: meson
X-Bugzilla-Version: 25.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: 14pwcse1224@uetpeshawar.edu.pk
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1736-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17514433640.A3d3B9d5b.333487
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


--17514433640.A3d3B9d5b.333487
Date: Wed, 2 Jul 2025 10:02:43 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1736

            Bug ID: 1736
           Summary: building DPDK [v25.07-rc2] error: inlining failed in
                    call to always_inline =E2=80=98_mm512_clmulepi64_epi128=
=E2=80=99:
                    target specific option mismatch
                    _mm512_clmulepi64_epi128 (__m512i __A, __m512i __B,
                    const int __C)
           Product: DPDK
           Version: 25.03
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: meson
          Assignee: dev@dpdk.org
          Reporter: 14pwcse1224@uetpeshawar.edu.pk
  Target Milestone: ---

/usr/lib/gcc/x86_64-redhat-linux/8/include/avx512fintrin.h:1579:1: error:
inlining failed in call to always_inline =E2=80=98_mm512_ternarylogic_epi64=
=E2=80=99: target
specific option mismatch
 _mm512_ternarylogic_epi64 (__m512i __A, __m512i __B, __m512i __C,
 ^~~~~~~~~~~~~~~~~~~~~~~~~
../lib/net/net_crc_avx512.c:56:9: note: called from here
  return _mm512_ternarylogic_epi64(tmp0, tmp1, data_block, 0x96);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from
/usr/lib/gcc/x86_64-redhat-linux/8/include/immintrin.h:111,
                 from
/usr/lib/gcc/x86_64-redhat-linux/8/include/x86intrin.h:48,
                 from ../lib/eal/x86/include/rte_vect.h:24,
                 from ../lib/net/net_crc_avx512.c:8:
/usr/lib/gcc/x86_64-redhat-linux/8/include/vpclmulqdqintrin.h:40:1: error:
inlining failed in call to always_inline =E2=80=98_mm512_clmulepi64_epi128=
=E2=80=99: target
specific option mismatch
 _mm512_clmulepi64_epi128 (__m512i __A, __m512i __B, const int __C)
 ^~~~~~~~~~~~~~~~~~~~~~~~
../lib/net/net_crc_avx512.c:54:9: note: called from here
  tmp1 =3D _mm512_clmulepi64_epi128(fold, precomp, 0x10);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from
/usr/lib/gcc/x86_64-redhat-linux/8/include/immintrin.h:111,
                 from
/usr/lib/gcc/x86_64-redhat-linux/8/include/x86intrin.h:48,
                 from ../lib/eal/x86/include/rte_vect.h:24,
                 from ../lib/net/net_crc_avx512.c:8:
/usr/lib/gcc/x86_64-redhat-linux/8/include/vpclmulqdqintrin.h:40:1: error:
inlining failed in call to always_inline =E2=80=98_mm512_clmulepi64_epi128=
=E2=80=99: target
specific option mismatch
 _mm512_clmulepi64_epi128 (__m512i __A, __m512i __B, const int __C)
 ^~~~~~~~~~~~~~~~~~~~~~~~
../lib/net/net_crc_avx512.c:53:9: note: called from here
  tmp0 =3D _mm512_clmulepi64_epi128(fold, precomp, 0x01);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[142/3483] Compiling C object lib/librte_ethdev.a.p/ethdev_rte_ethdev.c.o
ninja: build stopped: subcommand failed.

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17514433640.A3d3B9d5b.333487
Date: Wed, 2 Jul 2025 10:02:44 +0200
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
   title=3D"UNCONFIRMED - building DPDK [v25.07-rc2] error: inlining failed=
 in call to always_inline =E2=80=98_mm512_clmulepi64_epi128=E2=80=99: targe=
t specific option mismatch _mm512_clmulepi64_epi128 (__m512i __A, __m512i _=
_B, const int __C)"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1736">1736</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>building DPDK [v25.07-rc2] error: inlining failed in call to =
always_inline =E2=80=98_mm512_clmulepi64_epi128=E2=80=99: target specific o=
ption mismatch  _mm512_clmulepi64_epi128 (__m512i __A, __m512i __B, const i=
nt __C)
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
          <td>meson
          </td>
        </tr>

        <tr>
          <th>Assignee</th>
          <td>dev&#64;dpdk.org
          </td>
        </tr>

        <tr>
          <th>Reporter</th>
          <td>14pwcse1224&#64;uetpeshawar.edu.pk
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">/usr/lib/gcc/x86_64-redhat-linux/8=
/include/avx512fintrin.h:1579:1: error:
inlining failed in call to always_inline =E2=80=98_mm512_ternarylogic_epi64=
=E2=80=99: target
specific option mismatch
 _mm512_ternarylogic_epi64 (__m512i __A, __m512i __B, __m512i __C,
 ^~~~~~~~~~~~~~~~~~~~~~~~~
../lib/net/net_crc_avx512.c:56:9: note: called from here
  return _mm512_ternarylogic_epi64(tmp0, tmp1, data_block, 0x96);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from
/usr/lib/gcc/x86_64-redhat-linux/8/include/immintrin.h:111,
                 from
/usr/lib/gcc/x86_64-redhat-linux/8/include/x86intrin.h:48,
                 from ../lib/eal/x86/include/rte_vect.h:24,
                 from ../lib/net/net_crc_avx512.c:8:
/usr/lib/gcc/x86_64-redhat-linux/8/include/vpclmulqdqintrin.h:40:1: error:
inlining failed in call to always_inline =E2=80=98_mm512_clmulepi64_epi128=
=E2=80=99: target
specific option mismatch
 _mm512_clmulepi64_epi128 (__m512i __A, __m512i __B, const int __C)
 ^~~~~~~~~~~~~~~~~~~~~~~~
../lib/net/net_crc_avx512.c:54:9: note: called from here
  tmp1 =3D _mm512_clmulepi64_epi128(fold, precomp, 0x10);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from
/usr/lib/gcc/x86_64-redhat-linux/8/include/immintrin.h:111,
                 from
/usr/lib/gcc/x86_64-redhat-linux/8/include/x86intrin.h:48,
                 from ../lib/eal/x86/include/rte_vect.h:24,
                 from ../lib/net/net_crc_avx512.c:8:
/usr/lib/gcc/x86_64-redhat-linux/8/include/vpclmulqdqintrin.h:40:1: error:
inlining failed in call to always_inline =E2=80=98_mm512_clmulepi64_epi128=
=E2=80=99: target
specific option mismatch
 _mm512_clmulepi64_epi128 (__m512i __A, __m512i __B, const int __C)
 ^~~~~~~~~~~~~~~~~~~~~~~~
../lib/net/net_crc_avx512.c:53:9: note: called from here
  tmp0 =3D _mm512_clmulepi64_epi128(fold, precomp, 0x01);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[142/3483] Compiling C object lib/librte_ethdev.a.p/ethdev_rte_ethdev.c.o
ninja: build stopped: subcommand failed.
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
?id=3D1736">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17514433640.A3d3B9d5b.333487--
