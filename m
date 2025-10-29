Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D81CCF9F0
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:10:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 588CC40B9B;
	Wed, 29 Oct 2025 17:09:15 +0100 (CET)
Received: from mail-ot1-f100.google.com (mail-ot1-f100.google.com
 [209.85.210.100])
 by mails.dpdk.org (Postfix) with ESMTP id 7DE0B40A89
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:09:14 +0100 (CET)
Received: by mail-ot1-f100.google.com with SMTP id
 46e09a7af769-7c2846c961fso4790604a34.2
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:09:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761754154; x=1762358954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i6L+uNH1tAaLEsZf9XmKpv9AV1uuaMdcOUvtN9FzQkI=;
 b=CLkU8LtEt8eVL9c3WhQlB9qz4+2P6dUKGQSogQRyzanfnv9K67lJnwR/ZPWUeoNGrC
 3tf3aNzRQA/jwUjBA/QNqBJKXLfKLoNXsYo56ysHsnfard8upH2FSUo8CFRSESLUIAzF
 czA55U6jq2JsHbVez3HPWvtoCD4ewiwjmrZbmojaoToHexTitrroL5tTHESw2fcjnq3p
 2jjODtHQJRQI/ThXjZ9OYHP9aOdmJTVD0TNY5ZjjhQ0ntjNoYoxx8O5Nbnk7pZvqtopk
 +kkURXB+rvPc9+PtpCeNkRwamJ0lULOjdI6yewm9LqX5CcHXF0HhZK2dCX3MIiVabGVG
 Lutw==
X-Gm-Message-State: AOJu0YzENAH69UKdFBHySRUy0t0napo1IS+5FqAWdW/qykQD5tM/1Kdo
 WFtUcrOG0ZshOEhYRqf+T8Mcj3G32eR/pX0A084U7eFYwR4N1kJFAlBp6H+5gt00WoX48HM5UgF
 wtj/uAlBeBHg42/rPZ5EJ49d2E76zJxu3f7163598TD0noPbcyvNhsy/67Rd1dn2ujljYEaGEpK
 WcWVYQSurdSmOJtwzTEaNDLSSXHRhojIYKpVXZX5zxUPj+UktF2+KJUy//oIcJ+y3XOuzX0w==
X-Gm-Gg: ASbGncu2AXvHAdZp9HMsoJ/bpd95CZl0PrIYrnJwbWDzLR0HSDRneiD9kNCrcWA5kaQ
 vG8+u9QceG3QpTPSaGOGsMWhX7iSpx8q7tjd1c7IALpNDe2Wxn9ucLX2hDLzMxPIwUxIeqEGAgT
 X66jmOnsvSF/k/mNUTB27jcR2c8f7iTT2NHfYe+vhQV2gw5bhdjKEAVkj49rbtjoqTfX7jDhokt
 d78sZUamafPUBcaSjTYJGyo+hIxe1MEcuAfLhWNn7bs8Tv6ya6siWIgL1I7kLMBvpbCfCP49t6F
 shknQBk3FD9TxGF0aj3p1E09NJkVx6r+ayFAOcyhY5YrshOI9fMSIBVkLpTAPK+4HpGOPEJ/GWJ
 r4tQj7LcYIVLY+mzzwlvHsKpv2tN3pItxjeTmojx1yJ6QIdynyrQ3sf4+buhNocUf16ILnovphX
 Qz8ab2fOx4sSk1uDM12LuX39g3qbk8ylep777Q
X-Google-Smtp-Source: AGHT+IHMzDUoa1s1pNx7bVi7Tp0o2SC/6GyXRhWiQyIt9NH3c/KgBJJ0U7DhwXTrZ+7tcI3ohI14eXI2ga8+
X-Received: by 2002:a05:6830:44aa:b0:7af:353b:95ea with SMTP id
 46e09a7af769-7c68305f500mr2202722a34.14.1761754153672; 
 Wed, 29 Oct 2025 09:09:13 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
 by smtp-relay.gmail.com with ESMTPS id
 46e09a7af769-7c5301c8e89sm1307631a34.5.2025.10.29.09.09.13
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:09:13 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8a65ae81245so886080485a.3
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761754152; x=1762358952; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i6L+uNH1tAaLEsZf9XmKpv9AV1uuaMdcOUvtN9FzQkI=;
 b=SrPdGL+ltYmx4mrck8dOfM8No9/fCh/nS79syr9rQAwoRamXBwHRegJ9ZXKGtlVFII
 k+XDegBdtqVhW4sv251Ci1q65NyLLD8IcbX02PpWV/bL8w+4xPzCUrgpo5StRyaaj2ut
 zwEng/Cram4IXXVNx/mCiVtCDqht7KAhjqbz0=
X-Received: by 2002:a05:620a:2909:b0:8a1:d55f:8c9c with SMTP id
 af79cd13be357-8a8e59b10dfmr470031985a.71.1761754152296; 
 Wed, 29 Oct 2025 09:09:12 -0700 (PDT)
X-Received: by 2002:a05:620a:2909:b0:8a1:d55f:8c9c with SMTP id
 af79cd13be357-8a8e59b10dfmr470024985a.71.1761754151671; 
 Wed, 29 Oct 2025 09:09:11 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.09.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:09:11 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Peter Spreadborough <peter.spreadborough@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Farah Smith <farah.smith@broadcom.com>
Subject: [PATCH v5 23/57] net/bnxt/tf_ulp: ovs-dpdk packet drop observed with
 thor2
Date: Wed, 29 Oct 2025 12:06:38 -0400
Message-Id: <20251029160712.58519-24-manish.kurup@broadcom.com>
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

