Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640F2CCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 22:42:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6EF1E402DE;
	Thu, 16 Oct 2025 00:42:55 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 3EF8440273
 for <dev@dpdk.org>; Thu, 16 Oct 2025 00:42:54 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 2584E48948; Thu, 16 Oct 2025 00:42:54 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1802] bnxt PMD potential name conflicts
Date: Wed, 15 Oct 2025 22:42:54 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 25.07
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: minor
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
Message-ID: <bug-1802-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1802

            Bug ID: 1802
           Summary: bnxt PMD potential name conflicts
           Product: DPDK
           Version: 25.07
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: minor
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

The bnxt PMD exposes lots of symbols which do not use consistent prefix of
bnxt_ which could cause conflicts with user code and other PMD's when
statically linked.

bnxt :
0000000000000008 B mpc
00000000000002a0 D fec_mode
00000000000000c0 D link_speeds2_tbl
0000000000000000 D link_speeds_tbl
00000000000002e0 D link_status_str
0000000000000300 D media_type
0000000000000280 D signal_mode
0000000000007570 T vf_vnic_set_rxmask_cb
0000000000000050 T hweight32

0000000000000000 B bit
0000000000000000 D lfsr
0000000000000000 T rand16
0000000000000040 T rand32
0000000000000060 T rand_init
00000000000000f0 T stack_dump
0000000000000000 T stack_init
0000000000000050 T stack_is_empty
0000000000000060 T stack_is_full
0000000000000030 T stack_items
00000000000000b0 T stack_pop
0000000000000070 T stack_push
0000000000000040 T stack_size
0000000000000000 D mod_data
0000000000000370 T next_pow2
0000000000000390 T prev_pow2
00000000000003b0 T roundup32
00000000000003c0 T roundup64

--=20
You are receiving this mail because:
You are the assignee for the bug.=
