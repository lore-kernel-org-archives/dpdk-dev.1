Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8340FEA83B
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 10:08:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95761402CE;
	Wed, 25 Mar 2026 11:08:48 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id D4FC84028E
 for <dev@dpdk.org>; Wed, 25 Mar 2026 11:08:46 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id A2EC84AD99; Wed, 25 Mar 2026 11:08:46 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [wishes/any Bug 1913] Introduce RTE_EAL_INIT_PRIO() alternative to
 RTE_INIT_PRIO()
Date: Wed, 25 Mar 2026 10:08:46 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: wishes
X-Bugzilla-Component: any
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mb@smartsharesystems.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone bug_group
Message-ID: <bug-1913-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1913

            Bug ID: 1913
           Summary: Introduce RTE_EAL_INIT_PRIO() alternative to
                    RTE_INIT_PRIO()
           Product: wishes
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: any
          Assignee: dev@dpdk.org
          Reporter: mb@smartsharesystems.com
  Target Milestone: ---
             Group: wishes-managers

RTE_INIT_PRIO(func, prio) is a macro by which libraries and applications can
install a function to be called before application main().

I propose a similar macro, RTE_EAL_INIT_PRIO(func, prio), to install functi=
ons
to be called during different stages of rte_eal_init().

Example use cases:

1. Conceptually move the trace library out of the EAL library, so the trace
library is no longer a core library upon which the EAL library depends; ins=
tead
the trace library would depend on the EAL library.

2. Make lcore variables use DPDK memory.
If lcore variables were to use DPDK, it would also limit the use of the lco=
re
variable constructor macros (RTE_LCORE_VAR_INIT(), RTE_LCORE_VAR_INIT_SIZE(=
),
RTE_LCORE_VAR_INIT_SIZE_ALIGN()) to after DPDK memory has been initialized;
they can no longer be used by RTE_INIT()/RTE_INIT_PRIO() functions.
This is possible if the libraries/applications currently using
RTE_INIT()/RTE_INIT_PRIO() could use RTE_EAL_INIT_PRIO() instead.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
