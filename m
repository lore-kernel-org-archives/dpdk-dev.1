Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305ECCCD1A7
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 17:52:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5064840E25;
	Tue, 21 Oct 2025 19:52:33 +0200 (CEST)
Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com
 [209.85.128.225])
 by mails.dpdk.org (Postfix) with ESMTP id 026D840E34
 for <dev@dpdk.org>; Tue, 21 Oct 2025 19:52:31 +0200 (CEST)
Received: by mail-yw1-f225.google.com with SMTP id
 00721157ae682-78485c4146bso36008307b3.2
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761069151; x=1761673951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9JLfi6knnC2J+2HfZk5V9iKZRqpxbDUBxgUwg6KkWSg=;
 b=uCkT7IObvicw7v2y/NOnbzakQAEH4ll9VmelM5TRymTsFE+pNbbRd6kfljR/xgkzbQ
 vq2u+exGvDRmDQYCSvIwZi78VslLWGZ99PGWkzKJ2am5d6RpDT/CKx7tuGKzXAT1K4I7
 J4qOFi+5O/XDJTklKcDoBBpei5v1WANw7gWTi5pP44bwy3sRwqFbrkE86e/BLLe42rsB
 0fL0b3hWnlOzE5zmQMRwm2TyJRinZi94j+1g7K/xnFDnWALmwKO1bgou4UrMJIQFf2vI
 biPsrX6UphEcFVN96Ta0ShyLEaguoKNtoYELmKvWrSlWRTv6/+PyTVSs4NIQ11yGDxwo
 4Wcw==
X-Gm-Message-State: AOJu0YwMJlpMDfiCWBDicqa3I+tpCB/OR15RtA6y739YxfwjuFD0Q/aB
 0NulvqDzsyZ7llb/N3lMiltUpFNNo0iHXeeSYxDba1YATn9yyI5xzHxLgZARnRiUu3Vl1zLtLv2
 bWDXmXvczRnNZ0ijRnf8oZE2jz0hgexzJmgOxyO5I9+6h80ZWjKzZObDsdSJrI6q/WyipN9H+8o
 wBw5N0vKtHnW7+2akSUiJIP9nT9TQ7ed3mIswhRYxyV2meYHCHXhxLeVzCHRPIKE0uc1WD8g==
X-Gm-Gg: ASbGncudACVpsr+OkQhvfylisqmdDST7S9psOWyS1g5INgSRNv/z56FjbOyMP/Rt6rX
 PQSO3wylz8xkBy23uvQUe220EnVAuYmMhQ1P5SVJeI25TJr6SBmFeaswYEyLS5+MDd/3jsItXAf
 e5Ug9APxW5PkH6he+BPncw1KvIBL8ECFQuNRuyMZwiFT4tZOssmVZcWh2PaYqmGqbkx+wJPv7qZ
 JpqMNuYJlTLWnF6zNH0mQFM2qHTN4fVTPo3eIJcPjiLK/41C/40ttKD5bFeCUQMQQqverzK2qMA
 ByU+UBLVK5Oln5w+mvkN05t686tJafjtpW1su2zXy0qM4irS9CW0SidPQ/nOZBjgXr1+UIzDzqg
 2/QmKwrNBQWoxMIJqi40Cludfm/veduFcYuJTLv1CJnb1w+c48JVw6MhLJ1f1DoQ/smfBHmsTiL
 /ANHPsfa5UGb911Z4I+UtCQ4NW2PaVZN4L8w==
X-Google-Smtp-Source: AGHT+IG7GPYsGf9NHzv8/y4n9RUJ9TQRQmi2JnU78Pt6gX6ITj7gMMi19HwYq82Gq/wET1haUrRz1PC5TYwA
X-Received: by 2002:a05:690e:1289:b0:63e:17d8:d96f with SMTP id
 956f58d0204a3-63e17d8dc72mr13827383d50.30.1761069151268; 
 Tue, 21 Oct 2025 10:52:31 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
 by smtp-relay.gmail.com with ESMTPS id
 956f58d0204a3-63e2662c4f2sm820907d50.2.2025.10.21.10.52.30
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 10:52:31 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-28eb14e3cafso115950385ad.1
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761069149; x=1761673949; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9JLfi6knnC2J+2HfZk5V9iKZRqpxbDUBxgUwg6KkWSg=;
 b=YO2x2mkpPvT98RU2deAiYyLmfoIvaI8U6x++d9l67tsOA//dQLwp1P5UkUk7xP6n/c
 C3qYif5++y20DNltUgTBvfOmI2w+/Oqa0tPQZoFTJYMpt4H+y1LT+imQRM9CQ+kd96YM
 zaf9tGv+TFp8KGO/EYcQwwgmcLDo1AM+0Rn1k=
X-Received: by 2002:a17:903:11cf:b0:24c:ca55:6d90 with SMTP id
 d9443c01a7336-290ccaba086mr227095085ad.61.1761069149454; 
 Tue, 21 Oct 2025 10:52:29 -0700 (PDT)
X-Received: by 2002:a17:903:11cf:b0:24c:ca55:6d90 with SMTP id
 d9443c01a7336-290ccaba086mr227094675ad.61.1761069148663; 
 Tue, 21 Oct 2025 10:52:28 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-292472193c2sm115441495ad.104.2025.10.21.10.52.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 10:52:28 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>
Subject: [PATCH v4 14/57] net/bnxt/tf_core: fix vfr clean up and stats lockup
Date: Tue, 21 Oct 2025 13:50:06 -0400
Message-Id: <20251021175049.46092-15-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251021175049.46092-1-manish.kurup@broadcom.com>
References: <20251015090024.32250-1-manish.kurup@broadcom.com>
 <20251021175049.46092-1-manish.kurup@broadcom.com>
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
index c57c98a911..df293bbb84 100644
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

