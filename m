Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A899CCFA0D
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 15:27:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18E6740DCE;
	Wed,  5 Nov 2025 16:27:02 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 1C9F540B90
 for <dev@dpdk.org>; Wed,  5 Nov 2025 16:26:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762356419; x=1793892419;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XBaJC0kEZLH5WjEp68DiV9PteALH4IuvM+yzXQRn+1k=;
 b=mq2eiM7K8cSgHFF2DwoEHV0VKFAV4SRe+YoGwNDNTVT7190x+ldHD9KE
 0VzZECl0NYZuyYLVzFpYg1R1Tx32ZuPB+OYNezT4k4U5SQe/WujGV3qHj
 P6b+da8+otHoY88ECS4ZROnxL9TMdtwiT4UodgjBKeQaHBEZ65d0rfO6k
 1xhGJMak+R5EvLekRckiuTep2vzJBNMTtXwRc1tyubJJ1bYzo325L/CWy
 ZtK+q+k1H7Iyct7q9drEvTvibAUfUYmARR5nlDoZNUzia7GNoY/Tl3HpA
 srbe+bRF6+qUhcdNcW5TcYP6vJ+I16nuw+Cdbp7tKYGnIlXhWTNwgm5F6 w==;
X-CSE-ConnectionGUID: Lv2xVOmqRIai05WgXJg4kQ==
X-CSE-MsgGUID: 3l+qZ5HeSOywALc/K+Pd0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="68127087"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; d="scan'208";a="68127087"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2025 07:26:58 -0800
X-CSE-ConnectionGUID: ODj+Hb/LSt2Ik+YCDwHICQ==
X-CSE-MsgGUID: c2e56kxEQkiyBsLL620iYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; d="scan'208";a="218257321"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa001.fm.intel.com with ESMTP; 05 Nov 2025 07:26:57 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 5/6] net/iavf: fix QinQ insertion for single packet Tx
Date: Wed,  5 Nov 2025 15:26:41 +0000
Message-Id: <20251105152642.2981673-6-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105152642.2981673-1-ciara.loftus@intel.com>
References: <20251031152250.2441980-1-ciara.loftus@intel.com>
 <20251105152642.2981673-1-ciara.loftus@intel.com>
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

