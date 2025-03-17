Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C32FC282EC
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Mar 2025 07:40:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 230A0402BB;
	Mon, 17 Mar 2025 08:40:34 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 081F740291
 for <dev@dpdk.org>; Mon, 17 Mar 2025 08:40:33 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id E282846406; Mon, 17 Mar 2025 08:40:32 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1677] E810 VLAN Stripping Offload broken with
 multiple RX queues
Date: Mon, 17 Mar 2025 07:40:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 24.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: roemerthorben@web.de
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1677-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17421972320.8Aa61.1848440
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


--17421972320.8Aa61.1848440
Date: Mon, 17 Mar 2025 08:40:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1677

            Bug ID: 1677
           Summary: E810 VLAN Stripping Offload broken with multiple RX
                    queues
           Product: DPDK
           Version: 24.11
          Hardware: x86
                OS: Linux
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: roemerthorben@web.de
  Target Milestone: ---

## Overwiew
When using net/ice with E810 NICs and multiple RX queues, hardware VLAN
stripping seems to be working inconsistently, leading to missing VLAN
information for some received packets.

## Setup + Build
* x86-build on Debian Bookworm
* DPDK 24.11 and current main (2025-03-14,
7d6c28c9199351805e693e9b8f58f60e6f51c2ab) were tested
* E810 NIC with firmware 4.0 and 4.6 were tested
* ice DDP (1.3.30.0, ICE OS Default Package (double VLAN mode)) and (1.3.46=
.0,
ICE COMMS package (double VLAN mode)) were tested
* AVX2 Vector Rx is chosen by ice driver ("ICE_DRIVER: ice_set_rx_function(=
):
Using AVX2 OFFLOAD Vector Rx (port 0)")

## Steps to Reproduce
1. Start testpmd with two rx queues:
./dpdk-testpmd -- -i --enable-hw-vlan-strip --rxq 2 --txq 2
testpmd> show port 0 rx_offload configuration
Rx Offloading Configuration of port 0 :
  Port : VLAN_STRIP RSS_HASH
  Queue[ 0] : VLAN_STRIP RSS_HASH
  Queue[ 1] : VLAN_STRIP RSS_HASH
testpmd> set verbose 1
Change verbose level from 0 to 1
testpmd> start

2. Send multiple IPv4+UDP packets with VLAN 100 and different destination IP
addresses until packets for both queues are received. testpmd output:
src=3DXX:XX:XX:XX:XX:XX - dst=3DYY:YY:YY:YY:YY:YY - pool=3Dmb_pool_0 - type=
=3D0x0800 -
length=3D60 - nb_segs=3D1 - RSS hash=3D0xfd40ac19 - RSS queue=3D0x1 - VLAN =
tci=3D0x64 -
hw ptype: L2_ETHER L3_IPV4_EXT_UNKNOWN L4_UDP  - sw ptype: L2_ETHER L3_IPV4
L4_UDP  - l2_len=3D14 - l3_len=3D20 - l4_len=3D8 - Destination UDP port=3D1=
234 -
Receive queue=3D0x1
ol_flags: RTE_MBUF_F_RX_VLAN RTE_MBUF_F_RX_RSS_HASH RTE_MBUF_F_RX_L4_CKSUM_=
GOOD
RTE_MBUF_F_RX_IP_CKSUM_GOOD RTE_MBUF_F_RX_VLAN_STRIPPED
RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD=20

src=3DXX:XX:XX:XX:XX:XX - dst=3DYY:YY:YY:YY:YY:YY - pool=3Dmb_pool_0 - type=
=3D0x0800 -
length=3D60 - nb_segs=3D1 - RSS hash=3D0x91fa772a - RSS queue=3D0x0 - hw pt=
ype:
L2_ETHER L3_IPV4_EXT_UNKNOWN L4_UDP  - sw ptype: L2_ETHER L3_IPV4 L4_UDP  -
l2_len=3D14 - l3_len=3D20 - l4_len=3D8 - Destination UDP port=3D1234 - Rece=
ive
queue=3D0x0
ol_flags: RTE_MBUF_F_RX_RSS_HASH RTE_MBUF_F_RX_L4_CKSUM_GOOD
RTE_MBUF_F_RX_IP_CKSUM_GOOD RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD=20

3. The mbuf for the packet received by queue 0x1 (first packet displayed he=
re)
is looking as expected:
* `RTE_MBUF_F_RX_VLAN_STRIPPED` is set in `ol_flags`
* `VLAN tci` is 0x64=3D100=20
* `type` (ethertype) is 0x0800 becase VLAN header was stripped, leaving
0x0800=3DIPv4.

The mbuf for the second packet, received by queue 0x0, looks broken: `ol_fl=
ags`
does not contain `RTE_MBUF_F_RX_VLAN_STRIPPED` and `VLAN tci` is not set, w=
hich
indicates that the VLAN was not stripped. But `type` (ethertype) is still
0x0800, as if the VLAN header had been stripped. If no VLAN was stripped, t=
he
type should be 0x8100. If the VLAN was stripped, `ol_flags` and `VLAN tci`
should be set. This inconsistency means that the VLAN information was
completely lost and can not be recovered by the userspace application for
packets received by queue 0x0.

## Additional Information
The issue is also present in a custom user space application, so it seems
unlikely to be an error in testpmd.

According to ice.ini in docs/, the driver should fully support VLAN Strippi=
ng
even in vector paths.

The issue occurs since commit
http://git.dpdk.org/dpdk/commit/drivers/net/ice?id=3D882ed13a2a8c3b5cba48c1=
5af710bf09d445094a.
Before that (or if reverted), no VLAN is stripped but the mbuf is consisten=
t at
least (type 0x8100).

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17421972320.8Aa61.1848440
Date: Mon, 17 Mar 2025 08:40:32 +0100
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
   title=3D"UNCONFIRMED - E810 VLAN Stripping Offload broken with multiple =
RX queues"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1677">1677</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>E810 VLAN Stripping Offload broken with multiple RX queues
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
          <td>roemerthorben&#64;web.de
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">## Overwiew
When using net/ice with E810 NICs and multiple RX queues, hardware VLAN
stripping seems to be working inconsistently, leading to missing VLAN
information for some received packets.

## Setup + Build
* x86-build on Debian Bookworm
* DPDK 24.11 and current main (2025-03-14,
7d6c28c9199351805e693e9b8f58f60e6f51c2ab) were tested
* E810 NIC with firmware 4.0 and 4.6 were tested
* ice DDP (1.3.30.0, ICE OS Default Package (double VLAN mode)) and (1.3.46=
.0,
ICE COMMS package (double VLAN mode)) were tested
* AVX2 Vector Rx is chosen by ice driver (&quot;ICE_DRIVER: ice_set_rx_func=
tion():
Using AVX2 OFFLOAD Vector Rx (port 0)&quot;)

## Steps to Reproduce
1. Start testpmd with two rx queues:
./dpdk-testpmd -- -i --enable-hw-vlan-strip --rxq 2 --txq 2
testpmd&gt; show port 0 rx_offload configuration
Rx Offloading Configuration of port 0 :
  Port : VLAN_STRIP RSS_HASH
  Queue[ 0] : VLAN_STRIP RSS_HASH
  Queue[ 1] : VLAN_STRIP RSS_HASH
testpmd&gt; set verbose 1
Change verbose level from 0 to 1
testpmd&gt; start

2. Send multiple IPv4+UDP packets with VLAN 100 and different destination IP
addresses until packets for both queues are received. testpmd output:
src=3DXX:XX:XX:XX:XX:XX - dst=3DYY:YY:YY:YY:YY:YY - pool=3Dmb_pool_0 - type=
=3D0x0800 -
length=3D60 - nb_segs=3D1 - RSS hash=3D0xfd40ac19 - RSS queue=3D0x1 - VLAN =
tci=3D0x64 -
hw ptype: L2_ETHER L3_IPV4_EXT_UNKNOWN L4_UDP  - sw ptype: L2_ETHER L3_IPV4
L4_UDP  - l2_len=3D14 - l3_len=3D20 - l4_len=3D8 - Destination UDP port=3D1=
234 -
Receive queue=3D0x1
ol_flags: RTE_MBUF_F_RX_VLAN RTE_MBUF_F_RX_RSS_HASH RTE_MBUF_F_RX_L4_CKSUM_=
GOOD
RTE_MBUF_F_RX_IP_CKSUM_GOOD RTE_MBUF_F_RX_VLAN_STRIPPED
RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD=20

src=3DXX:XX:XX:XX:XX:XX - dst=3DYY:YY:YY:YY:YY:YY - pool=3Dmb_pool_0 - type=
=3D0x0800 -
length=3D60 - nb_segs=3D1 - RSS hash=3D0x91fa772a - RSS queue=3D0x0 - hw pt=
ype:
L2_ETHER L3_IPV4_EXT_UNKNOWN L4_UDP  - sw ptype: L2_ETHER L3_IPV4 L4_UDP  -
l2_len=3D14 - l3_len=3D20 - l4_len=3D8 - Destination UDP port=3D1234 - Rece=
ive
queue=3D0x0
ol_flags: RTE_MBUF_F_RX_RSS_HASH RTE_MBUF_F_RX_L4_CKSUM_GOOD
RTE_MBUF_F_RX_IP_CKSUM_GOOD RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD=20

3. The mbuf for the packet received by queue 0x1 (first packet displayed he=
re)
is looking as expected:
* `RTE_MBUF_F_RX_VLAN_STRIPPED` is set in `ol_flags`
* `VLAN tci` is 0x64=3D100=20
* `type` (ethertype) is 0x0800 becase VLAN header was stripped, leaving
0x0800=3DIPv4.

The mbuf for the second packet, received by queue 0x0, looks broken: `ol_fl=
ags`
does not contain `RTE_MBUF_F_RX_VLAN_STRIPPED` and `VLAN tci` is not set, w=
hich
indicates that the VLAN was not stripped. But `type` (ethertype) is still
0x0800, as if the VLAN header had been stripped. If no VLAN was stripped, t=
he
type should be 0x8100. If the VLAN was stripped, `ol_flags` and `VLAN tci`
should be set. This inconsistency means that the VLAN information was
completely lost and can not be recovered by the userspace application for
packets received by queue 0x0.

## Additional Information
The issue is also present in a custom user space application, so it seems
unlikely to be an error in testpmd.

According to ice.ini in docs/, the driver should fully support VLAN Strippi=
ng
even in vector paths.

The issue occurs since commit
<a href=3D"http://git.dpdk.org/dpdk/commit/drivers/net/ice?id=3D882ed13a2a8=
c3b5cba48c15af710bf09d445094a">http://git.dpdk.org/dpdk/commit/drivers/net/=
ice?id=3D882ed13a2a8c3b5cba48c15af710bf09d445094a</a>.
Before that (or if reverted), no VLAN is stripped but the mbuf is consisten=
t at
least (type 0x8100).
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
?id=3D1677">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17421972320.8Aa61.1848440--
