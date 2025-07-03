Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48212C83F03
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 16:51:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83A4640267;
	Thu,  3 Jul 2025 18:51:14 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 1DF6C40264
 for <dev@dpdk.org>; Thu,  3 Jul 2025 18:51:13 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 1811146AE8; Thu,  3 Jul 2025 18:51:13 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1739] net/cnxk: identincal code in branches
Date: Thu, 03 Jul 2025 16:51:13 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: unspecified
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
Message-ID: <bug-1739-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17515614720.0EfcF.1301070
Content-Transfer-Encoding: 7bit
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


--17515614720.0EfcF.1301070
Date: Thu, 3 Jul 2025 18:51:12 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1739

            Bug ID: 1739
           Summary: net/cnxk: identincal code in branches
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: minor
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

Enabling compiler flag to detect identical branches in conditional finds:

[228/3418] Compiling C object
drivers/libtmp_rte_common_cnxk.a.p/common_cnxk_roc_cpt.c.o
../drivers/common/cnxk/roc_cpt.c: In function =E2=80=98cpt_get_blkaddr=E2=
=80=99:
../drivers/common/cnxk/roc_cpt.c:677:12: warning: this condition has identi=
cal
branches [-Wduplicated-branches]
  677 |         if (dev_is_vf(dev))
      |            ^


uint64_t
cpt_get_blkaddr(struct dev *dev)
{
        uint64_t reg;
        uint64_t off;

        /* Reading the discovery register to know which CPT is the LF
         * attached to. Assume CPT LF's of only one block are attached
         * to a pffunc.
         */
        if (dev_is_vf(dev))
                off =3D RVU_VF_BLOCK_ADDRX_DISC(RVU_BLOCK_ADDR_CPT1);
        else
                off =3D RVU_PF_BLOCK_ADDRX_DISC(RVU_BLOCK_ADDR_CPT1);

And many more.


[243/3418] Compiling C object
drivers/libtmp_rte_common_cnxk.a.p/common_cnxk_roc_nix_inl_dev.c.o
../drivers/common/cnxk/roc_nix_inl_dev.c: In function =E2=80=98nix_inl_nix_=
setup=E2=80=99:
../drivers/common/cnxk/roc_nix_inl_dev.c:833:17: warning: this condition has
identical branches [-Wduplicated-branches]
  833 |         else if (roc_model_is_cn10k())
      |                 ^
[246/3418] Compiling C object
drivers/libtmp_rte_common_cnxk.a.p/common_cnxk_roc_nix_inl.c.o
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
[260/3418] Compiling C object
drivers/libtmp_rte_common_cnxk.a.p/common_cnxk_roc_nix_queue.c.o
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

--17515614720.0EfcF.1301070
Date: Thu, 3 Jul 2025 18:51:12 +0200
MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

<html>
    <head>
      <base href=3D"https://bugs.dpdk.org/">
    </head>
    <body><table border=3D"1" cellspacing=3D"0" cellpadding=3D"8" class=3D"=
bz_new_table">
        <tr>
          <th>Bug ID</th>
          <td><a class=3D"bz_bug_link=20
          bz_status_UNCONFIRMED "
   title=3D"UNCONFIRMED - net/cnxk: identincal code in branches"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1739">1739</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>net/cnxk: identincal code in branches
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>unspecified
          </td>
        </tr>

        <tr>
          <th>Hardware</th>
          <td>All
          </td>
        </tr>

        <tr>
          <th>OS</th>
          <td>All
          </td>
        </tr>

        <tr>
          <th>Status</th>
          <td>UNCONFIRMED
          </td>
        </tr>

        <tr>
          <th>Severity</th>
          <td>minor
          </td>
        </tr>

        <tr>
          <th>Priority</th>
          <td>Normal
          </td>
        </tr>

        <tr>
          <th>Component</th>
          <td>ethdev
          </td>
        </tr>

        <tr>
          <th>Assignee</th>
          <td>dev&#64;dpdk.org
          </td>
        </tr>

        <tr>
          <th>Reporter</th>
          <td>stephen&#64;networkplumber.org
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">Enabling compiler flag to detect i=
dentical branches in conditional finds:

[228/3418] Compiling C object
drivers/libtmp_rte_common_cnxk.a.p/common_cnxk_roc_cpt.c.o
../drivers/common/cnxk/roc_cpt.c: In function =E2=80=98cpt_get_blkaddr=E2=
=80=99:
../drivers/common/cnxk/roc_cpt.c:677:12: warning: this condition has identi=
cal
branches [-Wduplicated-branches]
  677 |         if (dev_is_vf(dev))
      |            ^


uint64_t
cpt_get_blkaddr(struct dev *dev)
{
        uint64_t reg;
        uint64_t off;

        /* Reading the discovery register to know which CPT is the LF
         * attached to. Assume CPT LF's of only one block are attached
         * to a pffunc.
         */
        if (dev_is_vf(dev))
                off =3D RVU_VF_BLOCK_ADDRX_DISC(RVU_BLOCK_ADDR_CPT1);
        else
                off =3D RVU_PF_BLOCK_ADDRX_DISC(RVU_BLOCK_ADDR_CPT1);

And many more.


[243/3418] Compiling C object
drivers/libtmp_rte_common_cnxk.a.p/common_cnxk_roc_nix_inl_dev.c.o
../drivers/common/cnxk/roc_nix_inl_dev.c: In function =E2=80=98nix_inl_nix_=
setup=E2=80=99:
../drivers/common/cnxk/roc_nix_inl_dev.c:833:17: warning: this condition has
identical branches [-Wduplicated-branches]
  833 |         else if (roc_model_is_cn10k())
      |                 ^
[246/3418] Compiling C object
drivers/libtmp_rte_common_cnxk.a.p/common_cnxk_roc_nix_inl.c.o
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
[260/3418] Compiling C object
drivers/libtmp_rte_common_cnxk.a.p/common_cnxk_roc_nix_queue.c.o
../drivers/common/cnxk/roc_nix_queue.c: In function =E2=80=98roc_nix_cq_ini=
t=E2=80=99:
../drivers/common/cnxk/roc_nix_queue.c:1290:90: warning: this condition has
identical branches [-Wduplicated-branches]
 1290 |                         cq_ctx-&gt;lbp_frac =3D force_tail_drop ?
NIX_CQ_LBP_THRESH_FRAC_REF1 :
      |
          </pre>
        </div>
      </p>


      <hr>
      <span>You are receiving this mail because:</span>

      <ul>
          <li>You are the assignee for the bug.</li>
      </ul>
      <div itemscope itemtype=3D"http://schema.org/EmailMessage">
        <div itemprop=3D"action" itemscope itemtype=3D"http://schema.org/Vi=
ewAction">
=20=20=20=20=20=20=20=20=20=20
          <link itemprop=3D"url" href=3D"https://bugs.dpdk.org/show_bug.cgi=
?id=3D1739">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17515614720.0EfcF.1301070--
