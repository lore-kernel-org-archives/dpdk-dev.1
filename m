Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0EBCCD184
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 22:16:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D10F40A80;
	Fri, 10 Oct 2025 00:15:47 +0200 (CEST)
Received: from mail-vs1-f97.google.com (mail-vs1-f97.google.com
 [209.85.217.97]) by mails.dpdk.org (Postfix) with ESMTP id 1C5F440695
 for <dev@dpdk.org>; Fri, 10 Oct 2025 00:15:46 +0200 (CEST)
Received: by mail-vs1-f97.google.com with SMTP id
 ada2fe7eead31-55784771e9dso761265137.1
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:15:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760048145; x=1760652945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i6L+uNH1tAaLEsZf9XmKpv9AV1uuaMdcOUvtN9FzQkI=;
 b=FkgUAnyKvF50ECPsXHqfeL0sdOpbP1sGJDIcl7Fl2Sa2Y6CuCQpmEVurtT4xwzjCz1
 wdrmFbIKEHrzbshw8YQFAsNp0Z5sqZOg0FQyeVLQvsbEHgt2pkPWGedBZzrNrwqGSaJi
 Qa1cQa1781w7QLNR5wt6H+5nsMeYM6oItotIjvJW0H/r895+AtHKHV+nNZ8uRuB9bRum
 meZn54VVcWTSvNben108MbgTeP40G5l/sxO3ZLRWCi9eUNjzvS6ZhiRM1/iPKpWmQlbg
 9itdFmby3l/Y5LPvUfm+Xkkh8B3bSQDBULBXkIsr5yZvvTHdZwNiMMKLe/F1IGlxR3vs
 OENg==
X-Gm-Message-State: AOJu0YzCNN6WJRsrwjFGLs1+cFfvbdKU+z18Vci13NSM7rZTyayIIOm/
 ADkhZCcTeLjdetOrRheMjNwjCab/hbJBuEJEyK+TKj3mRCW8OH7rEQnjPvS5uNRn8tuKbj2R3SP
 zznmAdbSt2w2GswNU+bKaZRkL/lDUqjjSNycJcwYX7I38pZlgB+RDaMa9v1LbJ76Pd1i/bTPVCW
 O/0Lh2joRf1t6buDPiHvBDshA+8oO+Wo/70s7/Ex1anORKw0ACMADVC/wfxaGNToZ0RXaVTA==
X-Gm-Gg: ASbGnct5g8d8xBF1wBiTAWQqwG/+gW6m2Oi2IyyclO4BaKsK02kQ5KXqxEER2nI7MCH
 BYOELbgo9YUOHFwiyM5CfNe1+eUJG2FQ/FM9NHMSkTx81+uyvDjbAt5kaIptYOEtWHgUfREtsGh
 3IDcwihfkjQoPO9XwBUt9zL/R2rBTalF7hY3XRbge77XQHhugVqKSPnQPpfw14eVYcA8AAAeaF8
 F4jyuM8QDaV3mT7AwqBgLZtE+t4BGuQdoOv324sOCeZV19iQz7WMyBPVczcUtGFf12aS9Q8teDH
 ObSKmfVT6ZCc7JkEprQnivz2raOuWf4c5uI7uy5rlcAhAKo6gHLvvBft5lEAiasYJVLoN063QTl
 zZzp4C5bvC62XdX+j3B/jNmjTqNTC34McYZ3M90Q0Mba8oTcjHV+z92bX+T0TNIEMo81Jjb968D
 L5r2zG
X-Google-Smtp-Source: AGHT+IEO2VqPF552ss/lMA9cvZbUv/l9P+p8EJ26EmCRWWeWKZxo7kDSYqIvHGwIqJo7FN/cmwGCGqOIJUlz
X-Received: by 2002:a05:6102:8383:20b0:5d5:f8d6:aa1d with SMTP id
 ada2fe7eead31-5d5f8d6aa2dmr1112346137.1.1760048145395; 
 Thu, 09 Oct 2025 15:15:45 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
 by smtp-relay.gmail.com with ESMTPS id
 71dfb90a1353d-554d8036d3bsm61991e0c.7.2025.10.09.15.15.45
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 15:15:45 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8776a952dd4so53456046d6.3
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760048144; x=1760652944; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i6L+uNH1tAaLEsZf9XmKpv9AV1uuaMdcOUvtN9FzQkI=;
 b=he3k2WuRJsV5uTpAdH5jxPI+TZYelyiMgk08EXXVjt1n/3rel7zQy2JP/AnVWsmtxa
 HFZuX1mXeN1he1Zapd7mDMPP0PrGzeiDbtiMsnrGmfTC80X8K5fR51Q4om0Q/s0IdKJT
 ocwOp/wDhpuY0ZuFwAsK3Rx9WQmnngB0UDU6c=
X-Received: by 2002:ad4:5ec5:0:b0:72b:5e10:55bb with SMTP id
 6a1803df08f44-87b2efe832dmr156851986d6.48.1760048144376; 
 Thu, 09 Oct 2025 15:15:44 -0700 (PDT)
X-Received: by 2002:ad4:5ec5:0:b0:72b:5e10:55bb with SMTP id
 6a1803df08f44-87b2efe832dmr156851546d6.48.1760048143851; 
 Thu, 09 Oct 2025 15:15:43 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm4189986d6.17.2025.10.09.15.15.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 15:15:43 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Peter Spreadborough <peter.spreadborough@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Farah Smith <farah.smith@broadcom.com>
Subject: [PATCH v2 20/54] net/bnxt/tf_ulp: ovs-dpdk packet drop observed with
 thor2
Date: Thu,  9 Oct 2025 18:10:55 -0400
Message-Id: <20251009221129.28256-21-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251009221129.28256-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
 <20251009221129.28256-1-manish.kurup@broadcom.com>
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
 drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c | 79 +++++++++++++++++++---------
 drivers/net/bnxt/tf_ulp/ulp_sc_mgr.h |  2 +
 2 files changed, 57 insertions(+), 24 deletions(-)

diff --git a/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c b/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c
index b246b90fe2..24012e30b1 100644
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
-					count = (struct ulp_sc_tfc_stats_cache_entry *)
-						((uintptr_t)batch_info.em_hdl[batch]);
-					memcpy(&count->packet_count, data, ULP_TFC_ACT_WORD_SZ);
+					uint64_t *cptr = (uint64_t *)data;
+				   uintptr_t em_hdl = batch_info.em_hdl[batch];
+
+					count = (struct ulp_sc_tfc_stats_cache_entry *)em_hdl;
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

