Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619E4C7114A
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 06:35:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62F2E402ED;
	Tue, 17 Jun 2025 08:35:03 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 46B2A402DC
 for <dev@dpdk.org>; Tue, 17 Jun 2025 08:35:02 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 31D5E469D4; Tue, 17 Jun 2025 08:35:02 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1725] iavf pmd vlan Issue: dpdk-22.11.0
Date: Tue, 17 Jun 2025 06:35:01 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 22.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: major
X-Bugzilla-Who: amiyaranjan.mohakud@gmail.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1725-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17501421020.aae5b.2061179
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


--17501421020.aae5b.2061179
Date: Tue, 17 Jun 2025 08:35:01 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1725

            Bug ID: 1725
           Summary: iavf pmd vlan Issue: dpdk-22.11.0
           Product: DPDK
           Version: 22.11
          Hardware: x86
                OS: Linux
            Status: UNCONFIRMED
          Severity: major
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: amiyaranjan.mohakud@gmail.com
  Target Milestone: ---

Hi All,

I'm encountering an issue with XL710 SR-IOV on KVM for VLAN packets with
DPDK-22.11.0 version.=20

Issue Description: I have disabled RTE_ETH_RX_OFFLOAD_VLAN_STRIP in
rte_eth_conf and calling rte_eth_dev_configure and expecting my dpdk
application to receive the packets with vlan tags. Later I added some vlans
using rte_eth_dev_vlan_filter() and I see that the vlan is getting stripped=
 off
 for the incoming packets.=20

Setup Details:(KVM SR-IOV)

KVM Host: Ubuntu 20.04.6 LTS: kernel version: 5.4.0-216-generic #236-Ubuntu
NIC: XL710
3b:00.0 Ethernet controller: Intel Corporation Ethernet Controller XL710 for
40GbE QSFP+ (rev 02)
3b:00.1 Ethernet controller: Intel Corporation Ethernet Controller XL710 for
40GbE QSFP+ (rev 02)
i40e PF Driver: Out of tree 2.20.12
Firmware: 9.00/9.40=20
DPDK Version: 22.11.0


Observation/Analysis:

I could see that even after disabling RTE_ETH_RX_OFFLOAD_VLAN_STRIP offload
flag, when I receive the packets, the mbuf offload flags (RTE_MBUF_F_RX_VLA=
N |
RTE_MBUF_F_RX_VLAN_STRIPPED) are set inside the mbuf. This confirms that the
driver is stripping off the vlans.


I tried with recommended PF driver version for DPDK-22.11.0 as per
https://mails.dpdk.org/archives/dev/2023-November/281700.html and DPDK-22.11
release note https://doc.dpdk.org/guides/rel_notes/release_22_11.html. Stil=
l it
did not help.


       Intel=C2=AE Ethernet Converged Network Adapter XL710-QDA2 (2X40G)
    Firmware version(PF): 9.00 0x8000ce86 1.3179.0
    Device id (pf/vf): 8086:1583 / 8086:154c
    Driver version(out-tree): 2.20.12 (i40e)
    Driver version(in-tree): 5.15.0-46-generic (i40e)


Upon debugging further, I came across a DPDK commit:
https://github.com/DPDK/dpdk/commit/e25c7ed114b296ddaa583427824acc30bcf9c85d
which says it sets the vlan_strip on in PF when we set vlan filter on VF.=20

I picked the fix, but still it did not help.

Later when I debugged further, I found that the vf_cap_flags is set to
VIRTCHNL_VF_OFFLOAD_VLAN_V2 for the above PF driver and still it sets the
vlan_strip on. I extended the dpdk commit for the VIRTCHNL_VF_OFFLOAD_VLAN_=
V2
case which fixed the issue.


I just want to know if it's a known issue for the VIRTCHNL_VF_OFFLOAD_VLAN_=
V2
case. I understand it's a known issue for VIRTCHNL_VF_OFFLOAD_VLAN_V1 and d=
pdk
has a fix for it.=20
Do we need to add the fix for VIRTCHNL_VF_OFFLOAD_VLAN_V2 as well. Can we
mainstream it? If yes, please let me know so that I can raise a pull request
for it, if required.

Regards
Amiya

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17501421020.aae5b.2061179
Date: Tue, 17 Jun 2025 08:35:02 +0200
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
   title=3D"UNCONFIRMED - iavf pmd vlan Issue: dpdk-22.11.0"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1725">1725</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>iavf pmd vlan Issue: dpdk-22.11.0
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>22.11
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
          <td>amiyaranjan.mohakud&#64;gmail.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">Hi All,

I'm encountering an issue with XL710 SR-IOV on KVM for VLAN packets with
DPDK-22.11.0 version.=20

Issue Description: I have disabled RTE_ETH_RX_OFFLOAD_VLAN_STRIP in
rte_eth_conf and calling rte_eth_dev_configure and expecting my dpdk
application to receive the packets with vlan tags. Later I added some vlans
using rte_eth_dev_vlan_filter() and I see that the vlan is getting stripped=
 off
 for the incoming packets.=20

Setup Details:(KVM SR-IOV)

KVM Host: Ubuntu 20.04.6 LTS: kernel version: 5.4.0-216-generic #236-Ubuntu
NIC: XL710
3b:00.0 Ethernet controller: Intel Corporation Ethernet Controller XL710 for
40GbE QSFP+ (rev 02)
3b:00.1 Ethernet controller: Intel Corporation Ethernet Controller XL710 for
40GbE QSFP+ (rev 02)
i40e PF Driver: Out of tree 2.20.12
Firmware: 9.00/9.40=20
DPDK Version: 22.11.0


Observation/Analysis:

I could see that even after disabling RTE_ETH_RX_OFFLOAD_VLAN_STRIP offload
flag, when I receive the packets, the mbuf offload flags (RTE_MBUF_F_RX_VLA=
N |
RTE_MBUF_F_RX_VLAN_STRIPPED) are set inside the mbuf. This confirms that the
driver is stripping off the vlans.


I tried with recommended PF driver version for DPDK-22.11.0 as per
<a href=3D"https://mails.dpdk.org/archives/dev/2023-November/281700.html">h=
ttps://mails.dpdk.org/archives/dev/2023-November/281700.html</a> and DPDK-2=
2.11
release note <a href=3D"https://doc.dpdk.org/guides/rel_notes/release_22_11=
.html">https://doc.dpdk.org/guides/rel_notes/release_22_11.html</a>. Still =
it
did not help.


       Intel=C2=AE Ethernet Converged Network Adapter XL710-QDA2 (2X40G)
    Firmware version(PF): 9.00 0x8000ce86 1.3179.0
    Device id (pf/vf): 8086:1583 / 8086:154c
    Driver version(out-tree): 2.20.12 (i40e)
    Driver version(in-tree): 5.15.0-46-generic (i40e)


Upon debugging further, I came across a DPDK commit:
<a href=3D"https://github.com/DPDK/dpdk/commit/e25c7ed114b296ddaa583427824a=
cc30bcf9c85d">https://github.com/DPDK/dpdk/commit/e25c7ed114b296ddaa5834278=
24acc30bcf9c85d</a>
which says it sets the vlan_strip on in PF when we set vlan filter on VF.=20

I picked the fix, but still it did not help.

Later when I debugged further, I found that the vf_cap_flags is set to
VIRTCHNL_VF_OFFLOAD_VLAN_V2 for the above PF driver and still it sets the
vlan_strip on. I extended the dpdk commit for the VIRTCHNL_VF_OFFLOAD_VLAN_=
V2
case which fixed the issue.


I just want to know if it's a known issue for the VIRTCHNL_VF_OFFLOAD_VLAN_=
V2
case. I understand it's a known issue for VIRTCHNL_VF_OFFLOAD_VLAN_V1 and d=
pdk
has a fix for it.=20
Do we need to add the fix for VIRTCHNL_VF_OFFLOAD_VLAN_V2 as well. Can we
mainstream it? If yes, please let me know so that I can raise a pull request
for it, if required.

Regards
Amiya
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
?id=3D1725">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17501421020.aae5b.2061179--
