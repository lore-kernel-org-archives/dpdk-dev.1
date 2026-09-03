Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B55C61DD3
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 14:39:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8288142DDF;
	Thu,  3 Sep 2026 16:38:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 764F142DC7;
 Thu,  3 Sep 2026 16:38:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788446324; x=1819982324;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RAZKPwSvAO57FbzYpVPWZJGQ0u99jIkAK6r5wckuwxc=;
 b=FJCxrTRgqGfKdp8ciHp3MOXjcakx/6yvZp0JmKkmhRXO1LYjlf0p4H4E
 Qj/BlmxIz8SDTMXudEWs2ZsWfx9cMP+vj/uropV8bt0RQHM+m7cyAbxVw
 egeZeUx/qTkIyXgRQK1pXaCAhNKBIv4e1mEEQVDCG1FH2d6GzZhsOn+X8
 0yhgjH/NDDqeoL8BKpY8AZnskdsJvKCUr5M5jmg7/oY+86JdOB/Hxd9Ku
 albSupqSj4ohRBJzNvsTkN9ktnBaDfyWLk69YJ72rSWnPDiR4x51rBnz+
 cvhZ4dH79v+0cZTsvOYzQiFarbvWflgsJyFYRPRgvWPlBzkVU7gtjPgW4 Q==;
X-CSE-ConnectionGUID: Leizm4/YTLib5OLhtNiYaA==
X-CSE-MsgGUID: JrW+/7jYSJuF86ix3a3AJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="87869791"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="87869791"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 07:38:44 -0700
X-CSE-ConnectionGUID: S5+cmSJ1RvCicOQ809MaTw==
X-CSE-MsgGUID: GBH+BT+8QCyxloK4aq67LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="273894971"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa005.jf.intel.com with ESMTP; 03 Sep 2026 07:38:42 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Ciara Loftus <ciara.loftus@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Zhichao Zeng <zhichaox.zeng@intel.com>, Qi Zhang <qi.z.zhang@intel.com>,
 Yiding Zhou <yidingx.zhou@intel.com>
Subject: [PATCH v2 6/7] net/iavf: fix missing outer QinQ tag for tunnelled
 packets
Date: Thu,  3 Sep 2026 15:37:28 +0100
Message-ID: <20260903143827.327131-7-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903143827.327131-1-bruce.richardson@intel.com>
References: <20260831102621.495759-1-bruce.richardson@intel.com>
 <20260903143827.327131-1-bruce.richardson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

When the QinQ feature was enabled along with tunnelling support, the
tunnel options were written directly to the context descriptor quad-word
rather than being merged in. This leads to any QinQ tag in the context
descriptor getting overwritten.

Change order of operations so that the tunnel options go first and the
QinQ tags are merged into that.

Fixes: 4f8259df563a ("net/iavf: enable Tx outer checksum offload on AVX512")
Fixes: 70baceadabf2 ("net/iavf: fix AVX512 Tx")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   | 6 ++++--
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
index 715805c65a..d05e6101ad 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
@@ -1969,6 +1969,8 @@ ctx_vtx(volatile struct ci_tx_desc *txdp,
 
 #ifdef IAVF_TX_VLAN_QINQ_OFFLOAD
 		if (offload) {
+			/* tunnel fill assigns low_ctx_qw1; must run before QinQ/VLAN OR below */
+			iavf_fill_ctx_desc_tunneling_field(&low_ctx_qw1, pkt[1]);
 			if (pkt[1]->ol_flags & RTE_MBUF_F_TX_QINQ) {
 				uint64_t qinq_tag = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 ?
 					(uint64_t)pkt[1]->vlan_tci_outer :
@@ -1990,6 +1992,8 @@ ctx_vtx(volatile struct ci_tx_desc *txdp,
 
 #ifdef IAVF_TX_VLAN_QINQ_OFFLOAD
 		if (offload) {
+			/* tunnel fill assigns low_ctx_qw0; must run before QinQ/VLAN OR below */
+			iavf_fill_ctx_desc_tunneling_field(&low_ctx_qw0, pkt[0]);
 			if (pkt[0]->ol_flags & RTE_MBUF_F_TX_QINQ) {
 				uint64_t qinq_tag = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 ?
 					(uint64_t)pkt[0]->vlan_tci_outer :
@@ -2012,8 +2016,6 @@ ctx_vtx(volatile struct ci_tx_desc *txdp,
 		if (offload) {
 			iavf_txd_enable_offload(pkt[1], &hi_data_qw1, vlan_flag);
 			iavf_txd_enable_offload(pkt[0], &hi_data_qw0, vlan_flag);
-			iavf_fill_ctx_desc_tunneling_field(&low_ctx_qw1, pkt[1]);
-			iavf_fill_ctx_desc_tunneling_field(&low_ctx_qw0, pkt[0]);
 		}
 
 		__m256i desc2_3 =
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
index dfbbea80f7..bae9b2af9c 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
@@ -2111,6 +2111,8 @@ ctx_vtx(volatile struct ci_tx_desc *txdp,
 
 #ifdef IAVF_TX_VLAN_QINQ_OFFLOAD
 		if (offload) {
+			/* tunnel fill assigns low_ctx_qw1; must run before QinQ/VLAN OR below */
+			iavf_fill_ctx_desc_tunnelling_field(&low_ctx_qw1, pkt[1]);
 			if (pkt[1]->ol_flags & RTE_MBUF_F_TX_QINQ) {
 				uint64_t qinq_tag = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 ?
 					(uint64_t)pkt[1]->vlan_tci_outer :
@@ -2131,6 +2133,8 @@ ctx_vtx(volatile struct ci_tx_desc *txdp,
 
 #ifdef IAVF_TX_VLAN_QINQ_OFFLOAD
 		if (offload) {
+			/* tunnel fill assigns low_ctx_qw0; must run before QinQ/VLAN OR below */
+			iavf_fill_ctx_desc_tunnelling_field(&low_ctx_qw0, pkt[0]);
 			if (pkt[0]->ol_flags & RTE_MBUF_F_TX_QINQ) {
 				uint64_t qinq_tag = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 ?
 					(uint64_t)pkt[0]->vlan_tci_outer :
@@ -2151,8 +2155,6 @@ ctx_vtx(volatile struct ci_tx_desc *txdp,
 		if (offload) {
 			iavf_txd_enable_offload(pkt[1], &hi_data_qw1, vlan_flag);
 			iavf_txd_enable_offload(pkt[0], &hi_data_qw0, vlan_flag);
-			iavf_fill_ctx_desc_tunnelling_field(&low_ctx_qw1, pkt[1]);
-			iavf_fill_ctx_desc_tunnelling_field(&low_ctx_qw0, pkt[0]);
 		}
 
 		__m512i desc0_3 =
-- 
2.53.0

