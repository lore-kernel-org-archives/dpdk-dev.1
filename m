Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B07CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:06:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47B2040EE7;
	Wed, 15 Oct 2025 11:04:52 +0200 (CEST)
Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com
 [209.85.210.227])
 by mails.dpdk.org (Postfix) with ESMTP id A73D540E20
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:04:49 +0200 (CEST)
Received: by mail-pf1-f227.google.com with SMTP id
 d2e1a72fcca58-77f1f29a551so7992098b3a.3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519089; x=1761123889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yLNcYNDlnGphmhCBMz0plfQEOX8KFQsicyeioDDEx2E=;
 b=cZnTFub64NqffT8GmWjcFgpSrLH1JsrhV+s30oaNXnQRl7JciTvLCaeOm8UIPSFeBK
 EvnwvhgqxsggPyKF1MmTUt5tGREgNosgOg5GmuM3w/6S5a90rAfdaHyLtmB4083Wpi4p
 jZgRgSbo9dSPCFfRZhPzgMfQvnrGo9kMGOizG5yFVXjm7f4saRJZRWf/kVD+s/fAv1ik
 Y495RnrL4NCxGmJ57/NlbcStmepai4nSuK+uzZIzggteXcFv2KywK4Wjwg38GLvPp8Hk
 F/24PZkNCGk8hwwdPYmzmM0YD6BZCCvVtqZLeZGoyqeyvUon1vbnwKSwhzEAvIfmyIY9
 s7OQ==
X-Gm-Message-State: AOJu0YwPR1ILafTfAXZjqwFqLMXJ5BXoRJBqDm5SSZYuaGn/sfHChCgY
 dNkM3ZrIvLmPGLrGs+Cl53uVWceUqRmCCKkcR9dT7hFDufOQ2bJwDd8eFAkxY+tb/i8yBQjjVCJ
 rvbRFY+CGrRIg+acT8Zu3YNPO1vA7fl2wgF3sy22AYPAylP4jboEj8t6ACND7kHs/a0SXpxrrWx
 8cu+FFbTkMZVmhao23nRt3G7OrkGnGrdUa1O5es7HmxHtnSXECLErod5PDZXRe+xZ3kez7Kg==
X-Gm-Gg: ASbGncs3F9GrU7z8JLEprs6HaoRHLuegKGhbNXu+ptGiPrT/iK9+qn/dNJZEdkYOn4p
 qVZ1qWAGenKByhP0W1v2a2LX1DJzeJF77iuX+/blJUinSag6b3BusJLR1x7h2ukwepFp/N0O5eR
 K9FJRYz1wuUoxQsDCaAjO0Uwm+0n4b2Q8EGIJuPmngK1u8cLWGGLAz9TVGB2vDRwJm1n+cRcWVh
 umJCVGdaufQ16mMuTks7gG/MjAFrzgguOlctwvGUOhU08Q4kOB7Y1Zslf8Vv3HRNxuwp2qSyisq
 jGNb1yLxsdAn+TbFXDO4a5h8lX+9tdZoZODE/WriZDTx9wR5v1zpW7th30wz7Y1mmsXFMJ4YXSv
 yGquQKe/c9g8DLJCOWtHsMktqc9wYKJv5nVzEU0NpLvm8EWxchZ6tueiOT/F/hx0bmE/Q+1IA
X-Google-Smtp-Source: AGHT+IHd4ecFKAwliXvEr4Ad4soot2SBXb14tzjwfspZ7iPCVXtBWu+fF6x5qRMzNXDpBnw4GVMcjWFCshuD
X-Received: by 2002:a05:6a20:3956:b0:2e3:a914:aa93 with SMTP id
 adf61e73a8af0-32da83de20cmr37491401637.30.1760519088567; 
 Wed, 15 Oct 2025 02:04:48 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-1.dlp.protect.broadcom.com. [144.49.247.1])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-33b626ea0b6sm1555385a91.7.2025.10.15.02.04.48
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:04:48 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b6097ca315bso16813013a12.3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760519086; x=1761123886; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yLNcYNDlnGphmhCBMz0plfQEOX8KFQsicyeioDDEx2E=;
 b=aX5Dv9smqM5pg4yWOI7u9FqfvFznHfvcUNy0ssL0Aedz65fWe/8FZ9LC128cQKUfsh
 OqFNXjKTPrM1JMWPaicGqSEgUMvmf23NwP7WmpIa3SwDh8xPF4pHCtboSKqF8z5tjFZq
 xcOXw+JXy2c5dOnnZkd5xGAoKZUPlu/mEK060=
X-Received: by 2002:a05:6a20:729c:b0:2fc:660a:23f0 with SMTP id
 adf61e73a8af0-32da845fb62mr39142821637.46.1760519086008; 
 Wed, 15 Oct 2025 02:04:46 -0700 (PDT)
X-Received: by 2002:a05:6a20:729c:b0:2fc:660a:23f0 with SMTP id
 adf61e73a8af0-32da845fb62mr39142780637.46.1760519085364; 
 Wed, 15 Oct 2025 02:04:45 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.04.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:04:44 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Peter Spreadborough <peter.spreadborough@broadcom.com>,
 Jay Ding <jay.ding@broadcom.com>, Farah Smith <farah.smith@broadcom.com>
Subject: [PATCH v3 32/54] net/bnxt/tf_core: handle out of order MPC completions
Date: Wed, 15 Oct 2025 05:00:02 -0400
Message-Id: <20251015090024.32250-33-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251015090024.32250-1-manish.kurup@broadcom.com>
References: <20251009221129.28256-1-manish.kurup@broadcom.com>
 <20251015090024.32250-1-manish.kurup@broadcom.com>
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

From: Peter Spreadborough <peter.spreadborough@broadcom.com>

It is possible for MPC completions to be returned in an order
different to the corresponding MPC requests. This change adds
using the MPC opaque field to uniquely associate a completion
with a request and handling of out of order completions to
the batch-end processing.

Signed-off-by: Peter Spreadborough <peter.spreadborough@broadcom.com>
Reviewed-by: Jay Ding <jay.ding@broadcom.com>
Reviewed-by: Farah Smith <farah.smith@broadcom.com>
Reviewed-by: Manish Kurup <manish.kurup@broadcom.com>
---
 drivers/net/bnxt/bnxt_mpc.c           |  26 +++++-
 drivers/net/bnxt/bnxt_mpc.h           |   7 +-
 drivers/net/bnxt/tf_core/v3/tfc_act.c |  12 +--
 drivers/net/bnxt/tf_core/v3/tfc_em.c  | 126 +++++++++++++++++++++-----
 drivers/net/bnxt/tf_core/v3/tfc_em.h  |   4 +-
 5 files changed, 138 insertions(+), 37 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_mpc.c b/drivers/net/bnxt/bnxt_mpc.c
index 2582b50782..259066fa61 100644
--- a/drivers/net/bnxt/bnxt_mpc.c
+++ b/drivers/net/bnxt/bnxt_mpc.c
@@ -575,7 +575,9 @@ int bnxt_mpc_open(struct bnxt *bp)
 	return rc;
 }
 
-int bnxt_mpc_cmd_cmpl(struct bnxt_mpc_txq *mpc_queue, struct bnxt_mpc_mbuf *out_msg)
+int bnxt_mpc_cmd_cmpl(struct bnxt_mpc_txq *mpc_queue,
+		      struct bnxt_mpc_mbuf *out_msg,
+		      uint16_t *opaque)
 {
 	struct bnxt_cp_ring_info *cpr = mpc_queue->cp_ring;
 	uint32_t raw_cons = cpr->cp_raw_cons;
@@ -665,12 +667,13 @@ int bnxt_mpc_cmd_cmpl(struct bnxt_mpc_txq *mpc_queue, struct bnxt_mpc_mbuf *out_
 		bnxt_db_mpc_cq(cpr);
 	}
 
+	*opaque = (uint16_t)mpc_cmpl->info2;
 	return nb_mpc_cmds;
 }
 
 static uint16_t bnxt_mpc_xmit(struct bnxt_mpc_mbuf *mpc_cmd,
 			      struct bnxt_mpc_txq *mpc_queue,
-			      uint32_t *opaque)
+			      uint16_t *opaque)
 {
 	struct bnxt_mpc_ring_info *mpr = mpc_queue->mpc_ring;
 	struct bnxt_ring *ring = mpr->mpc_ring_struct;
@@ -715,13 +718,14 @@ static uint16_t bnxt_mpc_xmit(struct bnxt_mpc_mbuf *mpc_cmd,
 int bnxt_mpc_send(struct bnxt *bp,
 		  struct bnxt_mpc_mbuf *in_msg,
 		  struct bnxt_mpc_mbuf *out_msg,
-		  uint32_t *opaque,
+		  uint16_t *opaque,
 		  bool batch)
 {
 	int rc;
 	struct bnxt_mpc_txq *mpc_queue = bp->mpc->mpc_txq[in_msg->chnl_id];
 	int retry = BNXT_MPC_RX_RETRY;
 	uint32_t pi = 0;
+	uint16_t rx_opaque;
 
 	if (out_msg->cmp_type != CMPL_BASE_TYPE_MID_PATH_SHORT &&
 	    out_msg->cmp_type != CMPL_BASE_TYPE_MID_PATH_LONG)
@@ -737,6 +741,8 @@ int bnxt_mpc_send(struct bnxt *bp,
 	 * it can be detected.
 	 */
 	pi = mpc_queue->mpc_ring->raw_prod;
+	*opaque = mpc_queue->seq_num;
+	mpc_queue->seq_num++;
 	rc = bnxt_mpc_xmit(in_msg, mpc_queue, opaque);
 
 	if (unlikely(rc))
@@ -761,10 +767,20 @@ int bnxt_mpc_send(struct bnxt *bp,
 	do {
 		rte_delay_us_block(BNXT_MPC_RX_US_DELAY);
 
-		rc =  bnxt_mpc_cmd_cmpl(mpc_queue, out_msg);
+		rc =  bnxt_mpc_cmd_cmpl(mpc_queue, out_msg, &rx_opaque);
 
-		if (rc == 1)
+		if (rc == 1) {
+			if (rx_opaque != *opaque)
+				PMD_DRV_LOG_LINE(ERR,
+					    "%s: Out of order completion. Opaque Expected:%d Got:%d",
+					    __func__,
+					    *opaque,
+					    rx_opaque);
 			return 0;
+		}
+#ifdef MPC_DEBUG
+		PMD_DRV_LOG_LINE("Received zero or more than one completion:%d", rc);
+#endif
 		retry--;
 	} while (retry);
 
diff --git a/drivers/net/bnxt/bnxt_mpc.h b/drivers/net/bnxt/bnxt_mpc.h
index b089ddd4bb..da3672e493 100644
--- a/drivers/net/bnxt/bnxt_mpc.h
+++ b/drivers/net/bnxt/bnxt_mpc.h
@@ -93,6 +93,7 @@ struct bnxt_mpc_txq {
 	struct bnxt_cp_ring_info	*cp_ring;
 	const struct rte_memzone *mz;
 	struct bnxt_mpc_mbuf **free;
+	uint16_t	seq_num;
 
 	void (*cmpl_handler_cb)(struct bnxt_mpc_txq *mpc_queue,
 				uint32_t nb_mpc_cmds);
@@ -109,9 +110,11 @@ int bnxt_mpc_close(struct bnxt *bp);
 int bnxt_mpc_send(struct bnxt *bp,
 		  struct bnxt_mpc_mbuf *in_msg,
 		  struct bnxt_mpc_mbuf *out_msg,
-		  uint32_t *opaque,
+		  uint16_t *opaque,
 		  bool batch);
-int bnxt_mpc_cmd_cmpl(struct bnxt_mpc_txq *mpc_queue, struct bnxt_mpc_mbuf *out_msg);
+int bnxt_mpc_cmd_cmpl(struct bnxt_mpc_txq *mpc_queue,
+		      struct bnxt_mpc_mbuf *out_msg,
+		      uint16_t *opaque);
 int bnxt_mpc_poll_cmd_cmpls(struct bnxt_mpc_txq *mpc_queue);
 
 #endif
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_act.c b/drivers/net/bnxt/tf_core/v3/tfc_act.c
index 3c1c76359b..d93064dbc6 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_act.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_act.c
@@ -225,7 +225,7 @@ int tfc_act_set(struct tfc *tfcp,
 	int rc = 0;
 	uint8_t tx_msg[TFC_MPC_MAX_TX_BYTES];
 	uint8_t rx_msg[TFC_MPC_MAX_RX_BYTES];
-	uint32_t msg_count = BNXT_MPC_COMP_MSG_COUNT;
+	uint16_t opaque;
 	uint32_t i;
 	uint32_t buff_len;
 	struct cfa_mpc_data_obj fields_cmd[CFA_BLD_MPC_WRITE_CMD_MAX_FLD];
@@ -311,7 +311,7 @@ int tfc_act_set(struct tfc *tfcp,
 	rc = tfc_mpc_send(tfcp->bp,
 			  &mpc_msg_in,
 			  &mpc_msg_out,
-			  &msg_count,
+			  &opaque,
 			  TFC_MPC_TABLE_WRITE,
 			  batch_info);
 
@@ -377,7 +377,7 @@ static int tfc_act_get_only(struct tfc *tfcp,
 	int rc = 0;
 	uint8_t tx_msg[TFC_MPC_MAX_TX_BYTES] = { 0 };
 	uint8_t rx_msg[TFC_MPC_MAX_RX_BYTES] = { 0 };
-	uint32_t msg_count = BNXT_MPC_COMP_MSG_COUNT;
+	uint16_t opaque;
 	int i;
 	uint32_t buff_len;
 	struct cfa_mpc_data_obj fields_cmd[CFA_BLD_MPC_READ_CMD_MAX_FLD] = { {0} };
@@ -477,7 +477,7 @@ static int tfc_act_get_only(struct tfc *tfcp,
 	rc = tfc_mpc_send(tfcp->bp,
 			  &mpc_msg_in,
 			  &mpc_msg_out,
-			  &msg_count,
+			  &opaque,
 			  TFC_MPC_TABLE_READ,
 			  batch_info);
 
@@ -556,7 +556,7 @@ static int tfc_act_get_clear(struct tfc *tfcp,
 	int rc = 0;
 	uint8_t tx_msg[TFC_MPC_MAX_TX_BYTES] = { 0 };
 	uint8_t rx_msg[TFC_MPC_MAX_RX_BYTES] = { 0 };
-	uint32_t msg_count = BNXT_MPC_COMP_MSG_COUNT;
+	uint16_t opaque;
 	int i;
 	uint32_t buff_len;
 	struct cfa_mpc_data_obj fields_cmd[CFA_BLD_MPC_READ_CLR_CMD_MAX_FLD] = { {0} };
@@ -665,7 +665,7 @@ static int tfc_act_get_clear(struct tfc *tfcp,
 	rc = tfc_mpc_send(tfcp->bp,
 			  &mpc_msg_in,
 			  &mpc_msg_out,
-			  &msg_count,
+			  &opaque,
 			  TFC_MPC_TABLE_READ_CLEAR,
 			  batch_info);
 
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_em.c b/drivers/net/bnxt/tf_core/v3/tfc_em.c
index 828b7838f5..47870747e1 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_em.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_em.c
@@ -129,7 +129,7 @@ int tfc_em_insert(struct tfc *tfcp, uint8_t tsid,
 	uint32_t buff_len;
 	uint8_t tx_msg[TFC_MPC_MAX_TX_BYTES];
 	uint8_t rx_msg[TFC_MPC_MAX_RX_BYTES];
-	uint32_t msg_count = BNXT_MPC_COMP_MSG_COUNT;
+	uint16_t opaque;
 	uint32_t i;
 	uint32_t hash = 0;
 	struct cfa_mpc_data_obj fields_cmd[CFA_BLD_MPC_EM_INSERT_CMD_MAX_FLD];
@@ -354,7 +354,7 @@ int tfc_em_insert(struct tfc *tfcp, uint8_t tsid,
 	rc = tfc_mpc_send(tfcp->bp,
 			  &mpc_msg_in,
 			  &mpc_msg_out,
-			  &msg_count,
+			  &opaque,
 			  TFC_MPC_EM_INSERT,
 			  parms->batch_info);
 
@@ -500,7 +500,7 @@ int tfc_em_delete_raw(struct tfc *tfcp,
 	struct bnxt_mpc_mbuf mpc_msg_out;
 	uint8_t tx_msg[TFC_MPC_MAX_TX_BYTES];
 	uint8_t rx_msg[TFC_MPC_MAX_RX_BYTES];
-	uint32_t msg_count = BNXT_MPC_COMP_MSG_COUNT;
+	uint16_t opaque = 0;
 	int i;
 	struct cfa_mpc_data_obj fields_cmd[CFA_BLD_MPC_EM_DELETE_CMD_MAX_FLD];
 	struct cfa_bld_mpcinfo *mpc_info;
@@ -565,7 +565,7 @@ int tfc_em_delete_raw(struct tfc *tfcp,
 	rc = tfc_mpc_send(tfcp->bp,
 			  &mpc_msg_in,
 			  &mpc_msg_out,
-			  &msg_count,
+			  &opaque,
 			  TFC_MPC_EM_DELETE,
 			  batch_info);
 	if (rc) {
@@ -834,7 +834,7 @@ int tfc_em_delete_entries_by_pool_id(struct tfc *tfcp,
 int tfc_mpc_send(struct bnxt *bp,
 		 struct bnxt_mpc_mbuf *in_msg,
 		 struct bnxt_mpc_mbuf *out_msg,
-		 uint32_t *opaque,
+		 uint16_t *opaque,
 		 int type,
 		 struct tfc_mpc_batch_info_t *batch_info)
 {
@@ -856,6 +856,8 @@ int tfc_mpc_send(struct bnxt *bp,
 		batch_info->comp_info[batch_info->count].mpc_queue =
 			bp->mpc->mpc_txq[in_msg->chnl_id];
 		batch_info->comp_info[batch_info->count].type = type;
+		batch_info->comp_info[batch_info->count].opaque = *opaque;
+		batch_info->comp_info[batch_info->count].valid = true;
 		batch_info->count++;
 	}
 
@@ -863,7 +865,8 @@ int tfc_mpc_send(struct bnxt *bp,
 }
 
 static int tfc_mpc_process_completions(uint8_t *rx_msg,
-				       struct tfc_mpc_comp_info_t *comp_info)
+				       struct tfc_mpc_comp_info_t *comp_info,
+				       uint16_t *opaque)
 {
 	int rc;
 	int retry = BNXT_MPC_RX_RETRY;
@@ -872,7 +875,8 @@ static int tfc_mpc_process_completions(uint8_t *rx_msg,
 
 	do {
 		rc =  bnxt_mpc_cmd_cmpl(comp_info->mpc_queue,
-					&comp_info->out_msg);
+					&comp_info->out_msg,
+					opaque);
 
 		if (likely(rc == 1)) {
 #ifdef MPC_DEBUG
@@ -913,14 +917,41 @@ bool tfc_mpc_batch_started(struct tfc_mpc_batch_info_t *batch_info)
 	return (batch_info->enabled && batch_info->count > 0);
 }
 
+/* Test out of order handling */
+/*#define MPC_OOO_DEBUG */
+
+#ifdef MPC_OOO_DEBUG
+static void swap_entries(struct tfc_mpc_batch_info_t *batch_info, int count)
+{
+	struct tfc_mpc_comp_info_t tmp;
+	int i1;
+	int i2;
+
+	i1 = rand() % (count - 1);
+	i2 = rand() % (count - 1);
+
+	PMD_DRV_LOG(ERR, "%s: Swapping index %d and %d",
+		    __func__,
+		    i1,
+		    i2);
+
+	memcpy(&tmp, &batch_info->comp_info[i1], sizeof(tmp));
+	memcpy(&batch_info->comp_info[i1], &batch_info->comp_info[i2], sizeof(tmp));
+	memcpy(&batch_info->comp_info[i2], &tmp, sizeof(tmp));
+}
+#endif
+
 int tfc_mpc_batch_end(struct tfc *tfcp,
 		      struct tfc_mpc_batch_info_t *batch_info)
 {
-	uint32_t i;
+	uint32_t j;
+	uint32_t start_index = 0;
 	int rc;
 	uint8_t rx_msg[TFC_MPC_MAX_RX_BYTES];
 	struct cfa_bld_mpcinfo *mpc_info;
 	uint32_t hash = 0;
+	uint16_t opaque = 0;
+	uint32_t count;
 #if TFC_EM_DYNAMIC_BUCKET_EN
 	bool *db_unused;
 	uint32_t *db_offset;
@@ -945,17 +976,65 @@ int tfc_mpc_batch_end(struct tfc *tfcp,
 	if (batch_info->count < (BNXT_MPC_COMP_MAX_COUNT / 4))
 		rte_delay_us_block(BNXT_MPC_RX_US_DELAY * 4);
 
-	for (i = 0; i < batch_info->count; i++) {
+#ifdef MPC_OOO_DEBUG
+	/* force out of order in large batches */
+	if (batch_info->count > 10)
+		swap_entries(batch_info, batch_info->count);
+#endif
+
+	count = batch_info->count;
+
+	while (count) {
 		rc = tfc_mpc_process_completions(&rx_msg[TFC_MPC_HEADER_SIZE_BYTES],
-						 &batch_info->comp_info[i]);
+						 &batch_info->comp_info[start_index],
+						 &opaque);
 		if (unlikely(rc))
 			return -1;
 
+#ifdef MPC_DEBUG
+		PMD_DRV_LOG(ERR, "%s: count:%d start_index:%d bo:%d op:%d ci:%p type:%d",
+			    __func__,
+			    count,
+			    start_index,
+			    batch_info->comp_info[start_index].opaque,
+			    opaque,
+			    batch_info->comp_info[start_index].mpc_queue,
+			    batch_info->comp_info[start_index].type);
+#endif
+
+		/* Find batch entry that has a matching opaque value */
+		for (j = start_index; j < batch_info->count; j++) {
+			if (!batch_info->comp_info[j].valid ||
+			    opaque != batch_info->comp_info[j].opaque ||
+			    batch_info->comp_info[start_index].mpc_queue !=
+			    batch_info->comp_info[j].mpc_queue)
+				continue;
+
+			count--;
+
+			if (j != start_index) {
+				PMD_DRV_LOG_LINE(INFO,
+						 "%s: OOO comp. Opq Exp:%d Got:%d j:%d",
+						 __func__,
+						 batch_info->comp_info[j].opaque,
+						 opaque, j);
+			} else {
+				start_index++;
+
+				while (count &&
+				       start_index < batch_info->count &&
+				       !batch_info->comp_info[start_index].valid)
+					start_index++;
+			}
+
+			batch_info->comp_info[j].out_msg.msg_data = rx_msg;
+			break;
+		}
 
-		switch (batch_info->comp_info[i].type) {
+		switch (batch_info->comp_info[j].type) {
 		case TFC_MPC_EM_INSERT:
 			rc = tfc_em_insert_response(mpc_info,
-						    &batch_info->comp_info[i].out_msg,
+						    &batch_info->comp_info[j].out_msg,
 						    rx_msg,
 						    &hash);
 			/*
@@ -963,14 +1042,14 @@ int tfc_mpc_batch_end(struct tfc *tfcp,
 			 * flow DB entry that requires the flow_handle
 			 * contained within to be updated.
 			 */
-			batch_info->em_hdl[i] =
-				tfc_create_flow_handle2(batch_info->em_hdl[i],
+			batch_info->em_hdl[j] =
+				tfc_create_flow_handle2(batch_info->em_hdl[j],
 							hash);
 			batch_info->em_error = rc;
 			break;
 		case TFC_MPC_EM_DELETE:
 			rc = tfc_em_delete_response(mpc_info,
-						    &batch_info->comp_info[i].out_msg,
+						    &batch_info->comp_info[j].out_msg,
 						    rx_msg
 #if TFC_EM_DYNAMIC_BUCKET_EN
 						    , bool *db_unused,
@@ -980,30 +1059,31 @@ int tfc_mpc_batch_end(struct tfc *tfcp,
 			break;
 		case TFC_MPC_TABLE_WRITE:
 			rc = tfc_act_set_response(mpc_info,
-						  &batch_info->comp_info[i].out_msg,
+						  &batch_info->comp_info[j].out_msg,
 						  rx_msg);
 			break;
 		case TFC_MPC_TABLE_READ:
 			rc = tfc_act_get_only_response(mpc_info,
-						       &batch_info->comp_info[i].out_msg,
+						       &batch_info->comp_info[j].out_msg,
 						       rx_msg,
-						       &batch_info->comp_info[i].read_words);
+						       &batch_info->comp_info[j].read_words);
 			break;
 
 		case TFC_MPC_TABLE_READ_CLEAR:
 			rc = tfc_act_get_clear_response(mpc_info,
-							&batch_info->comp_info[i].out_msg,
+							&batch_info->comp_info[j].out_msg,
 							rx_msg,
-							&batch_info->comp_info[i].read_words);
+							&batch_info->comp_info[j].read_words);
 			break;
 
 		default:
-			PMD_DRV_LOG_LINE(ERR, "MPC Batch not supported for type: %d",
-					 batch_info->comp_info[i].type);
+			PMD_DRV_LOG_LINE(ERR, "%s: MPC Batch not supported for type: %d",
+				    __func__, batch_info->comp_info[j].type);
 			return -1;
 		}
 
-		batch_info->result[i] = rc;
+		batch_info->comp_info[j].valid = false;
+		batch_info->result[j] = rc;
 		if (rc)
 			batch_info->error = true;
 	}
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_em.h b/drivers/net/bnxt/tf_core/v3/tfc_em.h
index 52589ea9c3..659cebe907 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_em.h
+++ b/drivers/net/bnxt/tf_core/v3/tfc_em.h
@@ -21,6 +21,8 @@ struct tfc_mpc_comp_info_t {
 	struct bnxt_mpc_mbuf out_msg;
 	int type;
 	uint16_t read_words;
+	uint16_t opaque;
+	bool valid;
 };
 
 struct tfc_mpc_batch_info_t {
@@ -249,7 +251,7 @@ int tfc_act_get_clear_response(struct cfa_bld_mpcinfo *mpc_info,
 int tfc_mpc_send(struct bnxt *bp,
 		 struct bnxt_mpc_mbuf *in_msg,
 		 struct bnxt_mpc_mbuf *out_msg,
-		 uint32_t *opaque,
+		 uint16_t *opaque,
 		 int type,
 		 struct tfc_mpc_batch_info_t *batch_info);
 
-- 
2.39.5 (Apple Git-154)

