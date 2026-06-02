Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF2DCD5BD1
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 22:30:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C95B402B6;
	Wed,  3 Jun 2026 00:30:29 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 95B66402A9
 for <dev@dpdk.org>; Wed,  3 Jun 2026 00:30:27 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 8381F4B5B0; Wed,  3 Jun 2026 00:30:27 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1949] function versioning is incompatible with LTO
Date: Tue, 02 Jun 2026 22:30:27 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
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
Message-ID: <bug-1949-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1949

            Bug ID: 1949
           Summary: function versioning is incompatible with LTO
           Product: DPDK
           Version: 25.07
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: minor
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

The default-version symver (@@) fails to assemble when build is using LTO.

Building a shared library with LTO fails when a function uses
RTE_DEFAULT_SYMBOL.
I introduces a new versioned symbol rte_eth_dev_get_name_by_port (ethdev).
This fails when doing LTO build with

invalid attempt to declare external version name as default
in symbol `rte_eth_dev_get_name_by_port@@DPDK_27'

Cause: the versioning macros emit a file-scope __asm__(".symver
=E2=80=A6@@DPDK_<ver>"). Top-level asm is opaque to LTO, so GCC may place t=
he directive
in a different ltrans partition than the _v<ver> definition. The implementa=
tion
symbol is then external in that partition, and gas rejects binding a default
version (@@) to an external symbol. Only the @@ (default) line fails; the
single-@ compat line is legal on an external symbol.

Fix: use the GCC symver function attribute (GCC =E2=89=A5 10) instead of to=
p-level asm,
gated on __has_attribute(symver); retain the asm path as fallback. Clang la=
cks
the attribute and stays on the asm path (LTO + versioning remains unsupport=
ed
there).

Marking severity as minor since no current in-tree code uses versioned symb=
ols.
But it is a trap waiting to happen.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
