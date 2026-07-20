Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBE5C44515
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Jul 2026 14:55:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FCEC4028E;
	Mon, 20 Jul 2026 16:55:32 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 7152740288
 for <dev@dpdk.org>; Mon, 20 Jul 2026 16:55:30 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 5CD014B8F1; Mon, 20 Jul 2026 16:55:30 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1971] [net/mlx5] PF initialization inside DPDK app
 conflicts with kernel bond on neighbouring port
Date: Mon, 20 Jul 2026 14:55:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 26.07
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: volodia.bond@gmail.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1971-3@http.bugs.dpdk.org/>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1971

            Bug ID: 1971
           Summary: [net/mlx5] PF initialization inside DPDK app conflicts
                    with kernel bond on neighbouring port
           Product: DPDK
           Version: 26.07
          Hardware: x86
                OS: Linux
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: volodia.bond@gmail.com
  Target Milestone: ---

## Overview

Seems like false positive detection of PF being a part of kernel bond and/or
wrong IBV device is assigned to DPDK ports when initialized along kernel bo=
nd.

Works with DPDK 25.03, possible regression after DPDK 26.03.

## Hardware and environment
* Debian 13 (trixie)
* 2 x ConnectX-6 Dx (MT2892 Family)
* Ethtool Info:=20
```
driver: mlx5_core
version: 6.12.94+deb13-amd64
firmware-version: 22.48.1000 (MT_0000000436)
```
* DPDK: main@bcd1686caa94aed1edf9f25dd1cc51175cedd1b7 (20.07.2026)
* Kernel devices: ens6f0np0 (38.00.0), ens6f1np1 (38.00.1), ens11f0np0
(98:00.0), ens11f0np0 (98:00.1)

* Network setup (might be simplified, but dunno if vlan/LAG matters)
```
# 1 port from each ConnectX-6 is bonded, remaining ports are used by DPDK.

S (server) <-> SW <-> C (client)

1. kernel bond <-> [ens6f1np1 + ens11f1np1] <-> trunk LAG, vlan.111
2. DPDK <-> [ens6f0np0 + ens11f0np0] <-> trunk LAG, vlan.222=20

C (client) should reach:
1. server bond IP via (ens6f1np1 | ens11f1np1) on vlan.111
2. [OPTIONAL] DPDK ports (ens6f0np0 | ens11f0np0) on vlan.222
```

## Steps to reproduce

1. Initilal state - testpmd is not running, no bond device present
2. Initialize bond device (IP network should match client subnet):
```
ip link del dev bond0 >/dev/null 2>&1=20
ip link add bond0 type bond mode balance-rr=20
ip link set ens6f1np1 down=20
ip link set ens11f1np1 down=20
ip link set ens6f1np1 master bond0=20
ip link set ens11f1np1 master bond0=20
ip link set bond0 up=20
ip link add link bond0 name test.111 type vlan id 111=20
ip addr add dev test.111 11.11.0.2/16 ip link set dev test.111 up
```
3. Start testpmd on non-bonded devices:
```
dpdk-testpmd --in-memory --no-telemetry -a 0000:38:00.0 -a 0000:98:00.0 -- =
-a
--forward-mode rxonly
```
4. Start C -> S pings via vlan.111 (targeting kernel bond)
5. Start tcpdump on bonded interfaces:=20
```
tcpdump -eni ens6f1np1
tcpdump -eni ens11f1np1
```

## Expected results
Bond device is accessible, ping is working, ICMP traffic is captured by
tcpdump.

## Actual results
No pings to bond device, no ICMP packets captured.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
