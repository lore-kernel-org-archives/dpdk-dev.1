Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CF4C7115C
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Jun 2025 13:11:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC71242EF2;
	Fri, 20 Jun 2025 15:11:35 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id AA537402F2
 for <dev@dpdk.org>; Fri, 20 Jun 2025 15:11:34 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id A0E1846A0E; Fri, 20 Jun 2025 15:11:34 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1729] RSS offload types are undocumented
Date: Fri, 20 Jun 2025 13:11:34 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 25.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mb@smartsharesystems.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1729-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17504250940.e17AEa5E.338522
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


--17504250940.e17AEa5E.338522
Date: Fri, 20 Jun 2025 15:11:34 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1729

            Bug ID: 1729
           Summary: RSS offload types are undocumented
           Product: DPDK
           Version: 25.03
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: mb@smartsharesystems.com
  Target Milestone: ---

A list of macros are defined for RSS offload types [1].
They have no descriptions, and some of them have very similar names, so it's
unclear what exactly they mean.

Examples:
- Does RTE_ETH_RSS_IPV4 provide the same RSS offload as (RTE_ETH_RSS_FRAG_I=
PV4
| RTE_ETH_RSS_NONFRAG_IPV4_OTHER)?
- What does RTE_ETH_RSS_IPV6_EX do, compared to RTE_ETH_RSS_IPV6?

[1]: https://elixir.bootlin.com/dpdk/v25.03/source/lib/ethdev/rte_ethdev.h#=
L553

Each of these macros should be documented.

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17504250940.e17AEa5E.338522
Date: Fri, 20 Jun 2025 15:11:34 +0200
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
   title=3D"UNCONFIRMED - RSS offload types are undocumented"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1729">1729</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>RSS offload types are undocumented
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
          <td>mb&#64;smartsharesystems.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">A list of macros are defined for R=
SS offload types [1].
They have no descriptions, and some of them have very similar names, so it's
unclear what exactly they mean.

Examples:
- Does RTE_ETH_RSS_IPV4 provide the same RSS offload as (RTE_ETH_RSS_FRAG_I=
PV4
| RTE_ETH_RSS_NONFRAG_IPV4_OTHER)?
- What does RTE_ETH_RSS_IPV6_EX do, compared to RTE_ETH_RSS_IPV6?

[1]: <a href=3D"https://elixir.bootlin.com/dpdk/v25.03/source/lib/ethdev/rt=
e_ethdev.h#L553">https://elixir.bootlin.com/dpdk/v25.03/source/lib/ethdev/r=
te_ethdev.h#L553</a>

Each of these macros should be documented.
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
?id=3D1729">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17504250940.e17AEa5E.338522--
