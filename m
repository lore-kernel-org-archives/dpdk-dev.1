Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB16FCCFA1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 09:11:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44BCE4066C;
	Wed, 12 Nov 2025 10:11:24 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 88BFD40670
 for <dev@dpdk.org>; Wed, 12 Nov 2025 10:11:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762938683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5ZZld0TQTFI3OtCadsfAeeG8tXIihhB6BY55tn/CGLo=;
 b=ZMmGKTc8uZuN2fbU4kvwrioa2SHmSi7I/kVIP91v1W0NUWl6H0FKGnPJ4oKZcJs6+mIBpA
 u8oMjSVWSsKVwp/cmX9sXWWuEyaG6lTiuAx5YtWLx/ssL/rcva1V8jxbLdqkxGXC8FQ53q
 WHHV9GXUII4pWhB1e74BcVUPEJ6svmY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-_HvOkjMCPyS5xeFav2HDGg-1; Wed,
 12 Nov 2025 04:11:19 -0500
X-MC-Unique: _HvOkjMCPyS5xeFav2HDGg-1
X-Mimecast-MFC-AGG-ID: _HvOkjMCPyS5xeFav2HDGg_1762938678
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF159195608A; Wed, 12 Nov 2025 09:11:18 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.34.108])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B928D196FC8B; Wed, 12 Nov 2025 09:11:16 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, maxime@leroys.fr,
 Sachin Saxena <sachin.saxena@nxp.com>, Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v2 3/5] net/dpaa2: remove dead code in loopback mode
Date: Wed, 12 Nov 2025 10:10:46 +0100
Message-ID: <20251112091049.2669481-4-david.marchand@redhat.com>
In-Reply-To: <20251112091049.2669481-1-david.marchand@redhat.com>
References: <20251108153207.1512863-1-david.marchand@redhat.com>
 <20251112091049.2669481-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4Lks1xMLXQcee0aGyqzfKQ6XJyYPtQ_XoUENdTLGqRI_1762938678
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

