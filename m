Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE78CD5BDE
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 23:27:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCE9540A80;
	Wed, 27 May 2026 01:26:08 +0200 (CEST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id CD73A406FF
 for <dev@dpdk.org>; Wed, 27 May 2026 01:26:02 +0200 (CEST)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-3045c195251so4410872eec.1
 for <dev@dpdk.org>; Tue, 26 May 2026 16:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779837962;
 x=1780442762; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W1TlseSdBJK5er3s/+rcCXjNtQ4TRuzlkUpmqPk7UwY=;
 b=rFrTlCRx6nwH0tA0CqpZQIi8mr7m/K7X+lpMAo+B4NyRo4bW534zNdpoCfH1ywpnHy
 KSerD3fvj2xwTSIPC12wiIF9T23pGP9r/79vrt0Pb9Vqkoliu8eRgk9kvqvri6eKcfpY
 nL691X+Ye82WXMsZZJhqwMvbeMa+67doNFARtJKpgz02guet4ydgeug7WEI5RUy8HGnF
 MPwOU4EbCwEzABm2mH81ggg1/f6+MzKbzcCx+u8GCiv+012j+JlyN40D5+8su8DIS8aY
 t9/1giuQuV5T9BXacaXQgygBbr7EEkUlOB1i/vDGASX/WJih7C2oQUDUlkM2t301jcbF
 IobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779837962; x=1780442762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W1TlseSdBJK5er3s/+rcCXjNtQ4TRuzlkUpmqPk7UwY=;
 b=PS308SkdkO8syxPTO0+njpt44zUeKSXF+W0nEbGiWpCMph9UPY8KSm9/jw9x4wpzu2
 kN0ILyCoTVm5OwBCQTX/3gG4958w7JOltchBTkXEkdp7gqXhi4nGtzqSsmVtzur1y4TX
 9vTQHomrZEGfc4qy7JQCOvyi/czz0VWt6owELMlE7tMfsddlPjsWzbXE+KfAk0C9y8R0
 cQHbcdcbRoH/4f87fZNcdsDkqtk3jwcJ6mBAT9M5Lk/hyg+e5II/mpXisgoGP8tIS0gL
 /l0kxoM8D4Ah3jT2kIHg1+RxU1xekudM+rWlxV0n/UW9gK/YU2jP8EkH4go/58G+358y
 zFKA==
X-Gm-Message-State: AOJu0YwhcaFH+6efsE4m1EDj4TDiwbA1rkRZZWCTLcRNFD8s/WGECFOP
 IfeuBl8+ypmk56dg+m/CzZi/VwBonnNn3gzTVl8FAe5VKhAaNBm6ZnoFkd0wlgPej9soAA/vUG6
 ncXp2
X-Gm-Gg: Acq92OGBmWAlsU6JolANGJuIyraDIsg/g2nlKCROqGkyj3zoF+nCoCu6qdqF1czoKqD
 BWSqJR0OUecb4j934XoVKFru4Pv1Kss9ACOMxmzIv7hd3UsqczlP76fOHVKnEbs0p3Ar/HzskdS
 7Fpk1WNC9rQe9/6wWCeNpIc4vdUaUB2v2W+3Ex8AdNxCRFXTxvUony+6OREqU3xaoxCLAIPdLHC
 IjKLNFRU6RejfC0EtCBRslJ+Rg79PqVk5jpBUWP67uADem9YYha/Y5ryuhpCZK1NqJXZpoUgsNM
 90C1YWsUpVPHyV68WmF8LMJfJK9iZDlaGals5vj/jtvxC8onaSrRYlHSjJrB5wl4aWn44J6KeHK
 tt5uje7E5JxSHxPP87yGPAE1Yc5rHUOy7hHaB+YxxjK/XJbjhqWNeWhvqgBtK8s//es9fmkT+Se
 Jq6XYWduau2puGWb7x2Y8mLoJmHfo3DPK4QpxeMqrFPK+N38QhWu+bLPgCLfIcA017xxKbRLDfn
 DG6fWdY01o=
X-Received: by 2002:a05:693c:2c0c:b0:303:a1af:5042 with SMTP id
 5a478bee46e88-30448d51723mr10065102eec.0.1779837961851; 
 Tue, 26 May 2026 16:26:01 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452230f1bsm11296132eec.14.2026.05.26.16.26.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 16:26:01 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: [PATCH v4 15/27] net/netvsc: replace rte_atomic32 with stdatomic
Date: Tue, 26 May 2026 16:24:05 -0700
Message-ID: <20260526232542.620966-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526232542.620966-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260526232542.620966-1-stephen@networkplumber.org>
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

