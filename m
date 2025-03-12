Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A79C28B2E
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 09:43:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D2A8402CE;
	Wed, 12 Mar 2025 10:43:55 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id E76B340265
 for <dev@dpdk.org>; Wed, 12 Mar 2025 10:43:53 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id BF51C463E6; Wed, 12 Mar 2025 10:43:53 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1673] failed to parse device "net_pcap0"
Date: Wed, 12 Mar 2025 09:43:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 21.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: 915768903@qq.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1673-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17417726330.342458.1615080
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


--17417726330.342458.1615080
Date: Wed, 12 Mar 2025 10:43:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1673

            Bug ID: 1673
           Summary: failed to parse device "net_pcap0"
           Product: DPDK
           Version: 21.11
          Hardware: x86
                OS: Linux
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: 915768903@qq.com
  Target Milestone: ---

[Background Introduction]
   "I understand that the KNI feature was removed in DPDK version 23. I want
DPDK to load TAP devices to communicate with the kernel. The control-plane
packets [ICMP] received from the physical port should be handled by the TAP
devices <=E2=80=93vdev=3Dnet_tap0 =E2=80=93vdev=3Dnet_tap1>. After processi=
ng by DPDK, the
user-plane packets will be sent back to the physical port via DPDK=E2=80=99=
s TX
interface."

[To create a TAP device]
  sudo ip tuntap add dev dpdk_tap mode tap
  sudo ip link set dpdk_tap up
  sudo ip addr add 5.5.5.88/24 dev dpdk_tap=20
[To create a TAP device]
    snprintf(option[opt_num++], 128, "dpdk_tap");
    snprintf(option[opt_num++], 128, "--main-lcore=3D%u", dns_cfg.mx_cpu);
    snprintf(option[opt_num++], 128, "--file-prefix=3Ddpdk_tap");
    snprintf(option[opt_num++], 128, "-c0x%016llx%016llx%016llx%016llx",
            core_mask[3], core_mask[2], core_mask[1], core_mask[0]);
    snprintf(option[opt_num++], 128, "-n4");
    snprintf(option[opt_num++], 128, "--vdev=3Dnet_pcap0,iface=3Ddpdk_tap");
    snprintf(option[opt_num++], 128, "--log-level=3Dlib.eal:debug");
    dpdk_opt_info_get(&opt_num, option, &dns_cfg);
    dpdk_pci_info_get(&opt_num, option);

    int ret;
    if((ret =3D rte_eal_init(opt_num, option)) < 0)
    {
        printf("!error: rte_eal_init failed\n");
        return false;
    }

[Error message"]
EAL: Detected lcore 62 as core 12 on socket 0
EAL: Detected lcore 63 as core 12 on socket 1
EAL: Maximum logical cores by configuration: 128
EAL: Detected CPU lcores: 64
EAL: Detected NUMA nodes: 2
EAL: Checking presence of .so 'librte_eal.so.22.0'
EAL: Checking presence of .so 'librte_eal.so.22'
EAL: Checking presence of .so 'librte_eal.so'
EAL: Detected static linkage of DPDK
EAL: failed to parse device "net_pcap0"
EAL: Unable to parse device 'net_pcap0,iface=3Ddpdk_tap'

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17417726330.342458.1615080
Date: Wed, 12 Mar 2025 10:43:53 +0100
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
   title=3D"UNCONFIRMED - failed to parse device &quot;net_pcap0&quot;"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1673">1673</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>failed to parse device &quot;net_pcap0&quot;
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>21.11
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
          <td>915768903&#64;qq.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">[Background Introduction]
   &quot;I understand that the KNI feature was removed in DPDK version 23. =
I want
DPDK to load TAP devices to communicate with the kernel. The control-plane
packets [ICMP] received from the physical port should be handled by the TAP
devices &lt;=E2=80=93vdev=3Dnet_tap0 =E2=80=93vdev=3Dnet_tap1&gt;. After pr=
ocessing by DPDK, the
user-plane packets will be sent back to the physical port via DPDK=E2=80=99=
s TX
interface.&quot;

[To create a TAP device]
  sudo ip tuntap add dev dpdk_tap mode tap
  sudo ip link set dpdk_tap up
  sudo ip addr add 5.5.5.88/24 dev dpdk_tap=20
[To create a TAP device]
    snprintf(option[opt_num++], 128, &quot;dpdk_tap&quot;);
    snprintf(option[opt_num++], 128, &quot;--main-lcore=3D%u&quot;, dns_cfg=
.mx_cpu);
    snprintf(option[opt_num++], 128, &quot;--file-prefix=3Ddpdk_tap&quot;);
    snprintf(option[opt_num++], 128, &quot;-c0x%016llx%016llx%016llx%016llx=
&quot;,
            core_mask[3], core_mask[2], core_mask[1], core_mask[0]);
    snprintf(option[opt_num++], 128, &quot;-n4&quot;);
    snprintf(option[opt_num++], 128, &quot;--vdev=3Dnet_pcap0,iface=3Ddpdk_=
tap&quot;);
    snprintf(option[opt_num++], 128, &quot;--log-level=3Dlib.eal:debug&quot=
;);
    dpdk_opt_info_get(&amp;opt_num, option, &amp;dns_cfg);
    dpdk_pci_info_get(&amp;opt_num, option);

    int ret;
    if((ret =3D rte_eal_init(opt_num, option)) &lt; 0)
    {
        printf(&quot;!error: rte_eal_init failed\n&quot;);
        return false;
    }

[Error message&quot;]
EAL: Detected lcore 62 as core 12 on socket 0
EAL: Detected lcore 63 as core 12 on socket 1
EAL: Maximum logical cores by configuration: 128
EAL: Detected CPU lcores: 64
EAL: Detected NUMA nodes: 2
EAL: Checking presence of .so 'librte_eal.so.22.0'
EAL: Checking presence of .so 'librte_eal.so.22'
EAL: Checking presence of .so 'librte_eal.so'
EAL: Detected static linkage of DPDK
EAL: failed to parse device &quot;net_pcap0&quot;
EAL: Unable to parse device 'net_pcap0,iface=3Ddpdk_tap'
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
?id=3D1673">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17417726330.342458.1615080--
