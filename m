Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD78C83F25
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 14:19:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A385402E2;
	Mon, 21 Jul 2025 16:19:33 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 73EDD40297
 for <dev@dpdk.org>; Mon, 21 Jul 2025 16:19:31 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 687B846BD9; Mon, 21 Jul 2025 16:19:31 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/other Bug 1758] net/mlx5: Incompatible enum type used in
 bitwise operation
Date: Mon, 21 Jul 2025 14:19:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: other
X-Bugzilla-Version: 25.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: andremuz@gmail.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1758-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17531075710.e8515F44f.2892809
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


--17531075710.e8515F44f.2892809
Date: Mon, 21 Jul 2025 16:19:31 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1758

            Bug ID: 1758
           Summary: net/mlx5: Incompatible enum type used in bitwise
                    operation
           Product: DPDK
           Version: 25.03
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: other
          Assignee: dev@dpdk.org
          Reporter: andremuz@gmail.com
  Target Milestone: ---

Compiling with MSCS results in the warning below:

../drivers/net/mlx5/mlx5_flow_dv.c(19636): warning C5287: operands are
different enum types 'ibv_flow_attr_type' and 'ibv_flow_flags'; use an expl=
icit
cast to silence this warning

It looks like a legit bug. Here is the offending line:

        struct mlx5dv_flow_matcher_attr dv_attr =3D {
                .type =3D IBV_FLOW_ATTR_NORMAL | IBV_FLOW_ATTR_FLAGS_EGRESS,

As the warning states, the constants in the bitwise operation belong to
different enums, and these enums have overlaping values, which makes the
bitwise operation very suspicious.
On top of that, I see that struct mlx5dv_flow_matcher_attr has a field named
"flags" which accepts values from ibv_flow_flags:

        struct mlx5dv_flow_matcher_attr {
                enum ibv_flow_attr_type type;
                uint32_t flags; /* From enum ibv_flow_flags. */

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17531075710.e8515F44f.2892809
Date: Mon, 21 Jul 2025 16:19:31 +0200
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
   title=3D"UNCONFIRMED - net/mlx5: Incompatible enum type used in bitwise =
operation"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1758">1758</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>net/mlx5: Incompatible enum type used in bitwise operation
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
          <td>other
          </td>
        </tr>

        <tr>
          <th>Assignee</th>
          <td>dev&#64;dpdk.org
          </td>
        </tr>

        <tr>
          <th>Reporter</th>
          <td>andremuz&#64;gmail.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">Compiling with MSCS results in the=
 warning below:

../drivers/net/mlx5/mlx5_flow_dv.c(19636): warning C5287: operands are
different enum types 'ibv_flow_attr_type' and 'ibv_flow_flags'; use an expl=
icit
cast to silence this warning

It looks like a legit bug. Here is the offending line:

        struct mlx5dv_flow_matcher_attr dv_attr =3D {
                .type =3D IBV_FLOW_ATTR_NORMAL | IBV_FLOW_ATTR_FLAGS_EGRESS,

As the warning states, the constants in the bitwise operation belong to
different enums, and these enums have overlaping values, which makes the
bitwise operation very suspicious.
On top of that, I see that struct mlx5dv_flow_matcher_attr has a field named
&quot;flags&quot; which accepts values from ibv_flow_flags:

        struct mlx5dv_flow_matcher_attr {
                enum ibv_flow_attr_type type;
                uint32_t flags; /* From enum ibv_flow_flags. */
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
?id=3D1758">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17531075710.e8515F44f.2892809--
