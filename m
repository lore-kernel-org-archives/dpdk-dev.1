Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0C4CD98F2
	for <dpdk-dev@archiver.kernel.org>; Sat, 20 Jun 2026 02:32:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E561740DF8;
	Sat, 20 Jun 2026 04:31:59 +0200 (CEST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com
 [209.85.128.177])
 by mails.dpdk.org (Postfix) with ESMTP id CD15640663
 for <dev@dpdk.org>; Sat, 20 Jun 2026 04:31:55 +0200 (CEST)
Received: by mail-yw1-f177.google.com with SMTP id
 00721157ae682-7fe4808741eso29285927b3.1
 for <dev@dpdk.org>; Fri, 19 Jun 2026 19:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781922715;
 x=1782527515; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W1TlseSdBJK5er3s/+rcCXjNtQ4TRuzlkUpmqPk7UwY=;
 b=hLE3t4OUwArmVSewnfX0RXj/sKqhRHxxB5867adBLniJLrVNCs15E7jD82L/mzLnn1
 qUf6yutWfvAWH8xZce0YDWXHHQ2VcmNYBeDdlLjrXgFSMWSKSF5VWjCGvEI5t128s2yO
 voDPxkIGW7WmjdyW+AeHohv+h1fFrIb5cH0l0DtSH51u0SNKUUN4/hpyMDwoFc74J4Ou
 B/jTgZfh18e36ttjZhWWDWpm8F8cb7DB7R77bUSfEBRExrICOQJcVqr3wU055OqD20b4
 VKGmaZfFcsDPX/pMISOMAJnxz3N74zXy/dXeworPh/SMJ2TIvuA6J6Q+n9XgE6wg/jpb
 cPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781922715; x=1782527515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W1TlseSdBJK5er3s/+rcCXjNtQ4TRuzlkUpmqPk7UwY=;
 b=F+3LTMzwcHxgCaLX7owauWiHHvhBdt564iOmCoVY07T2lhOnL+SKXvR4wZ3NoKz92D
 nDtgui9Y0yUR0wfIaK5B9O+KvAGC/sZRznUGnR5tesOQwwSGFWyz0/ueJEOxcQAg3VFa
 aqf9Ny9lnpPaC6Q+nDyjk19ttsP09QdoScdsSagQX0pKLJwQhMpVPmcOM8VFzB1NtGVa
 1DTtZMTE+cOG4p/hcJm6TRAyVkrcn/ij1mK1k1CMGVO2wJigrfFma29iaglzr7mOXR4Q
 96NbgC9+c4VekUUuLOZDoEvEuvfIg0yB9YbbZlZqc36ep7Kwo7IHQ/3Wgz3hLy2ythw9
 I+nQ==
X-Gm-Message-State: AOJu0YwSVLwkw700iDeZ3mIf3y2MUgWaa85TiHwa+fNYXqQqtT24/h2C
 I3NwIYev2cKa/1Gi7BgIUcwKV6ZfYHu8eNF7/Wn6ikURsHAamrArvGvv0TSsFgI0DNUJzfqrhIL
 a+HsS
X-Gm-Gg: AfdE7ckfmK6+skzJ9DTa73CtUqfqQ1idOKEedsib9uzuz54q7A09THuE5iGfOSZZtfp
 QCV1mhFNucEMnQghhr6sh+o95uayTtulzpel/q3vN3TwyeRC0qSPD/aK02VKIMIRTfgtmh02L6u
 YS9gK+VHef6l0gV5vVU3L4i+uwET2HhiEyMUuPVWu9kSxlGOCCxOb/HHdNAgTIjcP7t+bJu18+D
 ybzoz/VIWmn0GO1mEi0Sk99FIqSnGEylevR8LBTXTHPDUnaa04Mik128auxsBPH2fpucRlL3mKL
 MhwoLFQddxnQ68DaLQlOPtl91jUMN5sluCQeNmlGVd0kh5wL0EvdvxOGchDnYU2ME2F4aBFe2/t
 2ltj9joVPOuVUCM/kM6KagdJASdy+uwF4Sjh/ZV6KOZ7Dyjt2Nl7MqrFNTYvWuy/arIHRePBzEb
 pDP3LusIAh+sgu1fZqhq2Gu9vVibV892FMrlYZ+39UYL4myBdTWWs=
X-Received: by 2002:a05:690c:c243:b0:7ba:f690:70be with SMTP id
 00721157ae682-801301300cdmr59921627b3.7.1781922715110; 
 Fri, 19 Jun 2026 19:31:55 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8025c96ffd5sm6045897b3.9.2026.06.19.19.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 19:31:54 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: [PATCH v5 12/24] net/netvsc: replace rte_atomic32 with stdatomic
Date: Fri, 19 Jun 2026 19:28:37 -0700
Message-ID: <20260620023134.42877-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260620023134.42877-1-stephen@networkplumber.org>
References: <https://inbox.dpdk.org/dev/20260521042043.1590536-1-stephen@networkplumber.org>
 <20260620023134.42877-1-stephen@networkplumber.org>
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

