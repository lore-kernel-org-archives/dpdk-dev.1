Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA26606A319
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 07:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=WTfb+P9S
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 130444064F;
	Thu, 22 Oct 2026 09:36:21 +0200 (CEST)
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mails.dpdk.org (Postfix) with ESMTP id DEA06402D6
 for <dev@dpdk.org>; Wed, 21 Oct 2026 20:25:25 +0200 (CEST)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f32050e72so334547885a.1
 for <dev@dpdk.org>; Wed, 21 Oct 2026 11:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792607125; x=1793211925; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1jB9G8otnta03wiTrJQKFGX6oQzarifHRG8am8Zogwo=;
 b=WTfb+P9SXvL4Rdh8YY/83vptY5C5OZ5ZJwZac/o0ZbN6VyZIWc4RTHj3Gh36+72JIz
 01UHdFDpO8ODa4MQw+w7cK9tBP/BZYp0bSEe0qJiKTQCpLJN2WzR9LVpOMVENHtLbpuq
 wVeS/gwLeeoDcK8h8I5mmy1MU50/6GJ5bw451vovk8ATuSFPhISgLL3CvBwoPv9klgeR
 UH6pLrZEZ8dtcCz/+0R3hI2AEQVBooeLHK55/hDXFyi90kdzB5uTXUcQ4esfJHy9/poq
 dzAejhAcjABIML25E+0pKsPaziZ8BXBd8Y309YQLUBLtZKCxCy8/AY2mxQhsB4UBPpvU
 lH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792607125; x=1793211925;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1jB9G8otnta03wiTrJQKFGX6oQzarifHRG8am8Zogwo=;
 b=Yj+fmloxVfoT2vL1gx/R7abI1Syj6TQR8zTXY1JCeD+RFirwwCGfZpKl/ewBUwNuOp
 vqlzNHqVUG63JWh1a4FMNANqlTdRkaSe7/mGQAoYL/jwBciLSL3bKRTmZYZDexEeEJx3
 w7Eb8EnjqsG13TLlyoJHwHrMlqFMvvVcNdNqPMK7m2FSTVxeb94i4iePCFXMkr5fYpMi
 gqMUbJch1K+jSL+n18U3ywYfVJ31xLOOUh7DnEvM0AZbnIXTFd4ajrB5YlCAQFM7LcbH
 ulTRjzwAJ6Xyx+rVtaZ1d+XaRD4DBwEVKPumXYtE2PQmoSyA2MZ09hHjLaS1m1tj1ctu
 GCJg==
X-Gm-Message-State: AFq9FYJIsV07x8/3Y/k++sy4HtipK1ZNsHSZt5RZ82UMwxR5nH9PMWhA
 G2F8kmizLJGkIhUpfSIGUBzCctqOQcmdyHFWpj5vacDxjVqvW6TXXJQcqugt1jqFXTUHunaatwY
 r+q2PPfhKjTFMiNBIwEeAwziXl2xggtFzHkodmksTak7t/IAYBuQiu8U0SrvInKw1vKFhdVQHZ0
 HLMclOugqnjBlRYoPqn1EmANhaHo/n
X-Received: from qkcbb28-n2.prod.google.com
 ([2002:a05:620a:6e9c:20b0:93e:acdf:726c])
 (user=rnwolfe job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:6087:b0:93f:1af1:7951
 with SMTP id af79cd13be357-93f57f8ad29mr552392485a.66.1792607123436; Wed, 21
 Oct 2026 11:25:23 -0700 (PDT)
Date: Wed, 21 Oct 2026 14:25:22 -0400
In-Reply-To: <cover.1792439728.git.rnwolfe@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <cover.1792439728.git.rnwolfe@google.com>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <151e7d5905b8c695d77b4ca03834c22b1caf61a8.1792607101.git.rnwolfe@google.com>
Subject: [PATCH] net/gve: check the Rx scatter MTU at device start
From: Ryan Wolfe <rnwolfe@google.com>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, joshwash@google.com,
 stable@dpdk.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 22 Oct 2026 09:36:18 +0200
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

rte_eth_dev_configure() sets the MTU from rxmode.mtu without calling
mtu_set, and keeps Rx queues that are already set up when the queue
count doesn't change. Stopping the port and reconfiguring it with a
larger MTU, or without RTE_ETH_RX_OFFLOAD_SCATTER, therefore skipped
both the MTU change check and the Rx queue setup check, and GQI went
on to chain large frames for an application that hadn't enabled
scatter.

Move the check into gve_rx_check_scatter() and call it from
gve_dev_start() as well as gve_dev_mtu_set(), so starting such a
configuration fails with an error log instead.

Fixes: cffdca824388 ("net/gve: refuse an MTU that needs Rx scatter when it is off")
Cc: stable@dpdk.org

Reported-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Ryan Wolfe <rnwolfe@google.com>
---
Built with -Dwerror=true (gcc and clang); not yet run on gVNIC.

 drivers/net/gve/gve_ethdev.c | 53 ++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index 7506c46d9a..269950fde0 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -459,6 +459,32 @@ gve_start_queues(struct rte_eth_dev *dev)
 	return ret;
 }
 
+/* GQI chains a frame larger than one Rx buffer into a multi-segment
+ * mbuf. No Rx offload is per-queue here, so check the port offloads.
+ */
+static int
+gve_rx_check_scatter(struct rte_eth_dev *dev, uint16_t mtu)
+{
+	struct gve_priv *priv = dev->data->dev_private;
+	uint16_t i;
+
+	if (!gve_is_gqi(priv) ||
+	    (dev->data->dev_conf.rxmode.offloads & RTE_ETH_RX_OFFLOAD_SCATTER))
+		return 0;
+
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		struct gve_rx_queue *rxq = dev->data->rx_queues[i];
+
+		if (rxq != NULL && gve_rx_gqi_needs_scatter(mtu, rxq->rx_buf_len)) {
+			PMD_DRV_LOG(ERR, "MTU %u needs Rx scatter with %u byte Rx buffers",
+				    mtu, rxq->rx_buf_len);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static int
 gve_dev_start(struct rte_eth_dev *dev)
 {
@@ -471,6 +497,13 @@ gve_dev_start(struct rte_eth_dev *dev)
 		return -EPERM;
 	}
 
+	/* rte_eth_dev_configure() sets the MTU and the Rx offloads without
+	 * calling mtu_set, and keeps Rx queues already set up, so check again.
+	 */
+	ret = gve_rx_check_scatter(dev, dev->data->mtu);
+	if (ret != 0)
+		return ret;
+
 	ret = gve_start_queues(dev);
 	if (ret != 0) {
 		PMD_DRV_LOG(ERR, "Failed to start queues");
@@ -1031,23 +1064,9 @@ gve_dev_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
 		return -EBUSY;
 	}
 
-	/* GQI chains a frame larger than one Rx buffer into a multi-segment
-	 * mbuf. No Rx offload is per-queue here, so check the port offloads.
-	 */
-	if (gve_is_gqi(priv) &&
-	    !(dev->data->dev_conf.rxmode.offloads & RTE_ETH_RX_OFFLOAD_SCATTER)) {
-		for (uint16_t i = 0; i < dev->data->nb_rx_queues; i++) {
-			struct gve_rx_queue *rxq = dev->data->rx_queues[i];
-
-			if (rxq != NULL &&
-			    gve_rx_gqi_needs_scatter(mtu, rxq->rx_buf_len)) {
-				PMD_DRV_LOG(ERR,
-					    "MTU %u needs Rx scatter with %u byte Rx buffers",
-					    mtu, rxq->rx_buf_len);
-				return -EINVAL;
-			}
-		}
-	}
+	err = gve_rx_check_scatter(dev, mtu);
+	if (err != 0)
+		return err;
 
 	err = process_priv->ctrl_ops->set_mtu(priv, mtu);
 	if (err) {
-- 
2.56.0.218.g1ec904b173-goog

