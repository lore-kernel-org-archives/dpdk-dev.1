Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E445C61DBD
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 17:38:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A66F34025A;
	Fri, 28 Aug 2026 19:38:58 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 2980640151
 for <dev@dpdk.org>; Fri, 28 Aug 2026 19:38:57 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 1D6DD4CFA5; Fri, 28 Aug 2026 19:38:57 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 2015] memif: ring semantics differ from VPP
Date: Fri, 28 Aug 2026 17:38:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 26.11
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
Message-ID: <bug-2015-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2015

            Bug ID: 2015
           Summary: memif: ring semantics differ from VPP
           Product: DPDK
           Version: 26.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: minor
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

Found when doing AI assisted analysis and comparison of DPDK memif with VPP.


The two memif implementations disagree by one about what the hello
limit fields mean.

DPDK sends h->max_region =3D ETH_MEMIF_MAX_REGION_NUM - 1, treating the
field as an inclusive maximum index, and checks received indices with
>=3D against ETH_MEMIF_MAX_REGION_NUM.

VPP sends h->max_region =3D MEMIF_MAX_REGION (256) and checks received
indices with > rather than >=3D, so it accepts index 256 and therefore
257 regions. The same > form is used for its ring index checks.

Nothing is memory-unsafe on either side today, because both clamp what
they actually use, and VPP's regions are vectors. But the accepted range
and the advertised range do not agree, and the two stacks do not agree
with each other.

There is no memif specification outside VPP's tree, so this is the kind
of thing that only gets settled by writing it down. It should be pinned
in whatever wire contract comes out of the current memif hardening work,
and DPDK's side adjusted to match once the meaning is agreed.

Raised here so it is on the record and does not get fixed unilaterally
in one stack in a way that breaks the other.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
