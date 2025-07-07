Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EDEC71130
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Jul 2025 20:39:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1AC6940287;
	Mon,  7 Jul 2025 22:39:33 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 1802C4025D
 for <dev@dpdk.org>; Mon,  7 Jul 2025 22:39:31 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id E714D46B1F; Mon,  7 Jul 2025 22:39:30 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1750] ixgbe: X553 link remains down (NO-CARRIER)
Date: Mon, 07 Jul 2025 20:39:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 24.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: clinton@netgate.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1750-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17519207700.b4DDb6F70.505092
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


--17519207700.b4DDb6F70.505092
Date: Mon, 7 Jul 2025 22:39:30 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1750

            Bug ID: 1750
           Summary: ixgbe: X553 link remains down (NO-CARRIER)
           Product: DPDK
           Version: 24.11
          Hardware: x86
                OS: Linux
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: clinton@netgate.com
  Target Milestone: ---

Ethernet Connection X553 10 GbE SFP+ link can get stuck in a DOWN/NO-CARRIER
state when starting an application (testpmd or VPP).

The interface remains in a DOWN/NO-CARRIER state, even when unbinding the N=
IC
from vfio-pci followed by binding to the ixgbe kernel driver. The only way =
I've
been able to bring the interface back up is by rebooting the system.

I've tested with multiple systems, SFP+ modules, switches, etc...

I initially ran into this when running CSIT tests against VPP. After some t=
ime,
failures would start occurring because of the link issue. I found that
starting/stopping VPP multiple times eventually resulted in the interface s=
tate
getting stuck down.

I replicated this with testpmd as well.=20

Steps to Reproduce:
1. Bind X553 interfaces to vfio-pci driver
2. Compile testpmd application if not already compiled
3. Create a file (ie: testpmd-flap.txt) with the following contents:
port stop all
set link-up port 0
set link-up port 1
port reset all
port start all

4. Create a script to rerun the dpdk-testpmd application
while true; do
        echo | ./dpdk-testpmd -a 0000:03:00.0 -a 0000:03:00.1 -l 1-4 --
--disable-link-check --disable-device-start --cmdline=3Dtestpmd-flap.txt
        sleep .5
done

5. Run the script. The time it takes to fail can vary...sometimes it only t=
akes
a minute or so and other times it can take 30+ minutes. You'll need to stop=
 the
script to check the port state (testpmd> show port info all).

I'm using two interfaces and generally when this happens only one of the two
interfaces shows in the down state.

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17519207700.b4DDb6F70.505092
Date: Mon, 7 Jul 2025 22:39:30 +0200
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
   title=3D"UNCONFIRMED - ixgbe: X553 link remains down (NO-CARRIER)"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1750">1750</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>ixgbe: X553 link remains down (NO-CARRIER)
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
          <td>clinton&#64;netgate.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">Ethernet Connection X553 10 GbE SF=
P+ link can get stuck in a DOWN/NO-CARRIER
state when starting an application (testpmd or VPP).

The interface remains in a DOWN/NO-CARRIER state, even when unbinding the N=
IC
from vfio-pci followed by binding to the ixgbe kernel driver. The only way =
I've
been able to bring the interface back up is by rebooting the system.

I've tested with multiple systems, SFP+ modules, switches, etc...

I initially ran into this when running CSIT tests against VPP. After some t=
ime,
failures would start occurring because of the link issue. I found that
starting/stopping VPP multiple times eventually resulted in the interface s=
tate
getting stuck down.

I replicated this with testpmd as well.=20

Steps to Reproduce:
1. Bind X553 interfaces to vfio-pci driver
2. Compile testpmd application if not already compiled
3. Create a file (ie: testpmd-flap.txt) with the following contents:
port stop all
set link-up port 0
set link-up port 1
port reset all
port start all

4. Create a script to rerun the dpdk-testpmd application
while true; do
        echo | ./dpdk-testpmd -a 0000:03:00.0 -a 0000:03:00.1 -l 1-4 --
--disable-link-check --disable-device-start --cmdline=3Dtestpmd-flap.txt
        sleep .5
done

5. Run the script. The time it takes to fail can vary...sometimes it only t=
akes
a minute or so and other times it can take 30+ minutes. You'll need to stop=
 the
script to check the port state (testpmd&gt; show port info all).

I'm using two interfaces and generally when this happens only one of the two
interfaces shows in the down state.
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
?id=3D1750">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17519207700.b4DDb6F70.505092--
