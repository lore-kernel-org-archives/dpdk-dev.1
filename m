Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF105CCD183
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 00:25:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABBF240EDD;
	Fri, 17 Oct 2025 02:25:25 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id B108D40269
 for <dev@dpdk.org>; Fri, 17 Oct 2025 02:25:23 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 8705C48959; Fri, 17 Oct 2025 02:25:23 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1804] net/ntnic: potential name conflict rte_tsc_freq
Date: Fri, 17 Oct 2025 00:25:23 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
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
Message-ID: <bug-1804-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1804

            Bug ID: 1804
           Summary: net/ntnic: potential name conflict rte_tsc_freq
           Product: DPDK
           Version: 25.07
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: minor
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

Drivers should not have global variables that could conflict with EAL.

drivers/net/ntnic $ git grep rte_tsc_freq
include/stream_binary_flow_api.h:extern uint64_t rte_tsc_freq;
ntnic_ethdev.c:uint64_t rte_tsc_freq;
ntnic_ethdev.c: rte_tsc_freq =3D 100 * (rte_get_tsc_cycles() - now_rtc);
ntnic_filter/ntnic_filter.c:    RTE_ASSERT(rte_tsc_freq > 0);
ntnic_filter/ntnic_filter.c:    if ((now_rtc - internals->last_stat_rtc) <
rte_tsc_freq) {
ntnic_filter/ntnic_filter.c:    if ((now_rtc - last_stat_rtc) < rte_tsc_fre=
q)

--=20
You are receiving this mail because:
You are the assignee for the bug.=
