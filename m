Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BA2CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:02:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA69F40E15;
	Wed, 15 Oct 2025 11:01:37 +0200 (CEST)
Received: from mail-io1-f100.google.com (mail-io1-f100.google.com
 [209.85.166.100])
 by mails.dpdk.org (Postfix) with ESMTP id 3AACF40E12
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:01:36 +0200 (CEST)
Received: by mail-io1-f100.google.com with SMTP id
 ca18e2360f4ac-911afafcc20so252650239f.3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760518895; x=1761123695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wj/sSnMM5W6pCEhosYpxvZI8b1gfSWNN/dZledvFIc0=;
 b=fo/MOT/mPdCkKMHsU/4xBuIhGJt+aKa1OLT8r0xLZkIjH2WdfSg84Eyz5UJ3xALs5L
 IR9E3idhEBgXfk1MpDRURQettbsCfvFkonZZq7gpA9ZZeyf3+ic6D5l4LqTjcwH8ZxJL
 NTCvuII2G1SZf+y+CA0P+2K97j4bc9/OL8+cL+YTr4rpcsc+42PCspsHr05li78cXaGn
 sHQPdt6+wdwVnKjCw7IiubjAVq0YsOYR577JDyjdXjnD5ZdgG3s6NROfSMMpaJj5dJfp
 yZ4Yu//mCNdg5UlOmNCCZ1RBXDEfZC+7M4cNsatw6eHx28EvFDj56x0/+Oh877OG5nmM
 7Gow==
X-Gm-Message-State: AOJu0YwzPrEgNtSQkB4z62nE+0qgNsSd+TkQxofAD7u/10VYjq50I58z
 EDD/3Hmg+MuMQfE+N89mSPlJS5kreThs620aHP1YrdgrU/7XYWsB/t/c8QgmL3j4sVC2ITtSGXD
 cb+ElkWPxoLrSupxlM/8Yf0jZKBcVfaL8kxJjlNq7YaoRTiKhSWKqRKfqod0yPQGhBfuo1P/xeR
 cMTixxaWIEg7fQz4VN22XVfJrl+Cq3FIQI63wj7ZcfR57sEaqkfId3tQA8HWvlnaeS5XoEvg==
X-Gm-Gg: ASbGncu+aIzq+D2JvzZUbJggBIjFYudWw0mZMCJOZUt+OsZPVkQBDFdEJFbQnqjdShH
 asfUwkLVSbjsQLtjIzgazBj6VyUvqQ7+nWkkviZrkE7wsRQ3/xfihHWrfyimNx/lG5Mv2mpH6sC
 9bDRngvJLEp9ipdN151VR1KbfgZKvh+meCCCpg9ApigHkNmHW364xOn4c71IPiTgAMsuCSqF6Aq
 7xWb2JwIP8Ri10t1JxJNX5f8J1to3d4fgGRNRM1AbdmmJSNHv1D4Nz/NH84kbZd/9ht0RhTZASQ
 D4MR3NpNMU1DRDcfJtwDHs3GCtVBX1m1evCArTDVmr2z04tFL7tOrTrmIq1kZGD5wJ3tfMz3xuC
 6zBMTSUmh6J6igkuN+EekDfURXkzAhbTU0PV+8lC/QqUgS7dzE7WFuTpHn+YCEQVFoMdymie1i7
 e+NQ==
X-Google-Smtp-Source: AGHT+IGxDe6mLAepGKD8lc0dULuoAhwHpc4xVk3flOXdW3046v5Zl4/E4BYAnJFY25Dr6E83uRn1gIvWA7A0
X-Received: by 2002:a05:6e02:1b05:b0:430:a65c:a83a with SMTP id
 e9e14a558f8ab-430a65cc7ebmr53307525ab.32.1760518895387; 
 Wed, 15 Oct 2025 02:01:35 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 e9e14a558f8ab-430abfcc3desm1177895ab.32.2025.10.15.02.01.34
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:01:35 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-7a153ba0009so1611794b3a.1
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760518893; x=1761123693; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wj/sSnMM5W6pCEhosYpxvZI8b1gfSWNN/dZledvFIc0=;
 b=CP0lXidQ1GV9qic2Vc2k2oIaebr5ODbwUuloqO86wG5J4Te8MGReBKmGy1z1bDtbfI
 IwaJbngNZlBxW019DYOvxSxFtcnT1XEHOec9i4eebIQUY1pgfTjQzb2cyQE0lVN9tlbz
 71+lC/EpYe1VCuXQc6wdVNSouvCr6/ND51+oU=
X-Received: by 2002:a05:6a00:4fd4:b0:78a:f784:e8cf with SMTP id
 d2e1a72fcca58-79387829619mr29975495b3a.27.1760518892557; 
 Wed, 15 Oct 2025 02:01:32 -0700 (PDT)
X-Received: by 2002:a05:6a00:4fd4:b0:78a:f784:e8cf with SMTP id
 d2e1a72fcca58-79387829619mr29975447b3a.27.1760518891930; 
 Wed, 15 Oct 2025 02:01:31 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.01.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:01:31 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>
Subject: [PATCH v3 11/54] net/bnxt/tf_core: fix vfr clean up and stats lockup
Date: Wed, 15 Oct 2025 04:59:41 -0400
Message-Id: <20251015090024.32250-12-manish.kurup@broadcom.com>
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

From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

The representor flows were not being deleted as part of the
vfr clean up. Added code to delete flows related to vfr interface.
Also fixed the stats counter thread lockup.

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Reviewed-by: Peter Spreadborough <peter.spreadborough@broadcom.com>
Reviewed-by: Shuanglin Wang <shuanglin.wang@broadcom.com>
---
 drivers/net/bnxt/bnxt_reps.c         | 31 ++++++++++++++++++++++++----
 drivers/net/bnxt/tf_core/v3/tfc_em.c |  5 +++--
 drivers/net/bnxt/tf_core/v3/tfo.c    |  1 +
 drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c | 29 ++++++++++++++++----------
 drivers/net/bnxt/tf_ulp/ulp_sc_mgr.h |  2 +-
 5 files changed, 50 insertions(+), 18 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_reps.c b/drivers/net/bnxt/bnxt_reps.c
index 20a0ba65a5..f32b55b1ee 100644
--- a/drivers/net/bnxt/bnxt_reps.c
+++ b/drivers/net/bnxt/bnxt_reps.c
@@ -502,12 +502,33 @@ int bnxt_rep_dev_start_op(struct rte_eth_dev *eth_dev)
 	return 0;
 }
 
+static int bnxt_tf_vfr_flush_flows(struct bnxt_representor *vfr_bp)
+{
+	struct bnxt *parent_bp = vfr_bp->parent_dev->data->dev_private;
+	uint16_t func_id;
+
+	/* it is assumed that port is either TVF or PF */
+	if (unlikely(ulp_port_db_port_func_id_get(parent_bp->ulp_ctx,
+						  vfr_bp->dpdk_port_id,
+						  &func_id))) {
+		BNXT_DRV_DBG(ERR, "Invalid argument\n");
+		return -EINVAL;
+	}
+	return ulp_flow_db_function_flow_flush(parent_bp->ulp_ctx, func_id);
+}
+
 static int bnxt_tf_vfr_free(struct bnxt_representor *vfr)
 {
 	struct bnxt *parent_bp;
 	int32_t rc;
 
 	PMD_DRV_LOG_LINE(DEBUG, "BNXT Port:%d VFR ulp free", vfr->dpdk_port_id);
+	rc = bnxt_tf_vfr_flush_flows(vfr);
+	if (rc)
+		PMD_DRV_LOG_LINE(ERR,
+			    "Failed to delete rules from Port:%d VFR",
+			    vfr->dpdk_port_id);
+
 	rc = bnxt_ulp_delete_vfr_default_rules(vfr);
 	if (rc)
 		PMD_DRV_LOG_LINE(ERR,
@@ -603,15 +624,17 @@ int bnxt_rep_dev_info_get_op(struct rte_eth_dev *eth_dev,
 	struct bnxt *parent_bp;
 	unsigned int max_rx_rings;
 
+	/* Need be an error scenario, if parent is removed first */
+	if (eth_dev->device->driver == NULL)
+		return -ENODEV;
+
 	/* MAC Specifics */
 	if (!bnxt_rep_check_parent(rep_bp)) {
-		PMD_DRV_LOG_LINE(INFO, "Rep parent port does not exist");
-		/* Need be an error scenario, if parent is removed first */
-		if (eth_dev->device->driver == NULL)
-			return -ENODEV;
+		PMD_DRV_LOG_LINE(INFO, "Rep parent port does not exist.");
 		/* Need not be an error scenario, if parent is closed first */
 		return 0;
 	}
+
 	parent_bp = rep_bp->parent_dev->data->dev_private;
 	PMD_DRV_LOG_LINE(DEBUG, "Representor dev_info_get_op");
 	dev_info->max_mac_addrs = parent_bp->max_l2_ctx;
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_em.c b/drivers/net/bnxt/tf_core/v3/tfc_em.c
index feb6e899f6..8264f9a05d 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_em.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_em.c
@@ -936,8 +936,9 @@ int tfc_mpc_batch_end(struct tfc *tfcp,
 
 	tfo_mpcinfo_get(tfcp->tfo, &mpc_info);
 
-	if (unlikely(mpc_info->mpcops == NULL)) {
-		PMD_DRV_LOG_LINE(ERR, "MPC not initialized");
+	if (unlikely(mpc_info == NULL || mpc_info->mpcops == NULL)) {
+		PMD_DRV_LOG_LINE(ERR, "%s: MPC not initialized",
+			    __func__);
 		return -EINVAL;
 	}
 
diff --git a/drivers/net/bnxt/tf_core/v3/tfo.c b/drivers/net/bnxt/tf_core/v3/tfo.c
index bee813ebf6..f4ee81aefd 100644
--- a/drivers/net/bnxt/tf_core/v3/tfo.c
+++ b/drivers/net/bnxt/tf_core/v3/tfo.c
@@ -157,6 +157,7 @@ int tfo_mpcinfo_get(void *tfo, struct cfa_bld_mpcinfo **mpc_info)
 {
 	struct tfc_object *tfco = (struct tfc_object *)tfo;
 
+	*mpc_info = NULL;
 	if (tfo == NULL) {
 		PMD_DRV_LOG_LINE(ERR, "Invalid tfo pointer");
 		return -EINVAL;
diff --git a/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c b/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c
index 753c19b055..6b6733133a 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c
@@ -158,9 +158,11 @@ ulp_sc_mgr_deinit(struct bnxt_ulp_context *ctxt)
 	if (!ulp_sc_info)
 		return -EINVAL;
 
-	rte_free(ulp_sc_info->stats_cache_tbl);
+	if (ulp_sc_info->stats_cache_tbl)
+		rte_free(ulp_sc_info->stats_cache_tbl);
 
-	rte_free(ulp_sc_info->read_data);
+	if (ulp_sc_info->read_data)
+		rte_free(ulp_sc_info->read_data);
 
 	rte_free(ulp_sc_info);
 
@@ -186,9 +188,14 @@ static uint32_t ulp_stats_cache_main_loop(void *arg)
 	uint32_t batch_size;
 	struct tfc *tfcp = NULL;
 	uint32_t batch, stat_cnt;
+	int oldstate;
+	int oldtype;
 	uint8_t *data;
 	int rc;
 
+	pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, &oldstate);
+	pthread_setcanceltype(PTHREAD_CANCEL_DEFERRED, &oldtype);
+
 	while (true) {
 		ctxt = NULL;
 		while (!ctxt) {
@@ -222,7 +229,6 @@ static uint32_t ulp_stats_cache_main_loop(void *arg)
 			if (bnxt_ulp_cntxt_acquire_fdb_lock(ctxt))
 				break;
 
-			batch_info.enabled = false;
 			rc = tfc_mpc_batch_start(&batch_info);
 			if (unlikely(rc)) {
 				PMD_DRV_LOG_LINE(ERR,
@@ -250,12 +256,12 @@ static uint32_t ulp_stats_cache_main_loop(void *arg)
 					(uint64_t)sce;
 
 				rc = sc_ops->ulp_stats_cache_update(tfcp,
-							    sce->dir,
-							    &ulp_sc_info->read_data_iova[batch],
-							    sce->handle,
-							    &words,
-							    &batch_info,
-							    sce->reset);
+								    sce->dir,
+								    data,
+								    sce->handle,
+								    &words,
+								    &batch_info,
+								    sce->reset);
 				if (unlikely(rc)) {
 					/* Abort this batch */
 					PMD_DRV_LOG_LINE(ERR,
@@ -278,7 +284,8 @@ static uint32_t ulp_stats_cache_main_loop(void *arg)
 			bnxt_ulp_cntxt_release_fdb_lock(ctxt);
 
 			if (unlikely(rc)) {
-				PMD_DRV_LOG_LINE(ERR, "MPC batch end failed rc:%d", rc);
+				PMD_DRV_LOG_LINE(ERR,
+						 "MPC batch end failed rc:%d", rc);
 				batch_info.enabled = false;
 				break;
 			}
@@ -306,7 +313,7 @@ static uint32_t ulp_stats_cache_main_loop(void *arg)
 	}
 
  terminate:
-	PMD_DRV_LOG_LINE(DEBUG, "Terminating the stats cachce thread");
+	PMD_DRV_LOG_LINE(ERR, "Terminating the stats cachce thread");
 	return 0;
 }
 
diff --git a/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.h b/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.h
index 5501dc18fd..29d0b0a1a4 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.h
+++ b/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.h
@@ -36,7 +36,7 @@ struct ulp_sc_tfc_stats_cache_entry {
 struct bnxt_ulp_sc_info {
 	struct ulp_sc_tfc_stats_cache_entry *stats_cache_tbl;
 	uint8_t		*read_data;
-	uint64_t	read_data_iova[ULP_SC_BATCH_SIZE];
+	uint64_t        read_data_iova[ULP_SC_BATCH_SIZE];
 	uint32_t	flags;
 	uint32_t	num_entries;
 	uint32_t	num_counters;
-- 
2.39.5 (Apple Git-154)

