Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E305FCA101F
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Sep 2025 09:28:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E22F3402DD;
	Fri, 12 Sep 2025 11:28:53 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 520C5402CC
 for <dev@dpdk.org>; Fri, 12 Sep 2025 11:28:53 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 2B45D46ED8; Fri, 12 Sep 2025 11:28:53 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/meson Bug 1787] ARM toolchin prefix changed in newest toolchain
Date: Fri, 12 Sep 2025 09:28:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: meson
X-Bugzilla-Version: 24.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: major
X-Bugzilla-Who: nelio.laranjeiro@6wind.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1787-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17576693330.f7b8bE52.3393848
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


--17576693330.f7b8bE52.3393848
Date: Fri, 12 Sep 2025 11:28:52 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1787

            Bug ID: 1787
           Summary: ARM toolchin prefix changed in newest toolchain
           Product: DPDK
           Version: 24.11
          Hardware: ARM
                OS: Linux
            Status: UNCONFIRMED
          Severity: major
          Priority: Normal
         Component: meson
          Assignee: dev@dpdk.org
          Reporter: nelio.laranjeiro@6wind.com
  Target Milestone: ---

In config/arm/* files in the binary section, the prefix tool chain is hardc=
oded
with the old notation i.e. arch-os-abi, this has changed to arch-vendor-os-=
abi
causing all this files unusable with latest tool chain.

Example: arm-gnu-toolchain-14.3.rel1-aarch64-aarch64-none-linux-gnu.tar.xz =
[1]
which prefix is: aarch64-none-linux-gnu instead of old prefix
aarch64-linux-gnu.

[1]
https://developer.arm.com/-/media/Files/downloads/gnu/14.3.rel1/binrel/arm-=
gnu-toolchain-14.3.rel1-aarch64-aarch64-none-linux-gnu.tar.xz

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17576693330.f7b8bE52.3393848
Date: Fri, 12 Sep 2025 11:28:53 +0200
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
   title=3D"UNCONFIRMED - ARM toolchin prefix changed in newest toolchain"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1787">1787</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>ARM toolchin prefix changed in newest toolchain
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>24.11
          </td>
        </tr>

        <tr>
          <th>Hardware</th>
          <td>ARM
          </td>
        </tr>

        <tr>
          <th>OS</th>
          <td>Linux
          </td>
        </tr>

        <tr>
          <th>Status</th>
          <td>UNCONFIRMED
          </td>
        </tr>

        <tr>
          <th>Severity</th>
          <td>major
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
          <td>nelio.laranjeiro&#64;6wind.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">In config/arm/* files in the binar=
y section, the prefix tool chain is hardcoded
with the old notation i.e. arch-os-abi, this has changed to arch-vendor-os-=
abi
causing all this files unusable with latest tool chain.

Example: arm-gnu-toolchain-14.3.rel1-aarch64-aarch64-none-linux-gnu.tar.xz =
[1]
which prefix is: aarch64-none-linux-gnu instead of old prefix
aarch64-linux-gnu.

[1]
<a href=3D"https://developer.arm.com/-/media/Files/downloads/gnu/14.3.rel1/=
binrel/arm-gnu-toolchain-14.3.rel1-aarch64-aarch64-none-linux-gnu.tar.xz">h=
ttps://developer.arm.com/-/media/Files/downloads/gnu/14.3.rel1/binrel/arm-g=
nu-toolchain-14.3.rel1-aarch64-aarch64-none-linux-gnu.tar.xz</a>
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
?id=3D1787">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17576693330.f7b8bE52.3393848--
