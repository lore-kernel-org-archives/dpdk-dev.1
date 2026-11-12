Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA9D606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 17:30:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 948AA415D7;
	Thu, 12 Nov 2026 18:30:10 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTPS id D201A40E32
 for <dev@dpdk.org>; Thu, 12 Nov 2026 18:30:08 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id B8A7D4D0C6; Thu, 12 Nov 2026 18:30:08 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/other Bug 2104] pipeline: table entry parser accepts actions
 not belonging to the table
Date: Thu, 12 Nov 2026 17:30:08 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: other
X-Bugzilla-Version: 26.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: major
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
Message-ID: <bug-2104-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2104

            Bug ID: 2104
           Summary: pipeline: table entry parser accepts actions not
                    belonging to the table
           Product: DPDK
           Version: 26.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: major
          Priority: Normal
         Component: other
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

Found by build with GCC 16 and -fanalyzer flag.

rte_swx_ctl_pipeline_table_entry_read() (lib/pipeline/rte_swx_ctl.c:3131) f=
inds
the action with action_find(ctl, tokens[1]), which searches all pipeline
actions. It does not check that the action is one of the table's actions.
entry->action_data is allocated from table->params.action_data_size (:321),=
 or
left NULL when that is 0. table_entry_action_argument_read() (:2896) then
copies the arguments into it. An entry line naming an action with more argu=
ment
bytes than the table allows writes past the buffer, or to NULL.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
