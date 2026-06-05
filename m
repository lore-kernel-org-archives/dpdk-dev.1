Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD9BCD6E75
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 00:48:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23C5E40651;
	Fri,  5 Jun 2026 02:48:32 +0200 (CEST)
Received: from mail-oa1-f98.google.com (mail-oa1-f98.google.com
 [209.85.160.98]) by mails.dpdk.org (Postfix) with ESMTP id 9C2AB402AC
 for <dev@dpdk.org>; Fri,  5 Jun 2026 02:48:30 +0200 (CEST)
Received: by mail-oa1-f98.google.com with SMTP id
 586e51a60fabf-440d9bfa309so1161813fac.2
 for <dev@dpdk.org>; Thu, 04 Jun 2026 17:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780620510; x=1781225310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BhbnIEuDSRp301F3jB41fpG5Tr7u3U+MkL+92lYLUdY=;
 b=TUjS3/7NRYR8tylKS8S4O2AfkXjLpcrjMSk/7UY0fDrbS7yJb5wlx8LO6Ue3fVdvVt
 e850dh7wi0JItbaGhFh5huAHhG5MNVJ3s1+JOuVIsfQokt3w+Zj3PfnKTBJ7Dw26pRQQ
 VYviWgOAwDvVpZEaUG2gotxSc7xbyUWuwnRIBbp099ePaz01HLIYjmcQqOiXT0r4QVHS
 hzbcXSAifMvPY0xaEGOojOT8kbn3AomePmrrMVaO+tUcvzxD9H/bauxwISrPkmPQwpkx
 6M3Rs1GH5RfkgsM31tfV9Y7rmtgP0OOJzMrtazlYEud7g3OTipln4Elhv41BVFFu3vfo
 +ykQ==
X-Gm-Message-State: AOJu0Yx3OwGmv6G92bpOhhGnEI7PQ2qEuGC/UjVfJ3fgDqI0ft5E5kuc
 2LO61z9uJn3HQWv1pbTnAmIchWSxDfyD2VH9gLtxaIwTszr1pTR4lGaSyWcllOAmmPayKG+zMcA
 l8Nbj8GMKs8cMZTudVNr1sGikHbcJb93BhCDwr9SxS2HIJQ8V4bL40cwnNcdxh2dZ9haptu8sXc
 yFEz/m7mx1lQWcZeu7t9vvdQKB6XjXrpiOkzV2yKg7jMiLktPwkVHSvkZta/cmf23FrSPzLIJfN
 13xPIvP3Jcn
X-Gm-Gg: Acq92OG9GtiFplKmPLbdWUMrBWZo0S5k+iGY4MEnLTmzYMywlc6BT1wjXynOHRu+agV
 aqvlRxgeostmWMitbLGS9rQH2eP24glPhk6ooDvoq7bXOVSpy3yX8tAD18vbigWLIg8FJvCXNH5
 ghsRM4dm6vta8oT02axtQK5Z5H6eRjfoVV87YwtZutQUVaAbyDgi4wIWRglmY4PJOd3mHDXVXvZ
 +h/+VOUm2fUZl2mb1XEzkVx+p8KOuV9h7WZy8xe/fjKNpbtCupfw/UfHPy+c6yDFjEpEUR3k/Bd
 G5SRRbs9lgmiSdrHbrFb1RwHNc8PfzpGttDudT/gFTH7sE/HeBYasKgRSu7HNpJuVmNJHbOPaTI
 YYXf22HPM0JpTTPdz9ox6GMC1MR92Stkx0vDU4d+wOYxbFPbawqCLsqAa1vrQ2/aH17HlQISW1J
 jNDgLw1tJzG7s3NLKsd+XhHfDAnN+WS7xr+ZDmwieiRse+D8jtOikPCExjCjQetBqN8o4fo2KyM
 P1YvMQSTymF
X-Received: by 2002:a05:6871:5822:b0:42c:2421:5781 with SMTP id
 586e51a60fabf-4413dc23d59mr692845fac.28.1780620509681; 
 Thu, 04 Jun 2026 17:48:29 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 586e51a60fabf-440d7f1ee67sm707336fac.8.2026.06.04.17.48.29
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 04 Jun 2026 17:48:29 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51790fd9107so19139351cf.0
 for <dev@dpdk.org>; Thu, 04 Jun 2026 17:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780620509; x=1781225309; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BhbnIEuDSRp301F3jB41fpG5Tr7u3U+MkL+92lYLUdY=;
 b=K+bOCIYVfj82U8z58fh6Vi9cIPtnORdRIZUVLLvywTQf+fU0CzG7He3Z2HvEwyZQiI
 NT/thxApoB1UTwJfllDCTNq+tclWrakcC+gdzH2HCCl9JUk4NTRl2T2GYACT0OGFE5Nq
 kGUK26ldv95tF37ua72+p7hRnQZadsgRQsCyU=
X-Received: by 2002:a05:622a:4a05:b0:517:8069:8afb with SMTP id
 d75a77b69052e-51795b6bbc0mr18762631cf.33.1780620508695; 
 Thu, 04 Jun 2026 17:48:28 -0700 (PDT)
X-Received: by 2002:a05:622a:4a05:b0:517:8069:8afb with SMTP id
 d75a77b69052e-51795b6bbc0mr18762231cf.33.1780620508043; 
 Thu, 04 Jun 2026 17:48:28 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd0556c0sm67187396d6.25.2026.06.04.17.48.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 17:48:27 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Keegan Freyhof <keegan.freyhof@broadcom.com>,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v2 1/5] net/bnxt: fix NQ/CQ processing for interrupt handling
Date: Thu,  4 Jun 2026 18:50:12 -0600
Message-ID: <20260605005016.2290160-2-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260605005016.2290160-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260603211341.2112344-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260605005016.2290160-1-Mohammad-Shuab.Siddique@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Keegan Freyhof <keegan.freyhof@broadcom.com>

Restructure CQ and NQ arming in NQ processing to be more readable.
Fix incorrect completion validation being used for NQEs and RX
completions in NQ processing.

Fixed the issue of excess interrupts by properly tracking the valid
bit for NQs and using the correct RX completion validation code.

Fixes: 683e5cf79249 ("net/bnxt: use common NQ ring")
Cc: stable@dpdk.org
Signed-off-by: Keegan Freyhof <keegan.freyhof@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt.h     |  2 +
 drivers/net/bnxt/bnxt_cpr.c | 100 +++++++++++++++++++++++++++++++++++++
 drivers/net/bnxt/bnxt_cpr.h |  34 ++++++++++++-
 drivers/net/bnxt/bnxt_rxq.c |  47 +++++++++++++++++-
 4 files changed, 180 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bnxt/bnxt.h b/drivers/net/bnxt/bnxt.h
index 03df28e64a..f21753e40c 100644
--- a/drivers/net/bnxt/bnxt.h
+++ b/drivers/net/bnxt/bnxt.h
@@ -433,8 +433,10 @@ struct bnxt_coal {
 #define DBR_TYPE_SQ				(0x0ULL << 60)
 #define DBR_TYPE_SRQ				(0x2ULL << 60)
 #define DBR_TYPE_CQ				(0x4ULL << 60)
+#define DBR_TYPE_CQ_ARMALL			(0x6ULL << 60)
 #define DBR_TYPE_NQ				(0xaULL << 60)
 #define DBR_TYPE_NQ_ARM				(0xbULL << 60)
+#define DBR_TYPE_NQ_MASK			(0xeULL << 60)
 
 #define DB_PF_OFFSET			0x10000
 #define DB_VF_OFFSET			0x4000
diff --git a/drivers/net/bnxt/bnxt_cpr.c b/drivers/net/bnxt/bnxt_cpr.c
index c6606e19a8..60d1ec0b4a 100644
--- a/drivers/net/bnxt/bnxt_cpr.c
+++ b/drivers/net/bnxt/bnxt_cpr.c
@@ -13,6 +13,106 @@
 #include "hsi_struct_def_dpdk.h"
 #include "tfc_vf2pf_msg.h"
 
+void bnxt_process_async_msg(struct bnxt *bp, struct tx_cmpl *cmpl)
+{
+	uint16_t type = cmpl->flags_type & TX_CMPL_TYPE_MASK;
+
+	switch (type) {
+	case HWRM_CMPL_TYPE_HWRM_DONE:
+		break;
+	case HWRM_ASYNC_EVENT_CMPL_TYPE_HWRM_ASYNC_EVENT:
+		bnxt_handle_async_event(bp, (struct cmpl_base *)cmpl);
+		break;
+	default:
+		PMD_DRV_LOG_LINE(ERR, "Port: %d Unhandled async message %x",
+				 bp->eth_dev->data->port_id, type);
+		break;
+	}
+}
+
+void bnxt_process_nq(struct bnxt *bp, struct bnxt_cp_ring_info *nqr,
+		     struct bnxt_cp_ring_info *rx_cpr)
+{
+	struct nqe_cn *nqcmps = (struct nqe_cn *)nqr->cp_desc_ring;
+	uint32_t ring_mask = nqr->cp_ring_struct->ring_mask;
+	uint32_t raw_cons = nqr->cp_raw_cons;
+	uint16_t nq_type, nqe_cnt = 0;
+	bool v_bit = nqr->valid;
+	uint32_t cons = RING_CMPL(ring_mask, raw_cons);
+
+	while (1) {
+		if (!CMPL_VALID(&nqcmps[cons], v_bit)) {
+			if (nqe_cnt) {
+				nqr->cp_raw_cons = raw_cons;
+				nqr->valid = v_bit;
+			}
+			return;
+		}
+
+		nq_type = NQ_CN_TYPE_MASK & nqcmps[cons].type;
+
+		if (CMP_TYPE((struct cmpl_base *)&nqcmps[cons]) != NQ_CN_TYPE_CQ_NOTIFICATION)
+			bnxt_process_async_msg(bp, (struct tx_cmpl *)&nqcmps[cons]);
+		else
+			rx_cpr->toggle = NQE_CN_TOGGLE((uint64_t)nqcmps[cons].type);
+
+		NEXT_CMPL(nqr, cons, v_bit, 1);
+		raw_cons++;
+		if (nq_type)
+			nqe_cnt++;
+	}
+}
+
+/* Arms/disarms the given NQ for Thor/Thor2, with P5+ represening the ASIC family  */
+void bnxt_arm_nq_p5p(struct bnxt_cp_ring_info *nqr, bool enable_irq)
+{
+	uint32_t raw_cons = nqr->cp_raw_cons;
+	uint64_t db_msg = 0;
+	uint32_t toggle = 0;
+
+	if (enable_irq == 1)
+		toggle = nqr->toggle;
+
+	db_msg = nqr->cp_db.db_key64 | (raw_cons & nqr->cp_db.db_ring_mask)
+		| DB_EPOCH(&nqr->cp_db, raw_cons) | DB_TOGGLE(toggle);
+
+	if (enable_irq)
+		db_msg |= DBR_TYPE_NQ_ARM;
+	else
+		db_msg |= DBR_TYPE_NQ_MASK;
+
+	rte_compiler_barrier();
+	rte_write64(db_msg, nqr->cp_db.doorbell);
+	rte_compiler_barrier();
+}
+
+/* Arms/disarms the given CQ for Thor/Thor2, with P5+ represening the ASIC family  */
+void bnxt_arm_rx_cq_p5p(struct bnxt_cp_ring_info *cpr, bool enable_irq)
+{
+	uint32_t raw_cons = cpr->cp_raw_cons;
+	uint64_t db_msg = 0;
+	uint32_t toggle = 0;
+
+	if (raw_cons == UINT32_MAX)
+		raw_cons = 0;
+
+	if (enable_irq == 1)
+		toggle = cpr->toggle;
+
+	db_msg = cpr->cp_db.db_key64 | (raw_cons & cpr->cp_db.db_ring_mask)
+		| DB_EPOCH(&cpr->cp_db, raw_cons) | DB_TOGGLE(toggle);
+
+	if (enable_irq)
+		db_msg |= DBR_TYPE_CQ_ARMALL;
+	else
+		db_msg |= DBR_TYPE_CQ;
+
+	rte_compiler_barrier();
+	rte_write64(db_msg, cpr->cp_db.doorbell);
+	rte_compiler_barrier();
+}
+
+
 void bnxt_wait_for_device_shutdown(struct bnxt *bp)
 {
 	uint32_t val, timeout;
diff --git a/drivers/net/bnxt/bnxt_cpr.h b/drivers/net/bnxt/bnxt_cpr.h
index 858ee15c47..e097f1034f 100644
--- a/drivers/net/bnxt/bnxt_cpr.h
+++ b/drivers/net/bnxt/bnxt_cpr.h
@@ -30,6 +30,14 @@ struct bnxt_db_info;
 #define RING_CMPL(ring_mask, idx)	((idx) & (ring_mask))
 #define NEXT_CMP(idx)		RING_CMP(ADV_RAW_CMP(idx, 1))
 
+#define DBR_TOGGLE_SFT			25
+#define DB_TOGGLE(tgl)			((tgl) << DBR_TOGGLE_SFT)
+
+#define NQ_CN_TOGGLE_MASK              0xc0UL
+#define NQ_CN_TOGGLE_SFT               6
+#define NQE_CN_TOGGLE(type)            (((type) & NQ_CN_TOGGLE_MASK) >>        \
+					NQ_CN_TOGGLE_SFT)
+
 #define DB_CP_REARM_FLAGS	(DB_KEY_CP | DB_IDX_VALID)
 #define DB_CP_FLAGS		(DB_KEY_CP | DB_IDX_VALID | DB_IRQ_DIS)
 
@@ -73,6 +81,21 @@ struct bnxt_db_info {
 #define DB_RING_IDX(db, idx)	(((idx) & (db)->db_ring_mask) |		\
 				 DB_EPOCH(db, idx))
 
+struct nqe_cn {
+	rte_le16_t      type;
+	#define NQ_CN_TYPE_MASK                 0x3fUL
+	#define NQ_CN_TYPE_SFT                  0
+	#define NQ_CN_TYPE_CQ_NOTIFICATION      0x30UL
+	#define NQ_CN_TYPE_LAST                 NQ_CN_TYPE_CQ_NOTIFICATION
+	#define NQ_CN_TOGGLE_MASK               0xc0UL
+	#define NQ_CN_TOGGLE_SFT                6
+	rte_le16_t      reserved16;
+	rte_le32_t      cq_handle_low;
+	rte_le32_t      v;
+	#define NQ_CN_V                         0x1UL
+	rte_le32_t      cq_handle_high;
+};
+
 struct bnxt_ring;
 struct bnxt_cp_ring_info {
 	uint32_t		cp_raw_cons;
@@ -89,7 +112,9 @@ struct bnxt_cp_ring_info {
 	struct bnxt_ring	*cp_ring_struct;
 	bool			valid;
 	uint32_t                epoch;
-	uint8_t			dpi;
+	uint32_t		toggle;
+	uint8_t			dpi;  /* Doorbell page index for multi-doorbell support */
+
 };
 
 #define RX_CMP_L2_ERRORS						\
@@ -101,6 +126,11 @@ void bnxt_handle_fwd_req(struct bnxt *bp, struct cmpl_base *cmp);
 int bnxt_event_hwrm_resp_handler(struct bnxt *bp, struct cmpl_base *cmp);
 void bnxt_dev_reset_and_resume(void *arg);
 void bnxt_wait_for_device_shutdown(struct bnxt *bp);
+void bnxt_arm_nq_p5p(struct bnxt_cp_ring_info *nqr, bool enable_irq);
+void bnxt_arm_rx_cq_p5p(struct bnxt_cp_ring_info *cpr, bool enable_irq);
+void bnxt_process_async_msg(struct bnxt *bp, struct tx_cmpl *cmpl);
+void bnxt_process_nq(struct bnxt *bp, struct bnxt_cp_ring_info *nqr,
+		     struct bnxt_cp_ring_info *rx_cpr);
 
 #define EVENT_DATA1_REASON_CODE_FW_EXCEPTION_FATAL     \
 	HWRM_ASYNC_EVENT_CMPL_RESET_NOTIFY_EVENT_DATA1_REASON_CODE_FW_EXCEPTION_FATAL
@@ -152,4 +182,6 @@ bnxt_cpr_cmp_valid(const void *cmpl, uint32_t raw_cons, uint32_t ring_size)
 	}
 	return false;
 }
+
 #endif
+
diff --git a/drivers/net/bnxt/bnxt_rxq.c b/drivers/net/bnxt/bnxt_rxq.c
index 91b3555df6..b93f5043de 100644
--- a/drivers/net/bnxt/bnxt_rxq.c
+++ b/drivers/net/bnxt/bnxt_rxq.c
@@ -461,7 +461,14 @@ bnxt_rx_queue_intr_enable_op(struct rte_eth_dev *eth_dev, uint16_t queue_id)
 			return -EINVAL;
 
 		cpr = rxq->cp_ring;
-		B_CP_DB_REARM(cpr, cpr->cp_raw_cons);
+		if (BNXT_CHIP_P5_P7(bp)) {
+			struct bnxt_cp_ring_info *nqr = bp->rxtx_nq_ring;
+
+			bnxt_arm_nq_p5p(nqr, 1);
+			bnxt_arm_rx_cq_p5p(rxq->cp_ring, 1);
+		} else {
+			B_CP_DB_ARM(cpr);
+		}
 	}
 	return rc;
 }
@@ -484,7 +491,43 @@ bnxt_rx_queue_intr_disable_op(struct rte_eth_dev *eth_dev, uint16_t queue_id)
 			return -EINVAL;
 
 		cpr = rxq->cp_ring;
-		B_CP_DB_DISARM(cpr);
+		if (BNXT_CHIP_P5_P7(bp)) {
+			struct bnxt_cp_ring_info *nqr = bp->rxtx_nq_ring;
+			struct bnxt_cp_ring_info *rx_cpr;
+
+			bnxt_arm_nq_p5p(nqr, 0);
+			/* Loops through all RXQs and finds the one that
+			 * received a packet if any
+			 */
+			uint32_t cons = RING_CMPL(nqr->cp_ring_struct->ring_mask,
+					nqr->cp_raw_cons);
+			struct cmpl_base *cmpl = &((nqr->cp_desc_ring)[cons]);
+
+			if (CMPL_VALID(cmpl, nqr->valid)) {
+				unsigned int rxid = 0;
+
+				rx_cpr = rxq->cp_ring;
+				for (; rxid < bp->rx_nr_rings; rxid++) {
+					rxq = bp->rx_queues[rxid];
+					rx_cpr = rxq->cp_ring;
+					cons = RING_CMPL(rx_cpr->cp_ring_struct->ring_mask,
+							 rx_cpr->cp_raw_cons);
+					cmpl = &((rx_cpr->cp_desc_ring)[cons]);
+					/* Because the valid bit in the rx
+					 * completion queue is not updated the
+					 * cmp valid using raw cons is used
+					 */
+					if (bnxt_cpr_cmp_valid(cmpl,
+							       rx_cpr->cp_raw_cons,
+							       rx_cpr->cp_ring_struct->ring_size)) {
+						break;
+					}
+				}
+				bnxt_process_nq(bp, nqr, rx_cpr);
+			}
+		} else {
+			B_CP_DB_DISARM(cpr);
+		}
 	}
 	return rc;
 }
-- 
2.47.3

