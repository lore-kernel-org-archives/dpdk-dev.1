Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD248CAC5B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:08:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67FFE40E1E;
	Tue, 30 Sep 2025 09:05:50 +0200 (CEST)
Received: from mail-oi1-f226.google.com (mail-oi1-f226.google.com
 [209.85.167.226])
 by mails.dpdk.org (Postfix) with ESMTP id 3D856402A2
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:37:02 +0200 (CEST)
Received: by mail-oi1-f226.google.com with SMTP id
 5614622812f47-43d271944beso3412457b6e.0
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192621; x=1759797421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sBoGK/kShLtwhXIJFpJt3tubz6p2/ti8Teo51b3ym68=;
 b=eAZMTdVaKN7xt3mczAoeecjzSYbOcCpjqPwRzbxTQJauH35Ny0leyvI8JCo9hUdJec
 JDOcxXmUDa1St8THBv7s6N3rtWoMZVDQteIdomYBK1cWB2fKfxK69We17DCW21S3hQLG
 FyVnqtI9pg7z+659qZi/O5TRFLo9uKBXYNawGZnGmq7R0ZkXNSstiP4pCZbOhktYK+HD
 TYatVpJqA+R/u4WoTZQkCXrxgxjtsoif6K3LZWur8tJyLCY3mg4D5ujvW8SmHpxdxlT0
 Pu+Zf3NnTzTSFZJj3Bn6LFvUFJ5lWpGDShI92T/6N7iqG8l+wHQdG3C+/kjW1ZNUA2fx
 TmCw==
X-Gm-Message-State: AOJu0YyW06z2X6ZaX+vNVHi50t1vnAAWheyuVL4gV7hvxWIMJtGRtBnu
 jsc6SCtcEy7YN0Cmb4AIwnyNsZfRiqgOaqAeDqA5udwUdsnKU0uZSaJkM5y03MLRALFpDzo7TKt
 yv/3hUxBHbJTTU/H6z8gEIF5Q7/NOfosQAQ7vGGSxwrPfXxkDbmZkjUdmx0/hyDi7fbXd4heuVF
 def+5CE1Tt06EpNa5bDfYF5M/Z34ahV3goLDzUaWN+8ARt4nVQaSTNi4fgBEzyMhKvRWNZ0g==
X-Gm-Gg: ASbGnctuBKjon5qdmix8yBOlV88lk3uTmgwWVDB4tBN3nMDXp8vi8pHMYSlcMMcLOrJ
 ItUiTHpwqBc7MPPmFUSmwck94eB1YA01EUlwVCMSlPmzzFfdO75BeNIyVzcvA7xcEhTpGSjC+tR
 5/eKI5R2sY+djX6MUfxmwUvExx6Lx5WEGxP/pSyG/oWs2R0dMnAuCkGuJiiFYYSDWU+Y10e1U7D
 ZMMvwTBqvEaNRseumWLO8yNPQP5pIQnmtrzsLlvoIYErI9ShRQ5oGxLeQXnS/yXz8sjRQHsp1JT
 tTIomgEl8G+9n18b3jDzGSCCUftUSdEcHQCqicv3MWRFgNrT8Pu2uhbL7jAtWwE+qbsqykw746j
 EHYczfHvJ+rRWvGyayFbb4449aEnaBNa0He3SfWMusBiWPJK2W/0ZgZImc2WlQHYNmv7AYv2bPs
 D4aNEq9qY=
X-Google-Smtp-Source: AGHT+IGu3gKxrTku0Vt7kjOE7rKqU3y9Wx/AS0RA8Kd6jIWm2eEY1vLHHRY1ZHWciHPTRRlSgyr5OsZQ0P+b
X-Received: by 2002:a05:6808:5142:b0:437:e790:db64 with SMTP id
 5614622812f47-43f93c453b3mr1092402b6e.6.1759192621417; 
 Mon, 29 Sep 2025 17:37:01 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
 by smtp-relay.gmail.com with ESMTPS id
 586e51a60fabf-363a2fc6e3bsm1062585fac.4.2025.09.29.17.37.00
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:37:01 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b5b3715102fso1512713a12.0
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192619; x=1759797419; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sBoGK/kShLtwhXIJFpJt3tubz6p2/ti8Teo51b3ym68=;
 b=fA71RKrwIsXrrrmqJJBV4Jp3LY5WN5WVOMuxfJOgmSvzV+OokypSbd1YujHvTc/NTF
 1l98bvb58E7YSXepO008EhQHW1uKfUXnQ1HItK3BAAL1Rp5jGam2stUrXWbmK3bwqh5F
 yD5K2ArY4WB8/oZuZzRRBmrTzNc9XXe/KhjjM=
X-Received: by 2002:a05:6a20:9c91:b0:2cf:afc1:cc3c with SMTP id
 adf61e73a8af0-31771bb5ceamr2655294637.16.1759192618704; 
 Mon, 29 Sep 2025 17:36:58 -0700 (PDT)
X-Received: by 2002:a05:6a20:9c91:b0:2cf:afc1:cc3c with SMTP id
 adf61e73a8af0-31771bb5ceamr2655269637.16.1759192618129; 
 Mon, 29 Sep 2025 17:36:58 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.36.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:36:57 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Peter Spreadborough <peter.spreadborough@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Farah Smith <farah.smith@broadcom.com>
Subject: [PATCH 20/54] net/bnxt/tf_ulp: ovs-dpdk packet drop observed with
 thor2
Date: Mon, 29 Sep 2025 20:35:30 -0400
Message-Id: <20250930003604.87108-21-manish.kurup@broadcom.com>
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

From: Peter Spreadborough <peter.spreadborough@broadcom.com>

Incorrect packet counts were being returned for ovs flows. This was
happening when stats counter was doing read-clear for flow stats at a
rate faster than OVS was reading the stats from us. In this
scenario SC would read a count and as a result the HW counter would be
reset, SC would then do a second read which would replace the current
count and it would be lost. The fix is to never do read-clear and always
update with the latest full count. If the application requests a reset
then the current count is returned minus the last value read and the last
value read updated with the current count, hence just the delta is
returned.

Signed-off-by: Peter Spreadborough <peter.spreadborough@broadcom.com>
Reviewed-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Reviewed-by: Farah Smith <farah.smith@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c | 77 +++++++++++++++++++---------
 drivers/net/bnxt/tf_ulp/ulp_sc_mgr.h |  2 +
 2 files changed, 56 insertions(+), 23 deletions(-)

diff --git a/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c b/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c
index b246b90fe2..07da6bd41c 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c
@@ -26,6 +26,8 @@
 #define ULP_TFC_CNTR_ALIGN 32
 #define ULP_TFC_ACT_WORD_SZ 32
 
+#define ULP_SC_MAX_COUNT 0xFFFFFFFFFFFFFFFFULL
+
 static const struct bnxt_ulp_sc_core_ops *
 bnxt_ulp_sc_ops_get(struct bnxt_ulp_context *ctxt)
 {
@@ -182,7 +184,7 @@ ulp_sc_mgr_deinit(struct bnxt_ulp_context *ctxt)
 	return 0;
 }
 
-#define ULP_SC_PERIOD_US 256
+#define ULP_SC_PERIOD_US 100000
 #define ULP_SC_CTX_DELAY 10000
 
 static uint32_t ulp_stats_cache_main_loop(void *arg)
@@ -265,12 +267,12 @@ static uint32_t ulp_stats_cache_main_loop(void *arg)
 					(uint64_t)sce;
 
 				rc = sc_ops->ulp_stats_cache_update(tfcp,
-								    sce->dir,
-								    data,
-								    sce->handle,
-								    &words,
-								    &batch_info,
-								    sce->reset);
+					    sce->dir,
+					    &ulp_sc_info->read_data_iova[batch],
+					    sce->handle,
+					    &words,
+					    &batch_info,
+					    false);
 				if (unlikely(rc)) {
 					/* Abort this batch */
 					PMD_DRV_LOG_LINE(ERR,
@@ -278,9 +280,6 @@ static uint32_t ulp_stats_cache_main_loop(void *arg)
 					break;
 				}
 
-				if (sce->reset)
-					sce->reset = false;
-
 				/* Next */
 				batch++;
 				sce++;
@@ -308,9 +307,15 @@ static uint32_t ulp_stats_cache_main_loop(void *arg)
 					PMD_DRV_LOG_LINE(ERR, "batch:%d result:%d",
 							 batch, batch_info.result[batch]);
 				} else {
+					uint64_t *cptr = (uint64_t *)data;
+
 					count = (struct ulp_sc_tfc_stats_cache_entry *)
-						((uintptr_t)batch_info.em_hdl[batch]);
-					memcpy(&count->packet_count, data, ULP_TFC_ACT_WORD_SZ);
+						batch_info.em_hdl[batch];
+					if (*cptr != count->packet_count) {
+						count->packet_count = *cptr;
+						cptr++;
+						count->byte_count = *cptr;
+					}
 				}
 
 				data += ULP_SC_PAGE_SIZE;
@@ -440,6 +445,8 @@ int ulp_sc_mgr_query_count_get(struct bnxt_ulp_context *ctxt,
 	uint32_t f2_cnt;
 	uint64_t *t;
 	uint64_t bs;
+	uint64_t packet_count;
+	uint64_t byte_count;
 	int rc = 0;
 
 	/* Get stats cache info */
@@ -450,8 +457,22 @@ int ulp_sc_mgr_query_count_get(struct bnxt_ulp_context *ctxt,
 	sce = ulp_sc_info->stats_cache_tbl;
 	sce += flow_id;
 
+	/* Save the counts to local variables since they could be modified
+	 * in the stats cache loop.
+	 */
+	packet_count = sce->packet_count;
+	byte_count = sce->byte_count;
+
 	/* To handle the parent flow */
 	if (sce->flags & ULP_SC_ENTRY_FLAG_PARENT) {
+		struct ulp_sc_tfc_stats_cache_entry *f1_sce = sce;
+
+		if (!(f1_sce->flags & ULP_SC_ENTRY_FLAG_VALID))
+			return -EBUSY;
+
+		packet_count = 0;
+		byte_count = 0;
+
 		flow_db = bnxt_ulp_cntxt_ptr2_flow_db_get(ctxt);
 		if (!flow_db) {
 			BNXT_DRV_DBG(ERR, "parent child db validation failed\n");
@@ -490,26 +511,36 @@ int ulp_sc_mgr_query_count_get(struct bnxt_ulp_context *ctxt,
 				/* no counter action, then ignore flows */
 				if (!(sce->flags & ULP_SC_ENTRY_FLAG_VALID))
 					continue;
-				count->hits += sce->packet_count;
-				count->hits_set = 1;
-				count->bytes += sce->byte_count;
-				count->bytes_set = 1;
+
+				packet_count += sce->packet_count;
+				byte_count += sce->byte_count;
 			} while (bs && f2_cnt);
 		}
+
+		sce = f1_sce;
 	} else {
 		/* To handle regular or child flows */
 		/* If entry is not valid return an error */
 		if (!(sce->flags & ULP_SC_ENTRY_FLAG_VALID))
 			return -EBUSY;
+	}
 
-		count->hits = sce->packet_count;
-		count->hits_set = 1;
-		count->bytes = sce->byte_count;
-		count->bytes_set = 1;
-
-		if (count->reset)
-			sce->reset = true;
+	if (count->reset) {
+		/* Calculate packet count delta */
+		count->hits = (packet_count - sce->last_packet_count) & ULP_SC_MAX_COUNT;
+		count->bytes = (byte_count - sce->last_byte_count) & ULP_SC_MAX_COUNT;
+	} else {
+		count->hits = packet_count;
+		count->bytes = byte_count;
 	}
+
+	/* Save the raw packet count */
+	sce->last_packet_count = packet_count;
+	sce->last_byte_count = byte_count;
+
+	count->bytes_set = 1;
+	count->hits_set = 1;
+
 	return rc;
 }
 
diff --git a/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.h b/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.h
index 29d0b0a1a4..631e2f77b2 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.h
+++ b/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.h
@@ -30,6 +30,8 @@ struct ulp_sc_tfc_stats_cache_entry {
 	uint64_t byte_count;
 	uint64_t count_fields1;
 	uint64_t count_fields2;
+	uint64_t last_packet_count;
+	uint64_t last_byte_count;
 	bool reset;
 };
 
-- 
2.39.5 (Apple Git-154)

