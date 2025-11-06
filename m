Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE25CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 11:50:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 550DA406B4;
	Thu,  6 Nov 2025 12:50:28 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 0F9FF4060A
 for <dev@dpdk.org>; Thu,  6 Nov 2025 12:50:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762429825; x=1793965825;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XBaJC0kEZLH5WjEp68DiV9PteALH4IuvM+yzXQRn+1k=;
 b=F/vATM4wNKshl5V5TTvTDgijNxOu/0X5kzErnPypZoMjws+A26ROeE+/
 e1TiKNG1CN4iAGBGXHTfqKvqj3W8/rLYF5GbA9p1+da8ZcOgynlp7iFjk
 vqPeld9bKf8lFFVvxSNVtPc3necnru+lOK1VT1AQeNarsCbJaw1Q2SzsC
 gxNYyvRLIr/zs9KSvi84CwwG4Sbzvje1z4Q2HlsRqoDe53RS81macaP77
 dMFSuF3JLC/BsvmOTye5j7azkf3z92hglTqqewRLfhGgRyfjsOff34FA8
 o9SyoqP2G/Z196ES/zNQMz/69qib6HTixqHuI5JXkUnxNvrFAhgyiyo3f g==;
X-CSE-ConnectionGUID: 78KqJ9sfQ7apdp0K6U0jOQ==
X-CSE-MsgGUID: 4uc//2tDQMiv59s1qUjauw==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="52129788"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="52129788"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 03:50:25 -0800
X-CSE-ConnectionGUID: kH+uzfMpQNWwNXAkIR1gHg==
X-CSE-MsgGUID: Hjjw5KGATNe1rLCXXS/cfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="187898362"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa008.jf.intel.com with ESMTP; 06 Nov 2025 03:50:24 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v3 5/6] net/iavf: fix QinQ insertion for single packet Tx
Date: Thu,  6 Nov 2025 11:50:15 +0000
Message-Id: <20251106115016.3035639-6-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251106115016.3035639-1-ciara.loftus@intel.com>
References: <20251105152642.2981673-1-ciara.loftus@intel.com>
 <20251106115016.3035639-1-ciara.loftus@intel.com>
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

QinQ insertion was enabled in the bulk transmit function but not the
single packet transmit function. Implement it in the single packet
function.

Fixes: 3aa4efa36438 ("net/iavf: support VLAN insertion in AVX512 Tx")

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
index 6182988612..cd067a0199 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
@@ -2077,12 +2077,16 @@ ctx_vtx1(volatile struct iavf_tx_desc *txdp, struct rte_mbuf *pkt,
 	if (offload) {
 		iavf_fill_ctx_desc_tunneling_avx512(&low_ctx_qw, pkt);
 #ifdef IAVF_TX_VLAN_QINQ_OFFLOAD
-		if (pkt->ol_flags & RTE_MBUF_F_TX_VLAN &&
+		if (pkt->ol_flags & RTE_MBUF_F_TX_QINQ) {
+			uint64_t qinq_tag = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 ?
+				(uint64_t)pkt->vlan_tci_outer :
+				(uint64_t)pkt->vlan_tci;
+			high_ctx_qw |= IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
+			low_ctx_qw |= qinq_tag << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
+		} else if ((pkt->ol_flags & RTE_MBUF_F_TX_VLAN) &&
 				vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
-			high_ctx_qw |= IAVF_TX_CTX_DESC_IL2TAG2 <<
-					IAVF_TXD_CTX_QW1_CMD_SHIFT;
-			low_ctx_qw |= (uint64_t)pkt->vlan_tci <<
-					IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
+			high_ctx_qw |= IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
+			low_ctx_qw |= (uint64_t)pkt->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
 		}
 #endif
 	}
-- 
2.34.1

