Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD8ACCD1A7
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 17:53:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9136640EE5;
	Tue, 21 Oct 2025 19:52:58 +0200 (CEST)
Received: from mail-il1-f225.google.com (mail-il1-f225.google.com
 [209.85.166.225])
 by mails.dpdk.org (Postfix) with ESMTP id 69E7640EDC
 for <dev@dpdk.org>; Tue, 21 Oct 2025 19:52:55 +0200 (CEST)
Received: by mail-il1-f225.google.com with SMTP id
 e9e14a558f8ab-430cadec5deso38747435ab.1
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761069175; x=1761673975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i6L+uNH1tAaLEsZf9XmKpv9AV1uuaMdcOUvtN9FzQkI=;
 b=OXn8LrgIuVYnfd2Ga50loTMFLbn2n61v728xrynq/L8rRvOaAbFRWpmmVMz06HEOs+
 wrYkJmDii2Ob3WF7NLW5AQvctdf2gm1IaSKCNVcc6YBZx3l/lm/IsgAk0rTAKavEItjo
 eLhHTFYsciVW+n5t+cV7WUmp0yiaJk+xEiHvEb5HOknUhemRU3CEkGaqbP4BySxsltl3
 +HZ/QK1a8UoVTg+/ZT2M7cXNEmr/7B91Y/uoDBFnMS8zLvQxzBwBbS7o40KdbUXJtVBT
 EIjYE8zG2jz97OGUXyro0zCVogVa9HkId76t5NULJ5i5Ru3Cn1/vlKn8sepfFQtbpDtS
 XB0w==
X-Gm-Message-State: AOJu0YzvErQ/GZBAIza+V59qdMvajXH7nqJMud7rsk+7bNUVrNM/XQTE
 j41E1BTrBusE7G4IQWCOd7LCtZGMLG1Owih+LRKBJwJCxHZKqmWshUD+oPslGXQii2aiXBY+Pe6
 mxEoUhyh5em57N2he6TeVCW407QsqwhszPv5yabFEuLdf+C0+kK/yZL0Nv7GAbbmJNUChVOgXK1
 MCezkemQ5EALAaTTrz83Zxxn5GLwLio/mMhrmPWAVruAk5HI4JTLbRDVLDzUemxk2O96ejEg==
X-Gm-Gg: ASbGncujiGxpYTGx6RKBF6aeDweZDNDhMc3oDJEtzrYal5w9HPCwPlyugmK5VzmbmEO
 zLC8ozGkn53KwQH0JnKVYy+NkMtHj9tpvbsV3H+wSLI8UmClWxpdiuki5hxGq9WMtwnxgTtD3RF
 TPqsU8Ssnth+kVm/SX+CUHaZObY8uoup7QHG/+g8J8R20q8oSgq8312e9vwHYM+S+NRGG/Hqopn
 pQZNUPXBoAtONroGrZoWKMjqzAa++3mR+nsGnTJMiALlo0cE55MGQc2+iLTU+NY9W3trDr4P846
 SCD/dmh5vA5ila0HbTzdLix+ZXWsQ0Nc6RQrANI1EAgX72hL87OldoFWSanlxUvul/kHUWtX9my
 2bT/Si0CzBBZAF0HZEmtg8I3EG1htiZvApnXn7Qs85+RS1MkSwDfYnuMMuM7OftjCD38RIAttdm
 EOgXCm7Ay60K7YnWHoAhTfAOKsnGUi2gj4Yg==
X-Google-Smtp-Source: AGHT+IEVEqGNheKmchhhU1QKN+3xzQTK7FTHkDERYs2gjizEfbl02bIRUskFVgZvmSb8dJHt7dZ4gbakCQsD
X-Received: by 2002:a05:6e02:1fca:b0:42f:946f:8eb4 with SMTP id
 e9e14a558f8ab-430c527bca5mr236881985ab.21.1761069174645; 
 Tue, 21 Oct 2025 10:52:54 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
 by smtp-relay.gmail.com with ESMTPS id
 e9e14a558f8ab-430d07cb544sm11283675ab.36.2025.10.21.10.52.53
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 10:52:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-26985173d8eso149790675ad.1
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761069172; x=1761673972; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i6L+uNH1tAaLEsZf9XmKpv9AV1uuaMdcOUvtN9FzQkI=;
 b=JXAnf9yjaix/3kI3nQI/rA6OdLJazr5BrFCDZTLMFWyz3ZwqNrcHL5pBzMkVqACjMw
 S8IRUAj9ybLCPxAHZb8nbtkNET/21r4ZvixiRYjHgvBeomBFYJulNwbDpxxjmNxbmk+j
 9aOvuyqaHmQXsry9Ky+GxRCbuB1ZiKyhM1cz8=
X-Received: by 2002:a17:902:e843:b0:264:ee2:c40f with SMTP id
 d9443c01a7336-290cb46c41cmr196562125ad.52.1761069171866; 
 Tue, 21 Oct 2025 10:52:51 -0700 (PDT)
X-Received: by 2002:a17:902:e843:b0:264:ee2:c40f with SMTP id
 d9443c01a7336-290cb46c41cmr196561885ad.52.1761069171300; 
 Tue, 21 Oct 2025 10:52:51 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-292472193c2sm115441495ad.104.2025.10.21.10.52.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 10:52:50 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Peter Spreadborough <peter.spreadborough@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Farah Smith <farah.smith@broadcom.com>
Subject: [PATCH v4 23/57] net/bnxt/tf_ulp: ovs-dpdk packet drop observed with
 thor2
Date: Tue, 21 Oct 2025 13:50:15 -0400
Message-Id: <20251021175049.46092-24-manish.kurup@broadcom.com>
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

