Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B3ECCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:04:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 327C740E21;
	Wed, 15 Oct 2025 11:04:15 +0200 (CEST)
Received: from mail-io1-f99.google.com (mail-io1-f99.google.com
 [209.85.166.99]) by mails.dpdk.org (Postfix) with ESMTP id 939D840E2F
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:04:13 +0200 (CEST)
Received: by mail-io1-f99.google.com with SMTP id
 ca18e2360f4ac-930a6c601b3so613506339f.3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:04:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519053; x=1761123853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i6L+uNH1tAaLEsZf9XmKpv9AV1uuaMdcOUvtN9FzQkI=;
 b=PR24fMqZUSSyCoE4s7JWpI2LZJS5mneuTYgv6JHZXGyWpnmUhDPvTc+qM3TA8C4h/w
 GYNQEyKMAloetyctRhBXvmjbKczAfFDJvikQZYJesSttpwNEn1rEqo+J2VAQpNoKUySC
 fKX8DcN6o4JZbu6UShZ1BFTT0vD8D7HRyod9Q1h/8s/7HKCk0hQUE8oKeWY/Zb7dv54X
 e2WAgC6QvQUbVCloPOHKGJipPH4ty75aO/Uk2j34cpiu2kacUy/8WNKbXuHsjzmdRk7A
 6F+qw65VyhYSgiwlEdhT6Q1Q62KQTPA1xw4VIFThJc0o9VZGTV+vTWNUktr0ePUVtTM4
 Qxpg==
X-Gm-Message-State: AOJu0YwXidma/0hs7GyVbI0JBMVQ+z7ZwdgHDpSS5HG67giimamQBVR/
 1f0AKOFka+bVHyckRV9+ThSCLVF74ftF8XZUkf7w9gwOucExYUl2g7vz4NR3xYRPJJ48ymnVtpe
 7qla69m3L325C7dXnCPrydf+Cmw8o8JCo9eIaI5tf4o87A5CqpYKRm2BTQ8OskkOyGi8BJH6K3e
 9ne3KuXdTde1ZpgURmjX+9fXNp3F/itFd46vdYvY2hfqY4mwYHQxLM+657oZxDyBJEaf4R4g==
X-Gm-Gg: ASbGncu8YCzuTF2EPTPH99Fe4ID3alTOak9fyrWG+lmR4Md2OVC2h/MoDTYwIiX9s7g
 TDxvqDk/VZU7hvx+DzOJgjHdSRiOE5IhuSVuevAvSdjTHlUjrIFM8Al3kP23ewI3nEgwrrvffJf
 jFX9ZNZXDjSglbaN57tl7QpTIp3TfjIQCVjYqOefDDtnZ2bo7nuE0hvOt5Pw+wtp+feKnNhpJNQ
 CsyTXbKsUDoA24XbYZ3w4SMWC/4HtffTQwL0f9h+fw2baTEOziJUuAaD5Vh2R/eYKW+gPB5plqR
 +g9foZ+inDv5sW3QBJj+vUCWicaHmAYpwWqEUHCS1Yd4zbEd0tauWlhCJZzFxfFAhzvSXPf/ibS
 7yPwAYq0iQLqruoGgFYWd6G5DJECLvUlgJi7XSWXv+RqQDiRERfm3Nvh8gfObuaxY7LeZaAFwS0
 hWZA==
X-Google-Smtp-Source: AGHT+IFAwiG+iP3V4RimDk2dUnA9wh0TMQ58Mn4d8NIPOiSQRiOQid1+pZSof1huj1y0+D/PRqiBTbx3z8u1
X-Received: by 2002:a05:6e02:17cd:b0:430:a3b0:8458 with SMTP id
 e9e14a558f8ab-430a3b085c1mr68155325ab.3.1760519052810; 
 Wed, 15 Oct 2025 02:04:12 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 8926c6da1cb9f-58f6d041f33sm1231911173.5.2025.10.15.02.04.12
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:04:12 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-782063922ceso8846601b3a.0
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760519051; x=1761123851; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i6L+uNH1tAaLEsZf9XmKpv9AV1uuaMdcOUvtN9FzQkI=;
 b=NMezRDZlZMHtVV8raWlltMklaCKg/G6rxjdBD9bipRpquSvx8ElQbsTaWVG8LZPI9E
 CNd+A/BJJir20fouH9XQ4POHyPsH+hCD7oDFMmeQRF9Ddzy7RdNLPRylQw/66GTK2BRH
 5n8eK43KXSgFvKVDRzwD8boFsGc5Ssnco4i3c=
X-Received: by 2002:a05:6a00:3d54:b0:781:be:277e with SMTP id
 d2e1a72fcca58-7938513618fmr30770761b3a.4.1760519050763; 
 Wed, 15 Oct 2025 02:04:10 -0700 (PDT)
X-Received: by 2002:a05:6a00:3d54:b0:781:be:277e with SMTP id
 d2e1a72fcca58-7938513618fmr30770716b3a.4.1760519049946; 
 Wed, 15 Oct 2025 02:04:09 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.04.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:04:09 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Peter Spreadborough <peter.spreadborough@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Farah Smith <farah.smith@broadcom.com>
Subject: [PATCH v3 20/54] net/bnxt/tf_ulp: ovs-dpdk packet drop observed with
 thor2
Date: Wed, 15 Oct 2025 04:59:50 -0400
Message-Id: <20251015090024.32250-21-manish.kurup@broadcom.com>
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

