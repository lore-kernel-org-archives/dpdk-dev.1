Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B4BCD5BB8
	for <dpdk-dev@archiver.kernel.org>; Sat, 23 May 2026 20:00:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5253940DCF;
	Sat, 23 May 2026 21:59:04 +0200 (CEST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id 4D19940A7F
 for <dev@dpdk.org>; Sat, 23 May 2026 21:58:58 +0200 (CEST)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-304545f5206so2270570eec.0
 for <dev@dpdk.org>; Sat, 23 May 2026 12:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779566337;
 x=1780171137; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V/NSixUAllDpBJeL4eFsZg3eKKVEaPbqc1yyJdFHBBY=;
 b=XkWLAmrpyGm6+HDn/IR6EnUajROdfAtDyl4U537Nk2q7z+qAOIB+QPDMxBmjvy3u3h
 8stjhjumLTh4Jhhc+M5rRRRgDF+3xAdgPObp8vhF+3MwP6NUD1RGzmCkxH+6xZE2NIQG
 XWtwaJb+GVnY1f4WMgC0ZyhWwy1fsh99MFhfWdIZtLkub2gffESDl27/M6u1xLADTBVA
 lZ2wb5gc/9fJKXgYPnXwbZbsBS6THMWHanrcoLRKFXW6+qecTpRcjIPdv9y54bWdN4IT
 S9sEonpiV34q8+iZIZ9rYoP6SUumedLE01yH0MlPYJpc+m8jmkt8RdwfTcz6la5hzD6m
 b8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779566337; x=1780171137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V/NSixUAllDpBJeL4eFsZg3eKKVEaPbqc1yyJdFHBBY=;
 b=ag0ylwrJJEI9jVvfdVAJoO/d9JERJuOS5+gT8X73h6zNj6fSYZ7h3kaPxUsccS3hge
 3dpG1vP+wfTSzXfxnU0Si8VEEhRG54cXo1dRv+FILhT9BPHJojKoSG3H0eU65CJtPjjY
 dr+tfWvZTZYOEpcAFTq2viEFWmc1fC76f+qJEILlxuX9qcdsJu6xD82Tglhr/Zl8h1vn
 gQ5swd2b/jSjzmr6aYwgLYbvrI6rJtN94W3CHbetUxALSonxZg5z0uLPmaThAKNB1Jrv
 kCqzwHM+zXnqH1W3mq/nHvZS4Ty6wHLHDDmd8SdEiH8OpCVhqDFjZ34EIpNwvnqxzb1Y
 tY4w==
X-Gm-Message-State: AOJu0Yxf5fpE96uxr9yo9aQAXwAZfPD6akxYE9Ox1ppDN2agGHts/vJY
 Kzti4cF2+s7icL1kQYMz1i0EQtBB1wud5er/LNbJP0WD4y4yy+bhxs6zGcQRsLVgMYhXQXYZhEk
 0Jnre
X-Gm-Gg: Acq92OFDvr5NBvtjCgMp9W/lSFSpQFcO2y0ec20y4pJ/bPzR8MACrJxIsTUz1iU5iGT
 nEjUYzJx8n5GBrz9Xj1sWvoqLOtSwSDF0hQ9TWNYdiDyfsZAg11o3/GIYV/xL/TYohr4IlwGNaD
 JBXuMamTimei41j5jKF4WcOt3Arkjvg6JwtFLqNyssGgPuQpxT+ZY0UtvvUd2Rl670ULhhSkFl1
 BhbqTPJE0UTajDwy90bIsGHv5wwJWvsSBInehn9nboZ9fM7vdPxDV9x4WuVOc4xfnHvMu6QUYjo
 s/NNNwpTSHpr4CC/CzYvk5sjRXlQBSzQsEh7vb6yOcoS7wtFVUxvOt9dngecHEjSqMdO1c10Xg/
 vjNZ4MI9/k6DQ2T8zTj8AHUF7R0N3d9Z+KYmsQdoJAGE9FsceEsXqnjHpOfInH+ipvpdXB4pxoD
 qrEuD861bjHm+ccf7bVT2Ch2/FAUU+G51ghV3IgI4ZPnAoCjGtvDruiGZCLqWMz0Ca6H5qK71Z
X-Received: by 2002:a05:7301:9f05:b0:2ee:be86:7b90 with SMTP id
 5a478bee46e88-3044912f80cmr3511371eec.29.1779566337405; 
 Sat, 23 May 2026 12:58:57 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452255234sm4838428eec.20.2026.05.23.12.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 12:58:57 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: [PATCH v3 15/27] net/netvsc: replace rte_atomic32 with stdatomic
Date: Sat, 23 May 2026 12:56:29 -0700
Message-ID: <20260523195839.454952-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523195839.454952-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260523195839.454952-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Change the rndis transaction id and buffer usage to use
stdatomic functions.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/netvsc/hn_rndis.c | 28 +++++++++++++++++++---------
 drivers/net/netvsc/hn_rxtx.c  | 12 +++++++-----
 drivers/net/netvsc/hn_var.h   |  6 +++---
 3 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/net/netvsc/hn_rndis.c b/drivers/net/netvsc/hn_rndis.c
index 7c54eebcef..4b1d3d5539 100644
--- a/drivers/net/netvsc/hn_rndis.c
+++ b/drivers/net/netvsc/hn_rndis.c
@@ -17,7 +17,7 @@
 #include <rte_string_fns.h>
 #include <rte_memzone.h>
 #include <rte_malloc.h>
-#include <rte_atomic.h>
+#include <rte_stdatomic.h>
 #include <rte_alarm.h>
 #include <rte_branch_prediction.h>
 #include <rte_ether.h>
@@ -59,7 +59,8 @@ hn_rndis_rid(struct hn_data *hv)
 	uint32_t rid;
 
 	do {
-		rid = rte_atomic32_add_return(&hv->rndis_req_id, 1);
+		rid = rte_atomic_fetch_add_explicit(&hv->rndis_req_id, 1,
+						    rte_memory_order_seq_cst);
 	} while (rid == 0);
 
 	return rid;
@@ -357,12 +358,14 @@ void hn_rndis_receive_response(struct hn_data *hv,
 	memcpy(hv->rndis_resp, data, len);
 
 	/* make sure response copied before update */
-	rte_smp_wmb();
-
-	if (rte_atomic32_cmpset(&hv->rndis_pending, hdr->rid, 0) == 0) {
+	uint32_t expected = hdr->rid;
+	if (!rte_atomic_compare_exchange_strong_explicit(&hv->rndis_pending,
+							 &expected, 0,
+							 rte_memory_order_release,
+							 rte_memory_order_relaxed)) {
 		PMD_DRV_LOG(NOTICE,
 			    "received id %#x pending id %#x",
-			    hdr->rid, (uint32_t)hv->rndis_pending);
+			    hdr->rid, expected);
 	}
 }
 
@@ -388,8 +391,11 @@ static int hn_rndis_exec1(struct hn_data *hv,
 		return -EINVAL;
 	}
 
+	uint32_t expected = 0;
 	if (comp != NULL &&
-	    rte_atomic32_cmpset(&hv->rndis_pending, 0, rid) == 0) {
+	    !rte_atomic_compare_exchange_strong_explicit(
+		    &hv->rndis_pending, &expected, rid,
+		    rte_memory_order_acquire, rte_memory_order_relaxed)) {
 		PMD_DRV_LOG(ERR,
 			    "Request already pending");
 		return -EBUSY;
@@ -405,7 +411,8 @@ static int hn_rndis_exec1(struct hn_data *hv,
 		time_t start = time(NULL);
 
 		/* Poll primary channel until response received */
-		while (hv->rndis_pending == rid) {
+		while (rte_atomic_load_explicit(&hv->rndis_pending,
+						rte_memory_order_acquire) == rid) {
 			if (hv->closed)
 				return -ENETDOWN;
 
@@ -413,7 +420,10 @@ static int hn_rndis_exec1(struct hn_data *hv,
 				PMD_DRV_LOG(ERR,
 					    "RNDIS response timed out");
 
-				rte_atomic32_cmpset(&hv->rndis_pending, rid, 0);
+				expected = rid;
+				rte_atomic_compare_exchange_strong_explicit(
+					&hv->rndis_pending, &expected, 0,
+					rte_memory_order_release, rte_memory_order_relaxed);
 				return -ETIMEDOUT;
 			}
 
diff --git a/drivers/net/netvsc/hn_rxtx.c b/drivers/net/netvsc/hn_rxtx.c
index 0d770d1b25..6f536610f2 100644
--- a/drivers/net/netvsc/hn_rxtx.c
+++ b/drivers/net/netvsc/hn_rxtx.c
@@ -17,7 +17,7 @@
 #include <rte_string_fns.h>
 #include <rte_memzone.h>
 #include <rte_malloc.h>
-#include <rte_atomic.h>
+#include <rte_stdatomic.h>
 #include <rte_bitmap.h>
 #include <rte_branch_prediction.h>
 #include <rte_ether.h>
@@ -558,7 +558,8 @@ static void hn_rx_buf_free_cb(void *buf __rte_unused, void *opaque)
 	struct hn_rx_queue *rxq = rxb->rxq;
 	struct hn_data *hv = rxq->hv;
 
-	rte_atomic32_dec(&rxq->rxbuf_outstanding);
+	rte_atomic_fetch_sub_explicit(&rxq->rxbuf_outstanding, 1,
+				      rte_memory_order_release);
 	hn_nvs_ack_rxbuf(hv, rxb->chan, rxb->xactid);
 }
 
@@ -602,8 +603,8 @@ static void hn_rxpkt(struct hn_rx_queue *rxq, struct hn_rx_bufinfo *rxb,
 	 * some space available in receive area for later packets.
 	 */
 	if (hv->rx_extmbuf_enable && dlen > hv->rx_copybreak &&
-	    (uint32_t)rte_atomic32_read(&rxq->rxbuf_outstanding) <
-			hv->rxbuf_section_cnt / 2) {
+	    rte_atomic_load_explicit(&rxq->rxbuf_outstanding,
+				     rte_memory_order_relaxed) < hv->rxbuf_section_cnt / 2) {
 		struct rte_mbuf_ext_shared_info *shinfo;
 		const void *rxbuf;
 		rte_iova_t iova;
@@ -619,7 +620,8 @@ static void hn_rxpkt(struct hn_rx_queue *rxq, struct hn_rx_bufinfo *rxb,
 
 		/* shinfo is already set to 1 by the caller */
 		if (rte_mbuf_ext_refcnt_update(shinfo, 1) == 2)
-			rte_atomic32_inc(&rxq->rxbuf_outstanding);
+			rte_atomic_fetch_add_explicit(&rxq->rxbuf_outstanding, 1,
+						      rte_memory_order_acquire);
 
 		rte_pktmbuf_attach_extbuf(m, data, iova,
 					  dlen + headroom, shinfo);
diff --git a/drivers/net/netvsc/hn_var.h b/drivers/net/netvsc/hn_var.h
index ef55dee28e..b0929de790 100644
--- a/drivers/net/netvsc/hn_var.h
+++ b/drivers/net/netvsc/hn_var.h
@@ -85,7 +85,7 @@ struct hn_rx_queue {
 
 	void *event_buf;
 	struct hn_rx_bufinfo *rxbuf_info;
-	rte_atomic32_t  rxbuf_outstanding;
+	RTE_ATOMIC(uint32_t) rxbuf_outstanding;
 };
 
 
@@ -166,8 +166,8 @@ struct hn_data {
 	uint32_t	rndis_agg_pkts;
 	uint32_t	rndis_agg_align;
 
-	volatile uint32_t  rndis_pending;
-	rte_atomic32_t	rndis_req_id;
+	RTE_ATOMIC(uint32_t) rndis_pending;
+	RTE_ATOMIC(uint32_t) rndis_req_id;
 	uint8_t		rndis_resp[256];
 
 	uint32_t	rss_hash;
-- 
2.53.0

