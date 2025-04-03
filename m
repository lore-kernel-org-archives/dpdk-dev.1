Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F34CC3600C
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Apr 2025 21:07:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 887C540A7D;
	Thu,  3 Apr 2025 23:07:44 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id E33F3406B6
 for <dev@dpdk.org>; Thu,  3 Apr 2025 23:07:43 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id D59AB464F9; Thu,  3 Apr 2025 23:07:43 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1691] e1000 device initialization fails with SIGILL
 in KVM
Date: Thu, 03 Apr 2025 21:07:43 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 24.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mgsmith@netgate.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone attachments.created
Message-ID: <bug-1691-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17437144630.2F89dBB1.1980692
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


--17437144630.2F89dBB1.1980692
Date: Thu, 3 Apr 2025 23:07:43 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1691

            Bug ID: 1691
           Summary: e1000 device initialization fails with SIGILL in KVM
           Product: DPDK
           Version: 24.11
          Hardware: x86
                OS: Linux
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: mgsmith@netgate.com
  Target Milestone: ---

Created attachment 309
  --> https://bugs.dpdk.org/attachment.cgi?id=3D309&action=3Dedit
backtrace from gdb

When attempting to run FD.io VPP in a qemu VM with e1000 interfaces, SIGILL=
 is
caught during initialization of one of the e1000 interfaces attached to the=
 VM.
The value of si_code is 2 (illegal operand).


This occurs on at least VPP versions:
 24.10 (DPDK 24.07)
 25.02 (DPDK 24.11)


The VM where the problem occurs is running ubuntu 24.04 LTS (kernel
6.8.0-54-generic). This issue does not occur on another VM running ubuntu 2=
2.04
LTS (kernel 5.15.0-133-generic) on the same host system and using the same
version of VPP/DPDK.


The problem occurs very consistently when DPDK is compiled with gcc using
optimization level 2 or 3. It does not occur when DPDK is compiled with gcc
using optimization level 1 or compiled with clang.


I'll attach a text file with a stack trace since I don't know how to make it
format nicely here. The signal is caught in e1000_id_led_init_generic() whi=
le
trying to read from the memory address of the ledctl register.=20


Googling found someone else reporting the same problem to qemu -
https://gitlab.com/qemu-project/qemu/-/issues/2784. It doesn't seem to me l=
ike
the issue can be attributed to qemu though.


It should be possible to reproduce the problem via:
1) Provision a qemu VM running ubuntu 24.04 ("noble"). Attach one or more e=
1000
NICs.
2) In the VM, install the VPP 25.02 deb packages (libvppinfra, vpp,
vpp-plugin-core, vpp-plugin-devtools, vpp-plugin-dpdk) for noble
(https://packagecloud.io/fdio/2502).
3) In the VM, run 'systemctl stop vpp.service' to make sure VPP is shut dow=
n.
4) In the VM, edit /etc/vpp/startup.conf. Add a line containing 'dpdk { dev
<PCI_addr_of_e1000> }'.
5) In the VM, run 'systemctl start vpp.service' to start VPP. Or just execu=
te
it from a shell as /usr/bin/vpp -c /etc/vpp/startup.conf. In either case, it
should crash immediately on SIGILL.


I'm not sure if it also affects e1000 hardware devices, I don't have any to
test.

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17437144630.2F89dBB1.1980692
Date: Thu, 3 Apr 2025 23:07:43 +0200
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
   title=3D"UNCONFIRMED - e1000 device initialization fails with SIGILL in =
KVM"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1691">1691</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>e1000 device initialization fails with SIGILL in KVM
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
          <td>mgsmith&#64;netgate.com
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
=3D"attachment.cgi?id=3D309" name=3D"attach_309" title=3D"backtrace from gd=
b">attachment 309</a> <a href=3D"attachment.cgi?id=3D309&amp;action=3Dedit"=
 title=3D"backtrace from gdb">[details]</a></span>
backtrace from gdb

When attempting to run FD.io VPP in a qemu VM with e1000 interfaces, SIGILL=
 is
caught during initialization of one of the e1000 interfaces attached to the=
 VM.
The value of si_code is 2 (illegal operand).


This occurs on at least VPP versions:
 24.10 (DPDK 24.07)
 25.02 (DPDK 24.11)


The VM where the problem occurs is running ubuntu 24.04 LTS (kernel
6.8.0-54-generic). This issue does not occur on another VM running ubuntu 2=
2.04
LTS (kernel 5.15.0-133-generic) on the same host system and using the same
version of VPP/DPDK.


The problem occurs very consistently when DPDK is compiled with gcc using
optimization level 2 or 3. It does not occur when DPDK is compiled with gcc
using optimization level 1 or compiled with clang.


I'll attach a text file with a stack trace since I don't know how to make it
format nicely here. The signal is caught in e1000_id_led_init_generic() whi=
le
trying to read from the memory address of the ledctl register.=20


Googling found someone else reporting the same problem to qemu -
<a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/2784">https://gitl=
ab.com/qemu-project/qemu/-/issues/2784</a>. It doesn't seem to me like
the issue can be attributed to qemu though.


It should be possible to reproduce the problem via:
1) Provision a qemu VM running ubuntu 24.04 (&quot;noble&quot;). Attach one=
 or more e1000
NICs.
2) In the VM, install the VPP 25.02 deb packages (libvppinfra, vpp,
vpp-plugin-core, vpp-plugin-devtools, vpp-plugin-dpdk) for noble
(<a href=3D"https://packagecloud.io/fdio/2502">https://packagecloud.io/fdio=
/2502</a>).
3) In the VM, run 'systemctl stop vpp.service' to make sure VPP is shut dow=
n.
4) In the VM, edit /etc/vpp/startup.conf. Add a line containing 'dpdk { dev
&lt;PCI_addr_of_e1000&gt; }'.
5) In the VM, run 'systemctl start vpp.service' to start VPP. Or just execu=
te
it from a shell as /usr/bin/vpp -c /etc/vpp/startup.conf. In either case, it
should crash immediately on SIGILL.


I'm not sure if it also affects e1000 hardware devices, I don't have any to
test.
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
?id=3D1691">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17437144630.2F89dBB1.1980692--
