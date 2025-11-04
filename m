Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CE8CCFA00
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 05:17:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BECC5402B6;
	Tue,  4 Nov 2025 06:17:50 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 506F5402B1
 for <dev@dpdk.org>; Tue,  4 Nov 2025 06:17:49 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 4706A48A9B; Tue,  4 Nov 2025 06:17:49 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1821] bnxt: warnings when building with gcc-16
Date: Tue, 04 Nov 2025 05:17:49 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 25.07
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
Message-ID: <bug-1821-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1821

            Bug ID: 1821
           Summary: bnxt: warnings when building with gcc-16
           Product: DPDK
           Version: 25.07
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

In file included from ../drivers/net/bnxt/tf_ulp/ulp_mapper.h:19,
                 from ../drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c:6:
In function =E2=80=98ulp_bs_push_msb=E2=80=99,
    inlined from =E2=80=98ulp_blob_push=E2=80=99 at
../drivers/net/bnxt/tf_ulp/ulp_utils.h:407:8,
    inlined from =E2=80=98ulp_blob_push_32=E2=80=99 at
../drivers/net/bnxt/tf_ulp/ulp_utils.h:551:7,
    inlined from =E2=80=98ulp_mapper_tfc_wc_tcam_post_process=E2=80=99 at
../drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c:138:9:
../drivers/net/bnxt/tf_ulp/ulp_utils.h:336:17: warning: =E2=80=98cword=E2=
=80=99 may be used
uninitialized [-Wmaybe-uninitialized]
  336 |                 ulp_bs_put_msb(bs, pos, 8, val[i]);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c: In function
=E2=80=98ulp_mapper_tfc_wc_tcam_post_process=E2=80=99:
../drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c:88:18: note: =E2=80=98cword=E2=
=80=99 declared here
   88 |         uint32_t cword, i, rc;
      |                  ^~~~~
In function =E2=80=98ulp_bs_push_msb=E2=80=99,
    inlined from =E2=80=98ulp_blob_push=E2=80=99 at
../drivers/net/bnxt/tf_ulp/ulp_utils.h:407:8,
    inlined from =E2=80=98ulp_blob_push_32=E2=80=99 at
../drivers/net/bnxt/tf_ulp/ulp_utils.h:551:7,
    inlined from =E2=80=98ulp_mapper_tfc_wc_tcam_post_process=E2=80=99 at
../drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c:138:9:
../drivers/net/bnxt/tf_ulp/ulp_utils.h:336:17: warning: =E2=80=98cword=E2=
=80=99 may be used
uninitialized [-Wmaybe-uninitialized]
  336 |                 ulp_bs_put_msb(bs, pos, 8, val[i]);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c: In function
=E2=80=98ulp_mapper_tfc_wc_tcam_post_process=E2=80=99:
../drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c:88:18: note: =E2=80=98cword=E2=
=80=99 declared here
   88 |         uint32_t cword, i, rc;
      |                  ^~~~~
In function =E2=80=98ulp_bs_push_msb=E2=80=99,
    inlined from =E2=80=98ulp_blob_push=E2=80=99 at
../drivers/net/bnxt/tf_ulp/ulp_utils.h:407:8,
    inlined from =E2=80=98ulp_blob_push_32=E2=80=99 at
../drivers/net/bnxt/tf_ulp/ulp_utils.h:551:7,
    inlined from =E2=80=98ulp_mapper_tfc_wc_tcam_post_process=E2=80=99 at
../drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c:138:9:
../drivers/net/bnxt/tf_ulp/ulp_utils.h:336:17: warning: =E2=80=98cword=E2=
=80=99 may be used
uninitialized [-Wmaybe-uninitialized]
  336 |                 ulp_bs_put_msb(bs, pos, 8, val[i]);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c: In function
=E2=80=98ulp_mapper_tfc_wc_tcam_post_process=E2=80=99:
../drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c:88:18: note: =E2=80=98cword=E2=
=80=99 declared here
   88 |         uint32_t cword, i, rc;
      |                  ^~~~~
In function =E2=80=98ulp_bs_push_msb=E2=80=99,
    inlined from =E2=80=98ulp_blob_push=E2=80=99 at
../drivers/net/bnxt/tf_ulp/ulp_utils.h:407:8,
    inlined from =E2=80=98ulp_blob_push_32=E2=80=99 at
../drivers/net/bnxt/tf_ulp/ulp_utils.h:551:7,
    inlined from =E2=80=98ulp_mapper_tfc_wc_tcam_post_process=E2=80=99 at
../drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c:138:9:
../drivers/net/bnxt/tf_ulp/ulp_utils.h:336:17: warning: =E2=80=98cword=E2=
=80=99 may be used
uninitialized [-Wmaybe-uninitialized]
  336 |                 ulp_bs_put_msb(bs, pos, 8, val[i]);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c: In function
=E2=80=98ulp_mapper_tfc_wc_tcam_post_process=E2=80=99:
../drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c:88:18: note: =E2=80=98cword=E2=
=80=99 declared here
   88 |         uint32_t cword, i, rc;
      |                  ^~~~~
In file included from ../drivers/net/bnxt/tf_ulp/ulp_mapper.c:12:
In function =E2=80=98ulp_bs_push_msb=E2=80=99,
    inlined from =E2=80=98ulp_blob_push=E2=80=99 at
../drivers/net/bnxt/tf_ulp/ulp_utils.h:407:8,
    inlined from =E2=80=98ulp_blob_push_32=E2=80=99 at
../drivers/net/bnxt/tf_ulp/ulp_utils.h:551:7,
    inlined from =E2=80=98ulp_mapper_wc_tcam_tbl_dyn_post_process=E2=80=99 =
at
../drivers/net/bnxt/tf_ulp/ulp_mapper.c:2499:9:
../drivers/net/bnxt/tf_ulp/ulp_utils.h:336:17: warning: =E2=80=98cword=E2=
=80=99 may be used
uninitialized [-Wmaybe-uninitialized]
  336 |                 ulp_bs_put_msb(bs, pos, 8, val[i]);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/bnxt/tf_ulp/ulp_mapper.c: In function
=E2=80=98ulp_mapper_wc_tcam_tbl_dyn_post_process=E2=80=99:
../drivers/net/bnxt/tf_ulp/ulp_mapper.c:2455:18: note: =E2=80=98cword=E2=80=
=99 declared here
 2455 |         uint32_t cword, i, rc;
      |                  ^~~~~
In function =E2=80=98ulp_bs_push_msb=E2=80=99,
    inlined from =E2=80=98ulp_blob_push=E2=80=99 at
../drivers/net/bnxt/tf_ulp/ulp_utils.h:407:8,
    inlined from =E2=80=98ulp_blob_push_32=E2=80=99 at
../drivers/net/bnxt/tf_ulp/ulp_utils.h:551:7,
    inlined from =E2=80=98ulp_mapper_wc_tcam_tbl_dyn_post_process=E2=80=99 =
at
../drivers/net/bnxt/tf_ulp/ulp_mapper.c:2499:9:
../drivers/net/bnxt/tf_ulp/ulp_utils.h:336:17: warning: =E2=80=98cword=E2=
=80=99 may be used
uninitialized [-Wmaybe-uninitialized]
  336 |                 ulp_bs_put_msb(bs, pos, 8, val[i]);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/bnxt/tf_ulp/ulp_mapper.c: In function
=E2=80=98ulp_mapper_wc_tcam_tbl_dyn_post_process=E2=80=99:
../drivers/net/bnxt/tf_ulp/ulp_mapper.c:2455:18: note: =E2=80=98cword=E2=80=
=99 declared here
 2455 |         uint32_t cword, i, rc;
      |                  ^~~~~
In function =E2=80=98ulp_bs_push_msb=E2=80=99,
    inlined from =E2=80=98ulp_blob_push=E2=80=99 at
../drivers/net/bnxt/tf_ulp/ulp_utils.h:407:8,
    inlined from =E2=80=98ulp_blob_push_32=E2=80=99 at
../drivers/net/bnxt/tf_ulp/ulp_utils.h:551:7,
    inlined from =E2=80=98ulp_mapper_wc_tcam_tbl_dyn_post_process=E2=80=99 =
at
../drivers/net/bnxt/tf_ulp/ulp_mapper.c:2499:9:
../drivers/net/bnxt/tf_ulp/ulp_utils.h:336:17: warning: =E2=80=98cword=E2=
=80=99 may be used
uninitialized [-Wmaybe-uninitialized]
  336 |                 ulp_bs_put_msb(bs, pos, 8, val[i]);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/bnxt/tf_ulp/ulp_mapper.c: In function
=E2=80=98ulp_mapper_wc_tcam_tbl_dyn_post_process=E2=80=99:
../drivers/net/bnxt/tf_ulp/ulp_mapper.c:2455:18: note: =E2=80=98cword=E2=80=
=99 declared here
 2455 |         uint32_t cword, i, rc;
      |                  ^~~~~
In function =E2=80=98ulp_bs_push_msb=E2=80=99,
    inlined from =E2=80=98ulp_blob_push=E2=80=99 at
../drivers/net/bnxt/tf_ulp/ulp_utils.h:407:8,
    inlined from =E2=80=98ulp_blob_push_32=E2=80=99 at
../drivers/net/bnxt/tf_ulp/ulp_utils.h:551:7,
    inlined from =E2=80=98ulp_mapper_wc_tcam_tbl_dyn_post_process=E2=80=99 =
at
../drivers/net/bnxt/tf_ulp/ulp_mapper.c:2499:9:
../drivers/net/bnxt/tf_ulp/ulp_utils.h:336:17: warning: =E2=80=98cword=E2=
=80=99 may be used
uninitialized [-Wmaybe-uninitialized]
  336 |                 ulp_bs_put_msb(bs, pos, 8, val[i]);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/bnxt/tf_ulp/ulp_mapper.c: In function
=E2=80=98ulp_mapper_wc_tcam_tbl_dyn_post_process=E2=80=99:
../drivers/net/bnxt/tf_ulp/ulp_mapper.c:2455:18: note: =E2=80=98cword=E2=80=
=99 declared here
 2455 |         uint32_t cword, i, rc;
      |                  ^~~~~
In function =E2=80=98ulp_bs_push_msb=E2=80=99,
    inlined from =E2=80=98ulp_blob_push=E2=80=99 at
../drivers/net/bnxt/tf_ulp/ulp_utils.h:407:8,
    inlined from =E2=80=98ulp_blob_push_32=E2=80=99 at
../drivers/net/bnxt/tf_ulp/ulp_utils.h:551:7,
    inlined from =E2=80=98ulp_mapper_wc_tcam_tbl_dyn_post_process=E2=80=99 =
at
../drivers/net/bnxt/tf_ulp/ulp_mapper.c:2504:9:
../drivers/net/bnxt/tf_ulp/ulp_utils.h:336:17: warning: =E2=80=98cword=E2=
=80=99 may be used
uninitialized [-Wmaybe-uninitialized]
  336 |                 ulp_bs_put_msb(bs, pos, 8, val[i]);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/bnxt/tf_ulp/ulp_mapper.c: In function
=E2=80=98ulp_mapper_wc_tcam_tbl_dyn_post_process=E2=80=99:
../drivers/net/bnxt/tf_ulp/ulp_mapper.c:2455:18: note: =E2=80=98cword=E2=80=
=99 declared here
 2455 |         uint32_t cword, i, rc;
      |                  ^~~~~
In function =E2=80=98ulp_bs_push_msb=E2=80=99,
    inlined from =E2=80=98ulp_blob_push=E2=80=99 at
../drivers/net/bnxt/tf_ulp/ulp_utils.h:407:8,
    inlined from =E2=80=98ulp_blob_push_32=E2=80=99 at
../drivers/net/bnxt/tf_ulp/ulp_utils.h:551:7,
    inlined from =E2=80=98ulp_mapper_wc_tcam_tbl_dyn_post_process=E2=80=99 =
at
../drivers/net/bnxt/tf_ulp/ulp_mapper.c:2504:9:
../drivers/net/bnxt/tf_ulp/ulp_utils.h:336:17: warning: =E2=80=98cword=E2=
=80=99 may be used
uninitialized [-Wmaybe-uninitialized]
  336 |                 ulp_bs_put_msb(bs, pos, 8, val[i]);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/bnxt/tf_ulp/ulp_mapper.c: In function
=E2=80=98ulp_mapper_wc_tcam_tbl_dyn_post_process=E2=80=99:
../drivers/net/bnxt/tf_ulp/ulp_mapper.c:2455:18: note: =E2=80=98cword=E2=80=
=99 declared here
 2455 |         uint32_t cword, i, rc;
      |                  ^~~~~
In function =E2=80=98ulp_bs_push_msb=E2=80=99,
    inlined from =E2=80=98ulp_blob_push=E2=80=99 at
../drivers/net/bnxt/tf_ulp/ulp_utils.h:407:8,
    inlined from =E2=80=98ulp_blob_push_32=E2=80=99 at
../drivers/net/bnxt/tf_ulp/ulp_utils.h:551:7,
    inlined from =E2=80=98ulp_mapper_wc_tcam_tbl_dyn_post_process=E2=80=99 =
at
../drivers/net/bnxt/tf_ulp/ulp_mapper.c:2504:9:
../drivers/net/bnxt/tf_ulp/ulp_utils.h:336:17: warning: =E2=80=98cword=E2=
=80=99 may be used
uninitialized [-Wmaybe-uninitialized]
  336 |                 ulp_bs_put_msb(bs, pos, 8, val[i]);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/bnxt/tf_ulp/ulp_mapper.c: In function
=E2=80=98ulp_mapper_wc_tcam_tbl_dyn_post_process=E2=80=99:
../drivers/net/bnxt/tf_ulp/ulp_mapper.c:2455:18: note: =E2=80=98cword=E2=80=
=99 declared here
 2455 |         uint32_t cword, i, rc;
      |                  ^~~~~
In function =E2=80=98ulp_bs_push_msb=E2=80=99,
    inlined from =E2=80=98ulp_blob_push=E2=80=99 at
../drivers/net/bnxt/tf_ulp/ulp_utils.h:407:8,
    inlined from =E2=80=98ulp_blob_push_32=E2=80=99 at
../drivers/net/bnxt/tf_ulp/ulp_utils.h:551:7,
    inlined from =E2=80=98ulp_mapper_wc_tcam_tbl_dyn_post_process=E2=80=99 =
at
../drivers/net/bnxt/tf_ulp/ulp_mapper.c:2504:9:
../drivers/net/bnxt/tf_ulp/ulp_utils.h:336:17: warning: =E2=80=98cword=E2=
=80=99 may be used
uninitialized [-Wmaybe-uninitialized]
  336 |                 ulp_bs_put_msb(bs, pos, 8, val[i]);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/bnxt/tf_ulp/ulp_mapper.c: In function
=E2=80=98ulp_mapper_wc_tcam_tbl_dyn_post_process=E2=80=99:
../drivers/net/bnxt/tf_ulp/ulp_mapper.c:2455:18: note: =E2=80=98cword=E2=80=
=99 declared here
 2455 |         uint32_t cword, i, rc;
      |                  ^~~~~

--=20
You are receiving this mail because:
You are the assignee for the bug.=
