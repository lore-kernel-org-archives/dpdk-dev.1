Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355A4C19F32
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 09:07:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6933E40156;
	Wed,  5 Mar 2025 10:07:49 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 40093400EF
 for <dev@dpdk.org>; Wed,  5 Mar 2025 10:07:48 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 1F1D34634A; Wed,  5 Mar 2025 10:07:48 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/meson Bug 1670] DPDK fails to compile using gcc version 8.5.0
Date: Wed, 05 Mar 2025 09:07:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: meson
X-Bugzilla-Version: 25.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: critical
X-Bugzilla-Who: subhim@nvidia.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1670-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17411656670.feACC.284291
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


--17411656670.feACC.284291
Date: Wed, 5 Mar 2025 10:07:47 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1670

            Bug ID: 1670
           Summary: DPDK fails to compile using gcc version 8.5.0
           Product: DPDK
           Version: 25.03
          Hardware: ARM
                OS: Linux
            Status: UNCONFIRMED
          Severity: critical
          Priority: Normal
         Component: meson
          Assignee: dev@dpdk.org
          Reporter: subhim@nvidia.com
  Target Milestone: ---

Compiling DPDK 25.03 on systems that runs gcc version 8.5.0 and ARM
architecture ( aarch64) is failing.

Reproducer :=20

1.Clone DPDK 23.05 :=20

git clone git:\\dpdk.org\dpdk dpdk-25.03

2. Compile DPDK :

meson build-meson --werror
-Dexamples=3Dethtool,ip_fragmentation,l2fwd-crypto,l3fwd-power,link_status_=
interrupt,multi_process/client_server_mp/mp_client,multi_process/client_ser=
ver_mp/mp_server,multi_process/simple_mp,multi_process/symmetric_mp,vdpa
-Dprefix=3D/download/dpdk/install -Dlibdir=3Dlib64
-Denable_drivers=3D*/mlx5,mempool/bucket,mempool/ring,mempool/stack,net/fai=
lsafe,net/netvsc,bus/vmbus,net/tap,net/vdev_netvsc,crypto/openssl,*/virtio*=
,bus/auxiliary
&& ninja -C build-meson install


Result : compilation fails with the following error  :=20

Compiler for C supports arguments -Wno-missing-field-initializers: YES
Compiler for C supports arguments -fzero-init-padding-bits=3Dall: NO
Message: Arm implementer: Arm
Message: Arm part number: 0xd42
Compiler for C supports arguments -mcpu=3Dcortex-a78ae: NO

config/arm/meson.build:915:12: ERROR: Problem encountered: Compiler does not
support -mcpu=3Dcortex-a78ae.

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17411656670.feACC.284291
Date: Wed, 5 Mar 2025 10:07:47 +0100
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
   title=3D"UNCONFIRMED - DPDK fails to compile using gcc version 8.5.0"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1670">1670</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>DPDK fails to compile using gcc version 8.5.0
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
          <td>critical
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
          <td>subhim&#64;nvidia.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">Compiling DPDK 25.03 on systems th=
at runs gcc version 8.5.0 and ARM
architecture ( aarch64) is failing.

Reproducer :=20

1.Clone DPDK 23.05 :=20

git clone git:\\dpdk.org\dpdk dpdk-25.03

2. Compile DPDK :

meson build-meson --werror
-Dexamples=3Dethtool,ip_fragmentation,l2fwd-crypto,l3fwd-power,link_status_=
interrupt,multi_process/client_server_mp/mp_client,multi_process/client_ser=
ver_mp/mp_server,multi_process/simple_mp,multi_process/symmetric_mp,vdpa
-Dprefix=3D/download/dpdk/install -Dlibdir=3Dlib64
-Denable_drivers=3D*/mlx5,mempool/bucket,mempool/ring,mempool/stack,net/fai=
lsafe,net/netvsc,bus/vmbus,net/tap,net/vdev_netvsc,crypto/openssl,*/virtio*=
,bus/auxiliary
&amp;&amp; ninja -C build-meson install


Result : compilation fails with the following error  :=20

Compiler for C supports arguments -Wno-missing-field-initializers: YES
Compiler for C supports arguments -fzero-init-padding-bits=3Dall: NO
Message: Arm implementer: Arm
Message: Arm part number: 0xd42
Compiler for C supports arguments -mcpu=3Dcortex-a78ae: NO

config/arm/meson.build:915:12: ERROR: Problem encountered: Compiler does not
support -mcpu=3Dcortex-a78ae.
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
?id=3D1670">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17411656670.feACC.284291--
