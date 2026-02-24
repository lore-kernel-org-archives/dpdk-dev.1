Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232ABEFB7F9
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 09:25:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09D894027F;
	Tue, 24 Feb 2026 10:25:32 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id D0058400D5
 for <dev@dpdk.org>; Tue, 24 Feb 2026 10:25:30 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 9F9494AC8C; Tue, 24 Feb 2026 10:25:30 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1894] Log library macros pollute the preprocessor
 namespace
Date: Tue, 24 Feb 2026 09:25:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
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
 target_milestone
Message-ID: <bug-1894-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1894

            Bug ID: 1894
           Summary: Log library macros pollute the preprocessor namespace
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: mb@smartsharesystems.com
  Target Milestone: ---

RTE_LOG macros take the severity level parameter without the RTE_LOG prefix,
e.g. RTE_LOG(DEBUG, MEMPOOL, "Something unexpected happened.");

If the application defines a macro named DEBUG, INFO, WARNING, ALERT, or any
other syslog severity name, the application cannot use the RTE_LOG macros, =
as
the application defined macro will be expanded.

For example:
#define DEBUG 2 /* Debug level. */
RTE_LOG(DEBUG, USER1, "Problem.");

Will first expand the DEBUG definition as:
RTE_LOG(2, USER1, "Problem.");

And then, according to the log library using:
#define RTE_LOG(l, t, ...) \
rte_log(RTE_LOG_ ## l, RTE_LOGTYPE_ ## t, # t ": " __VA_ARGS__)

expand to:
rte_log(RTE_LOG_2, RTE_LOGTYPE_USER1, "USER1: Problem.");

There is no such thing as RTE_LOG_2, so the build will fail.

Changing the RTE_LOG macro to require the full names for severity level and=
 log
type, e.g. RTE_LOG(RTE_LOG_DEBUG, RTE_LOGTYPE_USER1, "Problem."), would fix=
 the
namespace pollution; but it would require updating many source code files.
Backwards compatible macros could be defined in the log library header file
(rte_log.h) for applications still passing the non-prefixed names, e.g.:
#define DEBUG RTE_LOG_DEBUG

As an alternative workaround, the log library header file could define all =
the
shorthand (prefix stripped) names for log severity level and log type, so t=
he
preprocessor emits a warning if the application also defines any macro with=
 one
of those names.
E.g., in rte_log.h:
#define DEBUG DEBUG
#define USER1 USER1

For this workaround, we would also have to do something similar for the log
types defined in all libraries, e.g. in the mempool library header file:

extern int rte_mempool_logtype;
#define RTE_LOGTYPE_MEMPOOL     rte_mempool_logtype
+ #define MEMPOOL MEMPOOL
#define RTE_MEMPOOL_LOG(level, ...) \
        RTE_LOG_LINE(level, MEMPOOL, "" __VA_ARGS__)

--=20
You are receiving this mail because:
You are the assignee for the bug.=
