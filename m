Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D12CCD6E57
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 21:11:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F72E40651;
	Wed,  3 Jun 2026 23:11:57 +0200 (CEST)
Received: from mail-yx1-f98.google.com (mail-yx1-f98.google.com
 [74.125.224.98]) by mails.dpdk.org (Postfix) with ESMTP id A051540651
 for <dev@dpdk.org>; Wed,  3 Jun 2026 23:11:55 +0200 (CEST)
Received: by mail-yx1-f98.google.com with SMTP id
 956f58d0204a3-660390acd71so1105122d50.1
 for <dev@dpdk.org>; Wed, 03 Jun 2026 14:11:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780521115; x=1781125915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ypsyQIUC3FlRxR89BLBDT2qhgTINM2O1sZ3NodogXVQ=;
 b=YuGfHniTRqWxmWKNX1bkzqQkebhB+ZKmEATVueTm2/gTtfhjNd6XNiXo0iW5+cpq7g
 Zjd/YAtzsF3E7flQsbL5S3jtgewMTTj4dZ7pcsctj3JrA8khhswAquQ9X3IRygwXJFGe
 r7C895pJb+Z17/uisZ0WGH7gIX+StCaSiGLvI94FHO0UYsFlRf3fR/lofbKO7B9yRf75
 XT6VID2xhrTkJ1zHHLtRKAeg2SNq3XXkyPXXsrZJDqxTc6H4WZHtARlJKi2HObSoU3SB
 PPg+8kpnNA178j4jfjyhx+F3O78hRvhbyAmoQG2x8C1RUMg/OPh1FBy+uMEXEoxS6zq5
 aAyg==
X-Gm-Message-State: AOJu0YyJBQVzeZQOhqEMz2OVvQc9mdzYwfE0611V65AJY0bGKi9xmeF4
 kl02+a4Uh1NaT7ZCH1fGY6m+mS875Ikr4BDN3HNf+zrYkwD+sOuNVGU/kziSG/PY+uzPjckLIoh
 WIbOh5dMbhUO+wRNDtmcaVqspxqf7zhl0nklpGR2ZzaiWi/zig/qEWRW3ZLtn1DPWsj1cSBxq/f
 TkrB4lyDerZXyIRiEKbXeVd2luNVQq/hOMdR2W91aQqb4tnuncK5QH9VchSw/aw6sciKXHpLncB
 b8EjH2XTCD8
X-Gm-Gg: Acq92OGUqgT0qbgeqAVUhsuRNrwFckao4fgVuQXd//nfHJVqlEf7E115DDhuy8oJkzG
 MVCHxBzdfkdtnloPY4Y6gRoo8LSq51UNNUWaUTgE7Vx6jWl1jjRj8qXQ9nvGcFjFmw3MxIuT6Zg
 Wu0spG4pscFbsi+8Q4loaWknLDyv9s5V8iNb8TKdaMOSQ2bpCWQRdYnBGxVAo4GHmpzj9hos/V0
 DkEIBf8Iu0gPjhZ9E6Ajk65V11XemPqp+eM65mcV8bbUO8x5P7kO81NYufmXoEtfVT1su5ojNQT
 9Jp2eBCNxS63ued57cOqnI4s9MpNj9XiGwazZnk4sz7c9ihmTPICSWKyZ/S8ULPh+Dz38OKdCGc
 ImEogIL1udu1Jd8WK+XECxLndl4OQGpmUmZ4plywkLU6KuZHWQhgcm6gXoVeepp3zQMXlQQAlRh
 XKIacTtKgzEWwSFcB6QwMIUB8YfzX5sc2eFY4Ocmks12yTYyMCiPKxY4Pp7dHdBT5e7pn0IomoO
 tnJFGAESzlJ
X-Received: by 2002:a05:690e:14cd:b0:65e:28f3:4a51 with SMTP id
 956f58d0204a3-660f1212c73mr1047007d50.24.1780521114786; 
 Wed, 03 Jun 2026 14:11:54 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 956f58d0204a3-660d6471021sm321961d50.28.2026.06.03.14.11.54
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jun 2026 14:11:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8ced08f46b0so20681196d6.0
 for <dev@dpdk.org>; Wed, 03 Jun 2026 14:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780521114; x=1781125914; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ypsyQIUC3FlRxR89BLBDT2qhgTINM2O1sZ3NodogXVQ=;
 b=fYNMlEikv2MmkwEdQv5FNZY6jhZ4wesReS5KVXm3TS1OGU2uSzz+NAg5qgOel+gsDp
 ky8WkLwqCIyixHx9c1NaSYpXAxIk1rVt0AmrWjL01GE+FhUkh6W0jG3qPUPcL0YqBdFm
 nQFTCgxptFVVzuyodIm2yhAoUJyKDJJ8uTP44=
X-Received: by 2002:a05:6214:dc6:b0:8bd:3440:c024 with SMTP id
 6a1803df08f44-8ced81c64a4mr18290416d6.15.1780521113974; 
 Wed, 03 Jun 2026 14:11:53 -0700 (PDT)
X-Received: by 2002:a05:6214:dc6:b0:8bd:3440:c024 with SMTP id
 6a1803df08f44-8ced81c64a4mr18289936d6.15.1780521113380; 
 Wed, 03 Jun 2026 14:11:53 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd0520d3sm31665416d6.27.2026.06.03.14.11.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 14:11:52 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Keegan Freyhof <keegan.freyhof@broadcom.com>,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH 1/5] net/bnxt: fix NQ/CQ processing for interrupt handling
Date: Wed,  3 Jun 2026 15:13:37 -0600
Message-ID: <20260603211341.2112344-2-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603211341.2112344-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260603211341.2112344-1-Mohammad-Shuab.Siddique@broadcom.com>
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
 drivers/net/bnxt/bnxt_cpr.c | 99 +++++++++++++++++++++++++++++++++++++
 drivers/net/bnxt/bnxt_cpr.h | 34 ++++++++++++-
 drivers/net/bnxt/bnxt_rxq.c | 47 +++++++++++++++++-
 4 files changed, 179 insertions(+), 3 deletions(-)

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
@@ -13,6 +13,104 @@
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
+		printf("Port:%d Unhandled async message %x\n", bp->eth_dev->data->port_id, type);
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

