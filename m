Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F43C369D5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Apr 2025 02:34:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8F6A4026C;
	Tue, 29 Apr 2025 04:34:40 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id A079F40263
 for <dev@dpdk.org>; Tue, 29 Apr 2025 04:34:39 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 6A62E46658; Tue, 29 Apr 2025 04:34:39 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/meson Bug 1702] meson: Unsupported part number for ARM Grace
 during meson setup
Date: Tue, 29 Apr 2025 02:34:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: meson
X-Bugzilla-Version: 23.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: minor
X-Bugzilla-Who: probb@iol.unh.edu
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone attachments.created
Message-ID: <bug-1702-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17458940790.E1eAd1891.3958708
Content-Transfer-Encoding: 7bit
X-Bugzilla-URL: http://bugs.dpdk.org/
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


--17458940790.E1eAd1891.3958708
Date: Tue, 29 Apr 2025 04:34:39 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1702

            Bug ID: 1702
           Summary: meson: Unsupported part number for ARM Grace during
                    meson setup
           Product: DPDK
           Version: 23.11
          Hardware: ARM
                OS: All
            Status: UNCONFIRMED
          Severity: minor
          Priority: Normal
         Component: meson
          Assignee: dev@dpdk.org
          Reporter: probb@iol.unh.edu
  Target Milestone: ---

Created attachment 312
  --> https://bugs.dpdk.org/attachment.cgi?id=3D312&action=3Dedit
meson log

Hello. I am seeing an error reported by meson when attempting to run meson
setup on 23.11.

steps to reproduce:
1. clone dpdk-stable and checkout to 23.11
2. run "meson setup build"

error:
Message: Arm implementer: Arm
Message: Arm part number: 0xd4f

config/arm/meson.build:687:8: ERROR: Problem encountered: Unsupported part
number 0xd4f of implementer 0x41. Please add support for it or use the gene=
ric
(-Dplatform=3Dgeneric) build.


System info:
DPDK version: 23.11
OS: Ubuntu 24.04
CPU: Vendor ID:                ARM
  BIOS Vendor ID:         NVIDIA
  Model name:             Neoverse-V2
    BIOS Model name:      Grace A02 AOM-SCM-NV CPU @ 3.4GHz
meson version: .53 and 1.3.2 (tried both)

If you pass in -Dplatform=3Dgeneric meson (and ninja) run to completion wit=
hout
error. But, I imagine support for this part number should be added so that
meson will run without this flag, so I've created this ticket.

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17458940790.E1eAd1891.3958708
Date: Tue, 29 Apr 2025 04:34:39 +0200
MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
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
   title=3D"UNCONFIRMED - meson: Unsupported part number for ARM Grace duri=
ng meson setup"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1702">1702</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>meson: Unsupported part number for ARM Grace during meson set=
up
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
          <td>ARM
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
          <td>probb&#64;iol.unh.edu
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">Created <span class=3D""><a href=
=3D"attachment.cgi?id=3D312" name=3D"attach_312" title=3D"meson log">attach=
ment 312</a> <a href=3D"attachment.cgi?id=3D312&amp;action=3Dedit" title=3D=
"meson log">[details]</a></span>
meson log

Hello. I am seeing an error reported by meson when attempting to run meson
setup on 23.11.

steps to reproduce:
1. clone dpdk-stable and checkout to 23.11
2. run &quot;meson setup build&quot;

error:
Message: Arm implementer: Arm
Message: Arm part number: 0xd4f

config/arm/meson.build:687:8: ERROR: Problem encountered: Unsupported part
number 0xd4f of implementer 0x41. Please add support for it or use the gene=
ric
(-Dplatform=3Dgeneric) build.


System info:
DPDK version: 23.11
OS: Ubuntu 24.04
CPU: Vendor ID:                ARM
  BIOS Vendor ID:         NVIDIA
  Model name:             Neoverse-V2
    BIOS Model name:      Grace A02 AOM-SCM-NV CPU &#64; 3.4GHz
meson version: .53 and 1.3.2 (tried both)

If you pass in -Dplatform=3Dgeneric meson (and ninja) run to completion wit=
hout
error. But, I imagine support for this part number should be added so that
meson will run without this flag, so I've created this ticket.
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
?id=3D1702">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17458940790.E1eAd1891.3958708--
