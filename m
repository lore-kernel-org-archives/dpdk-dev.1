Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BA9CA0EE0
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 15:36:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5F8740ED4;
	Wed, 13 Aug 2025 17:36:17 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 82DCF40657
 for <dev@dpdk.org>; Wed, 13 Aug 2025 17:36:16 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 7120046D1A; Wed, 13 Aug 2025 17:36:16 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1771] [dpdk 23.11.5-rc1] drivers/net/cxgbe meson
 build failed on Fedora42 with gcc15.0.1
Date: Wed, 13 Aug 2025 15:36:16 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 23.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: stephen@networkplumber.org
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: WONTFIX
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: resolution bug_status cc
Message-ID: <bug-1771-3-duX3DtRZ5v@https.bugs.dpdk.org/>
In-Reply-To: <bug-1771-3@https.bugs.dpdk.org/>
References: <bug-1771-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17550993761.0D7E.267106
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


--17550993761.0D7E.267106
Date: Wed, 13 Aug 2025 17:36:16 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1771

Stephen Hemminger (stephen@networkplumber.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         Resolution|---                         |WONTFIX
             Status|UNCONFIRMED                 |RESOLVED
                 CC|                            |stephen@networkplumber.org

--- Comment #1 from Stephen Hemminger (stephen@networkplumber.org) ---
That is an old release. GCC 15 support was addressed in commit in main
which was not backported. Since version 23.11 pre-dates the release of that=
 OS
release, it is unreasonable to expect backport.

Use a later DPDK release please.

commit e0d947a1e6c2f80aa039a4f7082a8aa16797d8b9
Author: Ferruh Yigit <ferruh.yigit@amd.com>
Date:   Thu Oct 3 21:13:34 2024 -0700

    ethdev: convert string initialization

    gcc 15 experimental [1], with -Wextra flag, gives warning in variable
    initialization as string [2].

    The warning has a point when initialized variable is intended to use as
    string, since assignment is missing the required null terminator for
    this case. But warning is useless for our usecase.

    In this patch only updated a few instance to show the issue, there are
    many instances to fix, if we prefer to go this way.
    Other option is to disable warning but it can be useful for actual
    string usecases, so I prefer to keep it.

    Converted string initialization to array initialization.

    [1]
    gcc (GCC) 15.0.0 20241003 (experimental)

    [2]
    ../lib/ethdev/rte_flow.h:906:36:
      error: initializer-string for array of =E2=80=98unsigned char=E2=80=
=99 is too long
            [-Werror=3Dunterminated-string-initialization]
    906 |         .hdr.dst_addr.addr_bytes =3D "\xff\xff\xff\xff\xff\xff",
        |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~

    ../lib/ethdev/rte_flow.h:907:36:
      error: initializer-string for array of =E2=80=98unsigned char=E2=80=
=99 is too long
             [-Werror=3Dunterminated-string-initialization]
    907 |         .hdr.src_addr.addr_bytes =3D "\xff\xff\xff\xff\xff\xff",
        |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~

    ../lib/ethdev/rte_flow.h:1009:25:
      error: initializer-string for array of =E2=80=98unsigned char=E2=80=
=99 is too long
             [-Werror=3Dunterminated-string-initialization]
    1009 |                         "\xff\xff\xff\xff\xff\xff\xff\xff"
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    ../lib/ethdev/rte_flow.h:1012:25:
      error: initializer-string for array of =E2=80=98unsigned char=E2=80=
=99 is too long
             [-Werror=3Dunterminated-string-initialization]
    1012 |                         "\xff\xff\xff\xff\xff\xff\xff\xff"
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    ../lib/ethdev/rte_flow.h:1135:20:
      error: initializer-string for array of =E2=80=98unsigned char=E2=80=
=99 is too long
             [-Werror=3Dunterminated-string-initialization]
    1135 |         .hdr.vni =3D "\xff\xff\xff",
         |                    ^~~~~~~~~~~~~~

    Signed-off-by: Ferruh Yigit <ferruh.yigit@amd.com>

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17550993761.0D7E.267106
Date: Wed, 13 Aug 2025 17:36:16 +0200
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
    <body><span class=3D"vcard"><a class=3D"email" href=3D"mailto:stephen&#=
64;networkplumber.org" title=3D"Stephen Hemminger (stephen&#64;networkplumb=
er.org)"> <span class=3D"fn">Stephen Hemminger</span></a>
</span> changed
          <a class=3D"bz_bug_link=20
          bz_status_RESOLVED  bz_closed"
   title=3D"RESOLVED WONTFIX - [dpdk 23.11.5-rc1] drivers/net/cxgbe meson b=
uild failed on Fedora42 with gcc15.0.1"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1771">bug 1771</a>
          <br>
             <table border=3D"1" cellspacing=3D"0" cellpadding=3D"8" class=
=3D"bz_diff_table">
          <tr>
            <th>What</th>
            <th>Removed</th>
            <th>Added</th>
          </tr>

         <tr>
           <td style=3D"text-align:right;">Resolution</td>
           <td>---
           </td>
           <td>WONTFIX
           </td>
         </tr>

         <tr>
           <td style=3D"text-align:right;">Status</td>
           <td>UNCONFIRMED
           </td>
           <td>RESOLVED
           </td>
         </tr>

         <tr>
           <td style=3D"text-align:right;">CC</td>
           <td>
               &nbsp;
           </td>
           <td>stephen&#64;networkplumber.org
           </td>
         </tr></table>
      <p>
        <div class=3D"bz_comment_block">
            <b class=3D"bz_comment_head"><a class=3D"bz_bug_link=20
          bz_status_RESOLVED  bz_closed"
   title=3D"RESOLVED WONTFIX - [dpdk 23.11.5-rc1] drivers/net/cxgbe meson b=
uild failed on Fedora42 with gcc15.0.1"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1771#c1">Comment # 1</a>
              on <a class=3D"bz_bug_link=20
          bz_status_RESOLVED  bz_closed"
   title=3D"RESOLVED WONTFIX - [dpdk 23.11.5-rc1] drivers/net/cxgbe meson b=
uild failed on Fedora42 with gcc15.0.1"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1771">bug 1771</a>
              from <span class=3D"vcard"><a class=3D"email" href=3D"mailto:=
stephen&#64;networkplumber.org" title=3D"Stephen Hemminger (stephen&#64;net=
workplumber.org)"> <span class=3D"fn">Stephen Hemminger</span></a>
</span>
            </b>
          <pre class=3D"bz_comment_text">That is an old release. GCC 15 sup=
port was addressed in commit in main
which was not backported. Since version 23.11 pre-dates the release of that=
 OS
release, it is unreasonable to expect backport.

Use a later DPDK release please.

commit e0d947a1e6c2f80aa039a4f7082a8aa16797d8b9
Author: Ferruh Yigit &lt;<a href=3D"mailto:ferruh.yigit&#64;amd.com">ferruh=
.yigit&#64;amd.com</a>&gt;
Date:   Thu Oct 3 21:13:34 2024 -0700

    ethdev: convert string initialization

    gcc 15 experimental [1], with -Wextra flag, gives warning in variable
    initialization as string [2].

    The warning has a point when initialized variable is intended to use as
    string, since assignment is missing the required null terminator for
    this case. But warning is useless for our usecase.

    In this patch only updated a few instance to show the issue, there are
    many instances to fix, if we prefer to go this way.
    Other option is to disable warning but it can be useful for actual
    string usecases, so I prefer to keep it.

    Converted string initialization to array initialization.

    [1]
    gcc (GCC) 15.0.0 20241003 (experimental)

    [2]
    ../lib/ethdev/rte_flow.h:906:36:
      error: initializer-string for array of =E2=80=98unsigned char=E2=80=
=99 is too long
            [-Werror=3Dunterminated-string-initialization]
    906 |         .hdr.dst_addr.addr_bytes =3D &quot;\xff\xff\xff\xff\xff\x=
ff&quot;,
        |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~

    ../lib/ethdev/rte_flow.h:907:36:
      error: initializer-string for array of =E2=80=98unsigned char=E2=80=
=99 is too long
             [-Werror=3Dunterminated-string-initialization]
    907 |         .hdr.src_addr.addr_bytes =3D &quot;\xff\xff\xff\xff\xff\x=
ff&quot;,
        |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~

    ../lib/ethdev/rte_flow.h:1009:25:
      error: initializer-string for array of =E2=80=98unsigned char=E2=80=
=99 is too long
             [-Werror=3Dunterminated-string-initialization]
    1009 |                         &quot;\xff\xff\xff\xff\xff\xff\xff\xff&q=
uot;
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    ../lib/ethdev/rte_flow.h:1012:25:
      error: initializer-string for array of =E2=80=98unsigned char=E2=80=
=99 is too long
             [-Werror=3Dunterminated-string-initialization]
    1012 |                         &quot;\xff\xff\xff\xff\xff\xff\xff\xff&q=
uot;
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    ../lib/ethdev/rte_flow.h:1135:20:
      error: initializer-string for array of =E2=80=98unsigned char=E2=80=
=99 is too long
             [-Werror=3Dunterminated-string-initialization]
    1135 |         .hdr.vni =3D &quot;\xff\xff\xff&quot;,
         |                    ^~~~~~~~~~~~~~

    Signed-off-by: Ferruh Yigit &lt;<a href=3D"mailto:ferruh.yigit&#64;amd.=
com">ferruh.yigit&#64;amd.com</a>&gt;
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
?id=3D1771#c1">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17550993761.0D7E.267106--
