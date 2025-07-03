Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55102C77B7C
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 16:56:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C03540267;
	Thu,  3 Jul 2025 18:56:54 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 2CBEA40267
 for <dev@dpdk.org>; Thu,  3 Jul 2025 18:56:53 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 26DD546AE8; Thu,  3 Jul 2025 18:56:53 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1741] net/intel: duplicate identical branches
Date: Thu, 03 Jul 2025 16:56:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: unspecified
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
Message-ID: <bug-1741-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17515618130.4b8A.1303391
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


--17515618130.4b8A.1303391
Date: Thu, 3 Jul 2025 18:56:52 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1741

            Bug ID: 1741
           Summary: net/intel: duplicate identical branches
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

Enabling warning for duplicate branches finds several bits of suspect code:

[556/3631] Compiling C object
drivers/libtmp_rte_net_i40e.a.p/net_intel_i40e_i40e_tm.c.o
In file included from ../drivers/net/intel/i40e/i40e_tm.c:8:
../drivers/net/intel/i40e/i40e_ethdev.h: In function =E2=80=98i40e_calc_itr=
_interval=E2=80=99:
../drivers/net/intel/i40e/i40e_ethdev.h:1514:20: warning: this condition has
identical branches [-Wduplicated-branches]
 1514 |                 if (is_pf)
      |                    ^
[557/3631] Compiling C object
drivers/libtmp_rte_net_i40e.a.p/net_intel_i40e_base_i40e_diag.c.o
[558/3631] Compiling C object
drivers/libtmp_rte_net_i40e.a.p/net_intel_i40e_i40e_vf_representor.c.o
In file included from ../drivers/net/intel/i40e/i40e_vf_representor.c:13:
../drivers/net/intel/i40e/i40e_ethdev.h: In function =E2=80=98i40e_calc_itr=
_interval=E2=80=99:
../drivers/net/intel/i40e/i40e_ethdev.h:1514:20: warning: this condition has
identical branches [-Wduplicated-branches]
 1514 |                 if (is_pf)
      |                    ^
[559/3631] Compiling C object
drivers/libtmp_rte_net_i40e.a.p/net_intel_i40e_i40e_recycle_mbufs_vec_commo=
n.c.o
In file included from
../drivers/net/intel/i40e/i40e_recycle_mbufs_vec_common.c:10:
../drivers/net/intel/i40e/i40e_ethdev.h: In function =E2=80=98i40e_calc_itr=
_interval=E2=80=99:
../drivers/net/intel/i40e/i40e_ethdev.h:1514:20: warning: this condition has
identical branches [-Wduplicated-branches]
 1514 |                 if (is_pf)
      |=20=20=20=20

[558/3631] Compiling C object
drivers/libtmp_rte_net_i40e.a.p/net_intel_i40e_i40e_vf_representor.c.o
In file included from ../drivers/net/intel/i40e/i40e_vf_representor.c:13:
../drivers/net/intel/i40e/i40e_ethdev.h: In function =E2=80=98i40e_calc_itr=
_interval=E2=80=99:
../drivers/net/intel/i40e/i40e_ethdev.h:1514:20: warning: this condition has
identical branches [-Wduplicated-branches]
 1514 |                 if (is_pf)
      |                    ^
[559/3631] Compiling C object
drivers/libtmp_rte_net_i40e.a.p/net_intel_i40e_i40e_recycle_mbufs_vec_commo=
n.c.o
In file included from
../drivers/net/intel/i40e/i40e_recycle_mbufs_vec_common.c:10:
../drivers/net/intel/i40e/i40e_ethdev.h: In function =E2=80=98i40e_calc_itr=
_interval=E2=80=99:
../drivers/net/intel/i40e/i40e_ethdev.h:1514:20: warning: this condition has
identical branches [-Wduplicated-branches]
 1514 |                 if (is_pf)
      |                    ^
[560/3631] Compiling C object
drivers/libtmp_rte_net_dpaa2.a.p/net_dpaa2_dpaa2_ethdev.c.o
[561/3631] Compiling C object
drivers/libtmp_rte_net_iavf.a.p/net_intel_iavf_iavf_base_symbols.c.o
[562/3631] Compiling C object
drivers/libtmp_rte_net_i40e.a.p/net_intel_i40e_base_i40e_dcb.c.o
[563/3631] Compiling C object
drivers/libtmp_rte_net_i40e.a.p/net_intel_i40e_i40e_hash.c.o
In file included from ../drivers/net/intel/i40e/i40e_hash.c:16:
../drivers/net/intel/i40e/i40e_ethdev.h: In function =E2=80=98i40e_calc_itr=
_interval=E2=80=99:
../drivers/net/intel/i40e/i40e_ethdev.h:1514:20: warning: this condition has
identical branches [-Wduplicated-branches]
 1514 |                 if (is_pf)
      |                    ^
[564/3631] Compiling C object
drivers/libtmp_rte_net_i40e.a.p/net_intel_i40e_i40e_pf.c.o
In file included from ../drivers/net/intel/i40e/i40e_pf.c:25:
../drivers/net/intel/i40e/i40e_ethdev.h: In function =E2=80=98i40e_calc_itr=
_interval=E2=80=99:
../drivers/net/intel/i40e/i40e_ethdev.h:1514:20: warning: this condition has
identical branches [-Wduplicated-branches]
 1514 |                 if (is_pf)
      |                    ^
[565/3631] Compiling C object
drivers/libtmp_rte_net_i40e.a.p/net_intel_i40e_base_i40e_hmc.c.o
[566/3631] Compiling C object
drivers/libtmp_rte_net_i40e.a.p/net_intel_i40e_i40e_fdir.c.o
In file included from ../drivers/net/intel/i40e/i40e_fdir.c:30:
../drivers/net/intel/i40e/i40e_ethdev.h: In function =E2=80=98i40e_calc_itr=
_interval=E2=80=99:
../drivers/net/intel/i40e/i40e_ethdev.h:1514:20: warning: this condition has
identical branches [-Wduplicated-branches]
 1514 |                 if (is_pf)
      |                    ^
[567/3631] Compiling C object
drivers/libtmp_rte_net_i40e.a.p/net_intel_i40e_base_i40e_adminq.c.o
[568/3631] Compiling C object
drivers/libtmp_rte_net_i40e.a.p/net_intel_i40e_base_i40e_lan_hmc.c.o
[569/3631] Compiling C object
drivers/libtmp_rte_net_iavf.a.p/net_intel_iavf_base_iavf_impl.c.o
[570/3631] Compiling C object
drivers/libtmp_rte_net_iavf.a.p/net_intel_iavf_base_iavf_common.c.o
[571/3631] Compiling C object
drivers/libtmp_rte_net_i40e.a.p/net_intel_i40e_i40e_flow.c.o
In file included from ../drivers/net/intel/i40e/i40e_flow.c:25:
../drivers/net/intel/i40e/i40e_ethdev.h: In function =E2=80=98i40e_calc_itr=
_interval=E2=80=99:
../drivers/net/intel/i40e/i40e_ethdev.h:1514:20: warning: this condition has
identical branches [-Wduplicated-branches]
 1514 |                 if (is_pf)
      |                    ^
[572/3631] Compiling C object
drivers/libtmp_rte_net_iavf.a.p/net_intel_iavf_base_iavf_adminq.c.o
[573/3631] Compiling C object
drivers/libtmp_rte_net_dpaa.a.p/net_dpaa_dpaa_rxtx.c.o
[574/3631] Compiling C object
drivers/libtmp_rte_net_i40e.a.p/net_intel_i40e_rte_pmd_i40e.c.o
In file included from ../drivers/net/intel/i40e/rte_pmd_i40e.c:12:
../drivers/net/intel/i40e/i40e_ethdev.h: In function =E2=80=98i40e_calc_itr=
_interval=E2=80=99:
../drivers/net/intel/i40e/i40e_ethdev.h:1514:20: warning: this condition has
identical branches [-Wduplicated-branches]
 1514 |                 if (is_pf)
      |                    ^
[575/3631] Compiling C object
drivers/libtmp_rte_net_i40e.a.p/net_intel_i40e_base_i40e_nvm.c.o
[576/3631] Compiling C object
drivers/libtmp_rte_net_iavf.a.p/net_intel_iavf_iavf_tm.c.o
[577/3631] Compiling C object
drivers/libtmp_rte_net_dpaa2.a.p/net_dpaa2_dpaa2_flow.c.o
[578/3631] Compiling C object
drivers/libtmp_rte_net_iavf.a.p/net_intel_iavf_iavf_generic_flow.c.o
[579/3631] Compiling C object
drivers/libtmp_rte_net_iavf.a.p/net_intel_iavf_iavf_fdir.c.o
[580/3631] Compiling C object
drivers/libtmp_rte_net_iavf.a.p/net_intel_iavf_iavf_ipsec_crypto.c.o
[581/3631] Compiling C object
drivers/libtmp_rte_net_iavf.a.p/net_intel_iavf_iavf_hash.c.o
[582/3631] Compiling C object
drivers/libtmp_rte_net_i40e.a.p/net_intel_i40e_i40e_rxtx_vec_sse.c.o
In file included from ../drivers/net/intel/i40e/i40e_rxtx_vec_sse.c:11:
../drivers/net/intel/i40e/i40e_ethdev.h: In function =E2=80=98i40e_calc_itr=
_interval=E2=80=99:
../drivers/net/intel/i40e/i40e_ethdev.h:1514:20: warning: this condition has
identical branches [-Wduplicated-branches]
 1514 |                 if (is_pf)
      |                    ^
[583/3631] Compiling C object
drivers/libtmp_rte_net_iavf.a.p/net_intel_iavf_iavf_fsub.c.o
[584/3631] Compiling C object
drivers/libtmp_rte_net_idpf.a.p/net_intel_idpf_idpf_common_device.c.o
[585/3631] Compiling C object
drivers/libtmp_rte_net_idpf.a.p/net_intel_idpf_base_idpf_controlq_setup.c.o
[586/3631] Compiling C object
drivers/libtmp_rte_net_dpaa2.a.p/net_dpaa2_dpaa2_rxtx.c.o
[587/3631] Compiling C object
drivers/libtmp_rte_net_i40e.a.p/net_intel_i40e_base_i40e_common.c.o
../drivers/net/intel/i40e/base/i40e_common.c: In function
=E2=80=98i40e_lpi_stat_update=E2=80=99:
../drivers/net/intel/i40e/base/i40e_common.c:7342:56: warning: this conditi=
on
has identical branches [-Wduplicated-branches]
 7342 |                         (u32)(tx_counter - *tx_offset) :
      |                                                        ^
../drivers/net/intel/i40e/base/i40e_common.c:7345:56: warning: this conditi=
on
has identical branches [-Wduplicated-branches]
 7345 |                         (u32)(rx_counter - *rx_offset) :
      |                                                        ^
[588/3631] Compiling C object
drivers/libtmp_rte_net_idpf.a.p/net_intel_idpf_base_idpf_controlq.c.o
                ^

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17515618130.4b8A.1303391
Date: Thu, 3 Jul 2025 18:56:53 +0200
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
   title=3D"UNCONFIRMED - net/intel: duplicate identical branches"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1741">1741</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>net/intel: duplicate identical branches
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
          <td>normal
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
          <pre class=3D"bz_comment_text">Enabling warning for duplicate bra=
nches finds several bits of suspect code:

[556/3631] Compiling C object
drivers/libtmp_rte_net_i40e.a.p/net_intel_i40e_i40e_tm.c.o
In file included from ../drivers/net/intel/i40e/i40e_tm.c:8:
../drivers/net/intel/i40e/i40e_ethdev.h: In function =E2=80=98i40e_calc_itr=
_interval=E2=80=99:
../drivers/net/intel/i40e/i40e_ethdev.h:1514:20: warning: this condition has
identical branches [-Wduplicated-branches]
 1514 |                 if (is_pf)
      |                    ^
[557/3631] Compiling C object
drivers/libtmp_rte_net_i40e.a.p/net_intel_i40e_base_i40e_diag.c.o
[558/3631] Compiling C object
drivers/libtmp_rte_net_i40e.a.p/net_intel_i40e_i40e_vf_representor.c.o
In file included from ../drivers/net/intel/i40e/i40e_vf_representor.c:13:
../drivers/net/intel/i40e/i40e_ethdev.h: In function =E2=80=98i40e_calc_itr=
_interval=E2=80=99:
../drivers/net/intel/i40e/i40e_ethdev.h:1514:20: warning: this condition has
identical branches [-Wduplicated-branches]
 1514 |                 if (is_pf)
      |                    ^
[559/3631] Compiling C object
drivers/libtmp_rte_net_i40e.a.p/net_intel_i40e_i40e_recycle_mbufs_vec_commo=
n.c.o
In file included from
../drivers/net/intel/i40e/i40e_recycle_mbufs_vec_common.c:10:
../drivers/net/intel/i40e/i40e_ethdev.h: In function =E2=80=98i40e_calc_itr=
_interval=E2=80=99:
../drivers/net/intel/i40e/i40e_ethdev.h:1514:20: warning: this condition has
identical branches [-Wduplicated-branches]
 1514 |                 if (is_pf)
      |=20=20=20=20

[558/3631] Compiling C object
drivers/libtmp_rte_net_i40e.a.p/net_intel_i40e_i40e_vf_representor.c.o
In file included from ../drivers/net/intel/i40e/i40e_vf_representor.c:13:
../drivers/net/intel/i40e/i40e_ethdev.h: In function =E2=80=98i40e_calc_itr=
_interval=E2=80=99:
../drivers/net/intel/i40e/i40e_ethdev.h:1514:20: warning: this condition has
identical branches [-Wduplicated-branches]
 1514 |                 if (is_pf)
      |                    ^
[559/3631] Compiling C object
drivers/libtmp_rte_net_i40e.a.p/net_intel_i40e_i40e_recycle_mbufs_vec_commo=
n.c.o
In file included from
../drivers/net/intel/i40e/i40e_recycle_mbufs_vec_common.c:10:
../drivers/net/intel/i40e/i40e_ethdev.h: In function =E2=80=98i40e_calc_itr=
_interval=E2=80=99:
../drivers/net/intel/i40e/i40e_ethdev.h:1514:20: warning: this condition has
identical branches [-Wduplicated-branches]
 1514 |                 if (is_pf)
      |                    ^
[560/3631] Compiling C object
drivers/libtmp_rte_net_dpaa2.a.p/net_dpaa2_dpaa2_ethdev.c.o
[561/3631] Compiling C object
drivers/libtmp_rte_net_iavf.a.p/net_intel_iavf_iavf_base_symbols.c.o
[562/3631] Compiling C object
drivers/libtmp_rte_net_i40e.a.p/net_intel_i40e_base_i40e_dcb.c.o
[563/3631] Compiling C object
drivers/libtmp_rte_net_i40e.a.p/net_intel_i40e_i40e_hash.c.o
In file included from ../drivers/net/intel/i40e/i40e_hash.c:16:
../drivers/net/intel/i40e/i40e_ethdev.h: In function =E2=80=98i40e_calc_itr=
_interval=E2=80=99:
../drivers/net/intel/i40e/i40e_ethdev.h:1514:20: warning: this condition has
identical branches [-Wduplicated-branches]
 1514 |                 if (is_pf)
      |                    ^
[564/3631] Compiling C object
drivers/libtmp_rte_net_i40e.a.p/net_intel_i40e_i40e_pf.c.o
In file included from ../drivers/net/intel/i40e/i40e_pf.c:25:
../drivers/net/intel/i40e/i40e_ethdev.h: In function =E2=80=98i40e_calc_itr=
_interval=E2=80=99:
../drivers/net/intel/i40e/i40e_ethdev.h:1514:20: warning: this condition has
identical branches [-Wduplicated-branches]
 1514 |                 if (is_pf)
      |                    ^
[565/3631] Compiling C object
drivers/libtmp_rte_net_i40e.a.p/net_intel_i40e_base_i40e_hmc.c.o
[566/3631] Compiling C object
drivers/libtmp_rte_net_i40e.a.p/net_intel_i40e_i40e_fdir.c.o
In file included from ../drivers/net/intel/i40e/i40e_fdir.c:30:
../drivers/net/intel/i40e/i40e_ethdev.h: In function =E2=80=98i40e_calc_itr=
_interval=E2=80=99:
../drivers/net/intel/i40e/i40e_ethdev.h:1514:20: warning: this condition has
identical branches [-Wduplicated-branches]
 1514 |                 if (is_pf)
      |                    ^
[567/3631] Compiling C object
drivers/libtmp_rte_net_i40e.a.p/net_intel_i40e_base_i40e_adminq.c.o
[568/3631] Compiling C object
drivers/libtmp_rte_net_i40e.a.p/net_intel_i40e_base_i40e_lan_hmc.c.o
[569/3631] Compiling C object
drivers/libtmp_rte_net_iavf.a.p/net_intel_iavf_base_iavf_impl.c.o
[570/3631] Compiling C object
drivers/libtmp_rte_net_iavf.a.p/net_intel_iavf_base_iavf_common.c.o
[571/3631] Compiling C object
drivers/libtmp_rte_net_i40e.a.p/net_intel_i40e_i40e_flow.c.o
In file included from ../drivers/net/intel/i40e/i40e_flow.c:25:
../drivers/net/intel/i40e/i40e_ethdev.h: In function =E2=80=98i40e_calc_itr=
_interval=E2=80=99:
../drivers/net/intel/i40e/i40e_ethdev.h:1514:20: warning: this condition has
identical branches [-Wduplicated-branches]
 1514 |                 if (is_pf)
      |                    ^
[572/3631] Compiling C object
drivers/libtmp_rte_net_iavf.a.p/net_intel_iavf_base_iavf_adminq.c.o
[573/3631] Compiling C object
drivers/libtmp_rte_net_dpaa.a.p/net_dpaa_dpaa_rxtx.c.o
[574/3631] Compiling C object
drivers/libtmp_rte_net_i40e.a.p/net_intel_i40e_rte_pmd_i40e.c.o
In file included from ../drivers/net/intel/i40e/rte_pmd_i40e.c:12:
../drivers/net/intel/i40e/i40e_ethdev.h: In function =E2=80=98i40e_calc_itr=
_interval=E2=80=99:
../drivers/net/intel/i40e/i40e_ethdev.h:1514:20: warning: this condition has
identical branches [-Wduplicated-branches]
 1514 |                 if (is_pf)
      |                    ^
[575/3631] Compiling C object
drivers/libtmp_rte_net_i40e.a.p/net_intel_i40e_base_i40e_nvm.c.o
[576/3631] Compiling C object
drivers/libtmp_rte_net_iavf.a.p/net_intel_iavf_iavf_tm.c.o
[577/3631] Compiling C object
drivers/libtmp_rte_net_dpaa2.a.p/net_dpaa2_dpaa2_flow.c.o
[578/3631] Compiling C object
drivers/libtmp_rte_net_iavf.a.p/net_intel_iavf_iavf_generic_flow.c.o
[579/3631] Compiling C object
drivers/libtmp_rte_net_iavf.a.p/net_intel_iavf_iavf_fdir.c.o
[580/3631] Compiling C object
drivers/libtmp_rte_net_iavf.a.p/net_intel_iavf_iavf_ipsec_crypto.c.o
[581/3631] Compiling C object
drivers/libtmp_rte_net_iavf.a.p/net_intel_iavf_iavf_hash.c.o
[582/3631] Compiling C object
drivers/libtmp_rte_net_i40e.a.p/net_intel_i40e_i40e_rxtx_vec_sse.c.o
In file included from ../drivers/net/intel/i40e/i40e_rxtx_vec_sse.c:11:
../drivers/net/intel/i40e/i40e_ethdev.h: In function =E2=80=98i40e_calc_itr=
_interval=E2=80=99:
../drivers/net/intel/i40e/i40e_ethdev.h:1514:20: warning: this condition has
identical branches [-Wduplicated-branches]
 1514 |                 if (is_pf)
      |                    ^
[583/3631] Compiling C object
drivers/libtmp_rte_net_iavf.a.p/net_intel_iavf_iavf_fsub.c.o
[584/3631] Compiling C object
drivers/libtmp_rte_net_idpf.a.p/net_intel_idpf_idpf_common_device.c.o
[585/3631] Compiling C object
drivers/libtmp_rte_net_idpf.a.p/net_intel_idpf_base_idpf_controlq_setup.c.o
[586/3631] Compiling C object
drivers/libtmp_rte_net_dpaa2.a.p/net_dpaa2_dpaa2_rxtx.c.o
[587/3631] Compiling C object
drivers/libtmp_rte_net_i40e.a.p/net_intel_i40e_base_i40e_common.c.o
../drivers/net/intel/i40e/base/i40e_common.c: In function
=E2=80=98i40e_lpi_stat_update=E2=80=99:
../drivers/net/intel/i40e/base/i40e_common.c:7342:56: warning: this conditi=
on
has identical branches [-Wduplicated-branches]
 7342 |                         (u32)(tx_counter - *tx_offset) :
      |                                                        ^
../drivers/net/intel/i40e/base/i40e_common.c:7345:56: warning: this conditi=
on
has identical branches [-Wduplicated-branches]
 7345 |                         (u32)(rx_counter - *rx_offset) :
      |                                                        ^
[588/3631] Compiling C object
drivers/libtmp_rte_net_idpf.a.p/net_intel_idpf_base_idpf_controlq.c.o
                ^
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
?id=3D1741">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17515618130.4b8A.1303391--
