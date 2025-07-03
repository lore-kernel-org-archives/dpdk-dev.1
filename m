Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1A5C83F03
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 17:15:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07A7140267;
	Thu,  3 Jul 2025 19:15:06 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id C26A440267
 for <dev@dpdk.org>; Thu,  3 Jul 2025 19:15:04 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id B88E746AE7; Thu,  3 Jul 2025 19:15:04 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1745] bonding: duplicate shadow local variables
Date: Thu, 03 Jul 2025 17:15:04 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: unspecified
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
Message-ID: <bug-1745-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17515629040.dc6b.1313637
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


--17515629040.dc6b.1313637
Date: Thu, 3 Jul 2025 19:15:04 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1745

            Bug ID: 1745
           Summary: bonding: duplicate shadow local variables
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

Building with -Wshadow flags several potential bugs in bonding:

[963/3418] Compiling C object
drivers/libtmp_rte_net_bond.a.p/net_bonding_rte_eth_bond_pmd.c.o
../drivers/net/bonding/rte_eth_bond_pmd.c: In function =E2=80=98member_star=
t=E2=80=99:
../drivers/net/bonding/rte_eth_bond_pmd.c:1910:42: warning: declaration of
=E2=80=98internals=E2=80=99 shadows a previous local [-Wshadow]
 1910 |                 struct bond_dev_private *internals;
      |                                          ^~~~~~~~~
../drivers/net/bonding/rte_eth_bond_pmd.c:1828:34: note: shadowed declarati=
on
is here
 1828 |         struct bond_dev_private *internals =3D
bonding_eth_dev->data->dev_private;
      |                                  ^~~~~~~~~
../drivers/net/bonding/rte_eth_bond_pmd.c: In function
=E2=80=98bond_ethdev_allmulticast_disable=E2=80=99:
../drivers/net/bonding/rte_eth_bond_pmd.c:2914:34: warning: declaration of
=E2=80=98port_id=E2=80=99 shadows a previous local [-Wshadow]
 2914 |                         uint16_t port_id =3D
internals->members[i].port_id;
      |                                  ^~~~~~~
../drivers/net/bonding/rte_eth_bond_pmd.c:2903:18: note: shadowed declarati=
on
is here
 2903 |         uint16_t port_id;
      |                  ^~~~~~~
../drivers/net/bonding/rte_eth_bond_pmd.c: In function =E2=80=98bond_ethdev=
_configure=E2=80=99:
../drivers/net/bonding/rte_eth_bond_pmd.c:4111:26: warning: declaration of =
=E2=80=98i=E2=80=99
shadows a previous local [-Wshadow]
 4111 |                 unsigned i;
      |                          ^
../drivers/net/bonding/rte_eth_bond_pmd.c:3946:18: note: shadowed declarati=
on
is here
 3946 |         unsigned i, j;
      |

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17515629040.dc6b.1313637
Date: Thu, 3 Jul 2025 19:15:04 +0200
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
   title=3D"UNCONFIRMED - bonding: duplicate shadow local variables"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1745">1745</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>bonding: duplicate shadow local variables
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
          <pre class=3D"bz_comment_text">Building with -Wshadow flags sever=
al potential bugs in bonding:

[963/3418] Compiling C object
drivers/libtmp_rte_net_bond.a.p/net_bonding_rte_eth_bond_pmd.c.o
../drivers/net/bonding/rte_eth_bond_pmd.c: In function =E2=80=98member_star=
t=E2=80=99:
../drivers/net/bonding/rte_eth_bond_pmd.c:1910:42: warning: declaration of
=E2=80=98internals=E2=80=99 shadows a previous local [-Wshadow]
 1910 |                 struct bond_dev_private *internals;
      |                                          ^~~~~~~~~
../drivers/net/bonding/rte_eth_bond_pmd.c:1828:34: note: shadowed declarati=
on
is here
 1828 |         struct bond_dev_private *internals =3D
bonding_eth_dev-&gt;data-&gt;dev_private;
      |                                  ^~~~~~~~~
../drivers/net/bonding/rte_eth_bond_pmd.c: In function
=E2=80=98bond_ethdev_allmulticast_disable=E2=80=99:
../drivers/net/bonding/rte_eth_bond_pmd.c:2914:34: warning: declaration of
=E2=80=98port_id=E2=80=99 shadows a previous local [-Wshadow]
 2914 |                         uint16_t port_id =3D
internals-&gt;members[i].port_id;
      |                                  ^~~~~~~
../drivers/net/bonding/rte_eth_bond_pmd.c:2903:18: note: shadowed declarati=
on
is here
 2903 |         uint16_t port_id;
      |                  ^~~~~~~
../drivers/net/bonding/rte_eth_bond_pmd.c: In function =E2=80=98bond_ethdev=
_configure=E2=80=99:
../drivers/net/bonding/rte_eth_bond_pmd.c:4111:26: warning: declaration of =
=E2=80=98i=E2=80=99
shadows a previous local [-Wshadow]
 4111 |                 unsigned i;
      |                          ^
../drivers/net/bonding/rte_eth_bond_pmd.c:3946:18: note: shadowed declarati=
on
is here
 3946 |         unsigned i, j;
      |
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
?id=3D1745">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17515629040.dc6b.1313637--
