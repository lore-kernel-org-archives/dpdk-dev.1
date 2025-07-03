Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AE2C77B7C
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 16:49:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6175740267;
	Thu,  3 Jul 2025 18:49:10 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 5B75140264
 for <dev@dpdk.org>; Thu,  3 Jul 2025 18:49:08 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 4FF0E46AE7; Thu,  3 Jul 2025 18:49:08 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1738] bus/pci: Secondary process initialization kills
 non-DPDK network interfaces
Date: Thu, 03 Jul 2025 16:49:08 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 25.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: major
X-Bugzilla-Who: yonig@radcom.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1738-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17515613480.035a.1300103
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


--17515613480.035a.1300103
Date: Thu, 3 Jul 2025 18:49:08 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1738

            Bug ID: 1738
           Summary: bus/pci: Secondary process initialization kills
                    non-DPDK network interfaces
           Product: DPDK
           Version: 25.03
          Hardware: x86
                OS: Linux
            Status: UNCONFIRMED
          Severity: major
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: yonig@radcom.com
  Target Milestone: ---

On a system with one virtio interface bound to vfio-pci and additional virt=
io
interfaces bound to the kernel driver: Starting a secondary DPDK process (w=
ith
a -a flag specifying the pci address bound to vfio) causes all the kernel
network interfaces to stop working, requiring a reboot.

This behavior is reproduced on a specific environment consisting of several
VMs, but we have been unable to reproduce it on other environments, which a=
lso
use virtio and the same kernel version.

Steps to Reproduce:
./dpdk-testpmd -l 4,5 -n 4 -a 0000:00:04.0 --proc-type=3Dprimary -- -i
./dpdk-testpmd -l 6,7 -n 4 -a 0000:00:04.0 --proc-type=3Dsecondary -- -i

This happens on all dpdk versions starting at 24.3.

I have narrowed the cause down to the following two commits:
4b741542ecde  - bus/pci: avoid depending on private kernel value
647a0a6ecb04  - bus/pci: fix VFIO region info in secondary process

Without these commits there is no issue. With only 4b741542ecde, there is an
error in the secondary process initialization (virtio_pci_init(): failed to
remap pci device). With both commits, the network dies during secondary pro=
cess
initialization.

The kernel log contains lines such as:
kernel: NETDEV WATCHDOG: ens3 (virtio_net): transmit queue 0 timed out
...
kernel: virtio_net virtio0 ens3: TX timeout on queue: 0, sq: output.0, vq: =
0x1,
name: output.0, 5286000 usecs ago


Kernel version: kernel 5.14.0-362.8.1.el9_3.x86_64

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17515613480.035a.1300103
Date: Thu, 3 Jul 2025 18:49:08 +0200
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
   title=3D"UNCONFIRMED - bus/pci: Secondary process initialization kills n=
on-DPDK network interfaces"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1738">1738</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>bus/pci: Secondary process initialization kills non-DPDK netw=
ork interfaces
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
          <td>x86
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
          <td>yonig&#64;radcom.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">On a system with one virtio interf=
ace bound to vfio-pci and additional virtio
interfaces bound to the kernel driver: Starting a secondary DPDK process (w=
ith
a -a flag specifying the pci address bound to vfio) causes all the kernel
network interfaces to stop working, requiring a reboot.

This behavior is reproduced on a specific environment consisting of several
VMs, but we have been unable to reproduce it on other environments, which a=
lso
use virtio and the same kernel version.

Steps to Reproduce:
./dpdk-testpmd -l 4,5 -n 4 -a 0000:00:04.0 --proc-type=3Dprimary -- -i
./dpdk-testpmd -l 6,7 -n 4 -a 0000:00:04.0 --proc-type=3Dsecondary -- -i

This happens on all dpdk versions starting at 24.3.

I have narrowed the cause down to the following two commits:
4b741542ecde  - bus/pci: avoid depending on private kernel value
647a0a6ecb04  - bus/pci: fix VFIO region info in secondary process

Without these commits there is no issue. With only 4b741542ecde, there is an
error in the secondary process initialization (virtio_pci_init(): failed to
remap pci device). With both commits, the network dies during secondary pro=
cess
initialization.

The kernel log contains lines such as:
kernel: NETDEV WATCHDOG: ens3 (virtio_net): transmit queue 0 timed out
...
kernel: virtio_net virtio0 ens3: TX timeout on queue: 0, sq: output.0, vq: =
0x1,
name: output.0, 5286000 usecs ago


Kernel version: kernel 5.14.0-362.8.1.el9_3.x86_64
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
?id=3D1738">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17515613480.035a.1300103--
