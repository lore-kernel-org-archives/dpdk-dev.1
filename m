Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB5AC982D0
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 20:12:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA9BF43262;
	Thu, 17 Sep 2026 22:11:40 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 0B39943007
 for <dev@dpdk.org>; Thu, 17 Sep 2026 22:11:36 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d747ec6185so280935ad.0
 for <dev@dpdk.org>; Thu, 17 Sep 2026 13:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789675895;
 x=1790280695; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AP/DG4gQxGiyMGY/lzP1xkCcRepcdaetSXQ/5AwhtS0=;
 b=AR1NnstOZecsYzwVwE66WNS5A5/l32U+xX1K2Q2Cv8d54bdqmIwDEp+V0CrfKGqa/H
 D2EaRDPzzzHzkXsBG+AM2vMFmApcFll0lbim+yU0eSQvNkncWud05UqVcbSpqHI6OvMv
 DzVzMD4AqhdUfeNapSr9DKhbYw6gz+7SzDxUtNvOnF1i4lvoVkuuug+h/2PzCq8ZrqRN
 ICy1yhMOuRDwEFR8fKRG1v911w/KbLqDq/rXrVsaG3PcOGudGH53o0F/3wlq62Gw9iDd
 px9ss+83ry3vj8TWpkLb3SkXFGFrIEXt10DzAEgOGxtUOE51gOnf9E6zuLT0tY8IKf6W
 38Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789675895; x=1790280695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AP/DG4gQxGiyMGY/lzP1xkCcRepcdaetSXQ/5AwhtS0=;
 b=gnDXJhKAU9e6kQGXPRti7//9wKNEFqTrLljC5m8ku/CFyDpPm3BFbMXqB+cLYKdHTC
 RpsGb5ClhunHkkVDoUZAK3u0WUYEn7bW1MwtZYX0dn59RBoiitGuvTW8JAwNCZE8TCLe
 hbVOTrnKz2k3PpPCZXtfKXz7xh82kt8xBmOjJe1ietSmxDV9hUn3i3VG/J9zjcSF8HnM
 JO/cbIqnRULOoG8cCEjPsiU4OUJR7VAu1XkdDsAGql/NmNuKKL+BNsBcGCwJYgWll8xX
 dwr76N4AMq5zkue3t/rFZM7TGz82ougatNaVN1yxVN7jgGfKReEos7SxB2m9iQPRI9eu
 UHvw==
X-Gm-Message-State: AFuF++mlwTWoUFA9twR6cf2OFx/FDpLJpt+tNKTvGgXJJL6wydPmD/7z
 CVRbOSC1Sjao35ZvYBe6Ebuihf/DsNYd+u1mdMmJMPprOWlbbHMS+MjQJM1jO9D0Ots9YIFHv0h
 WDb+J
X-Gm-Gg: AYBFou02fCGKePEBRZS0KHW+ni43ybsslyPO7z+nkqXa/bB70jq0xtW7uZ75H6XQgtJ
 A8CVP+dCfO1jKujKW+AC9gIuCieGLuQmz9f5eZqLKy11+lXZRv4L6QWYIAWEuA0XgcllFZsXVQR
 xjyvoq/eTHKWGyBwxzK4AuBQdsfwSevi3ROygNFch924lDBJTG8QohetSdFPEmzyxKUC0ROGR8D
 3NsUJVvFdKZXrtEdzdLBgyt0kaY38zjavrza9IPUy4FDGvz/j4Z/PQQXHQUdDcMIWQQTsrfwkXd
 Zvyh4iYxTv6g3dxY2RZzVj3upQofTM16URKMpfWnEaHRX4TS54CKcEXOJntNH+krMJRIzOUBvvc
 jKy70pK75colJ6CeOXwBoJb79Y2FOX7fMC8vcN7bDBTfIGSbMrEXg2/UgPu69yDyJCPl3woDvrZ
 1M3+sdemnG1gyBFopuJjEOxNzO+sa7p5dTlJLuxrM6RvldnN+XytyQLVwV8ntXgxscQbXVy99vh
 riI6F0+SYq1U5zj87hyPYm4NS2TbnxXcbBOjg==
X-Received: by 2002:a17:903:2007:b0:2cf:afa5:b19a with SMTP id
 d9443c01a7336-2ddb1ae16a9mr3752205ad.11.1789675895150; 
 Thu, 17 Sep 2026 13:11:35 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd89f0870bsm31368345ad.63.2026.09.17.13.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 13:11:34 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: [PATCH v8 14/25] net/netvsc: replace rte_atomic32 with stdatomic
Date: Thu, 17 Sep 2026 13:10:18 -0700
Message-ID: <20260917201119.2168234-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917201119.2168234-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260917201119.2168234-1-stephen@networkplumber.org>
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

