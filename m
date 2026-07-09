Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E551C43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Jul 2026 16:03:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8988940C35;
	Thu,  9 Jul 2026 18:03:30 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 83C0640BA2
 for <dev@dpdk.org>; Thu,  9 Jul 2026 18:03:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783613008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZfbboIlde0jhXpmn09vzpU8Aj8I5XDRGdVN3dBmDXoU=;
 b=eKeXq/R5mycrve3xbn1wfTYBwSHDMRqhuh8tb4d9XR/vxi8Wi7wiEK2LAvIYzToBsv9jts
 LlLo/nVHhpKoGDEB7+hQ6czEMy0xc0iN2OH3qbD3jVZmKhblsmj0Y7Ky0ZfFC8bcdpw6gT
 mwfj5VZt+mqTheBHkDe6ntyK5f+yCRw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-49-tjryt3VBOyWv2YKJBwWvTw-1; Thu,
 09 Jul 2026 12:03:24 -0400
X-MC-Unique: tjryt3VBOyWv2YKJBwWvTw-1
X-Mimecast-MFC-AGG-ID: tjryt3VBOyWv2YKJBwWvTw_1783613003
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7EA5A1956047; Thu,  9 Jul 2026 16:03:23 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CF4C5175F; Thu,  9 Jul 2026 16:03:20 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com, cfontain@redhat.com,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v4 06/10] net/mlx5: remove MAC addresses flush helper on Linux
Date: Thu,  9 Jul 2026 18:02:42 +0200
Message-ID: <20260709160247.1798575-7-david.marchand@redhat.com>
In-Reply-To: <20260709160247.1798575-1-david.marchand@redhat.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260709160247.1798575-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MsCdQAWLQ2UsQ2oE1kwaLSZviMzxanEBc4fo38C1JY4_1783613003
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

This helper is exposing internals of net/mlx5 for no good reason.
All this code does is calling the remove helper.
Walk through the list in Linux implementation like the Windows
implementation.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/common/mlx5/linux/mlx5_nl.c | 40 -----------------------------
 drivers/common/mlx5/linux/mlx5_nl.h |  5 ----
 drivers/net/mlx5/linux/mlx5_os.c    | 13 +++++++---
 3 files changed, 10 insertions(+), 48 deletions(-)

diff --git a/drivers/common/mlx5/linux/mlx5_nl.c b/drivers/common/mlx5/linux/mlx5_nl.c
index 8b19838a7e..85736738ac 100644
--- a/drivers/common/mlx5/linux/mlx5_nl.c
+++ b/drivers/common/mlx5/linux/mlx5_nl.c
@@ -825,46 +825,6 @@ mlx5_nl_mac_addr_sync(int nlsk_fd, unsigned int iface_idx,
 	}
 }
 
-/**
- * Flush all added MAC addresses.
- *
- * @param[in] nlsk_fd
- *   Netlink socket file descriptor.
- * @param[in] iface_idx
- *   Net device interface index.
- * @param[in] mac_addrs
- *   Mac addresses array to flush.
- * @param n
- *   @p mac_addrs array size.
- * @param mac_own
- *   BITFIELD_DECLARE array to store the mac.
- * @param vf
- *   Flag for a VF device.
- */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_mac_addr_flush)
-void
-mlx5_nl_mac_addr_flush(int nlsk_fd, unsigned int iface_idx,
-		       struct rte_ether_addr *mac_addrs, int n,
-		       uint64_t *mac_own, bool vf)
-{
-	int i;
-
-	if (n <= 0 || n > MLX5_MAX_MAC_ADDRESSES)
-		return;
-
-	for (i = n - 1; i >= 0; --i) {
-		struct rte_ether_addr *m = &mac_addrs[i];
-
-		if (BITFIELD_ISSET(mac_own, i)) {
-			if (vf)
-				mlx5_nl_mac_addr_remove(nlsk_fd,
-							iface_idx,
-							m, i);
-			BITFIELD_RESET(mac_own, i);
-		}
-	}
-}
-
 /**
  * Enable promiscuous / all multicast mode through Netlink.
  *
diff --git a/drivers/common/mlx5/linux/mlx5_nl.h b/drivers/common/mlx5/linux/mlx5_nl.h
index 3f79a73c85..256ed7e2b7 100644
--- a/drivers/common/mlx5/linux/mlx5_nl.h
+++ b/drivers/common/mlx5/linux/mlx5_nl.h
@@ -65,11 +65,6 @@ __rte_internal
 void mlx5_nl_mac_addr_sync(int nlsk_fd, unsigned int iface_idx,
 			   struct rte_ether_addr *mac_addrs, int n);
 __rte_internal
-void mlx5_nl_mac_addr_flush(int nlsk_fd, unsigned int iface_idx,
-			    struct rte_ether_addr *mac_addrs, int n,
-			    uint64_t *mac_own,
-			    bool vf);
-__rte_internal
 int mlx5_nl_promisc(int nlsk_fd, unsigned int iface_idx, int enable);
 __rte_internal
 int mlx5_nl_allmulti(int nlsk_fd, unsigned int iface_idx, int enable);
diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index adc5878296..9fd366b10a 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -3495,10 +3495,17 @@ mlx5_os_mac_addr_flush(struct rte_eth_dev *dev)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 	const int vf = priv->sh->dev_cap.vf;
+	int i;
 
-	mlx5_nl_mac_addr_flush(priv->nl_socket_route, mlx5_ifindex(dev),
-			       dev->data->mac_addrs,
-			       MLX5_MAX_MAC_ADDRESSES, priv->mac_own, vf);
+	for (i = MLX5_MAX_MAC_ADDRESSES - 1; i >= 0; --i) {
+		if (BITFIELD_ISSET(priv->mac_own, i)) {
+			if (vf)
+				mlx5_nl_mac_addr_remove(priv->nl_socket_route,
+							mlx5_ifindex(dev),
+							&dev->data->mac_addrs[i], i);
+			BITFIELD_RESET(priv->mac_own, i);
+		}
+	}
 }
 
 static bool
-- 
2.54.0

