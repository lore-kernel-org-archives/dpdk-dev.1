Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35869CA0FED
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 23:01:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AB404029E;
	Thu, 28 Aug 2025 01:01:03 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 1363940298
 for <dev@dpdk.org>; Thu, 28 Aug 2025 01:01:02 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id E396046DE6; Thu, 28 Aug 2025 01:01:01 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1782] net/zxdh shadowed declarations
Date: Wed, 27 Aug 2025 23:01:00 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 25.07
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
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
Message-ID: <bug-1782-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17563356610.f4f77.3588626
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


--17563356610.f4f77.3588626
Date: Thu, 28 Aug 2025 01:01:01 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1782

            Bug ID: 1782
           Summary: net/zxdh shadowed declarations
           Product: DPDK
           Version: 25.07
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

Compiling DPDK with -Wshadow causes additional warnings about potential iss=
ues
caused by duplicate shadow declarations. One driver with issues is net/zxdh.

[1528/3627] Compiling C object
drivers/libtmp_rte_net_zxdh.a.p/net_zxdh_zxdh_msg.c.o
In file included from ../drivers/net/zxdh/zxdh_msg.h:14,
                 from ../drivers/net/zxdh/zxdh_msg.c:17:
../drivers/net/zxdh/zxdh_msg.c: In function =E2=80=98zxdh_add_vf_mac_table=
=E2=80=99:
../drivers/net/zxdh/zxdh_common.h:94:18: warning: declaration of =E2=80=98a=
ddr=E2=80=99 shadows
a previous local [-Wshadow]
   94 |         uint8_t *addr =3D ZXDH_ADDR_OF(typ, p, fld); \
      |                  ^~~~
../drivers/net/zxdh/zxdh_msg.c:1441:17: note: in expansion of macro =E2=80=
=98ZXDH_SET=E2=80=99
 1441 |                 ZXDH_SET(mac_reply_msg, mac_reply_msg_addr, mac_fla=
g,
ZXDH_EEXIST_MAC_FLAG);
      |                 ^~~~~~~~
../drivers/net/zxdh/zxdh_msg.c:1428:32: note: shadowed declaration is here
 1428 |         struct rte_ether_addr *addr =3D &mac_filter->mac;
      |                                ^~~~
../drivers/net/zxdh/zxdh_common.h:94:18: warning: declaration of =E2=80=98a=
ddr=E2=80=99 shadows
a previous local [-Wshadow]
   94 |         uint8_t *addr =3D ZXDH_ADDR_OF(typ, p, fld); \
      |                  ^~~~
../drivers/net/zxdh/zxdh_msg.c:1462:9: note: in expansion of macro =E2=80=
=98ZXDH_SET=E2=80=99
 1462 |         ZXDH_SET(msg_reply_body, reply_body, flag, ZXDH_REPS_SUCC);
      |         ^~~~~~~~
../drivers/net/zxdh/zxdh_msg.c:1428:32: note: shadowed declaration is here
 1428 |         struct rte_ether_addr *addr =3D &mac_filter->mac;
      |                                ^~~~
../drivers/net/zxdh/zxdh_common.h:94:18: warning: declaration of =E2=80=98a=
ddr=E2=80=99 shadows
a previous local [-Wshadow]
   94 |         uint8_t *addr =3D ZXDH_ADDR_OF(typ, p, fld); \
      |                  ^~~~
../drivers/net/zxdh/zxdh_msg.c:1468:9: note: in expansion of macro =E2=80=
=98ZXDH_SET=E2=80=99
 1468 |         ZXDH_SET(msg_reply_body, reply_body, flag, ZXDH_REPS_FAIL);
      |         ^~~~~~~~
../drivers/net/zxdh/zxdh_msg.c:1428:32: note: shadowed declaration is here
 1428 |         struct rte_ether_addr *addr =3D

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17563356610.f4f77.3588626
Date: Thu, 28 Aug 2025 01:01:01 +0200
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
   title=3D"UNCONFIRMED - net/zxdh shadowed declarations"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1782">1782</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>net/zxdh shadowed declarations
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>25.07
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
          <pre class=3D"bz_comment_text">Compiling DPDK with -Wshadow cause=
s additional warnings about potential issues
caused by duplicate shadow declarations. One driver with issues is net/zxdh.

[1528/3627] Compiling C object
drivers/libtmp_rte_net_zxdh.a.p/net_zxdh_zxdh_msg.c.o
In file included from ../drivers/net/zxdh/zxdh_msg.h:14,
                 from ../drivers/net/zxdh/zxdh_msg.c:17:
../drivers/net/zxdh/zxdh_msg.c: In function =E2=80=98zxdh_add_vf_mac_table=
=E2=80=99:
../drivers/net/zxdh/zxdh_common.h:94:18: warning: declaration of =E2=80=98a=
ddr=E2=80=99 shadows
a previous local [-Wshadow]
   94 |         uint8_t *addr =3D ZXDH_ADDR_OF(typ, p, fld); \
      |                  ^~~~
../drivers/net/zxdh/zxdh_msg.c:1441:17: note: in expansion of macro =E2=80=
=98ZXDH_SET=E2=80=99
 1441 |                 ZXDH_SET(mac_reply_msg, mac_reply_msg_addr, mac_fla=
g,
ZXDH_EEXIST_MAC_FLAG);
      |                 ^~~~~~~~
../drivers/net/zxdh/zxdh_msg.c:1428:32: note: shadowed declaration is here
 1428 |         struct rte_ether_addr *addr =3D &amp;mac_filter-&gt;mac;
      |                                ^~~~
../drivers/net/zxdh/zxdh_common.h:94:18: warning: declaration of =E2=80=98a=
ddr=E2=80=99 shadows
a previous local [-Wshadow]
   94 |         uint8_t *addr =3D ZXDH_ADDR_OF(typ, p, fld); \
      |                  ^~~~
../drivers/net/zxdh/zxdh_msg.c:1462:9: note: in expansion of macro =E2=80=
=98ZXDH_SET=E2=80=99
 1462 |         ZXDH_SET(msg_reply_body, reply_body, flag, ZXDH_REPS_SUCC);
      |         ^~~~~~~~
../drivers/net/zxdh/zxdh_msg.c:1428:32: note: shadowed declaration is here
 1428 |         struct rte_ether_addr *addr =3D &amp;mac_filter-&gt;mac;
      |                                ^~~~
../drivers/net/zxdh/zxdh_common.h:94:18: warning: declaration of =E2=80=98a=
ddr=E2=80=99 shadows
a previous local [-Wshadow]
   94 |         uint8_t *addr =3D ZXDH_ADDR_OF(typ, p, fld); \
      |                  ^~~~
../drivers/net/zxdh/zxdh_msg.c:1468:9: note: in expansion of macro =E2=80=
=98ZXDH_SET=E2=80=99
 1468 |         ZXDH_SET(msg_reply_body, reply_body, flag, ZXDH_REPS_FAIL);
      |         ^~~~~~~~
../drivers/net/zxdh/zxdh_msg.c:1428:32: note: shadowed declaration is here
 1428 |         struct rte_ether_addr *addr =3D
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
?id=3D1782">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17563356610.f4f77.3588626--
