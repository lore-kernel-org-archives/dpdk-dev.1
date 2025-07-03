Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1BBC83F03
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 17:06:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA5D140267;
	Thu,  3 Jul 2025 19:06:17 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 08EFB40264
 for <dev@dpdk.org>; Thu,  3 Jul 2025 19:06:16 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 0292C46AE8; Thu,  3 Jul 2025 19:06:16 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1743] malloc: duplicate shadowed variable definition
Date: Thu, 03 Jul 2025 17:06:16 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: minor
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
Message-ID: <bug-1743-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17515623750.dB4b56c.1309387
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


--17515623750.dB4b56c.1309387
Date: Thu, 3 Jul 2025 19:06:15 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1743

            Bug ID: 1743
           Summary: malloc: duplicate shadowed variable definition
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: minor
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

Building with -Wshadow reports:

[51/3418] Compiling C object lib/librte_eal.a.p/eal_common_malloc_heap.c.o
../lib/eal/common/malloc_heap.c: In function =E2=80=98malloc_heap_free=E2=
=80=99:
../lib/eal/common/malloc_heap.c:1047:23: warning: declaration of =E2=80=98a=
ligned_end=E2=80=99
shadows a previous local [-Wshadow]
 1047 |                 void *aligned_end =3D RTE_PTR_ADD(aligned_start,
aligned_len);
      |                       ^~~~~~~~~~~
../lib/eal/common/malloc_heap.c:862:45: note: shadowed declaration is here
  862 |         void *start, *aligned_start, *end, *aligned_end;
      |                                             ^~~~~~~~~~~

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17515623750.dB4b56c.1309387
Date: Thu, 3 Jul 2025 19:06:15 +0200
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
   title=3D"UNCONFIRMED - malloc: duplicate shadowed variable definition"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1743">1743</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>malloc: duplicate shadowed variable definition
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
          <td>minor
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
          <td>stephen&#64;networkplumber.org
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">Building with -Wshadow reports:

[51/3418] Compiling C object lib/librte_eal.a.p/eal_common_malloc_heap.c.o
../lib/eal/common/malloc_heap.c: In function =E2=80=98malloc_heap_free=E2=
=80=99:
../lib/eal/common/malloc_heap.c:1047:23: warning: declaration of =E2=80=98a=
ligned_end=E2=80=99
shadows a previous local [-Wshadow]
 1047 |                 void *aligned_end =3D RTE_PTR_ADD(aligned_start,
aligned_len);
      |                       ^~~~~~~~~~~
../lib/eal/common/malloc_heap.c:862:45: note: shadowed declaration is here
  862 |         void *start, *aligned_start, *end, *aligned_end;
      |                                             ^~~~~~~~~~~
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
?id=3D1743">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17515623750.dB4b56c.1309387--
