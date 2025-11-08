Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FEDCCFA18
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Nov 2025 15:32:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A8E1402F1;
	Sat,  8 Nov 2025 16:32:34 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id ADD01402EE
 for <dev@dpdk.org>; Sat,  8 Nov 2025 16:32:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762615952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5ZZld0TQTFI3OtCadsfAeeG8tXIihhB6BY55tn/CGLo=;
 b=M0yFl6f8sNefkosYJQtbYvYKa27FynmYcDtSLVQMDnBamTLgdXUY6ze6+zE5siqZO6Qv3q
 WLRJ2bSRWtLGQMFH/e1Ig0rXSojafRZw8saY5QS9cttXW7C+9Icr1Zhyn2GmN8EBM68BC4
 oKuJij5QqhSVUlbwc/+kKoBTZ1fCpSc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-4-w48hLNPRape507LPezmQ-1; Sat,
 08 Nov 2025 10:32:28 -0500
X-MC-Unique: 4-w48hLNPRape507LPezmQ-1
X-Mimecast-MFC-AGG-ID: 4-w48hLNPRape507LPezmQ_1762615947
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9BB0E195606B; Sat,  8 Nov 2025 15:32:27 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.16])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A96431800873; Sat,  8 Nov 2025 15:32:25 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, maxime@leroys.fr,
 Sachin Saxena <sachin.saxena@nxp.com>, Jun Yang <jun.yang@nxp.com>
Subject: [PATCH 3/5] net/dpaa2: remove dead code in loopback mode
Date: Sat,  8 Nov 2025 16:32:04 +0100
Message-ID: <20251108153207.1512863-4-david.marchand@redhat.com>
In-Reply-To: <20251108153207.1512863-1-david.marchand@redhat.com>
References: <20251108153207.1512863-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YJ9gkuN3CA5iID_TimGOTpL0hdZaB7wRK0bcLRWkL80_1762615947
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

This code was never used.

Fixes: f023d059769f ("net/dpaa2: support recycle loopback port")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.h  |  6 ----
 drivers/net/dpaa2/dpaa2_recycle.c | 50 -------------------------------
 2 files changed, 56 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index 87a94bc15b..86b3022ddb 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -531,12 +531,6 @@ int dpaa2_dev_recycle_config(struct rte_eth_dev *eth_dev);
 int dpaa2_dev_recycle_deconfig(struct rte_eth_dev *eth_dev);
 int dpaa2_soft_parser_loaded(void);
 
-int dpaa2_dev_recycle_qp_setup(struct rte_dpaa2_device *dpaa2_dev,
-	uint16_t qidx, uint64_t cntx,
-	eth_rx_burst_t tx_lpbk, eth_tx_burst_t rx_lpbk,
-	struct dpaa2_queue **txq,
-	struct dpaa2_queue **rxq);
-
 void
 dpaa2_dev_mac_setup_stats(struct rte_eth_dev *dev);
 
diff --git a/drivers/net/dpaa2/dpaa2_recycle.c b/drivers/net/dpaa2/dpaa2_recycle.c
index 94a7e2a020..d1e21dd4d1 100644
--- a/drivers/net/dpaa2/dpaa2_recycle.c
+++ b/drivers/net/dpaa2/dpaa2_recycle.c
@@ -730,53 +730,3 @@ dpaa2_dev_recycle_deconfig(struct rte_eth_dev *eth_dev)
 
 	return ret;
 }
-
-int
-dpaa2_dev_recycle_qp_setup(struct rte_dpaa2_device *dpaa2_dev,
-	uint16_t qidx, uint64_t cntx,
-	eth_rx_burst_t tx_lpbk, eth_tx_burst_t rx_lpbk,
-	struct dpaa2_queue **txq,
-	struct dpaa2_queue **rxq)
-{
-	struct rte_eth_dev *dev;
-	struct rte_eth_dev_data *data;
-	struct dpaa2_queue *txq_tmp;
-	struct dpaa2_queue *rxq_tmp;
-	struct dpaa2_dev_priv *priv;
-
-	dev = dpaa2_dev->eth_dev;
-	data = dev->data;
-	priv = data->dev_private;
-
-	if (!(priv->flags & DPAA2_TX_LOOPBACK_MODE) &&
-		(tx_lpbk || rx_lpbk)) {
-		DPAA2_PMD_ERR("%s is NOT recycle device!", data->name);
-
-		return -EINVAL;
-	}
-
-	if (qidx >= data->nb_rx_queues || qidx >= data->nb_tx_queues)
-		return -EINVAL;
-
-	rte_spinlock_lock(&priv->lpbk_qp_lock);
-
-	if (tx_lpbk)
-		dev->tx_pkt_burst = tx_lpbk;
-
-	if (rx_lpbk)
-		dev->rx_pkt_burst = rx_lpbk;
-
-	txq_tmp = data->tx_queues[qidx];
-	txq_tmp->lpbk_cntx = cntx;
-	rxq_tmp = data->rx_queues[qidx];
-	rxq_tmp->lpbk_cntx = cntx;
-
-	if (txq)
-		*txq = txq_tmp;
-	if (rxq)
-		*rxq = rxq_tmp;
-
-	rte_spinlock_unlock(&priv->lpbk_qp_lock);
-
-	return 0;
-}
-- 
2.51.0

