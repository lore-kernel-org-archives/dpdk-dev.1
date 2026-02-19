Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D9FE9A03B
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 16:07:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F52E402C6;
	Thu, 19 Feb 2026 17:07:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id B7F17402AA
 for <dev@dpdk.org>; Thu, 19 Feb 2026 17:07:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771517260; x=1803053260;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=rYxSaEUqsycfh6mrKZTOjtAv+avfxT1T8dsp14T1X7E=;
 b=c8fk5h5L9weJtQz0Wza9/pvrBbQNLp2iQJHwwKJYQ4wgof+yuYD7KAxX
 FMKlqZWZWTf17lCYk2i86sMtjojTys6jjXwIdFM76B6V1oYpKQbWDVJ/6
 58ml4Sms1mk2m6arsY4xQOx8RkO9OaOVc0u3jxIPnvb59wvk5N6N4fe6s
 JQgHQM2oEqM7vrWwB8aNAh7euahz96x8pl3a2U3KcZJyknIa1OSO5p6oC
 MkN73SUcabquPFFUiyWZ5bBTOy4DmhgV1X11DwP2ISSoJ91+8oPblakvR
 QMPjdUihgOkWi3XTD1JM1hcJk/TRAJqCFz5ZV+63I+1x5lRMTSn6GlsY+ Q==;
X-CSE-ConnectionGUID: JNcw5zwPTq+yokBlamlS7A==
X-CSE-MsgGUID: B/LKJFPuQG6Q/hihO0/yww==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="83713592"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="83713592"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 08:07:38 -0800
X-CSE-ConnectionGUID: EWJRf/HFTNiJRHhyOQioWw==
X-CSE-MsgGUID: Efe0NnKVRFeD06E/Ro/lXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="218320338"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa004.fm.intel.com with ESMTP; 19 Feb 2026 08:07:36 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH] net/iavf: explicitly pass flags param to Tx context fns
Date: Thu, 19 Feb 2026 16:07:26 +0000
Message-ID: <20260219160726.2117208-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
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

The get_context_desc() function takes as an explicit parameter the
ol_flags from the packet, which saves re-reading them from the mbuf. The
subfunctions for creating the segmentation part of the descriptor or the
ipsec handling do not take this parameter though, and then re-read the
ol_flags from the mbuf. While essentially harmless, this does confuse
static analysis tools like converity which does not realise that
ol_flags and m->ol_flags are the same, leading to false positives
like [1].

Fix this and avoid coverity false positives by just passing the local
ol_flags variable so all code uses the same flags source and avoid
unnecessary mbuf reads.

[1] Coverity Issue: 501497

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
NOTE: Not flagging this as a bugfix since there is no actual bug here,
just a code improvement to try and prevent false positives.
---
 drivers/net/intel/iavf/iavf_rxtx.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index e621d4bf47..2464a988eb 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -2361,14 +2361,14 @@ iavf_calc_context_desc(const struct rte_mbuf *mb, uint8_t vlan_flag)
 }
 
 static inline void
-iavf_fill_ctx_desc_tunnelling_field(uint64_t *qw0, const struct rte_mbuf *m)
+iavf_fill_ctx_desc_tunnelling_field(uint64_t *qw0, uint64_t ol_flags, const struct rte_mbuf *m)
 {
 	uint64_t eip_typ = IAVF_TX_CTX_DESC_EIPT_NONE;
 	uint64_t eip_len = 0;
 	uint64_t eip_noinc = 0;
 	/* Default - IP_ID is increment in each segment of LSO */
 
-	switch (m->ol_flags & (RTE_MBUF_F_TX_OUTER_IPV4 |
+	switch (ol_flags & (RTE_MBUF_F_TX_OUTER_IPV4 |
 			RTE_MBUF_F_TX_OUTER_IPV6 |
 			RTE_MBUF_F_TX_OUTER_IP_CKSUM)) {
 	case RTE_MBUF_F_TX_OUTER_IPV4:
@@ -2385,9 +2385,9 @@ iavf_fill_ctx_desc_tunnelling_field(uint64_t *qw0, const struct rte_mbuf *m)
 	break;
 	}
 
-	if (!(m->ol_flags & RTE_MBUF_F_TX_SEC_OFFLOAD)) {
+	if (!(ol_flags & RTE_MBUF_F_TX_SEC_OFFLOAD)) {
 		/* L4TUNT: L4 Tunneling Type */
-		switch (m->ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) {
+		switch (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) {
 		case RTE_MBUF_F_TX_TUNNEL_IPIP:
 			/* for non UDP / GRE tunneling, set to 00b */
 			break;
@@ -2425,7 +2425,7 @@ iavf_fill_ctx_desc_tunnelling_field(uint64_t *qw0, const struct rte_mbuf *m)
 					IAVF_TX_CTX_EXT_IP_IPV4 |
 					IAVF_TX_CTX_EXT_IP_IPV4_NO_CSUM)) &&
 				(eip_typ & IAVF_TXD_CTX_UDP_TUNNELING) &&
-				(m->ol_flags & RTE_MBUF_F_TX_OUTER_UDP_CKSUM))
+				(ol_flags & RTE_MBUF_F_TX_OUTER_UDP_CKSUM))
 			eip_typ |= IAVF_TXD_CTX_QW0_L4T_CS_MASK;
 	}
 
@@ -2435,18 +2435,18 @@ iavf_fill_ctx_desc_tunnelling_field(uint64_t *qw0, const struct rte_mbuf *m)
 }
 
 static inline uint16_t
-iavf_fill_ctx_desc_segmentation_field(volatile uint64_t *field,
+iavf_fill_ctx_desc_segmentation_field(volatile uint64_t *field, uint64_t ol_flags,
 	const struct rte_mbuf *m, struct iavf_ipsec_crypto_pkt_metadata *ipsec_md)
 {
 	uint64_t segmentation_field = 0;
 	uint64_t total_length = 0;
 
-	if (m->ol_flags & RTE_MBUF_F_TX_SEC_OFFLOAD) {
+	if (ol_flags & RTE_MBUF_F_TX_SEC_OFFLOAD) {
 		total_length = ipsec_md->l4_payload_len;
 	} else {
 		total_length = m->pkt_len - (m->l2_len + m->l3_len + m->l4_len);
 
-		if (m->ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK)
+		if (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK)
 			total_length -= m->outer_l3_len + m->outer_l2_len;
 	}
 
@@ -2573,7 +2573,7 @@ iavf_get_context_desc(uint64_t ol_flags, const struct rte_mbuf *mbuf,
 		}
 
 		/* TSO segmentation field */
-		iavf_fill_ctx_desc_segmentation_field(&cd_type_cmd, mbuf, ipsec_md);
+		iavf_fill_ctx_desc_segmentation_field(&cd_type_cmd, ol_flags, mbuf, ipsec_md);
 	}
 
 	/* VLAN field for L2TAG2 */
@@ -2589,7 +2589,7 @@ iavf_get_context_desc(uint64_t ol_flags, const struct rte_mbuf *mbuf,
 
 	/* Tunneling field */
 	if (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK)
-		iavf_fill_ctx_desc_tunnelling_field((uint64_t *)&cd_tunneling_params, mbuf);
+		iavf_fill_ctx_desc_tunnelling_field(&cd_tunneling_params, ol_flags, mbuf);
 
 	/* L2TAG2 field (VLAN) */
 	if (ol_flags & RTE_MBUF_F_TX_QINQ) {
-- 
2.51.0

