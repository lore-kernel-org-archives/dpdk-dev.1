Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8632EC43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 00:02:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 093404021E;
	Tue, 30 Jun 2026 02:02:48 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 7DA1940150
 for <dev@dpdk.org>; Tue, 30 Jun 2026 02:02:46 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 53F7F4B7C1; Tue, 30 Jun 2026 02:02:46 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1960] Many PMD's provide receive timestamp but are
 missing the read_clock ethdev operation
Date: Tue, 30 Jun 2026 00:02:45 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 22.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: stephen@networkplumber.org
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1960-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1960

            Bug ID: 1960
           Summary: Many PMD's provide receive timestamp but are missing
                    the read_clock ethdev operation
           Product: DPDK
           Version: 22.03
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

The implementation of receive timestamp is inconsistent in DPDK.
If a driver advertises RX timestamp offload it must also have the facility =
to
tell application what units that timestamp is in.  Some searching showed.

 Summary

  You're absolutely right - many DPDK drivers that advertise
RTE_ETH_RX_OFFLOAD_TIMESTAMP capability don't implement the
  read_clock ethdev operation properly. Here's the breakdown:

  Drivers with PROPER implementation (have both timestamp support and
read_clock):

  - cnxk - Marvell OCTEON
  - mlx5 - Mellanox/NVIDIA
  - pcap - Software pcap driver
  - intel/e1000 (igb, igc) - Intel 1G NICs
  - intel/ice - Intel E810 NICs

  Drivers MISSING read_clock implementation despite supporting timestamps:

  - af_packet - Linux AF_PACKET
  - ark - Atomic Rules Arkville
  - bnxt - Broadcom NetXtreme
  - dpaa2 - NXP DPAA2
  - ena - Amazon ENA
  - failsafe - Fail-safe PMD
  - hns3 - Huawei HiSilicon
  - nfb - Cesnet NFB
  - sxe2 - Wangxun SXE2000
  - xsc - Yunsilicon XSC
  - intel/cpfl - Intel Infrastructure Processing Unit
  - intel/iavf - Intel Adaptive Virtual Function
  - intel/idpf - Intel Infrastructure Data Path Function

--=20
You are receiving this mail because:
You are the assignee for the bug.=
