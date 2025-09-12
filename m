Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C54CAC582
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Sep 2025 07:49:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11F3A402DD;
	Fri, 12 Sep 2025 09:49:51 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id BF6C7402CC
 for <dev@dpdk.org>; Fri, 12 Sep 2025 09:49:49 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 9A13446ED6; Fri, 12 Sep 2025 09:49:49 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1786] dumpcap crashes with segmentation fault when
 capturing from af_packet
Date: Fri, 12 Sep 2025 07:49:49 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kerem.aksu@i2i-systems.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1786-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17576633890.FAfFA5.3318953
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


--17576633890.FAfFA5.3318953
Date: Fri, 12 Sep 2025 09:49:49 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1786

            Bug ID: 1786
           Summary: dumpcap crashes with segmentation fault when capturing
                    from af_packet
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: kerem.aksu@i2i-systems.com
  Target Milestone: ---

dumpcap crashes when capturing traffic from af_packet ethernet device.

$ ./dpdk-dumpcap -i 0
Capturing on 'net_af_packet0'
File: /tmp/dpdk-dumpcap_0_net_af_packet0_20250912103908.pcapng

Thread 1 "dpdk-dumpcap" received signal SIGSEGV, Segmentation fault.
0x00007ffff7e46d78 in strlcpy () from /lib/x86_64-linux-gnu/libbsd.so.0


#0  0x00007ffff7e46d78 in strlcpy () from /lib/x86_64-linux-gnu/libbsd.so.0
#1  0x0000555556406faa in eth_dev_change_flags (if_name=3D0x560490350da0 <e=
rror:
Cannot access memory at address 0x560490350da0>, flags=3D256, mask=3D429496=
7295) at
../drivers/net/af_packet/rte_eth_af_packet.c:592
#2  0x0000555556407080 in eth_dev_promiscuous_enable (dev=3D0x55555b38d680
<rte_eth_devices>) at ../drivers/net/af_packet/rte_eth_af_packet.c:613
#3  0x0000555556211eb1 in rte_eth_promiscuous_enable (port_id=3D0) at
../lib/ethdev/rte_ethdev.c:2680
#4  0x0000555555629a49 in enable_pdump (r=3D0x15b438040, mp=3D0x15ba3c900) =
at
../app/dumpcap/main.c:688
#5  0x000055555562af5b in main (argc=3D3, argv=3D0x7fffffffe448) at
../app/dumpcap/main.c:818

dumpcap tries to enable promiscuous mode on the host device but it cannot
access device name and crashes.

I think problem caused by a strdup(3) within rte_eth_af_packet.c:744 struct
pmd_internals * (internals)->if_name is allocated with strdup(3) which is n=
ot
accessible from secondary process (in this context dumpcap).=20

Allocating this field with rte_malloc probably will fix the issue.

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17576633890.FAfFA5.3318953
Date: Fri, 12 Sep 2025 09:49:49 +0200
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
   title=3D"UNCONFIRMED - dumpcap crashes with segmentation fault when capt=
uring from af_packet"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1786">1786</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>dumpcap crashes with segmentation fault when capturing from a=
f_packet
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>unspecified
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
          <td>kerem.aksu&#64;i2i-systems.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">dumpcap crashes when capturing tra=
ffic from af_packet ethernet device.

$ ./dpdk-dumpcap -i 0
Capturing on 'net_af_packet0'
File: /tmp/dpdk-dumpcap_0_net_af_packet0_20250912103908.pcapng

Thread 1 &quot;dpdk-dumpcap&quot; received signal SIGSEGV, Segmentation fau=
lt.
0x00007ffff7e46d78 in strlcpy () from /lib/x86_64-linux-gnu/libbsd.so.0


#0  0x00007ffff7e46d78 in strlcpy () from /lib/x86_64-linux-gnu/libbsd.so.0
#1  0x0000555556406faa in eth_dev_change_flags (if_name=3D0x560490350da0 &l=
t;error:
Cannot access memory at address 0x560490350da0&gt;, flags=3D256, mask=3D429=
4967295) at
../drivers/net/af_packet/rte_eth_af_packet.c:592
#2  0x0000555556407080 in eth_dev_promiscuous_enable (dev=3D0x55555b38d680
&lt;rte_eth_devices&gt;) at ../drivers/net/af_packet/rte_eth_af_packet.c:613
#3  0x0000555556211eb1 in rte_eth_promiscuous_enable (port_id=3D0) at
../lib/ethdev/rte_ethdev.c:2680
#4  0x0000555555629a49 in enable_pdump (r=3D0x15b438040, mp=3D0x15ba3c900) =
at
../app/dumpcap/main.c:688
#5  0x000055555562af5b in main (argc=3D3, argv=3D0x7fffffffe448) at
../app/dumpcap/main.c:818

dumpcap tries to enable promiscuous mode on the host device but it cannot
access device name and crashes.

I think problem caused by a strdup(3) within rte_eth_af_packet.c:744 struct
pmd_internals * (internals)-&gt;if_name is allocated with strdup(3) which i=
s not
accessible from secondary process (in this context dumpcap).=20

Allocating this field with rte_malloc probably will fix the issue.
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
?id=3D1786">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17576633890.FAfFA5.3318953--
