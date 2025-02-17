Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05C6C021AA
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Feb 2025 18:58:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6847402CB;
	Mon, 17 Feb 2025 19:57:57 +0100 (CET)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id C0CC5400EF
 for <dev@dpdk.org>; Mon, 17 Feb 2025 19:57:55 +0100 (CET)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-220bff984a0so82385035ad.3
 for <dev@dpdk.org>; Mon, 17 Feb 2025 10:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739818675;
 x=1740423475; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7qI5oT8haAeNGb+/XLE2k+8nToLa/jR39UcN7uD/Gy8=;
 b=dFwINA1aCylfaMwZTp7hwL6E6cG/gXvf10rLMuL45sG6D+mpwPLYvrC7bLCPlLLs/s
 fIrfc7pbQbTjwProJNDNVezldP4RY7Sz7aPWmrrmytxvVYIOCBJyEe65H2y0PJd57MJf
 nswr70ULG+VG4G0lw7x0PDQ6o//O1WYMid2FbIxp2nHF0ZWgMyLswsvRr2GrDAWhqsY6
 ivTmakmPaUVdz+zrPvOnBKUlE/DtAENOJp0/5oyWnRcvaJipfUoLg+39uVQEDfeMsmVK
 3xmAOnINPyfhdicRMwGKM1x1RCR9tbBigUPI+LVTd42MU4Uv4qSma9779flwScgYnO8y
 PQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739818675; x=1740423475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7qI5oT8haAeNGb+/XLE2k+8nToLa/jR39UcN7uD/Gy8=;
 b=kT1b5YICkB+UBT4NmTYf1YoBnjgQ0NdOsqLIrhY4xOtPeJ7YHbMs6CqY8ia5Pw23gI
 wmPuK5Yy5rt/pZApAQJrXqPnnfTfMXTqmDmAz3hmQ41qzMUEIjibNd8esMCIeJtWLeNw
 AIKH46xIgob9FO1Y+A2YbfUrN+kZkkAyv5qpjcQ5bQVyPIhpgzH4/m1Ti1n76JPOJMBb
 MT1dNcnK2EJAeoiAzFd8ebqh3l/x9EzpXIQj/xcVWth9ibqRtVqpVhLJXF3u90i0rqQs
 7mhQJQut2Jz3ND0iUKMK4zj87qwsg/qeZKhZtxz1CjBBmE/F888oSMl1MLUm7cha3ZNR
 p1LA==
X-Gm-Message-State: AOJu0YzeBW+9TNO8+fM1oct2cdUP5adwb3rPeXbe2YdUoMk2E4c7SkSc
 68ZBkXRIkJ/5mnzuLLS1GQe72UpLuQxhpz0FHhNYaiiqNgFAuBoc3G/vf9H4k6UJK/qS1KePQHn
 1PtQ=
X-Gm-Gg: ASbGncvm7BqlSCUdr5c2zOpMZdeDDXdODc3hMhC9ehbcjqFhrTIsLi1vstkYnRn2ICs
 yBPNiekGNfbiZhUj2/KYJZ63/1xGW9AXuJ/b6c6kxwq3pzOe+yRRaiMw3GLlVGCcNtWy3B8htoJ
 9VYWtFwstvHUZVjZSeFbR5yN0R7iFP/u5ovD403WVuJU7XwMHY+oQ8oYkpm48wq/pTW/3n/2Wpb
 SCpTQEJZJ7IpIL+pFygXzWWwJF00h4T1/iQlBYlkcpgbpdCz3StAH1nXOysxf4hevx0tsAA79ZK
 Im+RbY1wn46n/ZUOdXzpKzQn09dAWJIEc5S9lnYY+MAbmuaCNEgfiD4VSNxJffSmNUEH
X-Google-Smtp-Source: AGHT+IHajSxJYcbgO0WGdfwupj0I5Nli8RMT5tdQI9y2pljlWgzdi9skn/7/PI9nT1J19Ha78Fi58A==
X-Received: by 2002:a05:6a21:78a6:b0:1db:eb82:b22f with SMTP id
 adf61e73a8af0-1ee8cb1dde5mr17010179637.5.1739818674394; 
 Mon, 17 Feb 2025 10:57:54 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adb57c5dc68sm7815149a12.9.2025.02.17.10.57.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 10:57:53 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 01/11] ethdev: remove unnecessary deref on function pointers
Date: Mon, 17 Feb 2025 10:54:00 -0800
Message-ID: <20250217185743.169778-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250217185743.169778-1-stephen@networkplumber.org>
References: <20250217185743.169778-1-stephen@networkplumber.org>
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

The expression *dev->dev_ops->rx_queue_start and
dev->dev_ops->rx_queue_start are equivalent.
Remove the unnecessary asterisk and parenthesis.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ethdev/ethdev_driver.c   |  16 +-
 lib/ethdev/ethdev_private.c  |   4 +-
 lib/ethdev/rte_ethdev.c      | 489 ++++++++++++++++-------------------
 lib/ethdev/rte_ethdev_cman.c |   8 +-
 4 files changed, 241 insertions(+), 276 deletions(-)

diff --git a/lib/ethdev/ethdev_driver.c b/lib/ethdev/ethdev_driver.c
index 13d328d97b..e1976db05f 100644
--- a/lib/ethdev/ethdev_driver.c
+++ b/lib/ethdev/ethdev_driver.c
@@ -749,11 +749,10 @@ rte_eth_hairpin_queue_peer_bind(uint16_t cur_port, uint16_t cur_queue,
 
 	/* No need to check the validity again. */
 	dev = &rte_eth_devices[cur_port];
-	if (*dev->dev_ops->hairpin_queue_peer_bind == NULL)
+	if (dev->dev_ops->hairpin_queue_peer_bind == NULL)
 		return -ENOTSUP;
 
-	return (*dev->dev_ops->hairpin_queue_peer_bind)(dev, cur_queue,
-							peer_info, direction);
+	return dev->dev_ops->hairpin_queue_peer_bind(dev, cur_queue, peer_info, direction);
 }
 
 int
@@ -764,11 +763,10 @@ rte_eth_hairpin_queue_peer_unbind(uint16_t cur_port, uint16_t cur_queue,
 
 	/* No need to check the validity again. */
 	dev = &rte_eth_devices[cur_port];
-	if (*dev->dev_ops->hairpin_queue_peer_unbind == NULL)
+	if (dev->dev_ops->hairpin_queue_peer_unbind == NULL)
 		return -ENOTSUP;
 
-	return (*dev->dev_ops->hairpin_queue_peer_unbind)(dev, cur_queue,
-							  direction);
+	return dev->dev_ops->hairpin_queue_peer_unbind(dev, cur_queue, direction);
 }
 
 int
@@ -785,11 +783,11 @@ rte_eth_hairpin_queue_peer_update(uint16_t peer_port, uint16_t peer_queue,
 
 	/* No need to check the validity again. */
 	dev = &rte_eth_devices[peer_port];
-	if (*dev->dev_ops->hairpin_queue_peer_update == NULL)
+	if (dev->dev_ops->hairpin_queue_peer_update == NULL)
 		return -ENOTSUP;
 
-	return (*dev->dev_ops->hairpin_queue_peer_update)(dev, peer_queue,
-					cur_info, peer_info, direction);
+	return dev->dev_ops->hairpin_queue_peer_update(dev, peer_queue,
+						       cur_info, peer_info, direction);
 }
 
 int
diff --git a/lib/ethdev/ethdev_private.c b/lib/ethdev/ethdev_private.c
index eed8c78747..cc7fd97d4a 100644
--- a/lib/ethdev/ethdev_private.c
+++ b/lib/ethdev/ethdev_private.c
@@ -398,7 +398,7 @@ eth_dev_rxq_release(struct rte_eth_dev *dev, uint16_t qid)
 		return;
 
 	if (dev->dev_ops->rx_queue_release != NULL)
-		(*dev->dev_ops->rx_queue_release)(dev, qid);
+		dev->dev_ops->rx_queue_release(dev, qid);
 	rxq[qid] = NULL;
 }
 
@@ -411,7 +411,7 @@ eth_dev_txq_release(struct rte_eth_dev *dev, uint16_t qid)
 		return;
 
 	if (dev->dev_ops->tx_queue_release != NULL)
-		(*dev->dev_ops->tx_queue_release)(dev, qid);
+		dev->dev_ops->tx_queue_release(dev, qid);
 	txq[qid] = NULL;
 }
 
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index c4079bb924..ed9b7dba55 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -859,7 +859,7 @@ rte_eth_dev_rx_queue_start(uint16_t port_id, uint16_t rx_queue_id)
 	if (ret != 0)
 		return ret;
 
-	if (*dev->dev_ops->rx_queue_start == NULL)
+	if (dev->dev_ops->rx_queue_start == NULL)
 		return -ENOTSUP;
 
 	if (rte_eth_dev_is_rx_hairpin_queue(dev, rx_queue_id)) {
@@ -896,7 +896,7 @@ rte_eth_dev_rx_queue_stop(uint16_t port_id, uint16_t rx_queue_id)
 	if (ret != 0)
 		return ret;
 
-	if (*dev->dev_ops->rx_queue_stop == NULL)
+	if (dev->dev_ops->rx_queue_stop == NULL)
 		return -ENOTSUP;
 
 	if (rte_eth_dev_is_rx_hairpin_queue(dev, rx_queue_id)) {
@@ -940,7 +940,7 @@ rte_eth_dev_tx_queue_start(uint16_t port_id, uint16_t tx_queue_id)
 	if (ret != 0)
 		return ret;
 
-	if (*dev->dev_ops->tx_queue_start == NULL)
+	if (dev->dev_ops->tx_queue_start == NULL)
 		return -ENOTSUP;
 
 	if (rte_eth_dev_is_tx_hairpin_queue(dev, tx_queue_id)) {
@@ -977,7 +977,7 @@ rte_eth_dev_tx_queue_stop(uint16_t port_id, uint16_t tx_queue_id)
 	if (ret != 0)
 		return ret;
 
-	if (*dev->dev_ops->tx_queue_stop == NULL)
+	if (dev->dev_ops->tx_queue_stop == NULL)
 		return -ENOTSUP;
 
 	if (rte_eth_dev_is_tx_hairpin_queue(dev, tx_queue_id)) {
@@ -1308,7 +1308,7 @@ rte_eth_dev_configure(uint16_t port_id, uint16_t nb_rx_q, uint16_t nb_tx_q,
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->dev_configure == NULL)
+	if (dev->dev_ops->dev_configure == NULL)
 		return -ENOTSUP;
 
 	if (dev->data->dev_started) {
@@ -1567,7 +1567,7 @@ rte_eth_dev_configure(uint16_t port_id, uint16_t nb_rx_q, uint16_t nb_tx_q,
 		goto rollback;
 	}
 
-	diag = (*dev->dev_ops->dev_configure)(dev);
+	diag = dev->dev_ops->dev_configure(dev);
 	if (diag != 0) {
 		RTE_ETHDEV_LOG_LINE(ERR, "Port%u dev_configure = %d",
 			port_id, diag);
@@ -1630,12 +1630,12 @@ eth_dev_mac_restore(struct rte_eth_dev *dev,
 
 	/* replay MAC address configuration including default MAC */
 	addr = &dev->data->mac_addrs[0];
-	if (*dev->dev_ops->mac_addr_set != NULL)
-		(*dev->dev_ops->mac_addr_set)(dev, addr);
-	else if (*dev->dev_ops->mac_addr_add != NULL)
-		(*dev->dev_ops->mac_addr_add)(dev, addr, 0, pool);
+	if (dev->dev_ops->mac_addr_set != NULL)
+		dev->dev_ops->mac_addr_set(dev, addr);
+	else if (dev->dev_ops->mac_addr_add != NULL)
+		dev->dev_ops->mac_addr_add(dev, addr, 0, pool);
 
-	if (*dev->dev_ops->mac_addr_add != NULL) {
+	if (dev->dev_ops->mac_addr_add != NULL) {
 		for (i = 1; i < dev_info->max_mac_addrs; i++) {
 			addr = &dev->data->mac_addrs[i];
 
@@ -1648,8 +1648,7 @@ eth_dev_mac_restore(struct rte_eth_dev *dev,
 
 			do {
 				if (pool_mask & UINT64_C(1))
-					(*dev->dev_ops->mac_addr_add)(dev,
-						addr, i, pool);
+					dev->dev_ops->mac_addr_add(dev, addr, i, pool);
 				pool_mask >>= 1;
 				pool++;
 			} while (pool_mask);
@@ -1668,9 +1667,8 @@ eth_dev_promiscuous_restore(struct rte_eth_dev *dev, uint16_t port_id)
 	 * would like to bypass the same value set
 	 */
 	if (rte_eth_promiscuous_get(port_id) == 1 &&
-	    *dev->dev_ops->promiscuous_enable != NULL) {
-		ret = eth_err(port_id,
-			      (*dev->dev_ops->promiscuous_enable)(dev));
+	    dev->dev_ops->promiscuous_enable != NULL) {
+		ret = eth_err(port_id, dev->dev_ops->promiscuous_enable(dev));
 		if (ret != 0 && ret != -ENOTSUP) {
 			RTE_ETHDEV_LOG_LINE(ERR,
 				"Failed to enable promiscuous mode for device (port %u): %s",
@@ -1678,9 +1676,8 @@ eth_dev_promiscuous_restore(struct rte_eth_dev *dev, uint16_t port_id)
 			return ret;
 		}
 	} else if (rte_eth_promiscuous_get(port_id) == 0 &&
-		   *dev->dev_ops->promiscuous_disable != NULL) {
-		ret = eth_err(port_id,
-			      (*dev->dev_ops->promiscuous_disable)(dev));
+		   dev->dev_ops->promiscuous_disable != NULL) {
+		ret = eth_err(port_id, dev->dev_ops->promiscuous_disable(dev));
 		if (ret != 0 && ret != -ENOTSUP) {
 			RTE_ETHDEV_LOG_LINE(ERR,
 				"Failed to disable promiscuous mode for device (port %u): %s",
@@ -1703,9 +1700,8 @@ eth_dev_allmulticast_restore(struct rte_eth_dev *dev, uint16_t port_id)
 	 * would like to bypass the same value set
 	 */
 	if (rte_eth_allmulticast_get(port_id) == 1 &&
-	    *dev->dev_ops->allmulticast_enable != NULL) {
-		ret = eth_err(port_id,
-			      (*dev->dev_ops->allmulticast_enable)(dev));
+	    dev->dev_ops->allmulticast_enable != NULL) {
+		ret = eth_err(port_id, dev->dev_ops->allmulticast_enable(dev));
 		if (ret != 0 && ret != -ENOTSUP) {
 			RTE_ETHDEV_LOG_LINE(ERR,
 				"Failed to enable allmulticast mode for device (port %u): %s",
@@ -1713,9 +1709,8 @@ eth_dev_allmulticast_restore(struct rte_eth_dev *dev, uint16_t port_id)
 			return ret;
 		}
 	} else if (rte_eth_allmulticast_get(port_id) == 0 &&
-		   *dev->dev_ops->allmulticast_disable != NULL) {
-		ret = eth_err(port_id,
-			      (*dev->dev_ops->allmulticast_disable)(dev));
+		   dev->dev_ops->allmulticast_disable != NULL) {
+		ret = eth_err(port_id, dev->dev_ops->allmulticast_disable(dev));
 		if (ret != 0 && ret != -ENOTSUP) {
 			RTE_ETHDEV_LOG_LINE(ERR,
 				"Failed to disable allmulticast mode for device (port %u): %s",
@@ -1766,7 +1761,7 @@ rte_eth_dev_start(uint16_t port_id)
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
 	dev = &rte_eth_devices[port_id];
 
-	if (*dev->dev_ops->dev_start == NULL)
+	if (dev->dev_ops->dev_start == NULL)
 		return -ENOTSUP;
 
 	if (dev->data->dev_configured == 0) {
@@ -1794,7 +1789,7 @@ rte_eth_dev_start(uint16_t port_id)
 	    (restore_flags & RTE_ETH_RESTORE_MAC_ADDR))
 		eth_dev_mac_restore(dev, &dev_info);
 
-	diag = (*dev->dev_ops->dev_start)(dev);
+	diag = dev->dev_ops->dev_start(dev);
 	if (diag == 0)
 		dev->data->dev_started = 1;
 	else
@@ -1816,9 +1811,9 @@ rte_eth_dev_start(uint16_t port_id)
 	}
 
 	if (dev->data->dev_conf.intr_conf.lsc == 0) {
-		if (*dev->dev_ops->link_update == NULL)
+		if (dev->dev_ops->link_update == NULL)
 			return -ENOTSUP;
-		(*dev->dev_ops->link_update)(dev, 0);
+		dev->dev_ops->link_update(dev, 0);
 	}
 
 	/* expose selection of PMD fast-path functions */
@@ -1837,7 +1832,7 @@ rte_eth_dev_stop(uint16_t port_id)
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
 	dev = &rte_eth_devices[port_id];
 
-	if (*dev->dev_ops->dev_stop == NULL)
+	if (dev->dev_ops->dev_stop == NULL)
 		return -ENOTSUP;
 
 	if (dev->data->dev_started == 0) {
@@ -1850,7 +1845,7 @@ rte_eth_dev_stop(uint16_t port_id)
 	/* point fast-path functions to dummy ones */
 	eth_dev_fp_ops_reset(rte_eth_fp_ops + port_id);
 
-	ret = (*dev->dev_ops->dev_stop)(dev);
+	ret = dev->dev_ops->dev_stop(dev);
 	if (ret == 0)
 		dev->data->dev_started = 0;
 	rte_ethdev_trace_stop(port_id, ret);
@@ -1867,9 +1862,9 @@ rte_eth_dev_set_link_up(uint16_t port_id)
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
 	dev = &rte_eth_devices[port_id];
 
-	if (*dev->dev_ops->dev_set_link_up == NULL)
+	if (dev->dev_ops->dev_set_link_up == NULL)
 		return -ENOTSUP;
-	ret = eth_err(port_id, (*dev->dev_ops->dev_set_link_up)(dev));
+	ret = eth_err(port_id, dev->dev_ops->dev_set_link_up(dev));
 
 	rte_ethdev_trace_set_link_up(port_id, ret);
 
@@ -1885,9 +1880,9 @@ rte_eth_dev_set_link_down(uint16_t port_id)
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
 	dev = &rte_eth_devices[port_id];
 
-	if (*dev->dev_ops->dev_set_link_down == NULL)
+	if (dev->dev_ops->dev_set_link_down == NULL)
 		return -ENOTSUP;
-	ret = eth_err(port_id, (*dev->dev_ops->dev_set_link_down)(dev));
+	ret = eth_err(port_id, dev->dev_ops->dev_set_link_down(dev));
 
 	rte_ethdev_trace_set_link_down(port_id, ret);
 
@@ -1902,9 +1897,9 @@ rte_eth_speed_lanes_get(uint16_t port_id, uint32_t *lane)
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
 	dev = &rte_eth_devices[port_id];
 
-	if (*dev->dev_ops->speed_lanes_get == NULL)
+	if (dev->dev_ops->speed_lanes_get == NULL)
 		return -ENOTSUP;
-	return eth_err(port_id, (*dev->dev_ops->speed_lanes_get)(dev, lane));
+	return eth_err(port_id, dev->dev_ops->speed_lanes_get(dev, lane));
 }
 
 int
@@ -1918,7 +1913,7 @@ rte_eth_speed_lanes_get_capability(uint16_t port_id,
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
 	dev = &rte_eth_devices[port_id];
 
-	if (*dev->dev_ops->speed_lanes_get_capa == NULL)
+	if (dev->dev_ops->speed_lanes_get_capa == NULL)
 		return -ENOTSUP;
 
 	if (speed_lanes_capa == NULL && num > 0) {
@@ -1928,7 +1923,7 @@ rte_eth_speed_lanes_get_capability(uint16_t port_id,
 		return -EINVAL;
 	}
 
-	ret = (*dev->dev_ops->speed_lanes_get_capa)(dev, speed_lanes_capa, num);
+	ret = dev->dev_ops->speed_lanes_get_capa(dev, speed_lanes_capa, num);
 
 	return ret;
 }
@@ -1941,9 +1936,9 @@ rte_eth_speed_lanes_set(uint16_t port_id, uint32_t speed_lanes_capa)
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
 	dev = &rte_eth_devices[port_id];
 
-	if (*dev->dev_ops->speed_lanes_set == NULL)
+	if (dev->dev_ops->speed_lanes_set == NULL)
 		return -ENOTSUP;
-	return eth_err(port_id, (*dev->dev_ops->speed_lanes_set)(dev, speed_lanes_capa));
+	return eth_err(port_id, dev->dev_ops->speed_lanes_set(dev, speed_lanes_capa));
 }
 
 int
@@ -1968,9 +1963,9 @@ rte_eth_dev_close(uint16_t port_id)
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->dev_close == NULL)
+	if (dev->dev_ops->dev_close == NULL)
 		return -ENOTSUP;
-	*lasterr = (*dev->dev_ops->dev_close)(dev);
+	*lasterr = dev->dev_ops->dev_close(dev);
 	if (*lasterr != 0)
 		lasterr = &binerr;
 
@@ -1989,7 +1984,7 @@ rte_eth_dev_reset(uint16_t port_id)
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
 	dev = &rte_eth_devices[port_id];
 
-	if (*dev->dev_ops->dev_reset == NULL)
+	if (dev->dev_ops->dev_reset == NULL)
 		return -ENOTSUP;
 
 	ret = rte_eth_dev_stop(port_id);
@@ -2017,7 +2012,7 @@ rte_eth_dev_is_removed(uint16_t port_id)
 	if (dev->state == RTE_ETH_DEV_REMOVED)
 		return 1;
 
-	if (*dev->dev_ops->is_removed == NULL)
+	if (dev->dev_ops->is_removed == NULL)
 		return 0;
 
 	ret = dev->dev_ops->is_removed(dev);
@@ -2254,7 +2249,7 @@ rte_eth_rx_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->rx_queue_setup == NULL)
+	if (dev->dev_ops->rx_queue_setup == NULL)
 		return -ENOTSUP;
 
 	if (rx_conf != NULL &&
@@ -2436,8 +2431,7 @@ rte_eth_rx_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
 			return ret;
 	}
 
-	ret = (*dev->dev_ops->rx_queue_setup)(dev, rx_queue_id, nb_rx_desc,
-					      socket_id, &local_conf, mp);
+	ret = dev->dev_ops->rx_queue_setup(dev, rx_queue_id, nb_rx_desc, socket_id, &local_conf, mp);
 	if (!ret) {
 		if (!dev->data->min_rx_buf_size ||
 		    dev->data->min_rx_buf_size > mbp_buf_size)
@@ -2484,7 +2478,7 @@ rte_eth_rx_hairpin_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
 	ret = rte_eth_dev_hairpin_capability_get(port_id, &cap);
 	if (ret != 0)
 		return ret;
-	if (*dev->dev_ops->rx_hairpin_queue_setup == NULL)
+	if (dev->dev_ops->rx_hairpin_queue_setup == NULL)
 		return -ENOTSUP;
 	/* if nb_rx_desc is zero use max number of desc from the driver. */
 	if (nb_rx_desc == 0)
@@ -2542,8 +2536,7 @@ rte_eth_rx_hairpin_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
 	if (dev->data->dev_started)
 		return -EBUSY;
 	eth_dev_rxq_release(dev, rx_queue_id);
-	ret = (*dev->dev_ops->rx_hairpin_queue_setup)(dev, rx_queue_id,
-						      nb_rx_desc, conf);
+	ret = dev->dev_ops->rx_hairpin_queue_setup(dev, rx_queue_id, nb_rx_desc, conf);
 	if (ret == 0)
 		dev->data->rx_queue_state[rx_queue_id] =
 			RTE_ETH_QUEUE_STATE_HAIRPIN;
@@ -2573,7 +2566,7 @@ rte_eth_tx_queue_setup(uint16_t port_id, uint16_t tx_queue_id,
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->tx_queue_setup == NULL)
+	if (dev->dev_ops->tx_queue_setup == NULL)
 		return -ENOTSUP;
 
 	if (tx_conf != NULL &&
@@ -2654,7 +2647,7 @@ rte_eth_tx_queue_setup(uint16_t port_id, uint16_t tx_queue_id,
 	}
 
 	rte_ethdev_trace_txq_setup(port_id, tx_queue_id, nb_tx_desc, tx_conf);
-	return eth_err(port_id, (*dev->dev_ops->tx_queue_setup)(dev,
+	return eth_err(port_id, dev->dev_ops->tx_queue_setup(dev,
 		       tx_queue_id, nb_tx_desc, socket_id, &local_conf));
 }
 
@@ -2687,7 +2680,7 @@ rte_eth_tx_hairpin_queue_setup(uint16_t port_id, uint16_t tx_queue_id,
 	ret = rte_eth_dev_hairpin_capability_get(port_id, &cap);
 	if (ret != 0)
 		return ret;
-	if (*dev->dev_ops->tx_hairpin_queue_setup == NULL)
+	if (dev->dev_ops->tx_hairpin_queue_setup == NULL)
 		return -ENOTSUP;
 	/* if nb_rx_desc is zero use max number of desc from the driver. */
 	if (nb_tx_desc == 0)
@@ -2745,8 +2738,7 @@ rte_eth_tx_hairpin_queue_setup(uint16_t port_id, uint16_t tx_queue_id,
 	if (dev->data->dev_started)
 		return -EBUSY;
 	eth_dev_txq_release(dev, tx_queue_id);
-	ret = (*dev->dev_ops->tx_hairpin_queue_setup)
-		(dev, tx_queue_id, nb_tx_desc, conf);
+	ret = dev->dev_ops->tx_hairpin_queue_setup(dev, tx_queue_id, nb_tx_desc, conf);
 	if (ret == 0)
 		dev->data->tx_queue_state[tx_queue_id] =
 			RTE_ETH_QUEUE_STATE_HAIRPIN;
@@ -2772,9 +2764,9 @@ rte_eth_hairpin_bind(uint16_t tx_port, uint16_t rx_port)
 		return -EBUSY;
 	}
 
-	if (*dev->dev_ops->hairpin_bind == NULL)
+	if (dev->dev_ops->hairpin_bind == NULL)
 		return -ENOTSUP;
-	ret = (*dev->dev_ops->hairpin_bind)(dev, rx_port);
+	ret = dev->dev_ops->hairpin_bind(dev, rx_port);
 	if (ret != 0)
 		RTE_ETHDEV_LOG_LINE(ERR, "Failed to bind hairpin Tx %d"
 			       " to Rx %d (%d - all ports)",
@@ -2799,9 +2791,9 @@ rte_eth_hairpin_unbind(uint16_t tx_port, uint16_t rx_port)
 		return -EBUSY;
 	}
 
-	if (*dev->dev_ops->hairpin_unbind == NULL)
+	if (dev->dev_ops->hairpin_unbind == NULL)
 		return -ENOTSUP;
-	ret = (*dev->dev_ops->hairpin_unbind)(dev, rx_port);
+	ret = dev->dev_ops->hairpin_unbind(dev, rx_port);
 	if (ret != 0)
 		RTE_ETHDEV_LOG_LINE(ERR, "Failed to unbind hairpin Tx %d"
 			       " from Rx %d (%d - all ports)",
@@ -2836,11 +2828,10 @@ rte_eth_hairpin_get_peer_ports(uint16_t port_id, uint16_t *peer_ports,
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->hairpin_get_peer_ports == NULL)
+	if (dev->dev_ops->hairpin_get_peer_ports == NULL)
 		return -ENOTSUP;
 
-	ret = (*dev->dev_ops->hairpin_get_peer_ports)(dev, peer_ports,
-						      len, direction);
+	ret = dev->dev_ops->hairpin_get_peer_ports(dev, peer_ports, len, direction);
 	if (ret < 0)
 		RTE_ETHDEV_LOG_LINE(ERR, "Failed to get %d hairpin peer %s ports",
 			       port_id, direction ? "Rx" : "Tx");
@@ -2926,12 +2917,11 @@ rte_eth_tx_done_cleanup(uint16_t port_id, uint16_t queue_id, uint32_t free_cnt)
 		return ret;
 #endif
 
-	if (*dev->dev_ops->tx_done_cleanup == NULL)
+	if (dev->dev_ops->tx_done_cleanup == NULL)
 		return -ENOTSUP;
 
 	/* Call driver to free pending mbufs. */
-	ret = (*dev->dev_ops->tx_done_cleanup)(dev->data->tx_queues[queue_id],
-					       free_cnt);
+	ret = dev->dev_ops->tx_done_cleanup(dev->data->tx_queues[queue_id], free_cnt);
 	ret = eth_err(port_id, ret);
 
 	rte_eth_trace_tx_done_cleanup(port_id, queue_id, free_cnt, ret);
@@ -2951,10 +2941,10 @@ rte_eth_promiscuous_enable(uint16_t port_id)
 	if (dev->data->promiscuous == 1)
 		return 0;
 
-	if (*dev->dev_ops->promiscuous_enable == NULL)
+	if (dev->dev_ops->promiscuous_enable == NULL)
 		return -ENOTSUP;
 
-	diag = (*dev->dev_ops->promiscuous_enable)(dev);
+	diag = dev->dev_ops->promiscuous_enable(dev);
 	dev->data->promiscuous = (diag == 0) ? 1 : 0;
 
 	diag = eth_err(port_id, diag);
@@ -2977,11 +2967,11 @@ rte_eth_promiscuous_disable(uint16_t port_id)
 	if (dev->data->promiscuous == 0)
 		return 0;
 
-	if (*dev->dev_ops->promiscuous_disable == NULL)
+	if (dev->dev_ops->promiscuous_disable == NULL)
 		return -ENOTSUP;
 
 	dev->data->promiscuous = 0;
-	diag = (*dev->dev_ops->promiscuous_disable)(dev);
+	diag = dev->dev_ops->promiscuous_disable(dev);
 	if (diag != 0)
 		dev->data->promiscuous = 1;
 
@@ -3018,9 +3008,9 @@ rte_eth_allmulticast_enable(uint16_t port_id)
 	if (dev->data->all_multicast == 1)
 		return 0;
 
-	if (*dev->dev_ops->allmulticast_enable == NULL)
+	if (dev->dev_ops->allmulticast_enable == NULL)
 		return -ENOTSUP;
-	diag = (*dev->dev_ops->allmulticast_enable)(dev);
+	diag = dev->dev_ops->allmulticast_enable(dev);
 	dev->data->all_multicast = (diag == 0) ? 1 : 0;
 
 	diag = eth_err(port_id, diag);
@@ -3043,10 +3033,10 @@ rte_eth_allmulticast_disable(uint16_t port_id)
 	if (dev->data->all_multicast == 0)
 		return 0;
 
-	if (*dev->dev_ops->allmulticast_disable == NULL)
+	if (dev->dev_ops->allmulticast_disable == NULL)
 		return -ENOTSUP;
 	dev->data->all_multicast = 0;
-	diag = (*dev->dev_ops->allmulticast_disable)(dev);
+	diag = dev->dev_ops->allmulticast_disable(dev);
 	if (diag != 0)
 		dev->data->all_multicast = 1;
 
@@ -3088,9 +3078,9 @@ rte_eth_link_get(uint16_t port_id, struct rte_eth_link *eth_link)
 	if (dev->data->dev_conf.intr_conf.lsc && dev->data->dev_started)
 		rte_eth_linkstatus_get(dev, eth_link);
 	else {
-		if (*dev->dev_ops->link_update == NULL)
+		if (dev->dev_ops->link_update == NULL)
 			return -ENOTSUP;
-		(*dev->dev_ops->link_update)(dev, 1);
+		dev->dev_ops->link_update(dev, 1);
 		*eth_link = dev->data->dev_link;
 	}
 
@@ -3116,9 +3106,9 @@ rte_eth_link_get_nowait(uint16_t port_id, struct rte_eth_link *eth_link)
 	if (dev->data->dev_conf.intr_conf.lsc && dev->data->dev_started)
 		rte_eth_linkstatus_get(dev, eth_link);
 	else {
-		if (*dev->dev_ops->link_update == NULL)
+		if (dev->dev_ops->link_update == NULL)
 			return -ENOTSUP;
-		(*dev->dev_ops->link_update)(dev, 0);
+		dev->dev_ops->link_update(dev, 0);
 		*eth_link = dev->data->dev_link;
 	}
 
@@ -3243,10 +3233,10 @@ rte_eth_stats_get(uint16_t port_id, struct rte_eth_stats *stats)
 
 	memset(stats, 0, sizeof(*stats));
 
-	if (*dev->dev_ops->stats_get == NULL)
+	if (dev->dev_ops->stats_get == NULL)
 		return -ENOTSUP;
 	stats->rx_nombuf = dev->data->rx_mbuf_alloc_failed;
-	ret = eth_err(port_id, (*dev->dev_ops->stats_get)(dev, stats));
+	ret = eth_err(port_id, dev->dev_ops->stats_get(dev, stats));
 
 	rte_eth_trace_stats_get(port_id, stats, ret);
 
@@ -3262,9 +3252,9 @@ rte_eth_stats_reset(uint16_t port_id)
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
 	dev = &rte_eth_devices[port_id];
 
-	if (*dev->dev_ops->stats_reset == NULL)
+	if (dev->dev_ops->stats_reset == NULL)
 		return -ENOTSUP;
-	ret = (*dev->dev_ops->stats_reset)(dev);
+	ret = dev->dev_ops->stats_reset(dev);
 	if (ret != 0)
 		return eth_err(port_id, ret);
 
@@ -3302,7 +3292,7 @@ eth_dev_get_xstats_count(uint16_t port_id)
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
 	dev = &rte_eth_devices[port_id];
 	if (dev->dev_ops->xstats_get_names != NULL) {
-		count = (*dev->dev_ops->xstats_get_names)(dev, NULL, 0);
+		count = dev->dev_ops->xstats_get_names(dev, NULL, 0);
 		if (count < 0)
 			return eth_err(port_id, count);
 	} else
@@ -3438,8 +3428,7 @@ eth_xstats_get_by_name_by_id(struct rte_eth_dev *dev, const uint64_t *ids,
 		for (i = 0; i < k; i++)
 			ids_copy[i] = ids[n + i] - basic_count;
 
-		rc = (*dev->dev_ops->xstats_get_names_by_id)(dev, ids_copy,
-					xstats_names + m, k);
+		rc = dev->dev_ops->xstats_get_names_by_id(dev, ids_copy, xstats_names + m, k);
 		if (rc < 0)
 			return rc;
 		m += rc;
@@ -3567,7 +3556,7 @@ rte_eth_xstats_get_names(uint16_t port_id,
 		/* If there are any driver-specific xstats, append them
 		 * to end of list.
 		 */
-		cnt_driver_entries = (*dev->dev_ops->xstats_get_names)(
+		cnt_driver_entries = dev->dev_ops->xstats_get_names(
 			dev,
 			xstats_names + cnt_used_entries,
 			size - cnt_used_entries);
@@ -3658,8 +3647,7 @@ eth_xtats_get_by_id(struct rte_eth_dev *dev, const uint64_t *ids,
 		for (i = 0; i < k; i++)
 			ids_copy[i] = ids[n + i] - basic_count;
 
-		rc = (*dev->dev_ops->xstats_get_by_id)(dev, ids_copy,
-					values + m, k);
+		rc = dev->dev_ops->xstats_get_by_id(dev, ids_copy, values + m, k);
 		if (rc < 0)
 			return rc;
 		m += rc;
@@ -3776,7 +3764,7 @@ rte_eth_xstats_get(uint16_t port_id, struct rte_eth_xstat *xstats,
 		/* Retrieve the xstats from the driver at the end of the
 		 * xstats struct.
 		 */
-		xcount = (*dev->dev_ops->xstats_get)(dev,
+		xcount = dev->dev_ops->xstats_get(dev,
 				     (n > count) ? xstats + count : NULL,
 				     (n > count) ? n - count : 0);
 
@@ -3816,7 +3804,7 @@ rte_eth_xstats_reset(uint16_t port_id)
 
 	/* implemented by the driver */
 	if (dev->dev_ops->xstats_reset != NULL) {
-		int ret = eth_err(port_id, (*dev->dev_ops->xstats_reset)(dev));
+		int ret = eth_err(port_id, dev->dev_ops->xstats_reset(dev));
 
 		rte_eth_trace_xstats_reset(port_id, ret);
 
@@ -3844,12 +3832,12 @@ rte_eth_xstats_set_counter(uint16_t port_id, uint64_t id, int on_off)
 		if (rte_eth_xstats_query_state(port_id, id) == 1)
 			return -EEXIST;
 		if (dev->dev_ops->xstats_enable != NULL)
-			return (*dev->dev_ops->xstats_enable)(dev, id - basic_count);
+			return dev->dev_ops->xstats_enable(dev, id - basic_count);
 	} else {
 		if (rte_eth_xstats_query_state(port_id, id) == 0)
 			return 0;
 		if (dev->dev_ops->xstats_disable != NULL)
-			return (*dev->dev_ops->xstats_disable)(dev, id - basic_count);
+			return dev->dev_ops->xstats_disable(dev, id - basic_count);
 	}
 
 	return -ENOTSUP;
@@ -3871,7 +3859,7 @@ rte_eth_xstats_query_state(uint16_t port_id, uint64_t id)
 
 	/* implemented by the driver */
 	if (dev->dev_ops->xstats_query_state != NULL)
-		return (*dev->dev_ops->xstats_query_state)(dev, id - basic_count);
+		return dev->dev_ops->xstats_query_state(dev, id - basic_count);
 
 	return -ENOTSUP;
 }
@@ -3894,9 +3882,9 @@ eth_dev_set_queue_stats_mapping(uint16_t port_id, uint16_t queue_id,
 	if (stat_idx >= RTE_ETHDEV_QUEUE_STAT_CNTRS)
 		return -EINVAL;
 
-	if (*dev->dev_ops->queue_stats_mapping_set == NULL)
+	if (dev->dev_ops->queue_stats_mapping_set == NULL)
 		return -ENOTSUP;
-	return (*dev->dev_ops->queue_stats_mapping_set) (dev, queue_id, stat_idx, is_rx);
+	return dev->dev_ops->queue_stats_mapping_set(dev, queue_id, stat_idx, is_rx);
 }
 
 int
@@ -3947,10 +3935,9 @@ rte_eth_dev_fw_version_get(uint16_t port_id, char *fw_version, size_t fw_size)
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->fw_version_get == NULL)
+	if (dev->dev_ops->fw_version_get == NULL)
 		return -ENOTSUP;
-	ret = eth_err(port_id, (*dev->dev_ops->fw_version_get)(dev,
-							fw_version, fw_size));
+	ret = eth_err(port_id, dev->dev_ops->fw_version_get(dev, fw_version, fw_size));
 
 	rte_ethdev_trace_fw_version_get(port_id, fw_version, fw_size, ret);
 
@@ -3995,9 +3982,9 @@ rte_eth_dev_info_get(uint16_t port_id, struct rte_eth_dev_info *dev_info)
 	dev_info->rss_algo_capa = RTE_ETH_HASH_ALGO_CAPA_MASK(DEFAULT);
 	dev_info->max_rx_bufsize = UINT32_MAX;
 
-	if (*dev->dev_ops->dev_infos_get == NULL)
+	if (dev->dev_ops->dev_infos_get == NULL)
 		return -ENOTSUP;
-	diag = (*dev->dev_ops->dev_infos_get)(dev, dev_info);
+	diag = dev->dev_ops->dev_infos_get(dev, dev_info);
 	if (diag != 0) {
 		/* Cleanup already filled in device information */
 		memset(dev_info, 0, sizeof(struct rte_eth_dev_info));
@@ -4063,10 +4050,9 @@ rte_eth_dev_get_supported_ptypes(uint16_t port_id, uint32_t ptype_mask,
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->dev_supported_ptypes_get == NULL)
+	if (dev->dev_ops->dev_supported_ptypes_get == NULL)
 		return 0;
-	all_ptypes = (*dev->dev_ops->dev_supported_ptypes_get)(dev,
-							       &no_of_elements);
+	all_ptypes = dev->dev_ops->dev_supported_ptypes_get(dev, &no_of_elements);
 
 	if (!all_ptypes)
 		return 0;
@@ -4116,15 +4102,14 @@ rte_eth_dev_set_ptypes(uint16_t port_id, uint32_t ptype_mask,
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->dev_supported_ptypes_get == NULL ||
-			*dev->dev_ops->dev_ptypes_set == NULL) {
+	if (dev->dev_ops->dev_supported_ptypes_get == NULL ||
+	    dev->dev_ops->dev_ptypes_set == NULL) {
 		ret = 0;
 		goto ptype_unknown;
 	}
 
 	if (ptype_mask == 0) {
-		ret = (*dev->dev_ops->dev_ptypes_set)(dev,
-				ptype_mask);
+		ret = dev->dev_ops->dev_ptypes_set(dev, ptype_mask);
 		goto ptype_unknown;
 	}
 
@@ -4143,8 +4128,7 @@ rte_eth_dev_set_ptypes(uint16_t port_id, uint32_t ptype_mask,
 		goto ptype_unknown;
 	}
 
-	all_ptypes = (*dev->dev_ops->dev_supported_ptypes_get)(dev,
-							       &no_of_elements);
+	all_ptypes = dev->dev_ops->dev_supported_ptypes_get(dev, &no_of_elements);
 	if (all_ptypes == NULL) {
 		ret = 0;
 		goto ptype_unknown;
@@ -4173,7 +4157,7 @@ rte_eth_dev_set_ptypes(uint16_t port_id, uint32_t ptype_mask,
 	if (set_ptypes != NULL && j < num)
 		set_ptypes[j] = RTE_PTYPE_UNKNOWN;
 
-	return (*dev->dev_ops->dev_ptypes_set)(dev, ptype_mask);
+	return dev->dev_ops->dev_ptypes_set(dev, ptype_mask);
 
 ptype_unknown:
 	if (num > 0)
@@ -4261,7 +4245,7 @@ rte_eth_dev_set_mtu(uint16_t port_id, uint16_t mtu)
 
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
 	dev = &rte_eth_devices[port_id];
-	if (*dev->dev_ops->mtu_set == NULL)
+	if (dev->dev_ops->mtu_set == NULL)
 		return -ENOTSUP;
 
 	/*
@@ -4270,7 +4254,7 @@ rte_eth_dev_set_mtu(uint16_t port_id, uint16_t mtu)
 	 * that are populated within the call to rte_eth_dev_info_get()
 	 * which relies on dev->dev_ops->dev_infos_get.
 	 */
-	if (*dev->dev_ops->dev_infos_get != NULL) {
+	if (dev->dev_ops->dev_infos_get != NULL) {
 		ret = rte_eth_dev_info_get(port_id, &dev_info);
 		if (ret != 0)
 			return ret;
@@ -4287,7 +4271,7 @@ rte_eth_dev_set_mtu(uint16_t port_id, uint16_t mtu)
 		return -EINVAL;
 	}
 
-	ret = (*dev->dev_ops->mtu_set)(dev, mtu);
+	ret = dev->dev_ops->mtu_set(dev, mtu);
 	if (ret == 0)
 		dev->data->mtu = mtu;
 
@@ -4319,10 +4303,10 @@ rte_eth_dev_vlan_filter(uint16_t port_id, uint16_t vlan_id, int on)
 			port_id, vlan_id);
 		return -EINVAL;
 	}
-	if (*dev->dev_ops->vlan_filter_set == NULL)
+	if (dev->dev_ops->vlan_filter_set == NULL)
 		return -ENOTSUP;
 
-	ret = (*dev->dev_ops->vlan_filter_set)(dev, vlan_id, on);
+	ret = dev->dev_ops->vlan_filter_set(dev, vlan_id, on);
 	if (ret == 0) {
 		struct rte_vlan_filter_conf *vfc;
 		int vidx;
@@ -4359,9 +4343,9 @@ rte_eth_dev_set_vlan_strip_on_queue(uint16_t port_id, uint16_t rx_queue_id,
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->vlan_strip_queue_set == NULL)
+	if (dev->dev_ops->vlan_strip_queue_set == NULL)
 		return -ENOTSUP;
-	(*dev->dev_ops->vlan_strip_queue_set)(dev, rx_queue_id, on);
+	dev->dev_ops->vlan_strip_queue_set(dev, rx_queue_id, on);
 
 	rte_ethdev_trace_set_vlan_strip_on_queue(port_id, rx_queue_id, on);
 
@@ -4379,10 +4363,9 @@ rte_eth_dev_set_vlan_ether_type(uint16_t port_id,
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
 	dev = &rte_eth_devices[port_id];
 
-	if (*dev->dev_ops->vlan_tpid_set == NULL)
+	if (dev->dev_ops->vlan_tpid_set == NULL)
 		return -ENOTSUP;
-	ret = eth_err(port_id, (*dev->dev_ops->vlan_tpid_set)(dev, vlan_type,
-							      tpid));
+	ret = eth_err(port_id, dev->dev_ops->vlan_tpid_set(dev, vlan_type, tpid));
 
 	rte_ethdev_trace_set_vlan_ether_type(port_id, vlan_type, tpid, ret);
 
@@ -4469,10 +4452,10 @@ rte_eth_dev_set_vlan_offload(uint16_t port_id, int offload_mask)
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->vlan_offload_set == NULL)
+	if (dev->dev_ops->vlan_offload_set == NULL)
 		return -ENOTSUP;
 	dev->data->dev_conf.rxmode.offloads = dev_offloads;
-	ret = (*dev->dev_ops->vlan_offload_set)(dev, mask);
+	ret = dev->dev_ops->vlan_offload_set(dev, mask);
 	if (ret) {
 		/* hit an error restore  original values */
 		dev->data->dev_conf.rxmode.offloads = orig_offloads;
@@ -4522,9 +4505,9 @@ rte_eth_dev_set_vlan_pvid(uint16_t port_id, uint16_t pvid, int on)
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
 	dev = &rte_eth_devices[port_id];
 
-	if (*dev->dev_ops->vlan_pvid_set == NULL)
+	if (dev->dev_ops->vlan_pvid_set == NULL)
 		return -ENOTSUP;
-	ret = eth_err(port_id, (*dev->dev_ops->vlan_pvid_set)(dev, pvid, on));
+	ret = eth_err(port_id, dev->dev_ops->vlan_pvid_set(dev, pvid, on));
 
 	rte_ethdev_trace_set_vlan_pvid(port_id, pvid, on, ret);
 
@@ -4547,10 +4530,10 @@ rte_eth_dev_flow_ctrl_get(uint16_t port_id, struct rte_eth_fc_conf *fc_conf)
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->flow_ctrl_get == NULL)
+	if (dev->dev_ops->flow_ctrl_get == NULL)
 		return -ENOTSUP;
 	memset(fc_conf, 0, sizeof(*fc_conf));
-	ret = eth_err(port_id, (*dev->dev_ops->flow_ctrl_get)(dev, fc_conf));
+	ret = eth_err(port_id, dev->dev_ops->flow_ctrl_get(dev, fc_conf));
 
 	rte_ethdev_trace_flow_ctrl_get(port_id, fc_conf, ret);
 
@@ -4578,9 +4561,9 @@ rte_eth_dev_flow_ctrl_set(uint16_t port_id, struct rte_eth_fc_conf *fc_conf)
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->flow_ctrl_set == NULL)
+	if (dev->dev_ops->flow_ctrl_set == NULL)
 		return -ENOTSUP;
-	ret = eth_err(port_id, (*dev->dev_ops->flow_ctrl_set)(dev, fc_conf));
+	ret = eth_err(port_id, dev->dev_ops->flow_ctrl_set(dev, fc_conf));
 
 	rte_ethdev_trace_flow_ctrl_set(port_id, fc_conf, ret);
 
@@ -4610,10 +4593,9 @@ rte_eth_dev_priority_flow_ctrl_set(uint16_t port_id,
 	}
 
 	/* High water, low water validation are device specific */
-	if  (*dev->dev_ops->priority_flow_ctrl_set == NULL)
+	if  (dev->dev_ops->priority_flow_ctrl_set == NULL)
 		return -ENOTSUP;
-	ret = eth_err(port_id, (*dev->dev_ops->priority_flow_ctrl_set)
-			       (dev, pfc_conf));
+	ret = eth_err(port_id, dev->dev_ops->priority_flow_ctrl_set(dev, pfc_conf));
 
 	rte_ethdev_trace_priority_flow_ctrl_set(port_id, pfc_conf, ret);
 
@@ -4686,10 +4668,9 @@ rte_eth_dev_priority_flow_ctrl_queue_info_get(uint16_t port_id,
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->priority_flow_ctrl_queue_info_get == NULL)
+	if (dev->dev_ops->priority_flow_ctrl_queue_info_get == NULL)
 		return -ENOTSUP;
-	ret = eth_err(port_id, (*dev->dev_ops->priority_flow_ctrl_queue_info_get)
-			(dev, pfc_queue_info));
+	ret = eth_err(port_id, dev->dev_ops->priority_flow_ctrl_queue_info_get(dev, pfc_queue_info));
 
 	rte_ethdev_trace_priority_flow_ctrl_queue_info_get(port_id,
 						pfc_queue_info, ret);
@@ -4762,10 +4743,9 @@ rte_eth_dev_priority_flow_ctrl_queue_configure(uint16_t port_id,
 			return ret;
 	}
 
-	if (*dev->dev_ops->priority_flow_ctrl_queue_config == NULL)
+	if (dev->dev_ops->priority_flow_ctrl_queue_config == NULL)
 		return -ENOTSUP;
-	ret = eth_err(port_id, (*dev->dev_ops->priority_flow_ctrl_queue_config)
-			(dev, pfc_queue_conf));
+	ret = eth_err(port_id, dev->dev_ops->priority_flow_ctrl_queue_config(dev, pfc_queue_conf));
 
 	rte_ethdev_trace_priority_flow_ctrl_queue_configure(port_id,
 						pfc_queue_conf, ret);
@@ -4859,10 +4839,9 @@ rte_eth_dev_rss_reta_update(uint16_t port_id,
 		return -ENOTSUP;
 	}
 
-	if (*dev->dev_ops->reta_update == NULL)
+	if (dev->dev_ops->reta_update == NULL)
 		return -ENOTSUP;
-	ret = eth_err(port_id, (*dev->dev_ops->reta_update)(dev, reta_conf,
-							    reta_size));
+	ret = eth_err(port_id, dev->dev_ops->reta_update(dev, reta_conf, reta_size));
 
 	rte_ethdev_trace_rss_reta_update(port_id, reta_conf, reta_size, ret);
 
@@ -4892,10 +4871,9 @@ rte_eth_dev_rss_reta_query(uint16_t port_id,
 	if (ret < 0)
 		return ret;
 
-	if (*dev->dev_ops->reta_query == NULL)
+	if (dev->dev_ops->reta_query == NULL)
 		return -ENOTSUP;
-	ret = eth_err(port_id, (*dev->dev_ops->reta_query)(dev, reta_conf,
-							   reta_size));
+	ret = eth_err(port_id, dev->dev_ops->reta_query(dev, reta_conf, reta_size));
 
 	rte_ethdev_trace_rss_reta_query(port_id, reta_conf, reta_size, ret);
 
@@ -4959,10 +4937,9 @@ rte_eth_dev_rss_hash_update(uint16_t port_id,
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->rss_hash_update == NULL)
+	if (dev->dev_ops->rss_hash_update == NULL)
 		return -ENOTSUP;
-	ret = eth_err(port_id, (*dev->dev_ops->rss_hash_update)(dev,
-								rss_conf));
+	ret = eth_err(port_id, dev->dev_ops->rss_hash_update(dev, rss_conf));
 
 	rte_ethdev_trace_rss_hash_update(port_id, rss_conf, ret);
 
@@ -5001,10 +4978,9 @@ rte_eth_dev_rss_hash_conf_get(uint16_t port_id,
 
 	rss_conf->algorithm = RTE_ETH_HASH_FUNCTION_DEFAULT;
 
-	if (*dev->dev_ops->rss_hash_conf_get == NULL)
+	if (dev->dev_ops->rss_hash_conf_get == NULL)
 		return -ENOTSUP;
-	ret = eth_err(port_id, (*dev->dev_ops->rss_hash_conf_get)(dev,
-								  rss_conf));
+	ret = eth_err(port_id, dev->dev_ops->rss_hash_conf_get(dev, rss_conf));
 
 	rte_ethdev_trace_rss_hash_conf_get(port_id, rss_conf, ret);
 
@@ -5062,10 +5038,9 @@ rte_eth_dev_udp_tunnel_port_add(uint16_t port_id,
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->udp_tunnel_port_add == NULL)
+	if (dev->dev_ops->udp_tunnel_port_add == NULL)
 		return -ENOTSUP;
-	ret = eth_err(port_id, (*dev->dev_ops->udp_tunnel_port_add)(dev,
-								udp_tunnel));
+	ret = eth_err(port_id, dev->dev_ops->udp_tunnel_port_add(dev, udp_tunnel));
 
 	rte_ethdev_trace_udp_tunnel_port_add(port_id, udp_tunnel, ret);
 
@@ -5094,10 +5069,9 @@ rte_eth_dev_udp_tunnel_port_delete(uint16_t port_id,
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->udp_tunnel_port_del == NULL)
+	if (dev->dev_ops->udp_tunnel_port_del == NULL)
 		return -ENOTSUP;
-	ret = eth_err(port_id, (*dev->dev_ops->udp_tunnel_port_del)(dev,
-								udp_tunnel));
+	ret = eth_err(port_id, dev->dev_ops->udp_tunnel_port_del(dev, udp_tunnel));
 
 	rte_ethdev_trace_udp_tunnel_port_delete(port_id, udp_tunnel, ret);
 
@@ -5113,9 +5087,9 @@ rte_eth_led_on(uint16_t port_id)
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
 	dev = &rte_eth_devices[port_id];
 
-	if (*dev->dev_ops->dev_led_on == NULL)
+	if (dev->dev_ops->dev_led_on == NULL)
 		return -ENOTSUP;
-	ret = eth_err(port_id, (*dev->dev_ops->dev_led_on)(dev));
+	ret = eth_err(port_id, dev->dev_ops->dev_led_on(dev));
 
 	rte_eth_trace_led_on(port_id, ret);
 
@@ -5131,9 +5105,9 @@ rte_eth_led_off(uint16_t port_id)
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
 	dev = &rte_eth_devices[port_id];
 
-	if (*dev->dev_ops->dev_led_off == NULL)
+	if (dev->dev_ops->dev_led_off == NULL)
 		return -ENOTSUP;
-	ret = eth_err(port_id, (*dev->dev_ops->dev_led_off)(dev));
+	ret = eth_err(port_id, dev->dev_ops->dev_led_off(dev));
 
 	rte_eth_trace_led_off(port_id, ret);
 
@@ -5158,9 +5132,9 @@ rte_eth_fec_get_capability(uint16_t port_id,
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->fec_get_capability == NULL)
+	if (dev->dev_ops->fec_get_capability == NULL)
 		return -ENOTSUP;
-	ret = (*dev->dev_ops->fec_get_capability)(dev, speed_fec_capa, num);
+	ret = dev->dev_ops->fec_get_capability(dev, speed_fec_capa, num);
 
 	rte_eth_trace_fec_get_capability(port_id, speed_fec_capa, num, ret);
 
@@ -5183,9 +5157,9 @@ rte_eth_fec_get(uint16_t port_id, uint32_t *fec_capa)
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->fec_get == NULL)
+	if (dev->dev_ops->fec_get == NULL)
 		return -ENOTSUP;
-	ret = eth_err(port_id, (*dev->dev_ops->fec_get)(dev, fec_capa));
+	ret = eth_err(port_id, dev->dev_ops->fec_get(dev, fec_capa));
 
 	rte_eth_trace_fec_get(port_id, fec_capa, ret);
 
@@ -5206,9 +5180,9 @@ rte_eth_fec_set(uint16_t port_id, uint32_t fec_capa)
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->fec_set == NULL)
+	if (dev->dev_ops->fec_set == NULL)
 		return -ENOTSUP;
-	ret = eth_err(port_id, (*dev->dev_ops->fec_set)(dev, fec_capa));
+	ret = eth_err(port_id, dev->dev_ops->fec_set(dev, fec_capa));
 
 	rte_eth_trace_fec_set(port_id, fec_capa, ret);
 
@@ -5260,7 +5234,7 @@ rte_eth_dev_mac_addr_add(uint16_t port_id, struct rte_ether_addr *addr,
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->mac_addr_add == NULL)
+	if (dev->dev_ops->mac_addr_add == NULL)
 		return -ENOTSUP;
 
 	if (rte_is_zero_ether_addr(addr)) {
@@ -5290,7 +5264,7 @@ rte_eth_dev_mac_addr_add(uint16_t port_id, struct rte_ether_addr *addr,
 	}
 
 	/* Update NIC */
-	ret = (*dev->dev_ops->mac_addr_add)(dev, addr, index, pool);
+	ret = dev->dev_ops->mac_addr_add(dev, addr, index, pool);
 
 	if (ret == 0) {
 		/* Update address in NIC data structure */
@@ -5323,7 +5297,7 @@ rte_eth_dev_mac_addr_remove(uint16_t port_id, struct rte_ether_addr *addr)
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->mac_addr_remove == NULL)
+	if (dev->dev_ops->mac_addr_remove == NULL)
 		return -ENOTSUP;
 
 	index = eth_dev_get_mac_addr_index(port_id, addr);
@@ -5336,7 +5310,7 @@ rte_eth_dev_mac_addr_remove(uint16_t port_id, struct rte_ether_addr *addr)
 		return 0;  /* Do nothing if address wasn't found */
 
 	/* Update NIC */
-	(*dev->dev_ops->mac_addr_remove)(dev, index);
+	dev->dev_ops->mac_addr_remove(dev, index);
 
 	/* Update address in NIC data structure */
 	rte_ether_addr_copy(&null_mac_addr, &dev->data->mac_addrs[index]);
@@ -5369,7 +5343,7 @@ rte_eth_dev_default_mac_addr_set(uint16_t port_id, struct rte_ether_addr *addr)
 	if (!rte_is_valid_assigned_ether_addr(addr))
 		return -EINVAL;
 
-	if (*dev->dev_ops->mac_addr_set == NULL)
+	if (dev->dev_ops->mac_addr_set == NULL)
 		return -ENOTSUP;
 
 	/* Keep address unique in dev->data->mac_addrs[]. */
@@ -5381,7 +5355,7 @@ rte_eth_dev_default_mac_addr_set(uint16_t port_id, struct rte_ether_addr *addr)
 		return -EEXIST;
 	}
 
-	ret = (*dev->dev_ops->mac_addr_set)(dev, addr);
+	ret = dev->dev_ops->mac_addr_set(dev, addr);
 	if (ret < 0)
 		return ret;
 
@@ -5467,9 +5441,9 @@ rte_eth_dev_uc_hash_table_set(uint16_t port_id, struct rte_ether_addr *addr,
 		}
 	}
 
-	if (*dev->dev_ops->uc_hash_table_set == NULL)
+	if (dev->dev_ops->uc_hash_table_set == NULL)
 		return -ENOTSUP;
-	ret = (*dev->dev_ops->uc_hash_table_set)(dev, addr, on);
+	ret = dev->dev_ops->uc_hash_table_set(dev, addr, on);
 	if (ret == 0) {
 		/* Update address in NIC data structure */
 		if (on)
@@ -5496,9 +5470,9 @@ rte_eth_dev_uc_all_hash_table_set(uint16_t port_id, uint8_t on)
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
 	dev = &rte_eth_devices[port_id];
 
-	if (*dev->dev_ops->uc_all_hash_table_set == NULL)
+	if (dev->dev_ops->uc_all_hash_table_set == NULL)
 		return -ENOTSUP;
-	ret = eth_err(port_id, (*dev->dev_ops->uc_all_hash_table_set)(dev, on));
+	ret = eth_err(port_id, dev->dev_ops->uc_all_hash_table_set(dev, on));
 
 	rte_ethdev_trace_uc_all_hash_table_set(port_id, on, ret);
 
@@ -5536,10 +5510,9 @@ int rte_eth_set_queue_rate_limit(uint16_t port_id, uint16_t queue_idx,
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->set_queue_rate_limit == NULL)
+	if (dev->dev_ops->set_queue_rate_limit == NULL)
 		return -ENOTSUP;
-	ret = eth_err(port_id, (*dev->dev_ops->set_queue_rate_limit)(dev,
-							queue_idx, tx_rate));
+	ret = eth_err(port_id, dev->dev_ops->set_queue_rate_limit(dev, queue_idx, tx_rate));
 
 	rte_eth_trace_set_queue_rate_limit(port_id, queue_idx, tx_rate, ret);
 
@@ -5568,10 +5541,9 @@ int rte_eth_rx_avail_thresh_set(uint16_t port_id, uint16_t queue_id,
 			port_id);
 		return -EINVAL;
 	}
-	if (*dev->dev_ops->rx_queue_avail_thresh_set == NULL)
+	if (dev->dev_ops->rx_queue_avail_thresh_set == NULL)
 		return -ENOTSUP;
-	ret = eth_err(port_id, (*dev->dev_ops->rx_queue_avail_thresh_set)(dev,
-							     queue_id, avail_thresh));
+	ret = eth_err(port_id, dev->dev_ops->rx_queue_avail_thresh_set(dev, queue_id, avail_thresh));
 
 	rte_eth_trace_rx_avail_thresh_set(port_id, queue_id, avail_thresh, ret);
 
@@ -5592,10 +5564,10 @@ int rte_eth_rx_avail_thresh_query(uint16_t port_id, uint16_t *queue_id,
 	if (*queue_id >= dev->data->nb_rx_queues)
 		*queue_id = 0;
 
-	if (*dev->dev_ops->rx_queue_avail_thresh_query == NULL)
+	if (dev->dev_ops->rx_queue_avail_thresh_query == NULL)
 		return -ENOTSUP;
-	ret = eth_err(port_id, (*dev->dev_ops->rx_queue_avail_thresh_query)(dev,
-							     queue_id, avail_thresh));
+	ret = eth_err(port_id,
+		      dev->dev_ops->rx_queue_avail_thresh_query(dev, queue_id, avail_thresh));
 
 	rte_eth_trace_rx_avail_thresh_query(port_id, *queue_id, ret);
 
@@ -5886,9 +5858,9 @@ rte_eth_dev_rx_intr_enable(uint16_t port_id,
 	if (ret != 0)
 		return ret;
 
-	if (*dev->dev_ops->rx_queue_intr_enable == NULL)
+	if (dev->dev_ops->rx_queue_intr_enable == NULL)
 		return -ENOTSUP;
-	ret = eth_err(port_id, (*dev->dev_ops->rx_queue_intr_enable)(dev, queue_id));
+	ret = eth_err(port_id, dev->dev_ops->rx_queue_intr_enable(dev, queue_id));
 
 	rte_ethdev_trace_rx_intr_enable(port_id, queue_id, ret);
 
@@ -5909,9 +5881,9 @@ rte_eth_dev_rx_intr_disable(uint16_t port_id,
 	if (ret != 0)
 		return ret;
 
-	if (*dev->dev_ops->rx_queue_intr_disable == NULL)
+	if (dev->dev_ops->rx_queue_intr_disable == NULL)
 		return -ENOTSUP;
-	ret = eth_err(port_id, (*dev->dev_ops->rx_queue_intr_disable)(dev, queue_id));
+	ret = eth_err(port_id, dev->dev_ops->rx_queue_intr_disable(dev, queue_id));
 
 	rte_ethdev_trace_rx_intr_disable(port_id, queue_id, ret);
 
@@ -6189,7 +6161,7 @@ rte_eth_rx_queue_info_get(uint16_t port_id, uint16_t queue_id,
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->rxq_info_get == NULL)
+	if (dev->dev_ops->rxq_info_get == NULL)
 		return -ENOTSUP;
 
 	memset(qinfo, 0, sizeof(*qinfo));
@@ -6237,7 +6209,7 @@ rte_eth_tx_queue_info_get(uint16_t port_id, uint16_t queue_id,
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->txq_info_get == NULL)
+	if (dev->dev_ops->txq_info_get == NULL)
 		return -ENOTSUP;
 
 	memset(qinfo, 0, sizeof(*qinfo));
@@ -6263,7 +6235,7 @@ rte_eth_recycle_rx_queue_info_get(uint16_t port_id, uint16_t queue_id,
 	if (unlikely(ret != 0))
 		return ret;
 
-	if (*dev->dev_ops->recycle_rxq_info_get == NULL)
+	if (dev->dev_ops->recycle_rxq_info_get == NULL)
 		return -ENOTSUP;
 
 	dev->dev_ops->recycle_rxq_info_get(dev, queue_id, recycle_rxq_info);
@@ -6293,7 +6265,7 @@ rte_eth_rx_burst_mode_get(uint16_t port_id, uint16_t queue_id,
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->rx_burst_mode_get == NULL)
+	if (dev->dev_ops->rx_burst_mode_get == NULL)
 		return -ENOTSUP;
 	memset(mode, 0, sizeof(*mode));
 	ret = eth_err(port_id,
@@ -6326,7 +6298,7 @@ rte_eth_tx_burst_mode_get(uint16_t port_id, uint16_t queue_id,
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->tx_burst_mode_get == NULL)
+	if (dev->dev_ops->tx_burst_mode_get == NULL)
 		return -ENOTSUP;
 	memset(mode, 0, sizeof(*mode));
 	ret = eth_err(port_id,
@@ -6359,7 +6331,7 @@ rte_eth_get_monitor_addr(uint16_t port_id, uint16_t queue_id,
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->get_monitor_addr == NULL)
+	if (dev->dev_ops->get_monitor_addr == NULL)
 		return -ENOTSUP;
 	ret = eth_err(port_id,
 		dev->dev_ops->get_monitor_addr(dev->data->rx_queues[queue_id], pmc));
@@ -6380,7 +6352,7 @@ rte_eth_dev_set_mc_addr_list(uint16_t port_id,
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
 	dev = &rte_eth_devices[port_id];
 
-	if (*dev->dev_ops->set_mc_addr_list == NULL)
+	if (dev->dev_ops->set_mc_addr_list == NULL)
 		return -ENOTSUP;
 	ret = eth_err(port_id, dev->dev_ops->set_mc_addr_list(dev,
 						mc_addr_set, nb_mc_addr));
@@ -6400,9 +6372,9 @@ rte_eth_timesync_enable(uint16_t port_id)
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
 	dev = &rte_eth_devices[port_id];
 
-	if (*dev->dev_ops->timesync_enable == NULL)
+	if (dev->dev_ops->timesync_enable == NULL)
 		return -ENOTSUP;
-	ret = eth_err(port_id, (*dev->dev_ops->timesync_enable)(dev));
+	ret = eth_err(port_id, dev->dev_ops->timesync_enable(dev));
 
 	rte_eth_trace_timesync_enable(port_id, ret);
 
@@ -6418,9 +6390,9 @@ rte_eth_timesync_disable(uint16_t port_id)
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
 	dev = &rte_eth_devices[port_id];
 
-	if (*dev->dev_ops->timesync_disable == NULL)
+	if (dev->dev_ops->timesync_disable == NULL)
 		return -ENOTSUP;
-	ret = eth_err(port_id, (*dev->dev_ops->timesync_disable)(dev));
+	ret = eth_err(port_id, dev->dev_ops->timesync_disable(dev));
 
 	rte_eth_trace_timesync_disable(port_id, ret);
 
@@ -6444,11 +6416,10 @@ rte_eth_timesync_read_rx_timestamp(uint16_t port_id, struct timespec *timestamp,
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->timesync_read_rx_timestamp == NULL)
+	if (dev->dev_ops->timesync_read_rx_timestamp == NULL)
 		return -ENOTSUP;
 
-	ret = eth_err(port_id, (*dev->dev_ops->timesync_read_rx_timestamp)
-			       (dev, timestamp, flags));
+	ret = eth_err(port_id, dev->dev_ops->timesync_read_rx_timestamp(dev, timestamp, flags));
 
 	rte_eth_trace_timesync_read_rx_timestamp(port_id, timestamp, flags,
 						 ret);
@@ -6473,11 +6444,10 @@ rte_eth_timesync_read_tx_timestamp(uint16_t port_id,
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->timesync_read_tx_timestamp == NULL)
+	if (dev->dev_ops->timesync_read_tx_timestamp == NULL)
 		return -ENOTSUP;
 
-	ret = eth_err(port_id, (*dev->dev_ops->timesync_read_tx_timestamp)
-			       (dev, timestamp));
+	ret = eth_err(port_id, dev->dev_ops->timesync_read_tx_timestamp(dev, timestamp));
 
 	rte_eth_trace_timesync_read_tx_timestamp(port_id, timestamp, ret);
 
@@ -6494,9 +6464,9 @@ rte_eth_timesync_adjust_time(uint16_t port_id, int64_t delta)
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
 	dev = &rte_eth_devices[port_id];
 
-	if (*dev->dev_ops->timesync_adjust_time == NULL)
+	if (dev->dev_ops->timesync_adjust_time == NULL)
 		return -ENOTSUP;
-	ret = eth_err(port_id, (*dev->dev_ops->timesync_adjust_time)(dev, delta));
+	ret = eth_err(port_id, dev->dev_ops->timesync_adjust_time(dev, delta));
 
 	rte_eth_trace_timesync_adjust_time(port_id, delta, ret);
 
@@ -6512,9 +6482,9 @@ rte_eth_timesync_adjust_freq(uint16_t port_id, int64_t ppm)
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
 	dev = &rte_eth_devices[port_id];
 
-	if (*dev->dev_ops->timesync_adjust_freq == NULL)
+	if (dev->dev_ops->timesync_adjust_freq == NULL)
 		return -ENOTSUP;
-	ret = eth_err(port_id, (*dev->dev_ops->timesync_adjust_freq)(dev, ppm));
+	ret = eth_err(port_id, dev->dev_ops->timesync_adjust_freq(dev, ppm));
 
 	rte_eth_trace_timesync_adjust_freq(port_id, ppm, ret);
 
@@ -6537,10 +6507,9 @@ rte_eth_timesync_read_time(uint16_t port_id, struct timespec *timestamp)
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->timesync_read_time == NULL)
+	if (dev->dev_ops->timesync_read_time == NULL)
 		return -ENOTSUP;
-	ret = eth_err(port_id, (*dev->dev_ops->timesync_read_time)(dev,
-								timestamp));
+	ret = eth_err(port_id, dev->dev_ops->timesync_read_time(dev, timestamp));
 
 	rte_eth_trace_timesync_read_time(port_id, timestamp, ret);
 
@@ -6563,10 +6532,9 @@ rte_eth_timesync_write_time(uint16_t port_id, const struct timespec *timestamp)
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->timesync_write_time == NULL)
+	if (dev->dev_ops->timesync_write_time == NULL)
 		return -ENOTSUP;
-	ret = eth_err(port_id, (*dev->dev_ops->timesync_write_time)(dev,
-								timestamp));
+	ret = eth_err(port_id, dev->dev_ops->timesync_write_time(dev, timestamp));
 
 	rte_eth_trace_timesync_write_time(port_id, timestamp, ret);
 
@@ -6588,9 +6556,9 @@ rte_eth_read_clock(uint16_t port_id, uint64_t *clock)
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->read_clock == NULL)
+	if (dev->dev_ops->read_clock == NULL)
 		return -ENOTSUP;
-	ret = eth_err(port_id, (*dev->dev_ops->read_clock)(dev, clock));
+	ret = eth_err(port_id, dev->dev_ops->read_clock(dev, clock));
 
 	rte_eth_trace_read_clock(port_id, clock, ret);
 
@@ -6645,9 +6613,9 @@ rte_eth_dev_get_reg_info_ext(uint16_t port_id, struct rte_dev_reg_info *info)
 	if (info->names != NULL && info->length != 0)
 		memset(info->names, 0, sizeof(struct rte_eth_reg_name) * info->length);
 
-	if (*dev->dev_ops->get_reg == NULL)
+	if (dev->dev_ops->get_reg == NULL)
 		return -ENOTSUP;
-	ret = eth_err(port_id, (*dev->dev_ops->get_reg)(dev, info));
+	ret = eth_err(port_id, dev->dev_ops->get_reg(dev, info));
 
 	rte_ethdev_trace_get_reg_info(port_id, info, ret);
 
@@ -6669,9 +6637,9 @@ rte_eth_dev_get_eeprom_length(uint16_t port_id)
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
 	dev = &rte_eth_devices[port_id];
 
-	if (*dev->dev_ops->get_eeprom_length == NULL)
+	if (dev->dev_ops->get_eeprom_length == NULL)
 		return -ENOTSUP;
-	ret = eth_err(port_id, (*dev->dev_ops->get_eeprom_length)(dev));
+	ret = eth_err(port_id, dev->dev_ops->get_eeprom_length(dev));
 
 	rte_ethdev_trace_get_eeprom_length(port_id, ret);
 
@@ -6694,9 +6662,9 @@ rte_eth_dev_get_eeprom(uint16_t port_id, struct rte_dev_eeprom_info *info)
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->get_eeprom == NULL)
+	if (dev->dev_ops->get_eeprom == NULL)
 		return -ENOTSUP;
-	ret = eth_err(port_id, (*dev->dev_ops->get_eeprom)(dev, info));
+	ret = eth_err(port_id, dev->dev_ops->get_eeprom(dev, info));
 
 	rte_ethdev_trace_get_eeprom(port_id, info, ret);
 
@@ -6719,9 +6687,9 @@ rte_eth_dev_set_eeprom(uint16_t port_id, struct rte_dev_eeprom_info *info)
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->set_eeprom == NULL)
+	if (dev->dev_ops->set_eeprom == NULL)
 		return -ENOTSUP;
-	ret = eth_err(port_id, (*dev->dev_ops->set_eeprom)(dev, info));
+	ret = eth_err(port_id, dev->dev_ops->set_eeprom(dev, info));
 
 	rte_ethdev_trace_set_eeprom(port_id, info, ret);
 
@@ -6745,9 +6713,9 @@ rte_eth_dev_get_module_info(uint16_t port_id,
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->get_module_info == NULL)
+	if (dev->dev_ops->get_module_info == NULL)
 		return -ENOTSUP;
-	ret = (*dev->dev_ops->get_module_info)(dev, modinfo);
+	ret = dev->dev_ops->get_module_info(dev, modinfo);
 
 	rte_ethdev_trace_get_module_info(port_id, modinfo, ret);
 
@@ -6785,9 +6753,9 @@ rte_eth_dev_get_module_eeprom(uint16_t port_id,
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->get_module_eeprom == NULL)
+	if (dev->dev_ops->get_module_eeprom == NULL)
 		return -ENOTSUP;
-	ret = (*dev->dev_ops->get_module_eeprom)(dev, info);
+	ret = dev->dev_ops->get_module_eeprom(dev, info);
 
 	rte_ethdev_trace_get_module_eeprom(port_id, info, ret);
 
@@ -6813,9 +6781,9 @@ rte_eth_dev_get_dcb_info(uint16_t port_id,
 
 	memset(dcb_info, 0, sizeof(struct rte_eth_dcb_info));
 
-	if (*dev->dev_ops->get_dcb_info == NULL)
+	if (dev->dev_ops->get_dcb_info == NULL)
 		return -ENOTSUP;
-	ret = eth_err(port_id, (*dev->dev_ops->get_dcb_info)(dev, dcb_info));
+	ret = eth_err(port_id, dev->dev_ops->get_dcb_info(dev, dcb_info));
 
 	rte_ethdev_trace_get_dcb_info(port_id, dcb_info, ret);
 
@@ -6883,10 +6851,10 @@ rte_eth_dev_hairpin_capability_get(uint16_t port_id,
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->hairpin_cap_get == NULL)
+	if (dev->dev_ops->hairpin_cap_get == NULL)
 		return -ENOTSUP;
 	memset(cap, 0, sizeof(*cap));
-	ret = eth_err(port_id, (*dev->dev_ops->hairpin_cap_get)(dev, cap));
+	ret = eth_err(port_id, dev->dev_ops->hairpin_cap_get(dev, cap));
 
 	rte_ethdev_trace_hairpin_capability_get(port_id, cap, ret);
 
@@ -6909,10 +6877,10 @@ rte_eth_dev_pool_ops_supported(uint16_t port_id, const char *pool)
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->pool_ops_supported == NULL)
+	if (dev->dev_ops->pool_ops_supported == NULL)
 		return 1; /* all pools are supported */
 
-	ret = (*dev->dev_ops->pool_ops_supported)(dev, pool);
+	ret = dev->dev_ops->pool_ops_supported(dev, pool);
 
 	rte_ethdev_trace_pool_ops_supported(port_id, pool, ret);
 
@@ -6929,9 +6897,9 @@ rte_eth_representor_info_get(uint16_t port_id,
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
 	dev = &rte_eth_devices[port_id];
 
-	if (*dev->dev_ops->representor_info_get == NULL)
+	if (dev->dev_ops->representor_info_get == NULL)
 		return -ENOTSUP;
-	ret = eth_err(port_id, (*dev->dev_ops->representor_info_get)(dev, info));
+	ret = eth_err(port_id, dev->dev_ops->representor_info_get(dev, info));
 
 	rte_eth_trace_representor_info_get(port_id, info, ret);
 
@@ -6963,10 +6931,10 @@ rte_eth_rx_metadata_negotiate(uint16_t port_id, uint64_t *features)
 			rte_flow_restore_info_dynflag_register() < 0)
 		*features &= ~RTE_ETH_RX_METADATA_TUNNEL_ID;
 
-	if (*dev->dev_ops->rx_metadata_negotiate == NULL)
+	if (dev->dev_ops->rx_metadata_negotiate == NULL)
 		return -ENOTSUP;
 	ret = eth_err(port_id,
-		      (*dev->dev_ops->rx_metadata_negotiate)(dev, features));
+		      dev->dev_ops->rx_metadata_negotiate(dev, features));
 
 	rte_eth_trace_rx_metadata_negotiate(port_id, *features, ret);
 
@@ -6995,11 +6963,11 @@ rte_eth_ip_reassembly_capability_get(uint16_t port_id,
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->ip_reassembly_capability_get == NULL)
+	if (dev->dev_ops->ip_reassembly_capability_get == NULL)
 		return -ENOTSUP;
 	memset(reassembly_capa, 0, sizeof(struct rte_eth_ip_reassembly_params));
 
-	ret = eth_err(port_id, (*dev->dev_ops->ip_reassembly_capability_get)
+	ret = eth_err(port_id, (dev->dev_ops->ip_reassembly_capability_get)
 					(dev, reassembly_capa));
 
 	rte_eth_trace_ip_reassembly_capability_get(port_id, reassembly_capa,
@@ -7030,11 +6998,11 @@ rte_eth_ip_reassembly_conf_get(uint16_t port_id,
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->ip_reassembly_conf_get == NULL)
+	if (dev->dev_ops->ip_reassembly_conf_get == NULL)
 		return -ENOTSUP;
 	memset(conf, 0, sizeof(struct rte_eth_ip_reassembly_params));
 	ret = eth_err(port_id,
-		      (*dev->dev_ops->ip_reassembly_conf_get)(dev, conf));
+		      dev->dev_ops->ip_reassembly_conf_get(dev, conf));
 
 	rte_eth_trace_ip_reassembly_conf_get(port_id, conf, ret);
 
@@ -7071,10 +7039,10 @@ rte_eth_ip_reassembly_conf_set(uint16_t port_id,
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->ip_reassembly_conf_set == NULL)
+	if (dev->dev_ops->ip_reassembly_conf_set == NULL)
 		return -ENOTSUP;
 	ret = eth_err(port_id,
-		      (*dev->dev_ops->ip_reassembly_conf_set)(dev, conf));
+		      dev->dev_ops->ip_reassembly_conf_set(dev, conf));
 
 	rte_eth_trace_ip_reassembly_conf_set(port_id, conf, ret);
 
@@ -7094,9 +7062,9 @@ rte_eth_dev_priv_dump(uint16_t port_id, FILE *file)
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->eth_dev_priv_dump == NULL)
+	if (dev->dev_ops->eth_dev_priv_dump == NULL)
 		return -ENOTSUP;
-	return eth_err(port_id, (*dev->dev_ops->eth_dev_priv_dump)(dev, file));
+	return eth_err(port_id, dev->dev_ops->eth_dev_priv_dump(dev, file));
 }
 
 int
@@ -7118,11 +7086,11 @@ rte_eth_rx_descriptor_dump(uint16_t port_id, uint16_t queue_id,
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->eth_rx_descriptor_dump == NULL)
+	if (dev->dev_ops->eth_rx_descriptor_dump == NULL)
 		return -ENOTSUP;
 
-	return eth_err(port_id, (*dev->dev_ops->eth_rx_descriptor_dump)(dev,
-						queue_id, offset, num, file));
+	return eth_err(port_id,
+		       dev->dev_ops->eth_rx_descriptor_dump(dev, queue_id, offset, num, file));
 }
 
 int
@@ -7144,11 +7112,11 @@ rte_eth_tx_descriptor_dump(uint16_t port_id, uint16_t queue_id,
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->eth_tx_descriptor_dump == NULL)
+	if (dev->dev_ops->eth_tx_descriptor_dump == NULL)
 		return -ENOTSUP;
 
-	return eth_err(port_id, (*dev->dev_ops->eth_tx_descriptor_dump)(dev,
-						queue_id, offset, num, file));
+	return eth_err(port_id,
+		       dev->dev_ops->eth_tx_descriptor_dump(dev, queue_id, offset, num, file));
 }
 
 int
@@ -7170,10 +7138,9 @@ rte_eth_buffer_split_get_supported_hdr_ptypes(uint16_t port_id, uint32_t *ptypes
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->buffer_split_supported_hdr_ptypes_get == NULL)
+	if (dev->dev_ops->buffer_split_supported_hdr_ptypes_get == NULL)
 		return -ENOTSUP;
-	all_types = (*dev->dev_ops->buffer_split_supported_hdr_ptypes_get)(dev,
-							      &no_of_elements);
+	all_types = dev->dev_ops->buffer_split_supported_hdr_ptypes_get(dev, &no_of_elements);
 
 	if (all_types == NULL)
 		return 0;
@@ -7199,9 +7166,9 @@ int rte_eth_dev_count_aggr_ports(uint16_t port_id)
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
 	dev = &rte_eth_devices[port_id];
 
-	if (*dev->dev_ops->count_aggr_ports == NULL)
+	if (dev->dev_ops->count_aggr_ports == NULL)
 		return 0;
-	ret = eth_err(port_id, (*dev->dev_ops->count_aggr_ports)(dev));
+	ret = eth_err(port_id, dev->dev_ops->count_aggr_ports(dev));
 
 	rte_eth_trace_count_aggr_ports(port_id, ret);
 
@@ -7223,7 +7190,7 @@ int rte_eth_dev_map_aggr_tx_affinity(uint16_t port_id, uint16_t tx_queue_id,
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->map_aggr_tx_affinity == NULL)
+	if (dev->dev_ops->map_aggr_tx_affinity == NULL)
 		return -ENOTSUP;
 
 	if (dev->data->dev_configured == 0) {
@@ -7255,8 +7222,8 @@ int rte_eth_dev_map_aggr_tx_affinity(uint16_t port_id, uint16_t tx_queue_id,
 		return -EINVAL;
 	}
 
-	ret = eth_err(port_id, (*dev->dev_ops->map_aggr_tx_affinity)(dev,
-				tx_queue_id, affinity));
+	ret = eth_err(port_id,
+		      dev->dev_ops->map_aggr_tx_affinity(dev, tx_queue_id, affinity));
 
 	rte_eth_trace_map_aggr_tx_affinity(port_id, tx_queue_id, affinity, ret);
 
diff --git a/lib/ethdev/rte_ethdev_cman.c b/lib/ethdev/rte_ethdev_cman.c
index 41e38bdc89..73262ffc5f 100644
--- a/lib/ethdev/rte_ethdev_cman.c
+++ b/lib/ethdev/rte_ethdev_cman.c
@@ -31,7 +31,7 @@ rte_eth_cman_info_get(uint16_t port_id, struct rte_eth_cman_info *info)
 	}
 
 	memset(info, 0, sizeof(struct rte_eth_cman_info));
-	ret = eth_err(port_id, (*dev->dev_ops->cman_info_get)(dev, info));
+	ret = eth_err(port_id, dev->dev_ops->cman_info_get(dev, info));
 
 	rte_eth_trace_cman_info_get(port_id, info, ret);
 
@@ -59,7 +59,7 @@ rte_eth_cman_config_init(uint16_t port_id, struct rte_eth_cman_config *config)
 	}
 
 	memset(config, 0, sizeof(struct rte_eth_cman_config));
-	ret = eth_err(port_id, (*dev->dev_ops->cman_config_init)(dev, config));
+	ret = eth_err(port_id, dev->dev_ops->cman_config_init(dev, config));
 
 	rte_eth_trace_cman_config_init(port_id, config, ret);
 
@@ -86,7 +86,7 @@ rte_eth_cman_config_set(uint16_t port_id, const struct rte_eth_cman_config *conf
 		return -ENOTSUP;
 	}
 
-	ret = eth_err(port_id, (*dev->dev_ops->cman_config_set)(dev, config));
+	ret = eth_err(port_id, dev->dev_ops->cman_config_set(dev, config));
 
 	rte_eth_trace_cman_config_set(port_id, config, ret);
 
@@ -114,7 +114,7 @@ rte_eth_cman_config_get(uint16_t port_id, struct rte_eth_cman_config *config)
 	}
 
 	memset(config, 0, sizeof(struct rte_eth_cman_config));
-	ret = eth_err(port_id, (*dev->dev_ops->cman_config_get)(dev, config));
+	ret = eth_err(port_id, dev->dev_ops->cman_config_get(dev, config));
 
 	rte_eth_trace_cman_config_get(port_id, config, ret);
 
-- 
2.47.2

