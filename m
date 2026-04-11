Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88A5F3ED40
	for <dpdk-dev@archiver.kernel.org>; Sat, 11 Apr 2026 13:14:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DAC9E402A3;
	Sat, 11 Apr 2026 15:14:32 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 5170E4026A
 for <dev@dpdk.org>; Sat, 11 Apr 2026 15:14:31 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 3AFEA4AE88; Sat, 11 Apr 2026 15:14:31 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1935] rte_lcore_to_cpu_id returns incorrect cpu-id
 when `lcore-map or re-map lcore` option used
Date: Sat, 11 Apr 2026 13:14:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 26.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: vipin.varghese@amd.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1935-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1935

            Bug ID: 1935
           Summary: rte_lcore_to_cpu_id returns incorrect cpu-id when
                    `lcore-map or re-map lcore` option used
           Product: DPDK
           Version: 26.03
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: vipin.varghese@amd.com
  Target Milestone: ---

DPDK: 26.03
test application: modified examples/helloworld
cmd:=20
 working: `./build/helloworld -l0,1,67,14,33`
 faulty-1: `./build/helloworld -l0,1,67,14,33 -R`=20
 faulty-2: `./build/helloworld -l0@8,1@18,2@67,3@14,4@33`

expected behaviour: if there are eal args for remap or map lcore, the API (=
as
per current understanding) should return the actual core on which it runs. =
API
`rte_lcore_cpuset` returns a valid value in all cases.

attaching screenshot for reference

--=20
You are receiving this mail because:
You are the assignee for the bug.=
