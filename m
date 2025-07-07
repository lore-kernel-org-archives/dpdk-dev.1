Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC96C71130
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Jul 2025 19:03:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77EF340287;
	Mon,  7 Jul 2025 21:03:35 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 3D50F4025D
 for <dev@dpdk.org>; Mon,  7 Jul 2025 21:03:33 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 1D6C146B1F; Mon,  7 Jul 2025 21:03:33 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/meson Bug 1749] Ninja Build Error on Intel CPU
Date: Mon, 07 Jul 2025 19:03:33 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: meson
X-Bugzilla-Version: 25.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mmahajan@iol.unh.edu
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1749-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17519150120.a21DD.434052
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


--17519150120.a21DD.434052
Date: Mon, 7 Jul 2025 21:03:32 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1749

            Bug ID: 1749
           Summary: Ninja Build Error on Intel CPU
           Product: DPDK
           Version: 25.03
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: meson
          Assignee: dev@dpdk.org
          Reporter: mmahajan@iol.unh.edu
  Target Milestone: ---

Hello,

A committed change to DPDK has introduced a build failure. The patch that
introduced the issue is: "net/intel: generalize vectorized Rx rearm" (commit
ID: c70e8654a81315e33d84f5d972174c9547b941c4). It was authored by Anatoly
Burakov and merged into dpdk on 2025-06-27.=20

An earlier patch in the series (net/ice: rename 16-byte descriptor flag)
renames the ICE driver Dc_arg from DRTE_LIBRTE_ICE_16BYTE_RX_DESC to
DRTE_NET_INTEL_USE_16BYTE_DESC. And when using this new flag in the meson
setup, it causes the build to fail.=20

Build commands:
CC=3Dgcc meson -Denable_kmods=3DTrue -Dlibdir=3Dlib
-Dc_args=3D'-DRTE_NET_INTEL_USE_16BYTE_DESC' --default-library=3Dstatic
x86_64-native-linux-gcc
ninja -C x86_64-native-linux-gcc


OS: Ubuntu VERSION=3D"22.04.3 LTS (Jammy Jellyfish)"
GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0
Meson: 1.3.1

CPU INFO
--------
Arch: x86_64
Model name: Intel(R) Xeon(R) Platinum 8360Y CPU @ 2.40GHz

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17519150120.a21DD.434052
Date: Mon, 7 Jul 2025 21:03:32 +0200
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
   title=3D"UNCONFIRMED - Ninja Build Error on Intel CPU"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1749">1749</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>Ninja Build Error on Intel CPU
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
          <td>mmahajan&#64;iol.unh.edu
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">Hello,

A committed change to DPDK has introduced a build failure. The patch that
introduced the issue is: &quot;net/intel: generalize vectorized Rx rearm&qu=
ot; (commit
ID: c70e8654a81315e33d84f5d972174c9547b941c4). It was authored by Anatoly
Burakov and merged into dpdk on 2025-06-27.=20

An earlier patch in the series (net/ice: rename 16-byte descriptor flag)
renames the ICE driver Dc_arg from DRTE_LIBRTE_ICE_16BYTE_RX_DESC to
DRTE_NET_INTEL_USE_16BYTE_DESC. And when using this new flag in the meson
setup, it causes the build to fail.=20

Build commands:
CC=3Dgcc meson -Denable_kmods=3DTrue -Dlibdir=3Dlib
-Dc_args=3D'-DRTE_NET_INTEL_USE_16BYTE_DESC' --default-library=3Dstatic
x86_64-native-linux-gcc
ninja -C x86_64-native-linux-gcc


OS: Ubuntu VERSION=3D&quot;22.04.3 LTS (Jammy Jellyfish)&quot;
GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0
Meson: 1.3.1

CPU INFO
--------
Arch: x86_64
Model name: Intel(R) Xeon(R) Platinum 8360Y CPU &#64; 2.40GHz
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
?id=3D1749">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17519150120.a21DD.434052--
