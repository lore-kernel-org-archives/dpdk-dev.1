Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465F5CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 14:06:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADBD142E78;
	Tue, 29 Sep 2026 16:04:39 +0200 (CEST)
Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com
 [74.125.228.38]) by mails.dpdk.org (Postfix) with ESMTP id 7F32242E10
 for <dev@dpdk.org>; Tue, 29 Sep 2026 16:04:27 +0200 (CEST)
Received: by mail-pz2-f38.google.com with SMTP id
 d2e1a72fcca58-88272e1d069so1850809b3a.1
 for <dev@dpdk.org>; Tue, 29 Sep 2026 07:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790690667;
 x=1791295467; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AP/DG4gQxGiyMGY/lzP1xkCcRepcdaetSXQ/5AwhtS0=;
 b=ssPGupJcQ+cOfT2rEBz1069rHgmI/OMfNWDqJK11vlfeOeI696aEg9YiHovljb6Xz1
 DOYa4eha8y847+m7pnkYHuc6SnDIHaxAq9sOxswbqxfasyZAEbWYWpQuzI2iZoFxzU7Q
 86gTfE3c0HfrrNSvMoFYKhfTBLzYJFHZfULPbNySoYwrIIykMIF3behiUl5ynsfP+hdw
 gAGx2BDDBrjZhngo+Sgkmp6WKJW/gmZ1za1QuSRz+GgfiPBlUXn2O2vTv36c7rKLw98M
 hAu5Z4e5QdbT4Vb/8ej5fd96JoUWSh1/XsGCr+ddlaePopI0qbMVJtTMJ/sQEA7js3A0
 bdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790690667; x=1791295467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AP/DG4gQxGiyMGY/lzP1xkCcRepcdaetSXQ/5AwhtS0=;
 b=mAWIr9FBgRe4HqZ4YOzjpnv2VmUK0YgGSqazDjs17QVAJ49CTd2qRIJLJAmiP/kxHy
 G13Ew4IdZQge0C3rT8VkpX7YcFWIx60mV9Xzgt30kw9nOx64YMiP5GPwDdOBZXnw1PY6
 Wu+HOPUTTnoUR2VaIN6or0ergY5M0yTMpuI1CQ7SNvA6m1d8oeo4KESam6ZjRcTRp0Nw
 cMI6mrQUw62fZE42j6bUxljPN6yC2C2lXFhw099r84U0WkgbsXd/NqG82HGyJylJU4SY
 7CPi598kazO51BJv9vLIDSDWzMOM5HSK1g6dc5WAOz9uOnqXL6efqOjwa1ZUFabO2ymJ
 i/8w==
X-Gm-Message-State: AFuF++kyLeivWF6dpJ8V08t7KjphlGc/aXf4PPB5ty6GDbSAYruYnd5J
 9BI4bMkNxqp6FCMrZFAURh7EzWAjr5ndLV9BwdEnCpIvzDhK7VzsxEWNI3tefJNmf7WPLy3wzWr
 C+0rUTTs=
X-Gm-Gg: AYBFou0c7sikc03pbXxrHx29xb6Ih1QWzQ97hJeXl8q67Z7rLHscKEGnP8Qy0JrM+NB
 Jk5OQYv/BvcqxwJ1gyDiV1cvE45pcnU/kpr2bGAENnLNa7b1YfZj4sZdlavEGDBmMxwJjbKyj7z
 X//sLU5gsAQZGpL3JNrIR5Jf579iLYI1H/rDSBfw7YMTZ/Hk25s5tAScy9UGjOd3D+ETz8UUgpn
 fypxXN8hnGct9sypzsmirF6oRm1XUuzWQBqhsfcc3nXme+9DKa81dd+r5302XbcaoHbTIQnVv5A
 Vio0FNJdRYWyt5HYZtzTEVxL9h+IMXQPr7H1UscYTy1ThIGG+f8Tu0uRA6uzYi3pWwpAJNC8ztn
 vS/MQM1pMLa/OFtEXuZ5zAuDBJin6UBs1dOLGsATqWWEuBVB7YTDHEZYPdQtneQMuvw7yBYlY1+
 F9DCOOouqIngFCm6aiXM9L2XOm1LxSGV4VOR297TgWctUyZmr3hoNNekux4bOjdeuLgWDdTiSP9
 xgq9Wgao5yDME2O57O7Jhax2oXsxzIxH+ZkEXhhZcXSG5aO
X-Received: by 2002:a05:6a00:909c:b0:881:b008:12dc with SMTP id
 d2e1a72fcca58-881b00817f8mr7978233b3a.51.1790690666445; 
 Tue, 29 Sep 2026 07:04:26 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-885e1066470sm998330b3a.18.2026.09.29.07.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 07:04:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: [PATCH v9 14/25] net/netvsc: replace rte_atomic32 with stdatomic
Date: Tue, 29 Sep 2026 07:02:00 -0700
Message-ID: <20260929140409.234453-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929140409.234453-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260929140409.234453-1-stephen@networkplumber.org>
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

It also removes rte_smp_wmb() and relies on the release
ordering of compare-exchange.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: Long Li <longli@microsoft.com>
---
 drivers/net/netvsc/hn_rndis.c | 28 +++++++++++++++++++---------
 drivers/net/netvsc/hn_rxtx.c  | 12 +++++++-----
 drivers/net/netvsc/hn_var.h   |  6 +++---
 3 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/net/netvsc/hn_rndis.c b/drivers/net/netvsc/hn_rndis.c
index 7c54eebcef..4e13d7c38f 100644
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
+						    rte_memory_order_seq_cst) + 1;
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
index 574b909c82..d7124a7df9 100644
--- a/drivers/net/netvsc/hn_var.h
+++ b/drivers/net/netvsc/hn_var.h
@@ -85,7 +85,7 @@ struct hn_rx_queue {
 
 	void *event_buf;
 	struct hn_rx_bufinfo *rxbuf_info;
-	rte_atomic32_t  rxbuf_outstanding;
+	RTE_ATOMIC(uint32_t) rxbuf_outstanding;
 };
 
 
@@ -167,8 +167,8 @@ struct hn_data {
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

