Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BD0D72371
	for <dpdk-dev@archiver.kernel.org>; Sun, 25 Jan 2026 21:17:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09C784026F;
	Sun, 25 Jan 2026 22:17:26 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 53CCE40269
 for <dev@dpdk.org>; Sun, 25 Jan 2026 22:17:24 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 453424A2DB; Sun, 25 Jan 2026 22:17:24 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/other Bug 1871] idxd_dmadev.portal volatile usage
Date: Sun, 25 Jan 2026 21:17:23 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: other
X-Bugzilla-Version: 21.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: scott.k.mitch1@gmail.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1871-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1871

            Bug ID: 1871
           Summary: idxd_dmadev.portal volatile usage
           Product: DPDK
           Version: 21.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: other
          Assignee: dev@dpdk.org
          Reporter: scott.k.mitch1@gmail.com
  Target Milestone: ---

idxd_dmadev_probe_pci uses RTE_PTR_ADD(idxd.u.pci->portals) [1] where the
argument is volatile [2] and assigns the result to idxd_dmadev.portal which=
 is
not volatile [3]. Disqualifying quantifiers should be done explicitly if
desired (not implicitly through RTE_PTR_ADD) and clear comments added, or
qualifiers should be preserved.

[1]
https://github.com/DPDK/dpdk/commit/9449330a845868de810b1c41b4b8e72ad41e031=
e#diff-976cfc47c9f1dfe38582a76e3dafe1275c55e44af64c6573ea1674c8bd94c560R260

[2]
https://github.com/DPDK/dpdk/commit/9449330a845868de810b1c41b4b8e72ad41e031=
e#diff-54e4d0d3f90a1a90e85160d1cd74aba322b2ed5743eed090fa00028fdbf70539R39

[3]
https://github.com/DPDK/dpdk/commit/e888bb1278c6c72f1bef774f14a9ee483626562=
4#diff-54e4d0d3f90a1a90e85160d1cd74aba322b2ed5743eed090fa00028fdbf70539R40

--=20
You are receiving this mail because:
You are the assignee for the bug.=
