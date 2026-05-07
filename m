Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C10ACD3444
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 14:24:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 119014060A;
	Thu,  7 May 2026 16:24:30 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 3A99B4026A
 for <dev@dpdk.org>; Thu,  7 May 2026 16:24:29 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 21F294B15A; Thu,  7 May 2026 16:24:29 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/DTS Bug 1943] dts: add missing device capability
Date: Thu, 07 May 2026 14:24:29 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: DTS
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: abailey@iol.unh.edu
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter cc
 target_milestone
Message-ID: <bug-1943-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1943

            Bug ID: 1943
           Summary: dts: add missing device capability
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: DTS
          Assignee: dev@dpdk.org
          Reporter: abailey@iol.unh.edu
                CC: juraj.linkes@pantheon.tech, probb@iol.unh.edu
  Target Milestone: ---

Device capabilities: 0x23( RUNTIME_RX_QUEUE_SETUP RUNTIME_TX_QUEUE_SETUP VM=
DQ )

There is currently a patch in that adds this VMDQ flag to device capabiliti=
es.
This field does not exist in the DeviceCapabilitiesFlag class and will cause
DTS to crash whenever present.

Add VMDQ field to DeviceCapabilitiesFlag class

--=20
You are receiving this mail because:
You are the assignee for the bug.=
