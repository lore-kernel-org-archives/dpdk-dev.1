Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162BFCAC5B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:07:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 147DB40E11;
	Tue, 30 Sep 2025 09:05:48 +0200 (CEST)
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com
 [209.85.215.228])
 by mails.dpdk.org (Postfix) with ESMTP id 9FFA5402D8
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:36:58 +0200 (CEST)
Received: by mail-pg1-f228.google.com with SMTP id
 41be03b00d2f7-b5a631b9c82so1401465a12.1
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192618; x=1759797418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b5s4amC7p9WJpKP5ilrkQY3tN37ouYRIk1tdUYSu/FQ=;
 b=Reqr95RHft+YjniOZslJ1gSfTQa1pDGJRtXTM5WrtywwQq/v6Oe+8xgqnx1YiCDtI/
 4GTl7zFujM7QnNdvD2iVcPY2XEGh4zxtv7go/cqNM5+uC3BI5f2y4Dt5Y3dAdH0ZKEYT
 Uxo6d5+PacZwWp9qVDi+ZNNninnQDDr8XoGEjTXCLNKOD0rkUpkcbQjTLu7aOXKJgz5s
 mPn7Mk9aIEnBG/0OcSkhcGx1yFktASkh1WAo+bRFHU26A/gEU6j3Ol6Kj4GfhotWPt6K
 B1JYNMhrvIZY1/pmnFbmAm/2hsQm7QdKHkT977ityKZSs4wFLs/YtthxPzzzH/6q7Vbl
 kHzQ==
X-Gm-Message-State: AOJu0YxDQMeR0k476geQQWpONPjDVc61gbHVitVaEUOxW4BZwjqg3Eam
 2sONoRLQAQHdjnz8IsOQxprQ470I49PK1tsMTOlcG7fJjUvJc11QW3iAc4cK+H0MxTWnBp/5xM+
 2otzcDlcOExsgZsGvD2NhhYFyQXCQn5GV9rVa//yi7HR/caIqW4uRlcbTYqf9t4V2bR5xP6bmbw
 4A/zgbpFlVSqHDbX0YahwusLuXdcBsVk8cZf8YqASsizvq/xxzE0yeR9iC7pVTfmc1oPiyGA==
X-Gm-Gg: ASbGncuwBN62Qg5qJibSCdqUPZcEb1MH54tgef4UJd46rHVJQgIWeGkS4HA3eB4fmzZ
 1/1qXfarrqq3iRXuvkd0LlR14Dsea8TF30f3j99qRV089qYGtOTtRO89gcKOf57ylErwSMhUFTx
 Ub0+kZpOnY1KQ3/TgygqdXILNZOWTomotgC8C/YR59aWFvEkaMPLzHKtIiSp3mJvg+APX3V8Gao
 3QW8ybetyiHrUlxOSJJEpPR8Tx+8r/3eRmEJDgL3hOo2IbQWXnI7qxnGicKDveORN7JdxNurq/4
 FZsX3JMc4eoQt03ne0omeL09XpwKdd4onH3p1vn7Pbv7GEtZZg3MBa+HZIVQlv39Lx8n8pVme4b
 YlJFMAa7lRFSyZbEQYWchEYlr2y3a+6+PoXXneRcwvnTyjrtALpeTOezTvT5cjSyKvCSjDBAsH/
 M5sQX8aDs=
X-Google-Smtp-Source: AGHT+IEldDfQ06Wx7+OPhlsmtb0iK3Pn0kif0Cks5w+frBm4cMNkvePosA5TPcg3QdPK6kLz+dupd/Qfq63j
X-Received: by 2002:a17:903:3d06:b0:275:7ee4:83bc with SMTP id
 d9443c01a7336-27ed49b8694mr221777655ad.2.1759192617771; 
 Mon, 29 Sep 2025 17:36:57 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-27ed6700a4csm11289025ad.32.2025.09.29.17.36.57
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:36:57 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-78102ba5966so4862859b3a.2
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192615; x=1759797415; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b5s4amC7p9WJpKP5ilrkQY3tN37ouYRIk1tdUYSu/FQ=;
 b=cBm+EisvvT6kEhtW/B/DvPFi76DthjO3EQAkp/4kYFfHWrfZOT3xNsHk8N/rPvK3Pj
 SKXHxxHw93JJoPtcuWXPf7GGu4tOzOE5cQC/0FJQEVXpazJEkFqtnPbk/X3iymv/7PAC
 UPTPdNq3x6kI2MbDonIKZlLJzm+Fq0i4Xy/oA=
X-Received: by 2002:a05:6a21:a60a:b0:2ee:4037:1df7 with SMTP id
 adf61e73a8af0-2ee40379aa6mr11985542637.7.1759192615629; 
 Mon, 29 Sep 2025 17:36:55 -0700 (PDT)
X-Received: by 2002:a05:6a21:a60a:b0:2ee:4037:1df7 with SMTP id
 adf61e73a8af0-2ee40379aa6mr11985522637.7.1759192615069; 
 Mon, 29 Sep 2025 17:36:55 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.36.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:36:54 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>
Subject: [PATCH 18/54] net/bnxt/tf_ulp: fix stats counter memory initialization
Date: Mon, 29 Sep 2025 20:35:28 -0400
Message-Id: <20250930003604.87108-19-manish.kurup@broadcom.com>
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

