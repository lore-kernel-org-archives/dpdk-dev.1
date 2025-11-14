Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3EACDB480
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 03:48:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0935B40652;
	Fri, 14 Nov 2025 04:48:30 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 9788940151
 for <dev@dpdk.org>; Fri, 14 Nov 2025 04:48:28 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 7BF3648B01; Fri, 14 Nov 2025 04:48:28 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: =?UTF-8?B?W0RQREsvZXRoZGV2IEJ1ZyAxODI5XSBuZXQvbWx4Ne+8mm1idWYg?=
 =?UTF-8?B?bGVhayB3aGVuIHN0YXJ0IGRldmljZSBmYWlsZWQ=?=
Date: Fri, 14 Nov 2025 03:48:28 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 24.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: zhang_zx0130@163.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1829-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1829

            Bug ID: 1829
           Summary: net/mlx5=EF=BC=9Ambuf leak when start device failed
           Product: DPDK
           Version: 24.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: zhang_zx0130@163.com
  Target Milestone: ---

An error 'CQ creation failure' occurred when starting the device to setup r=
xq,
and causing mbuf leakage.

(1)We suspect that the CQ creation failure error is due to a compatibility
issue between the firmware and the driver.
(2)but the mbuf leak problem does exist, in the mlx5_rxq_start function,
priv->obj_ops.rxq_obj_new(rxq) returns an error because of the CQ error. and
goto release rxq(mlx5_rxq_release), since the values if rxq->rq_ci and
rxq->rq_pi have not been properly initialized, it causes an inability to
release the mbufs(rxq_free_elts_sprq: used=3D1024) .

log:
mlx5_net: port 1 starting device
mlx5_net: port 1 Rx queues number update: 1 -> 1
mlx5_net: port 1 Tx queue 0 allocated and configured 1024 WRs
mlx5_net: Port 1 txq 0 updated with 0x50000c338fe8.
mlx5_net: Port 1 max work queue size is 32768.
mlx5_net: Port 1 dev_cap.max_sge is 30.
mlx5_net: port 1 SPRQ queue 0 allocated and configured 1024 segments (max 1=
024
packets)
mlx5_net: Port 1 rxq 0 updated with 0x50000c342cd8.
mlx5_net: Port 1 Port 1 Rx queue 0 CQ creation failure.
mlx5_net: Port 1 Port 1 Rx queue 0 freeing 1024 WRs
mlx5_net: Port 1 Port 1 Rx queue allocation failed: Cannot allocate memory
mlx5_net: Port 1 Port 1 Rx queue 0 freeing WRs


DPDK: 24.11.2
driver in kernel: 24.10-2.1.8
firmware: 14.25.1020 (MT_2420110034)

#ethtool -i eth0
driver: mlx5_core
version: 24.10-2.1.8
firmware-version: 14.25.1020 (MT_2420110034)
expansion-rom-version:=20
bus-info: 0000:02:00.0
supports-statistics: yes
supports-test: yes
supports-eeprom-access: no
supports-register-dump: no
supports-priv-flags: yes

--=20
You are receiving this mail because:
You are the assignee for the bug.=
