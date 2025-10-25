Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA3BCCD1BF
	for <dpdk-dev@archiver.kernel.org>; Sat, 25 Oct 2025 18:04:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B22504021E;
	Sat, 25 Oct 2025 20:04:08 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 909C640156
 for <dev@dpdk.org>; Sat, 25 Oct 2025 20:04:07 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 71FF7489D7; Sat, 25 Oct 2025 20:04:07 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1811] common/cnxk: identical branch warnings
Date: Sat, 25 Oct 2025 18:04:07 +0000
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
Message-ID: <bug-1811-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1811

            Bug ID: 1811
           Summary: common/cnxk: identical branch warnings
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

If DPDK is compiled with duplicate condition warnings, then the following
warnings show up:

[251/3707] Compiling C object drivers/...ommon_cnxk.a.p/common_cnxk_roc_cpt=
.c.o
../drivers/common/cnxk/roc_cpt.c: In function =E2=80=98cpt_get_blkaddr=E2=
=80=99:
../drivers/common/cnxk/roc_cpt.c:680:12: warning: this condition has identi=
cal
branches [-Wduplicated-branches]
  680 |         if (dev_is_vf(dev))
      |            ^
[265/3707] Compiling C object drivers/...xk.a.p/common_cnxk_roc_nix_inl_dev=
.c.o
../drivers/common/cnxk/roc_nix_inl_dev.c: In function =E2=80=98nix_inl_nix_=
setup=E2=80=99:
../drivers/common/cnxk/roc_nix_inl_dev.c:833:17: warning: this condition has
identical branches [-Wduplicated-branches]
  833 |         else if (roc_model_is_cn10k())
      |                 ^
[270/3707] Compiling C object drivers/...n_cnxk.a.p/common_cnxk_roc_nix_inl=
.c.o
../drivers/common/cnxk/roc_nix_inl.c: In function
=E2=80=98nix_inl_inb_ipsec_sa_tbl_setup=E2=80=99:
../drivers/common/cnxk/roc_nix_inl.c:426:17: warning: this condition has
identical branches [-Wduplicated-branches]
  426 |         else if (roc_model_is_cn10k())
      |                 ^
../drivers/common/cnxk/roc_nix_inl.c: In function =E2=80=98nix_inl_eng_caps=
_get=E2=80=99:
../drivers/common/cnxk/roc_nix_inl.c:1215:12: warning: this condition has
identical branches [-Wduplicated-branches]
 1215 |         if (roc_model_is_cn9k() || roc_model_is_cn10k())
      |            ^
../drivers/common/cnxk/roc_nix_inl.c: In function =E2=80=98roc_nix_inl_outb=
_init=E2=80=99:
../drivers/common/cnxk/roc_nix_inl.c:1616:17: warning: this condition has
identical branches [-Wduplicated-branches]
 1616 |         else if (roc_model_is_cn10k())
      |                 ^
[274/3707] Compiling C object drivers/...cnxk.a.p/common_cnxk_roc_nix_queue=
.c.o
../drivers/common/cnxk/roc_nix_queue.c: In function =E2=80=98roc_nix_cq_ini=
t=E2=80=99:
../drivers/common/cnxk/roc_nix_queue.c:1290:90: warning: this condition has
identical branches [-Wduplicated-branches]
 1290 |                         cq_ctx->lbp_frac =3D force_tail_drop ?
NIX_CQ_LBP_THRESH_FRAC_REF1 :
      |

--=20
You are receiving this mail because:
You are the assignee for the bug.=
