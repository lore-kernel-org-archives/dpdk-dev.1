Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B404CC79F80
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 08:37:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F2A842E4F;
	Fri,  4 Sep 2026 10:37:00 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id CAD54427E6
 for <dev@dpdk.org>; Fri,  4 Sep 2026 10:36:58 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id A6E544D071; Fri,  4 Sep 2026 10:36:58 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 2030] Duplicate mbox_alloc_msg_npa_aq_enq() causes
 orphaned AQ message to be sent to AF
Date: Fri, 04 Sep 2026 08:36:58 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 24.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: major
X-Bugzilla-Who: amiyaranjan.mohakud@gmail.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone attachments.created
Message-ID: <bug-2030-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2030

            Bug ID: 2030
           Summary: Duplicate mbox_alloc_msg_npa_aq_enq() causes orphaned
                    AQ message to be sent to AF
           Product: DPDK
           Version: 24.11
          Hardware: ARM
                OS: Linux
            Status: UNCONFIRMED
          Severity: major
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: amiyaranjan.mohakud@gmail.com
  Target Milestone: ---

Created attachment 389
  --> https://bugs.dpdk.org/attachment.cgi?id=3D389&action=3Dedit
Issue description

In npa_aura_pool_init(), the pool init message allocation is performed twic=
e on
non-CN20K platforms (e.g. CN10K).=20
Line 110 allocates a message via the else branch, but line 112 unconditiona=
lly
allocates another message, overwriting the pool_init_req pointer. The messa=
ge
allocated at line 110 is never initialized by the caller and is sent to the=
 AF
with only its mbox header (sig, id) set =E2=80=94 all other fields (aura_id=
, ctype, op,
context data) contain whatever was in the mbox buffer at the time of
allocation.

  // roc_npa.c lines 106-118

 106         if (roc_model_is_cn20k()) {
 107                 pool_init_req_cn20k =3D
mbox_alloc_msg_npa_cn20k_aq_enq(mbox);
 108                 pool_init_req =3D (struct npa_aq_enq_req
*)pool_init_req_cn20k;
 109         } else {
 110                 pool_init_req =3D mbox_alloc_msg_npa_aq_enq(mbox);=20
 111         }
 112         pool_init_req =3D mbox_alloc_msg_npa_aq_enq(mbox);
 113         if (pool_init_req =3D=3D NULL)
 114                 goto exit;
 115         pool_init_req->aura_id =3D aura_id;
 116         pool_init_req->ctype =3D NPA_AQ_CTYPE_POOL;
 117         pool_init_req->op =3D NPA_AQ_INSTOP_INIT;
 118         mbox_memcpy(&pool_init_req->pool, pool, sizeof(*pool));


As a result, mbox_process() at line 120 sends three NPA_AQ_ENQ messages to =
the
AF instead of the intended two (AURA_INIT + POOL_INIT). The orphaned messag=
e is
processed by the AF with uninitialized fields.

On CN20K, the same issue exists: line 107 allocates via
mbox_alloc_msg_npa_cn20k_aq_enq(), and line 112 allocates again
unconditionally.


Impact:

  - Every call to roc_npa_pool_create() sends a spurious AQ command to the =
AF
with uninitialized payload. This occurs once per pool/aura pair created dur=
ing
the lifetime of the application.

  - The uninitialized fields default to ctype=3D0 (NPA_AQ_CTYPE_AURA) and o=
p=3D0
(NPA_AQ_INSTOP_NOP) if the mbox buffer was zeroed, which is likely benign.
However, if the buffer contains residual data from a prior message, the AF =
may
execute an unintended operation (e.g., INIT or WRITE with corrupt context d=
ata)
on an arbitrary aura/pool.



Suggested fix:

  Remove line 112. The if/else block at lines 106-111 already handles both
CN20K and non-CN20K allocation correctly:

       if (roc_model_is_cn20k()) {
           pool_init_req_cn20k =3D mbox_alloc_msg_npa_cn20k_aq_enq(mbox);
           pool_init_req =3D (struct npa_aq_enq_req *)pool_init_req_cn20k;
       } else {
           pool_init_req =3D mbox_alloc_msg_npa_aq_enq(mbox);
       }
  -    pool_init_req =3D mbox_alloc_msg_npa_aq_enq(mbox);
       if (pool_init_req =3D=3D NULL)
           goto exit;

How to reproduce:

Any application that creates an NPA pool on CN10K or CN20K will trigger thi=
s.
Enable debug logging (--log-level=3D*:debug) and observe three NPA_AQ_ENQ
messages sent during npa_aura_pool_init() instead of two.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
