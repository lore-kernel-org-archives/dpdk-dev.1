Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C90C77B7C
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 17:19:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4DF040267;
	Thu,  3 Jul 2025 19:19:23 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id C0D2D40264
 for <dev@dpdk.org>; Thu,  3 Jul 2025 19:19:22 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id B791746AE8; Thu,  3 Jul 2025 19:19:22 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1746] mlx5: lotsof shadow varable warnings
Date: Thu, 03 Jul 2025 17:19:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
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
Message-ID: <bug-1746-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17515631620.faada6F2.1315469
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


--17515631620.faada6F2.1315469
Date: Thu, 3 Jul 2025 19:19:22 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1746

            Bug ID: 1746
           Summary: mlx5: lotsof shadow varable warnings
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: minor
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

Building with -Wshadow reports several potential issues with mlx5 driver.

[1123/3418] Compiling C object
drivers/libtmp_rte_net_mlx5.a.p/net_mlx5_mlx5_rss.c.o
In file included from ../drivers/net/mlx5/mlx5_rss.c:19:
../drivers/net/mlx5/mlx5_rx.h: In function =E2=80=98mprq_buf_replace=E2=80=
=99:
../drivers/net/mlx5/mlx5_rx.h:448:39: warning: declaration of =E2=80=98rep=
=E2=80=99 shadows a
previous local [-Wshadow]
  448 |                 struct mlx5_mprq_buf *rep;
      |                                       ^~~
../drivers/net/mlx5/mlx5_rx.h:424:31: note: shadowed declaration is here
  424 |         struct mlx5_mprq_buf *rep =3D rxq->mprq_repl;
      |                               ^~~
[1124/3418] Compiling C object
drivers/libtmp_rte_net_mlx5.a.p/net_mlx5_mlx5_ethdev.c.o
In file included from ../drivers/net/mlx5/mlx5_ethdev.c:26:
../drivers/net/mlx5/mlx5_rx.h: In function =E2=80=98mprq_buf_replace=E2=80=
=99:
../drivers/net/mlx5/mlx5_rx.h:448:39: warning: declaration of =E2=80=98rep=
=E2=80=99 shadows a
previous local [-Wshadow]
  448 |                 struct mlx5_mprq_buf *rep;
      |                                       ^~~
../drivers/net/mlx5/mlx5_rx.h:424:31: note: shadowed declaration is here
  424 |         struct mlx5_mprq_buf *rep =3D rxq->mprq_repl;
      |                               ^~~
In file included from ../lib/eal/include/dev_driver.h:8,
                 from ../lib/ethdev/ethdev_driver.h:19,
                 from ../drivers/net/mlx5/mlx5_ethdev.c:13:
../drivers/net/mlx5/mlx5_tx.h: In function =E2=80=98mlx5_tx_burst_empw_inli=
ne=E2=80=99:
../lib/eal/include/rte_common.h:817:28: warning: declaration of =E2=80=98_a=
=E2=80=99 shadows a
previous local [-Wshadow]
  817 |                 typeof (a) _a =3D (a); \
      |                            ^~
../lib/eal/include/rte_common.h:798:25: note: in definition of macro =E2=80=
=98RTE_MIN=E2=80=99
  798 |                 typeof (b) _b =3D (b); \
      |                         ^
../drivers/net/mlx5/mlx5_tx.h:2971:40: note: in expansion of macro =E2=80=
=98RTE_MAX=E2=80=99
 2971 |                                        RTE_MAX(txq->inlen_empw +
      |                                        ^~~~~~~
../lib/eal/include/rte_common.h:797:28: note: shadowed declaration is here
  797 |                 typeof (a) _a =3D (a); \
      |                            ^~
../drivers/net/mlx5/mlx5_tx.h:2970:32: note: in expansion of macro =E2=80=
=98RTE_MIN=E2=80=99
 2970 |                         room =3D RTE_MIN(room,
      |                                ^~~~~~~
../lib/eal/include/rte_common.h:817:28: warning: declaration of =E2=80=98_a=
=E2=80=99 shadows a
previous local [-Wshadow]
  817 |                 typeof (a) _a =3D (a); \
      |                            ^~
../lib/eal/include/rte_common.h:798:34: note: in definition of macro =E2=80=
=98RTE_MIN=E2=80=99
  798 |                 typeof (b) _b =3D (b); \
      |                                  ^
../drivers/net/mlx5/mlx5_tx.h:2971:40: note: in expansion of macro =E2=80=
=98RTE_MAX=E2=80=99
 2971 |                                        RTE_MAX(txq->inlen_empw +
      |                                        ^~~~~~~
../lib/eal/include/rte_common.h:797:28: note: shadowed declaration is here
  797 |                 typeof (a) _a =3D (a); \
      |                            ^~
../drivers/net/mlx5/mlx5_tx.h:2970:32: note: in expansion of macro =E2=80=
=98RTE_MIN=E2=80=99
 2970 |                         room =3D RTE_MIN(room,
      |                                ^~~~~~~
../lib/eal/include/rte_common.h:818:28: warning: declaration of =E2=80=98_b=
=E2=80=99 shadows a
previous local [-Wshadow]
  818 |                 typeof (b) _b =3D (b); \
      |                            ^~
../lib/eal/include/rte_common.h:798:34: note: in definition of macro =E2=80=
=98RTE_MIN=E2=80=99
  798 |                 typeof (b) _b =3D (b); \
      |                                  ^
../drivers/net/mlx5/mlx5_tx.h:2971:40: note: in expansion of macro =E2=80=
=98RTE_MAX=E2=80=99
 2971 |                                        RTE_MAX(txq->inlen_empw +
      |                                        ^~~~~~~
../lib/eal/include/rte_common.h:798:28: note: shadowed declaration is here
  798 |                 typeof (b) _b =3D (b); \
      |                            ^~
../drivers/net/mlx5/mlx5_tx.h:2970:32: note: in expansion of macro =E2=80=
=98RTE_MIN=E2=80=99
 2970 |                         room =3D RTE_MIN(room,
      |                                ^~~~~~~

...
Truncated because bugzilla can't take all of it.

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17515631620.faada6F2.1315469
Date: Thu, 3 Jul 2025 19:19:22 +0200
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
   title=3D"UNCONFIRMED - mlx5: lotsof shadow varable warnings"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1746">1746</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>mlx5: lotsof shadow varable warnings
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
          <pre class=3D"bz_comment_text">Building with -Wshadow reports sev=
eral potential issues with mlx5 driver.

[1123/3418] Compiling C object
drivers/libtmp_rte_net_mlx5.a.p/net_mlx5_mlx5_rss.c.o
In file included from ../drivers/net/mlx5/mlx5_rss.c:19:
../drivers/net/mlx5/mlx5_rx.h: In function =E2=80=98mprq_buf_replace=E2=80=
=99:
../drivers/net/mlx5/mlx5_rx.h:448:39: warning: declaration of =E2=80=98rep=
=E2=80=99 shadows a
previous local [-Wshadow]
  448 |                 struct mlx5_mprq_buf *rep;
      |                                       ^~~
../drivers/net/mlx5/mlx5_rx.h:424:31: note: shadowed declaration is here
  424 |         struct mlx5_mprq_buf *rep =3D rxq-&gt;mprq_repl;
      |                               ^~~
[1124/3418] Compiling C object
drivers/libtmp_rte_net_mlx5.a.p/net_mlx5_mlx5_ethdev.c.o
In file included from ../drivers/net/mlx5/mlx5_ethdev.c:26:
../drivers/net/mlx5/mlx5_rx.h: In function =E2=80=98mprq_buf_replace=E2=80=
=99:
../drivers/net/mlx5/mlx5_rx.h:448:39: warning: declaration of =E2=80=98rep=
=E2=80=99 shadows a
previous local [-Wshadow]
  448 |                 struct mlx5_mprq_buf *rep;
      |                                       ^~~
../drivers/net/mlx5/mlx5_rx.h:424:31: note: shadowed declaration is here
  424 |         struct mlx5_mprq_buf *rep =3D rxq-&gt;mprq_repl;
      |                               ^~~
In file included from ../lib/eal/include/dev_driver.h:8,
                 from ../lib/ethdev/ethdev_driver.h:19,
                 from ../drivers/net/mlx5/mlx5_ethdev.c:13:
../drivers/net/mlx5/mlx5_tx.h: In function =E2=80=98mlx5_tx_burst_empw_inli=
ne=E2=80=99:
../lib/eal/include/rte_common.h:817:28: warning: declaration of =E2=80=98_a=
=E2=80=99 shadows a
previous local [-Wshadow]
  817 |                 typeof (a) _a =3D (a); \
      |                            ^~
../lib/eal/include/rte_common.h:798:25: note: in definition of macro =E2=80=
=98RTE_MIN=E2=80=99
  798 |                 typeof (b) _b =3D (b); \
      |                         ^
../drivers/net/mlx5/mlx5_tx.h:2971:40: note: in expansion of macro =E2=80=
=98RTE_MAX=E2=80=99
 2971 |                                        RTE_MAX(txq-&gt;inlen_empw +
      |                                        ^~~~~~~
../lib/eal/include/rte_common.h:797:28: note: shadowed declaration is here
  797 |                 typeof (a) _a =3D (a); \
      |                            ^~
../drivers/net/mlx5/mlx5_tx.h:2970:32: note: in expansion of macro =E2=80=
=98RTE_MIN=E2=80=99
 2970 |                         room =3D RTE_MIN(room,
      |                                ^~~~~~~
../lib/eal/include/rte_common.h:817:28: warning: declaration of =E2=80=98_a=
=E2=80=99 shadows a
previous local [-Wshadow]
  817 |                 typeof (a) _a =3D (a); \
      |                            ^~
../lib/eal/include/rte_common.h:798:34: note: in definition of macro =E2=80=
=98RTE_MIN=E2=80=99
  798 |                 typeof (b) _b =3D (b); \
      |                                  ^
../drivers/net/mlx5/mlx5_tx.h:2971:40: note: in expansion of macro =E2=80=
=98RTE_MAX=E2=80=99
 2971 |                                        RTE_MAX(txq-&gt;inlen_empw +
      |                                        ^~~~~~~
../lib/eal/include/rte_common.h:797:28: note: shadowed declaration is here
  797 |                 typeof (a) _a =3D (a); \
      |                            ^~
../drivers/net/mlx5/mlx5_tx.h:2970:32: note: in expansion of macro =E2=80=
=98RTE_MIN=E2=80=99
 2970 |                         room =3D RTE_MIN(room,
      |                                ^~~~~~~
../lib/eal/include/rte_common.h:818:28: warning: declaration of =E2=80=98_b=
=E2=80=99 shadows a
previous local [-Wshadow]
  818 |                 typeof (b) _b =3D (b); \
      |                            ^~
../lib/eal/include/rte_common.h:798:34: note: in definition of macro =E2=80=
=98RTE_MIN=E2=80=99
  798 |                 typeof (b) _b =3D (b); \
      |                                  ^
../drivers/net/mlx5/mlx5_tx.h:2971:40: note: in expansion of macro =E2=80=
=98RTE_MAX=E2=80=99
 2971 |                                        RTE_MAX(txq-&gt;inlen_empw +
      |                                        ^~~~~~~
../lib/eal/include/rte_common.h:798:28: note: shadowed declaration is here
  798 |                 typeof (b) _b =3D (b); \
      |                            ^~
../drivers/net/mlx5/mlx5_tx.h:2970:32: note: in expansion of macro =E2=80=
=98RTE_MIN=E2=80=99
 2970 |                         room =3D RTE_MIN(room,
      |                                ^~~~~~~

...
Truncated because bugzilla can't take all of it.
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
?id=3D1746">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17515631620.faada6F2.1315469--
