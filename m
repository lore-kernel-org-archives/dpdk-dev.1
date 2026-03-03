Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C8EEDA6BE
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Mar 2026 17:30:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78F1140E8A;
	Tue,  3 Mar 2026 18:30:40 +0100 (CET)
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com
 [209.85.216.100])
 by mails.dpdk.org (Postfix) with ESMTP id 5CCE140268
 for <dev@dpdk.org>; Tue,  3 Mar 2026 18:30:39 +0100 (CET)
Received: by mail-pj1-f100.google.com with SMTP id
 98e67ed59e1d1-3599019ae92so1286011a91.0
 for <dev@dpdk.org>; Tue, 03 Mar 2026 09:30:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772559038; x=1773163838;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DOhWNFWNoCeWQChpMjEMbM7/JPk2LXs2Jg1ZusHP0nE=;
 b=BoB1l8OB4KQx0+AxbifRXW0jM+NEixk6ykTd7RfPngIfoA0N4nFpYcSAWGB4z3SHNn
 QXomYrPsCIQhgwBt2yFWzOj4c8DjnS6N0IiyC/me9sTn73zvwsnxHqQqrqKLIDzYBSUK
 2oFBk2Kp/dGqqkSetYwoVCBE5zC0KpNnD4/3Bwfu4eqAB0eHTZclQms4LzkeWQqijC7P
 QFdLD9UtE3BsSkBoxIcj8cgO6CO/gNcuUbNESw/cWrtxe6xhkHU07yVQY2eDZZdMdHie
 iDdQlwdzln32OFtUQWxbV2ak3LID5ef0oYCpOyMr8jrdx/mbqAQpcD04HFLKyMS5i8Eb
 9KMg==
X-Gm-Message-State: AOJu0YzFOyePprvnNJzQSftaJIRNeIiCjbFe3nWGlKGXE4WJt98smi19
 2EyIK/5d6i/caNr/3KY/j8yD3PfcOpDPHzu2yzPubQiSZsAAUIkHM+kAZMBa4ZaP9QIJI3EW1xs
 7ZWTxFKTHtwlJn3V1HRXPU+18nYI7w6++pD5+ZfJG+1FqqexcF0blgpdD0pqbgQchp1i8yDu9zY
 4sJof9qPibaEM/DssqfNjan6cwHohpIpatxktbBcouqQfE8B/OhfoyT//GgkSfSi0clJnLvC1BU
 ACfRrZVt7c3
X-Gm-Gg: ATEYQzxBkmfJQSxv31c+sxjh0Araa+ysnwePK88nZ6YSPKgW89aKCQQCnips6BRBzO2
 VAxPs2+ef369b7wR1PBYH0y5Ptqzbc6gBm0+zN/mDDiQp0Y8x0QWET+Y4adLTN2q6i8EyQRs5y2
 RRF6tp0Ex8ho/k/IqyTcGHjcVpRnF24EohCB5Nx2Ajhd3WFGQ74h3NADc4GWnV6l9gXUzBNG472
 w7YDPFqs0RrJQnUdW87l9HvIsAgILl9rwhbHVxS9803bNfnRVeWXwFqqX+7Qzt0DqtBUZa56R7N
 R2SH4JIhEe3VrnNuFkXZeWSsT7/uCcci3Cme8dFM9rme9i8anvY7jgrcQQB327wlPrHkPkjafvO
 /96XP7H7q1d/ktARE+9kIt9KuhAxTOgnlsWulPEYjttu8hwJHLGKHNkq+yais7Cf/2hiDa3lxOI
 C01Az85H3Imd36a0AcgUZlUPLRfywZ42LKyH2M8ChUYDIiHRre9U9TiFFxblVRF9m/ZhtD8LLWM
 g==
X-Received: by 2002:a17:90b:1ccd:b0:359:1063:6aed with SMTP id
 98e67ed59e1d1-35965c92637mr11937975a91.22.1772559038071; 
 Tue, 03 Mar 2026 09:30:38 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3599c47564bsm401615a91.4.2026.03.03.09.30.37
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 03 Mar 2026 09:30:38 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-504888a2a1dso445815021cf.0
 for <dev@dpdk.org>; Tue, 03 Mar 2026 09:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1772559036; x=1773163836; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DOhWNFWNoCeWQChpMjEMbM7/JPk2LXs2Jg1ZusHP0nE=;
 b=TqfFQ5xoSz8lz0K9TorXQzJ8/99BkWgQoEWNVx1G0DUkeCCa2Ys17meVeT73JMavIG
 EJ5J2ady/Kk7OOEXjBJnHi+XFkGtmW3AP6pVDPh5V9Pb3/ZJBqTEuzpAF5s8gGbf+Z4i
 ewxJtJilFqqPEP9ZgodIc8tzZ2TLttBXPOQ3Q=
X-Received: by 2002:a05:622a:1181:b0:501:4858:a6d0 with SMTP id
 d75a77b69052e-507529db89dmr231150561cf.56.1772559036268; 
 Tue, 03 Mar 2026 09:30:36 -0800 (PST)
X-Received: by 2002:a05:622a:1181:b0:501:4858:a6d0 with SMTP id
 d75a77b69052e-507529db89dmr231148911cf.56.1772559035010; 
 Tue, 03 Mar 2026 09:30:35 -0800 (PST)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50744ad028esm136756121cf.25.2026.03.03.09.30.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 09:30:34 -0800 (PST)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: =kishore.padmanabha@broadcom.com,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>,
 stable@dpdk.org
Subject: [PATCH] net/bnxt: add multi-doorbell support
Date: Tue,  3 Mar 2026 10:31:53 -0700
Message-ID: <20260303173156.204872-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
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

From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>

Add multi-doorbell support to spread doorbell accesses across
multiple doorbell pages for improved performance on P5/P7 chips.

Detect capability via HWRM_FUNC_QCAPS
Round-robin DPI assignment for NQ rings per device
TX rings inherit DPI from parent NQ
RX/CQ rings use privileged DPI 0
P7: DPI 0=legacy, DPI 1=push, DPI 2+ for multi-DB
P5: DPI 0=legacy, DPI 1+ for multi-DB

Cc: stable@dpdk.org

Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt.h                | 13 +++++
 drivers/net/bnxt/bnxt_cpr.h            |  1 +
 drivers/net/bnxt/bnxt_hwrm.c           | 51 +++++++++++++++++--
 drivers/net/bnxt/bnxt_hwrm.h           |  2 +-
 drivers/net/bnxt/bnxt_mpc.c            |  4 +-
 drivers/net/bnxt/bnxt_ring.c           | 70 ++++++++++++++++++--------
 drivers/net/bnxt/bnxt_ring.h           |  3 +-
 drivers/net/bnxt/bnxt_rxr.h            |  1 +
 drivers/net/bnxt/bnxt_txr.h            |  1 +
 drivers/net/bnxt/hsi_struct_def_dpdk.h | 30 +++++++++++
 10 files changed, 147 insertions(+), 29 deletions(-)

diff --git a/drivers/net/bnxt/bnxt.h b/drivers/net/bnxt/bnxt.h
index 83ae151066..53a97eb095 100644
--- a/drivers/net/bnxt/bnxt.h
+++ b/drivers/net/bnxt/bnxt.h
@@ -433,6 +433,13 @@ struct bnxt_coal {
 #define DB_PF_OFFSET			0x10000
 #define DB_VF_OFFSET			0x4000
 
+#define BNXT_PRIVILEGED_DPI		0
+#define BNXT_RESERVED_DPI_ONE		1
+#define BNXT_RESERVED_DPI_TWO		2
+#define BNXT_DEFAULT_DB_PAGE_SIZE	4096
+
+#define BNXT_KB_TO_BYTES(kb)		((kb) * 1024)
+
 #define BNXT_RSS_TBL_SIZE_P5		512U
 #define BNXT_RSS_ENTRIES_PER_CTX_P5	64
 #define BNXT_MAX_RSS_CTXTS_P5 \
@@ -873,6 +880,7 @@ struct bnxt {
 #define BNXT_FW_CAP_RX_ALL_PKT_TS	BIT(11)
 #define BNXT_FW_CAP_BACKING_STORE_V2	BIT(12)
 #define BNXT_FW_CAP_RX_RATE_PROFILE	BIT(17)
+#define BNXT_FW_CAP_MULTI_DB		BIT(18)
 #define BNXT_FW_BACKING_STORE_V2_EN(bp)	\
 	((bp)->fw_cap & BNXT_FW_CAP_BACKING_STORE_V2)
 #define BNXT_FW_BACKING_STORE_V1_EN(bp)	\
@@ -1079,6 +1087,11 @@ struct bnxt {
 	struct rte_eth_rss_conf	rss_conf; /* RSS configuration. */
 	uint16_t		tunnel_disable_flag; /* tunnel stateless offloads status */
 	uint8_t			chip_rev;
+	uint16_t		l2_db_multi_page_size_kb;	/* Multi-L2 DB BAR size in KB */
+	uint16_t		db_page_size;			/* Doorbell page size (typically 4KB) */
+	uint8_t			nq_dpi_start;			/* Starting DPI for NQ rings */
+	uint8_t			nq_dpi_count;			/* Number of DPI pages for NQ */
+	uint8_t			nq_dpi_counter;			/* Round-robin counter for NQ DPI */
 };
 
 static
diff --git a/drivers/net/bnxt/bnxt_cpr.h b/drivers/net/bnxt/bnxt_cpr.h
index 94f449e8b5..858ee15c47 100644
--- a/drivers/net/bnxt/bnxt_cpr.h
+++ b/drivers/net/bnxt/bnxt_cpr.h
@@ -89,6 +89,7 @@ struct bnxt_cp_ring_info {
 	struct bnxt_ring	*cp_ring_struct;
 	bool			valid;
 	uint32_t                epoch;
+	uint8_t			dpi;
 };
 
 #define RX_CMP_L2_ERRORS						\
diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index 0cef22b5ec..7c58727e59 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -1254,6 +1254,9 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 	if (flags_ext3 & HWRM_FUNC_QCAPS_OUTPUT_FLAGS_EXT3_RX_RATE_PROFILE_SEL_SUPPORTED)
 		bp->fw_cap |= BNXT_FW_CAP_RX_RATE_PROFILE;
 
+	if (flags_ext3 & HWRM_FUNC_QCAPS_OUTPUT_FLAGS_EXT3_MULTI_L2_DB_SUPPORTED)
+		bp->fw_cap |= BNXT_FW_CAP_MULTI_DB;
+
 	/* This block should be kept at the end of this function because it
 	 * sends another hwrm msg.
 	 */
@@ -2176,7 +2179,7 @@ int bnxt_hwrm_ring_alloc(struct bnxt *bp,
 			 struct bnxt_ring *ring,
 			 uint32_t ring_type, uint32_t map_index,
 			 uint32_t stats_ctx_id, uint32_t cmpl_ring_id,
-			 uint16_t tx_cosq_id)
+			 uint16_t tx_cosq_id, uint16_t dpi)
 {
 	int rc = 0;
 	uint32_t enables = 0;
@@ -2280,6 +2283,11 @@ int bnxt_hwrm_ring_alloc(struct bnxt *bp,
 		HWRM_UNLOCK();
 		return -EINVAL;
 	}
+
+	if (bp->fw_cap & BNXT_FW_CAP_MULTI_DB) {
+		req.dpi = rte_cpu_to_le_16(dpi);
+		enables |= HWRM_RING_ALLOC_INPUT_ENABLES_DPI_VALID;
+	}
 	req.enables = rte_cpu_to_le_32(enables);
 
 	rc = bnxt_hwrm_send_message(bp, &req, sizeof(req), BNXT_USE_CHIMP_MB);
@@ -4195,12 +4203,15 @@ int bnxt_set_hwrm_link_config(struct bnxt *bp, bool link_up)
 
 int bnxt_hwrm_func_qcfg(struct bnxt *bp, uint16_t *mtu)
 {
-	struct hwrm_func_qcfg_input req = {0};
 	struct hwrm_func_qcfg_output *resp = bp->hwrm_cmd_resp_addr;
+	struct hwrm_func_qcfg_input req = {0};
+	uint16_t l2_db_multi_kb;
+	uint16_t total_pages;
+	uint16_t svif_info;
 	uint16_t flags;
 	int rc = 0;
+
 	bp->func_svif = BNXT_SVIF_INVALID;
-	uint16_t svif_info;
 
 	HWRM_PREP(&req, HWRM_FUNC_QCFG, BNXT_USE_CHIMP_MB);
 	req.fid = rte_cpu_to_le_16(0xffff);
@@ -4246,9 +4257,39 @@ int bnxt_hwrm_func_qcfg(struct bnxt *bp, uint16_t *mtu)
 		bp->flags &= ~BNXT_FLAG_NPAR_PF;
 		break;
 	}
-
 	bp->legacy_db_size =
-		rte_le_to_cpu_16(resp->legacy_l2_db_size_kb) * 1024;
+		BNXT_KB_TO_BYTES(rte_le_to_cpu_16(resp->legacy_l2_db_size_kb));
+
+	/* Configure multi-doorbell if supported */
+	if (bp->fw_cap & BNXT_FW_CAP_MULTI_DB) {
+		l2_db_multi_kb = rte_le_to_cpu_16(resp->l2_db_multi_page_size_kb);
+		bp->l2_db_multi_page_size_kb = l2_db_multi_kb ? l2_db_multi_kb :
+			rte_le_to_cpu_16(resp->l2_doorbell_bar_size_kb);
+
+		if (bp->l2_db_multi_page_size_kb > 0) {
+			bp->db_page_size = BNXT_DEFAULT_DB_PAGE_SIZE;
+			total_pages = BNXT_KB_TO_BYTES(bp->l2_db_multi_page_size_kb) /
+					bp->db_page_size;
+
+			/* P7: DPI 0=legacy, DPI 1=push reserved; P5: DPI 0=legacy */
+			bp->nq_dpi_start = BNXT_CHIP_P7(bp) ?
+				BNXT_RESERVED_DPI_TWO : BNXT_RESERVED_DPI_ONE;
+			bp->nq_dpi_count = (total_pages > bp->nq_dpi_start) ?
+				(total_pages - bp->nq_dpi_start) : 0;
+			bp->nq_dpi_counter = 0;
+			PMD_DRV_LOG_LINE(INFO,
+					"Multi-doorbell: %u KB, "
+					"DPI range %u-%u (%u pages)",
+					bp->l2_db_multi_page_size_kb,
+					bp->nq_dpi_start,
+					bp->nq_dpi_start + bp->nq_dpi_count - 1,
+					bp->nq_dpi_count);
+		} else {
+			PMD_DRV_LOG_LINE(INFO,
+					"Multi-doorbell supported "
+					"but no pages allocated");
+		}
+	}
 
 	HWRM_UNLOCK();
 
diff --git a/drivers/net/bnxt/bnxt_hwrm.h b/drivers/net/bnxt/bnxt_hwrm.h
index ecb6335b3d..fc56223ab4 100644
--- a/drivers/net/bnxt/bnxt_hwrm.h
+++ b/drivers/net/bnxt/bnxt_hwrm.h
@@ -221,7 +221,7 @@ int bnxt_hwrm_ring_alloc(struct bnxt *bp,
 			 struct bnxt_ring *ring,
 			 uint32_t ring_type, uint32_t map_index,
 			 uint32_t stats_ctx_id, uint32_t cmpl_ring_id,
-			 uint16_t tx_cosq_id);
+			 uint16_t tx_cosq_id, uint16_t dpi);
 int bnxt_hwrm_ring_free(struct bnxt *bp,
 			struct bnxt_ring *ring, uint32_t ring_type,
 			uint16_t cp_ring_id);
diff --git a/drivers/net/bnxt/bnxt_mpc.c b/drivers/net/bnxt/bnxt_mpc.c
index 259066fa61..d77f9dd308 100644
--- a/drivers/net/bnxt/bnxt_mpc.c
+++ b/drivers/net/bnxt/bnxt_mpc.c
@@ -502,7 +502,7 @@ static int bnxt_mpc_ring_alloc_one(struct bnxt *bp, enum bnxt_mpc_chnl chnl_id)
 				  map_index,
 				  cpr->hw_stats_ctx_id,
 				  cp_ring->fw_ring_id,
-				  MPC_HW_COS_ID);
+				  MPC_HW_COS_ID, BNXT_PRIVILEGED_DPI);
 	if (rc) {
 		PMD_DRV_LOG_LINE(ERR, "mpc ring %d tx ring alloc failed rc:%d!",
 			    chnl_id, rc);
@@ -510,7 +510,7 @@ static int bnxt_mpc_ring_alloc_one(struct bnxt *bp, enum bnxt_mpc_chnl chnl_id)
 	}
 
 	bnxt_set_db(bp, &mpr->db, HWRM_RING_ALLOC_INPUT_RING_TYPE_TX, chnl_id,
-		    ring->fw_ring_id, ring->ring_mask);
+		    ring->fw_ring_id, ring->ring_mask, BNXT_PRIVILEGED_DPI);
 
 	bnxt_hwrm_set_ring_coal(bp, &coal, cp_ring->fw_ring_id);
 
diff --git a/drivers/net/bnxt/bnxt_ring.c b/drivers/net/bnxt/bnxt_ring.c
index b6d411a931..ccca779b97 100644
--- a/drivers/net/bnxt/bnxt_ring.c
+++ b/drivers/net/bnxt/bnxt_ring.c
@@ -353,8 +353,11 @@ void bnxt_set_db(struct bnxt *bp,
 		 uint32_t ring_type,
 		 uint32_t map_idx,
 		 uint32_t fid,
-		 uint32_t ring_mask)
+		 uint32_t ring_mask,
+		 uint16_t dpi)
 {
+	uint64_t dpi_offset;
+
 	if (BNXT_CHIP_P5_P7(bp)) {
 		int db_offset = DB_PF_OFFSET;
 		switch (ring_type) {
@@ -379,8 +382,14 @@ void bnxt_set_db(struct bnxt *bp,
 		} else if (BNXT_VF(bp)) {
 			db_offset = DB_VF_OFFSET;
 		}
-
 		db->doorbell = (char *)bp->doorbell_base + db_offset;
+
+		if (bp->fw_cap & BNXT_FW_CAP_MULTI_DB &&
+				dpi != BNXT_PRIVILEGED_DPI) {
+			dpi_offset = (dpi - bp->nq_dpi_start) *
+					bp->db_page_size;
+			db->doorbell = (char *)db->doorbell + dpi_offset;
+		}
 		db->db_key64 |= (uint64_t)fid << DBR_XID_SFT;
 		db->db_64 = true;
 	} else {
@@ -404,32 +413,33 @@ void bnxt_set_db(struct bnxt *bp,
 int bnxt_alloc_cmpl_ring(struct bnxt *bp, int queue_index,
 			 struct bnxt_cp_ring_info *cpr)
 {
-	struct bnxt_ring *cp_ring = cpr->cp_ring_struct;
-	uint32_t nq_ring_id = HWRM_NA_SIGNATURE;
 	int cp_ring_index = queue_index + BNXT_RX_VEC_START;
 	struct bnxt_cp_ring_info *nqr = bp->rxtx_nq_ring;
+	struct bnxt_ring *cp_ring = cpr->cp_ring_struct;
+	uint32_t nq_ring_id = HWRM_NA_SIGNATURE;
+	uint8_t dpi = BNXT_PRIVILEGED_DPI;
 	uint8_t ring_type;
 	int rc = 0;
 
 	ring_type = HWRM_RING_ALLOC_INPUT_RING_TYPE_L2_CMPL;
 
 	if (BNXT_HAS_NQ(bp)) {
-		if (nqr) {
-			nq_ring_id = nqr->cp_ring_struct->fw_ring_id;
-		} else {
+		if (!nqr) {
 			PMD_DRV_LOG_LINE(ERR, "NQ ring is NULL");
 			return -EINVAL;
 		}
+		nq_ring_id = nqr->cp_ring_struct->fw_ring_id;
 	}
 
+	cpr->dpi = dpi;
 	rc = bnxt_hwrm_ring_alloc(bp, cp_ring, ring_type, cp_ring_index,
-				  HWRM_NA_SIGNATURE, nq_ring_id, 0);
+				  HWRM_NA_SIGNATURE, nq_ring_id, 0, dpi);
 	if (rc)
 		return rc;
 
 	cpr->cp_raw_cons = 0;
 	bnxt_set_db(bp, &cpr->cp_db, ring_type, cp_ring_index,
-		    cp_ring->fw_ring_id, cp_ring->ring_mask);
+		    cp_ring->fw_ring_id, cp_ring->ring_mask, dpi);
 	bnxt_db_cq(cpr);
 
 	return 0;
@@ -437,10 +447,12 @@ int bnxt_alloc_cmpl_ring(struct bnxt *bp, int queue_index,
 
 int bnxt_alloc_rxtx_nq_ring(struct bnxt *bp)
 {
+	int ring_index = BNXT_NUM_ASYNC_CPR(bp);
+	uint8_t dpi = BNXT_PRIVILEGED_DPI;
 	struct bnxt_cp_ring_info *nqr;
 	struct bnxt_ring *ring;
-	int ring_index = BNXT_NUM_ASYNC_CPR(bp);
 	uint8_t ring_type;
+	uint8_t offset;
 	int rc = 0;
 
 	if (!BNXT_HAS_NQ(bp) || bp->rxtx_nq_ring)
@@ -481,8 +493,18 @@ int bnxt_alloc_rxtx_nq_ring(struct bnxt *bp)
 
 	ring_type = HWRM_RING_ALLOC_INPUT_RING_TYPE_NQ;
 
+	/* Assign DPI using round-robin if multi-doorbell is enabled */
+	if (bp->fw_cap & BNXT_FW_CAP_MULTI_DB && bp->nq_dpi_count > 0) {
+		offset = bp->nq_dpi_counter % bp->nq_dpi_count;
+		dpi = bp->nq_dpi_start + offset;
+		bp->nq_dpi_counter++;
+		PMD_DRV_LOG_LINE(DEBUG, "NQ ring assigned DPI %u", dpi);
+	}
+
+	nqr->dpi = dpi;
+
 	rc = bnxt_hwrm_ring_alloc(bp, ring, ring_type, ring_index,
-				  HWRM_NA_SIGNATURE, HWRM_NA_SIGNATURE, 0);
+				  HWRM_NA_SIGNATURE, HWRM_NA_SIGNATURE, 0, dpi);
 	if (rc) {
 		rte_free(ring);
 		rte_free(nqr);
@@ -490,7 +512,7 @@ int bnxt_alloc_rxtx_nq_ring(struct bnxt *bp)
 	}
 
 	bnxt_set_db(bp, &nqr->cp_db, ring_type, ring_index,
-		    ring->fw_ring_id, ring->ring_mask);
+		    ring->fw_ring_id, ring->ring_mask, dpi);
 	bnxt_db_nq(nqr);
 
 	bp->rxtx_nq_ring = nqr;
@@ -523,13 +545,16 @@ static int bnxt_alloc_rx_ring(struct bnxt *bp, int queue_index)
 	struct bnxt_rx_ring_info *rxr = rxq->rx_ring;
 	struct bnxt_ring *ring = rxr->rx_ring_struct;
 	uint8_t ring_type;
+	uint16_t dpi;
 	int rc = 0;
 
 	ring_type = HWRM_RING_ALLOC_INPUT_RING_TYPE_RX;
+	dpi = BNXT_PRIVILEGED_DPI;
+	rxr->dpi = dpi;
 
 	rc = bnxt_hwrm_ring_alloc(bp, ring, ring_type,
 				  queue_index, cpr->hw_stats_ctx_id,
-				  cp_ring->fw_ring_id, 0);
+				  cp_ring->fw_ring_id, 0, dpi);
 	if (rc)
 		return rc;
 
@@ -537,7 +562,7 @@ static int bnxt_alloc_rx_ring(struct bnxt *bp, int queue_index)
 	if (BNXT_HAS_RING_GRPS(bp))
 		bp->grp_info[queue_index].rx_fw_ring_id = ring->fw_ring_id;
 	bnxt_set_db(bp, &rxr->rx_db, ring_type, queue_index, ring->fw_ring_id,
-		    ring->ring_mask);
+		    ring->ring_mask, dpi);
 	bnxt_db_write(&rxr->rx_db, rxr->rx_raw_prod);
 
 	return 0;
@@ -568,7 +593,8 @@ static int bnxt_alloc_rx_agg_ring(struct bnxt *bp, int queue_index)
 	}
 
 	rc = bnxt_hwrm_ring_alloc(bp, ring, ring_type, map_idx,
-				  hw_stats_ctx_id, cp_ring->fw_ring_id, 0);
+				  hw_stats_ctx_id, cp_ring->fw_ring_id, 0,
+				  BNXT_PRIVILEGED_DPI);
 
 	if (rc)
 		return rc;
@@ -578,7 +604,7 @@ static int bnxt_alloc_rx_agg_ring(struct bnxt *bp, int queue_index)
 	if (BNXT_HAS_RING_GRPS(bp))
 		bp->grp_info[queue_index].ag_fw_ring_id = ring->fw_ring_id;
 	bnxt_set_db(bp, &rxr->ag_db, ring_type, map_idx, ring->fw_ring_id,
-		    ring->ring_mask);
+		    ring->ring_mask, BNXT_PRIVILEGED_DPI);
 	bnxt_db_write(&rxr->ag_db, rxr->ag_raw_prod);
 
 	return 0;
@@ -796,14 +822,16 @@ int bnxt_alloc_async_cp_ring(struct bnxt *bp)
 		ring_type = HWRM_RING_ALLOC_INPUT_RING_TYPE_L2_CMPL;
 
 	rc = bnxt_hwrm_ring_alloc(bp, cp_ring, ring_type, 0,
-				  HWRM_NA_SIGNATURE, HWRM_NA_SIGNATURE, 0);
+				  HWRM_NA_SIGNATURE, HWRM_NA_SIGNATURE, 0,
+				  BNXT_PRIVILEGED_DPI);
 
 	if (rc)
 		return rc;
 
 	cpr->cp_raw_cons = 0;
+	cpr->dpi = BNXT_PRIVILEGED_DPI;
 	bnxt_set_db(bp, &cpr->cp_db, ring_type, 0,
-		    cp_ring->fw_ring_id, cp_ring->ring_mask);
+		    cp_ring->fw_ring_id, cp_ring->ring_mask, BNXT_PRIVILEGED_DPI);
 
 	if (BNXT_HAS_NQ(bp))
 		bnxt_db_nq(cpr);
@@ -900,17 +928,19 @@ int bnxt_alloc_hwrm_tx_ring(struct bnxt *bp, int queue_index)
 	else
 		tx_cosq_id = bp->tx_cosq_id[0];
 
+	/* TX ring inherits DPI from parent NQ */
+	txr->dpi = bp->rxtx_nq_ring ? bp->rxtx_nq_ring->dpi : BNXT_PRIVILEGED_DPI;
 	rc = bnxt_hwrm_ring_alloc(bp, ring,
 				  HWRM_RING_ALLOC_INPUT_RING_TYPE_TX,
 				  queue_index, cpr->hw_stats_ctx_id,
 				  cp_ring->fw_ring_id,
-				  tx_cosq_id);
+				  tx_cosq_id, txr->dpi);
 	if (rc)
 		goto err_out;
 
 	bnxt_set_db(bp, &txr->tx_db, HWRM_RING_ALLOC_INPUT_RING_TYPE_TX,
 		    queue_index, ring->fw_ring_id,
-		    ring->ring_mask);
+		    ring->ring_mask, txr->dpi);
 	txq->index = idx;
 
 	return rc;
diff --git a/drivers/net/bnxt/bnxt_ring.h b/drivers/net/bnxt/bnxt_ring.h
index 3e2bd634a8..496c3e111f 100644
--- a/drivers/net/bnxt/bnxt_ring.h
+++ b/drivers/net/bnxt/bnxt_ring.h
@@ -89,7 +89,8 @@ void bnxt_set_db(struct bnxt *bp,
 		 uint32_t ring_type,
 		 uint32_t map_idx,
 		 uint32_t fid,
-		 uint32_t ring_mask);
+		 uint32_t ring_mask,
+		 uint16_t dpi);
 
 static inline void bnxt_db_write(struct bnxt_db_info *db, uint32_t idx)
 {
diff --git a/drivers/net/bnxt/bnxt_rxr.h b/drivers/net/bnxt/bnxt_rxr.h
index 7357ca4427..82d6b86fa5 100644
--- a/drivers/net/bnxt/bnxt_rxr.h
+++ b/drivers/net/bnxt/bnxt_rxr.h
@@ -142,6 +142,7 @@ struct bnxt_rx_ring_info {
 
 	uint32_t ol_flags_table[BNXT_OL_FLAGS_TBL_DIM];
 	uint32_t ol_flags_err_table[BNXT_OL_FLAGS_ERR_TBL_DIM];
+	uint8_t			dpi;  /* Doorbell page index for multi-doorbell support */
 };
 
 uint16_t bnxt_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
diff --git a/drivers/net/bnxt/bnxt_txr.h b/drivers/net/bnxt/bnxt_txr.h
index 09078d545d..fd92a242c3 100644
--- a/drivers/net/bnxt/bnxt_txr.h
+++ b/drivers/net/bnxt/bnxt_txr.h
@@ -26,6 +26,7 @@ struct bnxt_tx_ring_info {
 
 	unsigned short          *nr_bds;
 	struct bnxt_ring	*tx_ring_struct;
+	uint8_t			dpi;  /* Doorbell page index for multi-doorbell support */
 };
 
 static inline uint32_t bnxt_tx_bds_in_hw(struct bnxt_tx_queue *txq)
diff --git a/drivers/net/bnxt/hsi_struct_def_dpdk.h b/drivers/net/bnxt/hsi_struct_def_dpdk.h
index 06c61cba8f..26d5e9ca78 100644
--- a/drivers/net/bnxt/hsi_struct_def_dpdk.h
+++ b/drivers/net/bnxt/hsi_struct_def_dpdk.h
@@ -15744,6 +15744,15 @@ struct __rte_packed_begin hwrm_func_qcaps_output {
 	 */
 	#define HWRM_FUNC_QCAPS_OUTPUT_FLAGS_EXT3_MIRROR_ON_ROCE_SUPPORTED \
 		UINT32_C(0x20)
+	/*
+	 * When this bit is '1', it indicates that, when rx/tx/cq/nq l2
+	 * rings are allocated, each ring can be associated with a
+	 * non-common doorbell page index. When '0', a common doorbell
+	 * page is used for all rings on a PF. This bit is only set on a
+	 * PF.
+	 */
+	#define HWRM_FUNC_QCAPS_OUTPUT_FLAGS_EXT3_MULTI_L2_DB_SUPPORTED \
+		UINT32_C(0x200)
 	/*
 	 * The number of VFs that can be used for RoCE on the function. If less
 	 * than max_vfs, roce vfs will be assigned to the first VF of the
@@ -16268,6 +16277,12 @@ struct __rte_packed_begin hwrm_func_qcfg_output {
 	 * of the doorbell BAR between L2 and RoCE is required.
 	 */
 	uint16_t	l2_doorbell_bar_size_kb;
+	/*
+	 * The size of the doorbell BAR in KBytes reserved for multi-L2
+	 * doorbell pages. This area is a subset of l2_doorbell_bar_size_kb,
+	 * which is size of the total doorbell BAR space reserved for L2.
+	 */
+	uint16_t	l2_db_multi_page_size_kb;
 	/*
 	 * A bitmask indicating the active endpoints. Each bit represents a
 	 * specific endpoint, with bit 0 indicating EP 0 and bit 3 indicating
@@ -45464,6 +45479,13 @@ struct __rte_packed_begin hwrm_ring_alloc_input {
 	 */
 	#define HWRM_RING_ALLOC_INPUT_ENABLES_RX_RATE_PROFILE_VALID \
 		UINT32_C(0x1000)
+	/*
+	 * This bit must be '1' for the dpi field to be configured.
+	 * This should only be used when 'multi_l2_db_supported'
+	 * bit is set in flags_ext3 field of FUNC_QCAPS response.
+	 */
+	#define HWRM_RING_ALLOC_INPUT_ENABLES_DPI_VALID \
+		UINT32_C(0x2000)
 	/* Ring Type. */
 	uint8_t	ring_type;
 	/* L2 Completion Ring (CR) */
@@ -45831,6 +45853,14 @@ struct __rte_packed_begin hwrm_ring_alloc_input {
 	 * record.
 	 */
 	uint64_t	cq_handle;
+	/*
+	 * The "doorbell page index" is specified when allocating a l2 ring.
+	 * It is applicable for rx/tx/completion/nq rings, and should only be
+	 * used when 'multi_l2_db_supported' bit is set in flags_ext3 field of
+	 * FUNC_QCAPS response.
+	 */
+	uint16_t	dpi;
+	uint16_t	unused_5[3];
 } __rte_packed_end;
 
 /* hwrm_ring_alloc_output (size:128b/16B) */
-- 
2.47.3

