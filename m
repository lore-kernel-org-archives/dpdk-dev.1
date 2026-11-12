Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E20606A321
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 17:44:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B2CA42795;
	Thu, 12 Nov 2026 18:44:38 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTPS id 5FDA440E32
 for <dev@dpdk.org>; Thu, 12 Nov 2026 18:44:37 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 59F4D4D1AC; Thu, 12 Nov 2026 18:44:37 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 2117] net/cnxk: mulitple issues detected with GCC
 -fanalyzer
Date: Thu, 12 Nov 2026 17:44:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 26.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
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
Message-ID: <bug-2117-3@https.bugs.dpdk.org/>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

https://bugs.dpdk.org/show_bug.cgi?id=3D2117

            Bug ID: 2117
           Summary: net/cnxk: mulitple issues detected with GCC -fanalyzer
           Product: DPDK
           Version: 26.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

31. net/cnxk: process_ack_message() overwrites the buffer pointer it just
allocated
Component: ethdev | Severity: normal | Confidence: confirmed

drivers/net/cnxk/cnxk_rep_msg.c:338 sets adata->u.data =3D rte_zmalloc(...)=
. For
msg_len =3D=3D 8, :341 does rte_memcpy(&adata->u.data, buf, msg_len), overw=
riting
the pointer and leaking the allocation. For other sizes :343 copies into the
unchecked allocation.

32. net/cnxk: send_ack_message() never frees its buffer
Component: ethdev | Severity: normal | Confidence: confirmed

drivers/net/cnxk/cnxk_rep_msg.c:552 allocates buffer (CTRL_MSG_BUFFER_SZ). =
No
path frees it; the function ends at done: return rc; (:575).

33. net/cnxk: unchecked plt_zmalloc() in representor message and flow code
Component: ethdev | Severity: minor | Confidence: single pass

drivers/net/cnxk/cnxk_rep_msg.c:391, :419, :451, :613 and cnxk_rep_flow.c:2=
13,
:223 use the plt_zmalloc() result without a NULL check. At cnxk_rep_msg.c:4=
19
the new adata also replaces the one stored at :394, which is leaked.

34. net/cnxk: flow leaked in cnxk_eswitch_pfvf_flow_rules_install()
Component: ethdev | Severity: minor | Confidence: single pass

drivers/net/cnxk/cnxk_eswitch_flow.c:395 allocates flow. The goto free_flow
paths (:403-429) call cnxk_eswitch_flow_rules_remove_list(), which only fre=
es
list members; flow is not on the list yet.

35. net/cnxk: msg leaked in cnxk_representee_notification()
Component: ethdev | Severity: minor | Confidence: single pass

drivers/net/cnxk/cnxk_rep.c:398 allocates msg; when the notify_msg allocati=
on
fails (:406-409) it jumps to done without freeing msg.

36. net/cnxk: TM node and shaper profile leaked when roc add fails
Component: ethdev | Severity: normal | Confidence: single pass

cnxk_nix_tm_shaper_profile_add() (drivers/net/cnxk/cnxk_tm.c:306-312) and
cnxk_nix_tm_node_add() (:394-399) return on a roc error without freeing the
profile or node they allocated. Reachable with invalid user parameters.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
