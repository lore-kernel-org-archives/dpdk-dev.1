Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE2FCA0EE4
	for <dpdk-dev@archiver.kernel.org>; Sun, 17 Aug 2025 10:43:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D215440151;
	Sun, 17 Aug 2025 12:43:33 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 57ADB4003C
 for <dev@dpdk.org>; Sun, 17 Aug 2025 12:43:31 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 28F9B46D4D; Sun, 17 Aug 2025 12:43:31 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1772] [23.11] net/hns3 fails to build with clang 20
 and C11 stdatomic enabled
Date: Sun, 17 Aug 2025 10:43:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 23.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: alialnu@nvidia.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1772-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17554274100.60ce2.2836614
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


--17554274100.60ce2.2836614
Date: Sun, 17 Aug 2025 12:43:30 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1772

            Bug ID: 1772
           Summary: [23.11] net/hns3 fails to build with clang 20 and C11
                    stdatomic enabled
           Product: DPDK
           Version: 23.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: alialnu@nvidia.com
  Target Milestone: ---

$ meson --werror --buildtype=3Ddebugoptimized -Denable_stdatomic=3Dtrue bui=
ld &&
ninja-build -C build

[..]
drivers/net/hns3/hns3_ethdev.c:5224:6: error: address argument to atomic
operation must be a pointer to _Atomic type ('uint16_t *' (aka 'unsigned sh=
ort
*') invalid)
[..]

OS: Fedora Linux 42
Meson: 1.7.2
Compiler: clang version 20.1.8

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17554274100.60ce2.2836614
Date: Sun, 17 Aug 2025 12:43:30 +0200
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
   title=3D"UNCONFIRMED - [23.11] net/hns3 fails to build with clang 20 and=
 C11 stdatomic enabled"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1772">1772</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>[23.11] net/hns3 fails to build with clang 20 and C11 stdatom=
ic enabled
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>23.11
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
          <td>alialnu&#64;nvidia.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">$ meson --werror --buildtype=3Ddeb=
ugoptimized -Denable_stdatomic=3Dtrue build &amp;&amp;
ninja-build -C build

[..]
drivers/net/hns3/hns3_ethdev.c:5224:6: error: address argument to atomic
operation must be a pointer to _Atomic type ('uint16_t *' (aka 'unsigned sh=
ort
*') invalid)
[..]

OS: Fedora Linux 42
Meson: 1.7.2
Compiler: clang version 20.1.8
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
?id=3D1772">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17554274100.60ce2.2836614--
