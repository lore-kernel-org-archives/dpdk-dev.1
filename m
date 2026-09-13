Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A082EC88E63
	for <dpdk-dev@archiver.kernel.org>; Sun, 13 Sep 2026 17:51:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6AC844027A;
	Sun, 13 Sep 2026 19:51:43 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id E97564026E
 for <dev@dpdk.org>; Sun, 13 Sep 2026 19:51:41 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id C2D6F4D128; Sun, 13 Sep 2026 19:51:41 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 2043] ml/cnxk mvtvm: max_nb_qpairs parsed four
 bytes wide
Date: Sun, 13 Sep 2026 17:51:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 26.11
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
Message-ID: <bug-2043-3@https.bugs.dpdk.org/>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2043

            Bug ID: 2043
           Summary: ml/cnxk mvtvm: max_nb_qpairs parsed four bytes wide
           Product: DPDK
           Version: 26.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

drivers/ml/cnxk/mvtvm_ml_dev.c

parse_uint_arg() stores a uint32_t:

        *((uint32_t *)extra_args) =3D i;

but max_nb_qpairs is a uint16_t followed by an int in the same struct, so
parsing that argument writes past the field into its neighbour.

Fixes: 48c6081ab4b3 ("ml/cnxk: enable creation of MVTVM virtual device")

--=20
You are receiving this mail because:
You are the assignee for the bug.=
