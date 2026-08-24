Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FE4C5DF81
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 15:56:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF6024065A;
	Mon, 24 Aug 2026 17:56:11 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 799E340270
 for <dev@dpdk.org>; Mon, 24 Aug 2026 17:56:10 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 4F5EF4C9EE; Mon, 24 Aug 2026 17:56:10 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1986] dpaax: build warnings with clang-23
Date: Mon, 24 Aug 2026 15:56:09 +0000
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
Message-ID: <bug-1986-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D1986

            Bug ID: 1986
           Summary: dpaax: build warnings with clang-23
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

Clang 23 checks for set but not used global variables.



  ../drivers/common/dpaax/dpaa_of.c:14:12: error: variable 'alive' set but =
not
used
     [-Werror,-Wunused-but-set-global]
     14 | static int alive;
        |            ^

  clang-23 extends -Wunused-but-set-variable to file-scope statics
  (-Wunused-but-set-global), which is enabled by -Wall and fatal under -Wer=
ror.
  Earlier clang and GCC releases do not diagnose this case, so the code bui=
lds
  there.


  alive is assigned in of_init_path() and of_finish(), and is otherwise
referenced
  only as the condition argument to DPAAX_HWWARN(), at 13 call sites in
dpaa_of.c.
  That macro is defined in drivers/common/dpaax/dpaax_logs.h:

  #ifdef RTE_LIBRTE_DPAAX_DEBUG
  #define DPAAX_HWWARN(cond, fmt, ...) \
        do {\
                if (cond) \
                        DPAAX_LOG(DEBUG, "WARN: " fmt, ##__VA_ARGS__); \
        } while (0)
  #else
  #define DPAAX_HWWARN(cond, fmt, ...) do { } while (0)
  #endif

  The disabled variant discards cond entirely, so alive is never read =E2=
=80=94 hence
the
  warning.

There are three options:
1. Remove all this code, since RTE_LIBRTE_DPAAX_DEBUG is not defined anywhe=
re
and there is no meson build to set it. I.e dead code.

2. Add 0 to the do { } while() like:

#ifdef RTE_LIBRTE_DPAAX_DEBUG
#define DPAAX_HWWARN(cond, fmt, ...) \
        do {\
                if (cond) \
                        DPAAX_LOG(DEBUG, "WARN: " fmt, ##__VA_ARGS__); \
        } while (0)
#else
#define DPAAX_HWWARN(cond, fmt, ...) \
        do {\
                if (0 && (cond)) \
                        break; \
        } while (0)
#endif

3. Cleanup and keep the check.
Rename the variable because 'alive' is not descriptive.
Always do the check (no #ifdef) since it is good bug trap.
Make it a warning or notice level since buggy device tree is worth checking.

That would end up renaming or removing macro.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
