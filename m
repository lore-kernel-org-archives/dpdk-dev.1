Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75902CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:06:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D76B840DCB;
	Tue, 30 Sep 2025 09:05:39 +0200 (CEST)
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com
 [209.85.214.227])
 by mails.dpdk.org (Postfix) with ESMTP id 09315402D8
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:36:47 +0200 (CEST)
Received: by mail-pl1-f227.google.com with SMTP id
 d9443c01a7336-26a0a694ea8so44310975ad.3
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:36:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192606; x=1759797406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wj/sSnMM5W6pCEhosYpxvZI8b1gfSWNN/dZledvFIc0=;
 b=wtRUkxN86tTs819A16n8m+7MyXf8VhCKsh5CQv7l7+BNULLCwPqBb+slKoxF0JVTrv
 KsXzqaQHiUDGH2/hhgI95Nkhic8+S19wLw5kInjNL8BRLLF2/eAdPtcpaEhEK1zzyKP7
 UHJWokl4O3dqa5thMVfFuTIkJIG/N18lyCuGyQWN6tNMxXEfQt+ggBM+F4JCVfVRXtkn
 rb1gXVl3d/VX3w3raIkNDqGaOOWmDd5JczTipJjblwIt5i1wwqTcgoPUqn6fTl8CiseP
 4HBd19bg54jv3gqkVzQU6AmQ4DGTgazUpzS+U6z1qwx+BlX5eUAgCrjRN9O32d49uLKv
 agPA==
X-Gm-Message-State: AOJu0YxlRElTLRX+cPVa+4fBdk9gm4Yhn286Kud79htRMCuJThLQFT8t
 Q6HSN3ZXZQ/97e6OsqKImy+eVnDG9Owg47XZlAjWr+9p6Tmqz917DkSANd0LVIawYz/wqD21FAM
 Suoe+GSWeOK1cssfVU1kCffCLlegwGWZpM7DKS8h2DFkiI73Ahq9/f/kld9U+UMzYjPEYwIjWgM
 jMmJXFWbOLdZlQeKqTzGO59pp+bPY+l6RyH3qkYQDZYMGoDRhuCW3qRoZpLKSq65TuR0y74g==
X-Gm-Gg: ASbGncsZae/IEGqgHuB9kXKVmbZeI6NTaTwSFw+rCSSxCtUlt3TT0dFn+nGNvw0n1Nh
 ETLzfckG9G10PuNZ8dyp3bXVE8pBua5kSfG0hGiUbfqetAzr8MIp4VqyHJmMOlCR52MsUWaF8rY
 eDvD9OuJ1U+sVWlqmJ2lmHYwPj7ReTu7DMurk4Qdc0HsRTeHHmXvwnNXEl8M6G2nsBK2d2jvZTx
 oWTofJk/SVGPIfUctC+MCDa+QJraGo3DV9XWCMWnwIC6Ti40dxAeO2bxU8rCPZDj0Tx2lG0TPXq
 74EmUD54wkBzVtUP5wn5uK2inE5yp73o1DSe07EXfZF7lvv+aJJq3RJxlQde/fjpfpoaiayyYyX
 A5eeLeNlxrjz16STZ7MjKIHQ4zPBDgaqipw7wux3SV/Yndh+4wPRBKFbdkR2jSRzP7+xOfRzn10
 r2D2f0Vb8=
X-Google-Smtp-Source: AGHT+IGezwLd+jd6xp0N7UDkFPZAdAGF4eWBfgJ/ynwqjdNjcn+K2Lu5hlnWkKj/JOUSbuFh2ks3Lfc9PFUJ
X-Received: by 2002:a17:902:f785:b0:274:6d95:99d2 with SMTP id
 d9443c01a7336-27ed4a2d5d2mr206533805ad.39.1759192606100; 
 Mon, 29 Sep 2025 17:36:46 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-27ed66dfb21sm11260965ad.27.2025.09.29.17.36.45
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:36:46 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b55283ff3fcso3796882a12.3
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192604; x=1759797404; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wj/sSnMM5W6pCEhosYpxvZI8b1gfSWNN/dZledvFIc0=;
 b=PzWU/UcTAHTIHAvZMq904OSmlQ4osYSLd6m1HhTLSZZFQPXAPVGeZ7WH7zhFznIZ7I
 +8i6RTMWnrO2ohURvobdVcVPmiJ3xomtfArL1Y8xVeZvY4JyRrojKhkkgx02mJNYLMK2
 4ObvzSy2tu0XEg6SlNofWLBQD7mSQ4HJ6M7+g=
X-Received: by 2002:a05:6a21:2292:b0:2f6:9592:907f with SMTP id
 adf61e73a8af0-2f69592cb9bmr16588663637.29.1759192604152; 
 Mon, 29 Sep 2025 17:36:44 -0700 (PDT)
X-Received: by 2002:a05:6a21:2292:b0:2f6:9592:907f with SMTP id
 adf61e73a8af0-2f69592cb9bmr16588627637.29.1759192603528; 
 Mon, 29 Sep 2025 17:36:43 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.36.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:36:43 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>
Subject: [PATCH 11/54] net/bnxt/tf_core: fix vfr clean up and stats lockup
Date: Mon, 29 Sep 2025 20:35:21 -0400
Message-Id: <20250930003604.87108-12-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250930003604.87108-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Mailman-Approved-At: Tue, 30 Sep 2025 09:05:07 +0200
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

