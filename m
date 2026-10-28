Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298B2606A31A
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Oct 2026 14:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VYD3mwic
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A15440611;
	Wed, 28 Oct 2026 15:18:03 +0100 (CET)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTPS id 89F26402DC
 for <dev@dpdk.org>; Wed, 28 Oct 2026 15:17:57 +0100 (CET)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2e60f9af6e6so8377955ad.3
 for <dev@dpdk.org>; Wed, 28 Oct 2026 07:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793197076;
 x=1793801876; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JLDdbdHzjosSGNO199R2scIwXBBHNFU1zqk2xqakWoA=;
 b=VYD3mwicDpahL1FmiA6HNUvSS01mWbPAonVMs1XA8aAdDH+Yx8Y8+gn2VckR86rLLk
 JobWa0qZB0L5mdRwvY9VYckgn/7MMFYyj9HQfw/NZrZgPoqq2a0uoOjggajHviixg2/+
 iRfWzV9VFA5PNuOmez60pURW0zCMfeBTEEsQOn53qsFIOlF5dLo6OQBowKwuZhB5O9I4
 5rl2X6onofCre3WYHgozgynYFjCDyUSIA7dC2ukagFVenL0XGPW66Gd0UNZlfK3zBfOH
 FHbZcMpgg8NBy6CyIWl16Na8sZLNVJt40tt6i11IM1y0otUwV++jnq4QSDJy2dILd/fh
 OyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793197076; x=1793801876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JLDdbdHzjosSGNO199R2scIwXBBHNFU1zqk2xqakWoA=;
 b=0siFXPfsAbSAmtU1SDvz/vEJ6rcUPE+JQfalozHldTLPGfL5Zz8OQXT3hnaPmb5myj
 MkRiU2rhPHdUqKYIA20VW+BBYHRktmy6BCAt/y0qxmDlHDVvqU3BOBgarIfinIiZMHCN
 xlOxn86MjssJlmFC0fEOgegRRyDAdF3fKikiDLvghMtLF4ciRXm92JxLEbocIL60jD4V
 6QK78aMNrvo7ppALmHd3fAvNb6cXagN6vi84YbwDRm/Kg6lnMA9Bme+vvTgguBLdqRGc
 45NGS36Jzq/fJEUU83Jmas6qtI50NuUXtuPasE3DuobwRqzKL4l+GMbZZH2ZiYOppj/o
 JO2Q==
X-Gm-Message-State: AFq9FYJmKfA7vy3OzxugINYfjvBppKI3JJzupmUgVjV5QWyfMzBcXcWl
 kkOAeWDOQ6LPjqKWBbuIzhozJe6ESllDN0iLZDnZLqCqt6joDMaBjl9JHQ5767U3zfE4Xx/Ocih
 kVQDcPFU=
X-Gm-Gg: AYBFou1z2Rl/4VL4OMsUFtJNBEhrvxNCgwZWyKOCZ3GSpT7uSXM40kHiLtN+4DyXJi+
 yjImdOBdjF3Kd3Oxvkrgz9LkpauSPtjmAPz+I1bYCxjEVN5vK9XzJiuYGdg9jZ236j81zDQfiGd
 cWnYmltXjcwS5ypHob/NnM6nIBsdpNk9BD8Iv/6c7hJKlrZnPGQSEBnawrKU+o8kH51zW+WL8px
 our9rNDcllc4BhEZgoW/GWvBy3abO10JzZFof0GHyA61o4fc4GpVesONSgdHmCm0goquahPNAba
 mTR9GcinQjaQzg8Csu9XkJjI8F455LSSwKVdcUK2qd8PI00DQXoZEKyXmEzY0Siutky/7qeo6du
 dZqqNLdoEJUNlfW96mYTfpTv7tuxNWQwySt6wrcHemwLoFntrfIBiP9JIcCaCRJQz8YxbiHPb3v
 W6IX3qrrPowwEfJx3ph9o1gBC11Zp3Q9On0zYDvNOsalQTvdFmQ10wzpOjlDFmgjsqOO8muHPOO
 358u2FF6O2PLxE+3Pc4PgnwxoerK/LwlVjSskZ5sTohboslPMrnIJ79fiUl298g1DynlGSqIcL+
 5Jej/vHSsjJP/asp/d/HYSsBI3ouJ0PkyG8OhC5Kajx6c9wE9+q/Nk2l6LDBoM0QxGqgu/L8s7o
 Pm0wDij2R6Ur2Gg==
X-Received: by 2002:a17:902:d987:b0:2e9:3dd0:c8d with SMTP id
 d9443c01a7336-2eb0051d0damr25128505ad.14.1793197075980; 
 Wed, 28 Oct 2026 07:17:55 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6c3b67bsm22182415ad.52.2026.10.28.07.17.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:17:55 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Reshma Pattan <reshma.pattan@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH 4/4] pdump: undo partial enable on failure
Date: Wed, 28 Oct 2026 07:16:53 -0700
Message-ID: <20261028141750.310963-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028141750.310963-1-stephen@networkplumber.org>
References: <20261028141750.310963-1-stephen@networkplumber.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

If enabling capture failed partway, the callbacks already installed
were left in place. They still reference the ring and mempool of the
client that requested capture, and every later enable on that port
fails with EEXIST until the application is restarted.

Remove callbacks installed by the failed request, on the failing
direction and on Rx when Tx fails. Also release the BPF filter on
the error paths.

Fixes: 278f945402c5 ("pdump: add new library for packet capture")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pdump/rte_pdump.c | 91 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 72 insertions(+), 19 deletions(-)

diff --git a/lib/pdump/rte_pdump.c b/lib/pdump/rte_pdump.c
index 3261876d29..644c6bee68 100644
--- a/lib/pdump/rte_pdump.c
+++ b/lib/pdump/rte_pdump.c
@@ -251,6 +251,39 @@ pdump_tx(uint16_t port, uint16_t queue,
 }
 
 
+/* Remove callbacks on queues [first, last) after a failed enable */
+static void
+pdump_unwind_rx_callbacks(uint16_t port, uint16_t first, uint16_t last)
+{
+	uint16_t qid;
+
+	for (qid = first; qid < last; qid++) {
+		struct pdump_rxtx_cbs *cbs = &rx_cbs[port][qid];
+
+		if (cbs->cb == NULL)
+			continue;
+		rte_eth_remove_rx_callback(port, qid, cbs->cb);
+		pdump_cb_wait(cbs);
+		cbs->cb = NULL;
+	}
+}
+
+static void
+pdump_unwind_tx_callbacks(uint16_t port, uint16_t first, uint16_t last)
+{
+	uint16_t qid;
+
+	for (qid = first; qid < last; qid++) {
+		struct pdump_rxtx_cbs *cbs = &tx_cbs[port][qid];
+
+		if (cbs->cb == NULL)
+			continue;
+		rte_eth_remove_tx_callback(port, qid, cbs->cb);
+		pdump_cb_wait(cbs);
+		cbs->cb = NULL;
+	}
+}
+
 static int
 pdump_register_rx_callbacks(enum pdump_version ver,
 			    uint16_t end_q, uint16_t port, uint16_t queue,
@@ -258,10 +291,11 @@ pdump_register_rx_callbacks(enum pdump_version ver,
 			    struct rte_bpf *filter,
 			    uint16_t operation, uint32_t snaplen)
 {
-	uint16_t qid;
+	uint16_t first, qid;
+	int ret;
 
-	qid = (queue == RTE_PDUMP_ALL_QUEUES) ? 0 : queue;
-	for (; qid < end_q; qid++) {
+	first = (queue == RTE_PDUMP_ALL_QUEUES) ? 0 : queue;
+	for (qid = first; qid < end_q; qid++) {
 		struct pdump_rxtx_cbs *cbs = &rx_cbs[port][qid];
 
 		/* hairpin queues do not pass through rx burst */
@@ -279,6 +313,7 @@ pdump_register_rx_callbacks(enum pdump_version ver,
 				PDUMP_LOG_LINE(ERR,
 					"rx callback for port=%d queue=%d, already exists",
 					port, qid);
+				pdump_unwind_rx_callbacks(port, first, qid);
 				return -EEXIST;
 			}
 			cbs->use_count = 0;
@@ -294,13 +329,13 @@ pdump_register_rx_callbacks(enum pdump_version ver,
 				PDUMP_LOG_LINE(ERR,
 					"failed to add rx callback, errno=%d",
 					rte_errno);
-				return -rte_errno;
+				ret = -rte_errno;
+				pdump_unwind_rx_callbacks(port, first, qid);
+				return ret;
 			}
 
 			memset(&pdump_stats->rx[port][qid], 0, sizeof(struct rte_pdump_stats));
 		} else if (operation == DISABLE) {
-			int ret;
-
 			if (cbs->cb == NULL) {
 				PDUMP_LOG_LINE(ERR,
 					"no existing rx callback for port=%d queue=%d",
@@ -330,10 +365,11 @@ pdump_register_tx_callbacks(enum pdump_version ver,
 			    uint16_t operation, uint32_t snaplen)
 {
 
-	uint16_t qid;
+	uint16_t first, qid;
+	int ret;
 
-	qid = (queue == RTE_PDUMP_ALL_QUEUES) ? 0 : queue;
-	for (; qid < end_q; qid++) {
+	first = (queue == RTE_PDUMP_ALL_QUEUES) ? 0 : queue;
+	for (qid = first; qid < end_q; qid++) {
 		struct pdump_rxtx_cbs *cbs = &tx_cbs[port][qid];
 
 		/* hairpin queues do not pass through tx burst */
@@ -351,6 +387,7 @@ pdump_register_tx_callbacks(enum pdump_version ver,
 				PDUMP_LOG_LINE(ERR,
 					"tx callback for port=%d queue=%d, already exists",
 					port, qid);
+				pdump_unwind_tx_callbacks(port, first, qid);
 				return -EEXIST;
 			}
 			cbs->use_count = 0;
@@ -366,12 +403,12 @@ pdump_register_tx_callbacks(enum pdump_version ver,
 				PDUMP_LOG_LINE(ERR,
 					"failed to add tx callback, errno=%d",
 					rte_errno);
-				return -rte_errno;
+				ret = -rte_errno;
+				pdump_unwind_tx_callbacks(port, first, qid);
+				return ret;
 			}
 			memset(&pdump_stats->tx[port][qid], 0, sizeof(struct rte_pdump_stats));
 		} else if (operation == DISABLE) {
-			int ret;
-
 			if (cbs->cb == NULL) {
 				PDUMP_LOG_LINE(ERR,
 					"no existing tx callback for port=%d queue=%d",
@@ -440,7 +477,8 @@ set_pdump_rxtx_cbs(const struct pdump_request *p)
 		PDUMP_LOG_LINE(ERR,
 			  "failed to get port id for device id=%s",
 			  p->device);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto free_filter;
 	}
 
 	/* validation if packet capture is for all queues */
@@ -452,7 +490,7 @@ set_pdump_rxtx_cbs(const struct pdump_request *p)
 			PDUMP_LOG_LINE(ERR,
 				"Error during getting device (port %u) info: %s",
 				port, strerror(-ret));
-			return ret;
+			goto free_filter;
 		}
 
 		nb_rx_q = dev_info.nb_rx_queues;
@@ -460,18 +498,21 @@ set_pdump_rxtx_cbs(const struct pdump_request *p)
 		if (nb_rx_q == 0 && flags & RTE_PDUMP_FLAG_RX) {
 			PDUMP_LOG_LINE(ERR,
 				"number of rx queues cannot be 0");
-			return -EINVAL;
+			ret = -EINVAL;
+			goto free_filter;
 		}
 		if (nb_tx_q == 0 && flags & RTE_PDUMP_FLAG_TX) {
 			PDUMP_LOG_LINE(ERR,
 				"number of tx queues cannot be 0");
-			return -EINVAL;
+			ret = -EINVAL;
+			goto free_filter;
 		}
 		if ((nb_tx_q == 0 || nb_rx_q == 0) &&
 			flags == RTE_PDUMP_FLAG_RXTX) {
 			PDUMP_LOG_LINE(ERR,
 				"both tx&rx queues must be non zero");
-			return -EINVAL;
+			ret = -EINVAL;
+			goto free_filter;
 		}
 	}
 
@@ -482,7 +523,7 @@ set_pdump_rxtx_cbs(const struct pdump_request *p)
 						  ring, mp, filter,
 						  operation, p->snaplen);
 		if (ret < 0)
-			return ret;
+			goto free_filter;
 	}
 
 	/* register TX callback */
@@ -492,8 +533,20 @@ set_pdump_rxtx_cbs(const struct pdump_request *p)
 						  ring, mp, filter,
 						  operation, p->snaplen);
 		if (ret < 0)
-			return ret;
+			goto unwind_rx;
+	}
+
+	return 0;
+
+unwind_rx:
+	if (operation == ENABLE && (flags & RTE_PDUMP_FLAG_RX)) {
+		end_q = (queue == RTE_PDUMP_ALL_QUEUES) ? nb_rx_q : queue + 1;
+		pdump_unwind_rx_callbacks(port,
+			(queue == RTE_PDUMP_ALL_QUEUES) ? 0 : queue, end_q);
 	}
+free_filter:
+	if (filter != NULL)
+		rte_bpf_destroy(filter);
 
 	return ret;
 }
-- 
2.53.0

