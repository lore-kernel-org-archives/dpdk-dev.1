Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94A1CCF9F0
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:10:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EBB9240A87;
	Wed, 29 Oct 2025 17:09:07 +0100 (CET)
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com
 [209.85.216.98]) by mails.dpdk.org (Postfix) with ESMTP id 39F6B40695
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:09:06 +0100 (CET)
Received: by mail-pj1-f98.google.com with SMTP id
 98e67ed59e1d1-33e0008d3b3so81045a91.3
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761754145; x=1762358945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b5s4amC7p9WJpKP5ilrkQY3tN37ouYRIk1tdUYSu/FQ=;
 b=RBuiWAXUAL1F+SolDv0nFMf8/+DJWtPvKHKE3f+jOJkQfmb4zjQkb1z4U0mq3WLjWA
 HvYmL5l5Wr6lUFGjTHzV4psj5++scC8c1Uu68qrSZwfFlPRXv26J6X+qKLohzEotN1la
 h+7HGLy6PDVBoPAZqvRqCIBqnsSd+boIe34MLFg4LsmzIPd49V2EtqaJnXuHALWKoGpY
 1rZksFqAb+PXKXYwJhfURmiSUsY2x1Fn4epuBCgsONJ8rGRtD0l7i4e2XXEbHDf816hE
 iy7G9wrsaWNBy8orlf6qTJ+AlTaVckpmXyqvibpSYOrvPejAb/xbvCpM8j3uJYTFT7dy
 VJzg==
X-Gm-Message-State: AOJu0Yz2ZixIugqpg7blv+Hyb2QHUOta2wfV1jU4lUvXbSz5VZt3DGms
 S2qci3ECwd8YsB6Or0qnmjEAI+cYrSqtV3f0kLLSU71I4h8/n1G/QfrEBYK1NJnq0NBo+j4fHgH
 JlLJAa1bh2kNRSULbGMAO19wfMyNz0164umXTHF028OnXa5P+3BgyfgviwLe5bijCrIAooudMle
 t+UUckhgOO5kIYega1fcsoZ55NGETnurY3cLKlv6ERUxWgjthb+46aDuag4Z+MTbmt5oxmPQ==
X-Gm-Gg: ASbGnctP83XiO/e0pyvDU84C6JrvWIdB93/5//V/gK5o1V3/hDvuG1rwRFM69kZE9SR
 3fOgZUprr9YQdP0d+Ny8sXGQ1P/2fRu0CGSb04BDRer3EgtSk6XSNshc+jlPN5HyOQu6xIJgPsi
 9nsokNAFZ7oLwOXxmtyv4N2UrZcwSM6okkcOOWqd8lycTeOGLrN5U/HlDzdnvnfksjNdHFjhMqr
 Mak/rcgUWL5c6m5GD0l7izQu0goEJTE1LUyNo8R5oua5EkYHNRAR8I39iKJeELmMRIryKgBtxKm
 zrGFuqyZ4hjDCCcqkwKNuH6VP1DKxKOlSDvEn7dA9fbbiyI0pUc5t1A0FIhWEst+pPXY75Sh6ZW
 be1VmaG/tZX7/aF48iPrNbPZs97uV1vCPzxVI5hwjRwGZmXCH5GqcUQZUzxT28OllxSuRPcppFl
 lfgQ4ejlTN1KaMv66BKSrDxZ0ZmCce++jqTg==
X-Google-Smtp-Source: AGHT+IGhIRitTEMQzvebomZXHe6/b0AIWN/ALXJt1ZYNik27OFPh08jvc2KA6hPaMauox8J9mBeGNXgqu6Ul
X-Received: by 2002:a17:90a:d643:b0:329:e4d1:c20f with SMTP id
 98e67ed59e1d1-3403a15ac12mr3863216a91.9.1761754145139; 
 Wed, 29 Oct 2025 09:09:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-33fed7adf1asm1464118a91.0.2025.10.29.09.09.04
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:09:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8a3c5e46a06so980802185a.1
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761754143; x=1762358943; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b5s4amC7p9WJpKP5ilrkQY3tN37ouYRIk1tdUYSu/FQ=;
 b=Z5L95/yOrlEDSHywTnXzqpAHshbDKyL3bzJy+4pUS36Aa9cfYO8DWtDIjC5tLUqqJB
 O9sb98AHrSgN78tWPNwpEYAamqhUzvZg878jlf740wg/9Ybkk38Sm6JnVWSK0+sI3M1B
 THp7CPtWQRF5AevP923b6uGz1IHuVQxDKhL9s=
X-Received: by 2002:a05:620a:440d:b0:8a5:6ca3:d4b with SMTP id
 af79cd13be357-8a8efb03ec2mr455410485a.78.1761754143499; 
 Wed, 29 Oct 2025 09:09:03 -0700 (PDT)
X-Received: by 2002:a05:620a:440d:b0:8a5:6ca3:d4b with SMTP id
 af79cd13be357-8a8efb03ec2mr455404485a.78.1761754142926; 
 Wed, 29 Oct 2025 09:09:02 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.09.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:09:02 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>
Subject: [PATCH v5 21/57] net/bnxt/tf_ulp: stats counter memory cleanup
Date: Wed, 29 Oct 2025 12:06:36 -0400
Message-Id: <20251029160712.58519-22-manish.kurup@broadcom.com>
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

The stats counter cache memory initialization did not print the
error message on failure, updated the initialization to print
error message on failure.

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Reviewed-by: Shuanglin Wang <shuanglin.wang@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c | 35 ++++++++++++++++++----------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c b/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c
index fc4207b36c..b246b90fe2 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c
@@ -63,29 +63,30 @@ int32_t ulp_sc_mgr_init(struct bnxt_ulp_context *ctxt)
 	int i;
 
 	if (!ctxt) {
-		BNXT_DRV_DBG(DEBUG, "Invalid ULP CTXT\n");
+		BNXT_DRV_DBG(ERR, "Invalid ULP CTXT\n");
 		return -EINVAL;
 	}
 
 	if (bnxt_ulp_cntxt_dev_id_get(ctxt, &dev_id)) {
-		BNXT_DRV_DBG(DEBUG, "Failed to get device id\n");
+		BNXT_DRV_DBG(ERR, "Failed to get device id\n");
 		return -EINVAL;
 	}
 
 	dparms = bnxt_ulp_device_params_get(dev_id);
 	if (!dparms) {
-		BNXT_DRV_DBG(DEBUG, "Failed to device parms\n");
+		BNXT_DRV_DBG(ERR, "Failed to device parms\n");
 		return -EINVAL;
 	}
 
 	sc_ops = bnxt_ulp_sc_ops_get(ctxt);
 	if (sc_ops == NULL) {
-		BNXT_DRV_DBG(DEBUG, "Failed to get the counter ops\n");
+		BNXT_DRV_DBG(ERR, "Failed to get the counter ops\n");
 		return -EINVAL;
 	}
 
 	ulp_sc_info = rte_zmalloc("ulp_sc_info", sizeof(*ulp_sc_info), 0);
 	if (!ulp_sc_info) {
+		BNXT_DRV_DBG(ERR, "Failed to allocate stats cache container\n");
 		rc = -ENOMEM;
 		goto error;
 	}
@@ -99,8 +100,9 @@ int32_t ulp_sc_mgr_init(struct bnxt_ulp_context *ctxt)
 	ulp_sc_info->num_counters = dparms->ext_flow_db_num_entries;
 	if (!ulp_sc_info->num_counters) {
 		/* No need for software counters, call fw directly */
-		BNXT_DRV_DBG(DEBUG, "Sw flow counter support not enabled\n");
-		return 0;
+		BNXT_DRV_DBG(ERR, "Num of flow entries is not configured\n");
+		rc = -EINVAL;
+		goto error;
 	}
 
 	/*
@@ -115,6 +117,7 @@ int32_t ulp_sc_mgr_init(struct bnxt_ulp_context *ctxt)
 	ulp_sc_info->stats_cache_tbl = rte_zmalloc("ulp_stats_cache_tbl",
 						   stats_cache_tbl_sz, 0);
 	if (!ulp_sc_info->stats_cache_tbl) {
+		BNXT_DRV_DBG(ERR, "Failed to allocate stats cache table\n");
 		rc = -ENOMEM;
 		goto error;
 	}
@@ -123,7 +126,7 @@ int32_t ulp_sc_mgr_init(struct bnxt_ulp_context *ctxt)
 					     ULP_SC_BATCH_SIZE * ULP_SC_PAGE_SIZE,
 					     ULP_SC_PAGE_SIZE);
 	if (!ulp_sc_info->read_data) {
-		rte_free(ulp_sc_info->stats_cache_tbl);
+		BNXT_DRV_DBG(ERR, "Failed to allocate stats cache data\n");
 		rc = -ENOMEM;
 		goto error;
 	}
@@ -135,10 +138,15 @@ int32_t ulp_sc_mgr_init(struct bnxt_ulp_context *ctxt)
 	}
 
 	rc = ulp_sc_mgr_thread_start(ctxt);
-	if (rc)
-		BNXT_DRV_DBG(DEBUG, "Stats counter thread start failed\n");
+	if (rc) {
+		BNXT_DRV_DBG(ERR, "Stats cache thread start failed\n");
+		rc = -EIO;
+		goto error;
+	}
 
- error:
+	return 0;
+error:
+	ulp_sc_mgr_deinit(ctxt);
 	return rc;
 }
 
@@ -399,8 +407,11 @@ void ulp_sc_mgr_thread_cancel(struct bnxt_ulp_context *ctxt)
 	if (!ulp_sc_info)
 		return;
 
-	ulp_sc_info->flags &= ~ULP_FLAG_SC_THREAD;
-	pthread_cancel(ulp_sc_info->tid);
+	/* if thread started then stop it */
+	if (ulp_sc_info->flags & ULP_FLAG_SC_THREAD) {
+		pthread_cancel((pthread_t)ulp_sc_info->tid.opaque_id);
+		ulp_sc_info->flags &= ~ULP_FLAG_SC_THREAD;
+	}
 }
 
 /*
-- 
2.39.5 (Apple Git-154)

