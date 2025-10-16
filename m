Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE9ECCD19A
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 13:09:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7EAF240689;
	Thu, 16 Oct 2025 15:09:18 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 4D3EB40269
 for <dev@dpdk.org>; Thu, 16 Oct 2025 15:09:17 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 3844648956; Thu, 16 Oct 2025 15:09:17 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/DTS Bug 1803] DTS logs lose verbosity with addition of new
 IntEnum
Date: Thu, 16 Oct 2025 13:09:16 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: DTS
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: minor
X-Bugzilla-Who: abailey@iol.unh.edu
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 bug_file_loc op_sys bug_status bug_severity priority component assigned_to
 reporter cc target_milestone
Message-ID: <bug-1803-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1803

            Bug ID: 1803
           Summary: DTS logs lose verbosity with addition of new IntEnum
           Product: DPDK
           Version: unspecified
          Hardware: All
               URL: http://patchwork.dpdk.org/project/dpdk/patch/202509231
                    03758.3192015-2-paul.szczepanek@arm.com/
                OS: All
            Status: UNCONFIRMED
          Severity: minor
          Priority: Normal
         Component: DTS
          Assignee: dev@dpdk.org
          Reporter: abailey@iol.unh.edu
                CC: juraj.linkes@pantheon.tech, paul.szczepanek@arm.com,
                    probb@iol.unh.edu
  Target Milestone: ---

When DTS is run, the logs used to output the name of a NIC capability when a
test was skipped due to it missing said capability. The logs now output the
integer representation of the flag in the logs instead of the name of the
capability.
For Example: "reason: Required capability '{82}' not found."

--=20
You are receiving this mail because:
You are the assignee for the bug.=
