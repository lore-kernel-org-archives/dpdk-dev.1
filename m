Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671CFCCF9EB
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:09:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 586C9406BB;
	Wed, 29 Oct 2025 17:08:49 +0100 (CET)
Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com
 [209.85.160.97]) by mails.dpdk.org (Postfix) with ESMTP id 6889440656
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:08:46 +0100 (CET)
Received: by mail-oa1-f97.google.com with SMTP id
 586e51a60fabf-3d199f29161so88828fac.0
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:08:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761754126; x=1762358926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F/565j2krOhGZZormeLatUiDFBl210XoJi1Jlb772tA=;
 b=XRYF6+MAEwWR0G/T9JyHo7q7EuU2J4H0ZX3LBcxghCoNKkEsZfvf+Lge9V+AKrWF8f
 6x7eraa+HYftGjVEdtg4yOa10GFx0o30vb168ZLPrxLk7M/TyL+w/hWI5Ox+JJyU0TwO
 iou7EwyPTJ7n6+HufFMZqo6xpD6W+XS0Rim21SZTjgzbV1+9i9e1mGNqtc89XNkb3yn7
 OD2yoCR2NqZYB5H2+F4g5c5ApOz5MWzqK6sJ2Pzg07IJI4CUvbTmSw1EVinY2YBuSqFZ
 R7sBxYs03EgHs7uNBPd8KehVl1WYb/Eks2sI1lGzYTMistPofEJoS+3BNITOmEsq1bDw
 Uk3Q==
X-Gm-Message-State: AOJu0YxVDiY3u8TyIOpmoSrTjGXP2AvwWXTdWTiRXo34GbN6nIKlz3Fk
 0Gy2w7JdlYHUZGrwBksLCFgf4sXXhL9wu0ipQ4qDc02pu7idQ/jvPUL5u1xKMj0F9Tyr0Vz0i4Z
 HIAGYZOpXEUv/mwRKqmhUyGBNSQOfDxNgKtK+JgZ3ikKhA70YxMLpg7LNVlQRnUSVwd1o3DvecS
 BJD3JpYQNSInta4LvTFez/QAlzE1RTvFn4vJ2aiWAd1K9r9Nneq94H5bVFbQ4cErAhmD9ryQ==
X-Gm-Gg: ASbGncuIdBw96mihwTvMgtA23rrgrPM5wUw4piYZMGYJuRr0gJJGsCmn5vyW8lODD4w
 p7PXuyxTbrUhN6eHI+T0ltGmrviZJ1kev/NfJboRyin+9YsTPDavUx3dIPFTaPECi7L35hcXuMz
 qh50BdYMHYRTVl40r+ecXzDRLfYZmD1jYTaGboJqIpb+RRqTKoJgZFvyiLRyrP1LqMk7WIcTEKY
 jtNPL95Qjp1EQ85+S0+QgDuX7j/xVXsaXJv0b2b7BQUbiGNx2LUHXWGP/nAh/ArbNR34nWbFTqJ
 TJVSvGFDiRF5odVyRTveaSSb4oqJ8N16nUEz2Xmgi+u0J6C3J2Ys8dLQl4ZFQLoqRlfJhIeLND+
 G7qFgFJWy/L04ZVIspIYTkPZ3rFjaaEGktKIJYzeJfiZfpcPFlRPjatW4rtAMY7hcnstA2XGgor
 Bxaxz1RLIt7hZPKppqGETQiJosxz2N6dpsHw==
X-Google-Smtp-Source: AGHT+IH7ez5qEGamyEU4KC0WuuGTOzy8o2cP7ePeOBD+XNI+pwdLeZ7oFmPhi5OTnxU2R0FqpQr6rewMVsv2
X-Received: by 2002:a05:6870:84ca:b0:367:6cdd:8c52 with SMTP id
 586e51a60fabf-3d745b82e13mr1717027fac.14.1761754125601; 
 Wed, 29 Oct 2025 09:08:45 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
 by smtp-relay.gmail.com with ESMTPS id
 586e51a60fabf-3d1e2e2f20bsm1343508fac.8.2025.10.29.09.08.45
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:08:45 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4e892acc0b3so233979701cf.2
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761754124; x=1762358924; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F/565j2krOhGZZormeLatUiDFBl210XoJi1Jlb772tA=;
 b=FwhCit7NAJaTV8mA78YrBh51Op8afXbMIHRtKitzf8CIajved8vNdDVDk/3efryuc+
 /Nly0wJd1rq8MaiGR6XOmNk54Lxve4ydCGN4LsCFy1Mjr0eBjNlqevZNKOydEWGMydZu
 Z7ypoJXLgYb+8IMZ/dALiTPVGwzgFQv7L/k/k=
X-Received: by 2002:a05:622a:56:b0:4ec:76d8:e73f with SMTP id
 d75a77b69052e-4ed15bba94amr37913521cf.10.1761754124226; 
 Wed, 29 Oct 2025 09:08:44 -0700 (PDT)
X-Received: by 2002:a05:622a:56:b0:4ec:76d8:e73f with SMTP id
 d75a77b69052e-4ed15bba94amr37912971cf.10.1761754123524; 
 Wed, 29 Oct 2025 09:08:43 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.08.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:08:43 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>
Subject: [PATCH v5 14/57] net/bnxt/tf_core: VFR cleanup and stats lockup
 handling
Date: Wed, 29 Oct 2025 12:06:29 -0400
Message-Id: <20251029160712.58519-15-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251029160712.58519-1-manish.kurup@broadcom.com>
References: <20251021175049.46092-1-manish.kurup@broadcom.com>
 <20251029160712.58519-1-manish.kurup@broadcom.com>
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
Also handled the stats counter thread lockup correctly.

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
index a216aab14e..e26a086f41 100644
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
index c888dd1e4e..5ec2f7afa2 100644
--- a/drivers/net/bnxt/tf_core/v3/tfo.c
+++ b/drivers/net/bnxt/tf_core/v3/tfo.c
@@ -155,6 +155,7 @@ int tfo_mpcinfo_get(void *tfo, struct cfa_bld_mpcinfo **mpc_info)
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

