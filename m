Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C1AC88E72
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 14:42:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A314F40E1C;
	Mon, 14 Sep 2026 16:42:47 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id E277040A87
 for <dev@dpdk.org>; Mon, 14 Sep 2026 16:42:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789396965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kll+RbcL7vTlXGyBVaNPOtypXqLrBxUmDmZRfqYSm0k=;
 b=XiEp7TQZmL3dZ0KqzaCJRmwVkuTGsl+fHEOx2AhgACzQr1ttON9sEBqLw+vWgL8/QxPGpO
 UK2ayKm43/aIcZ/lQx6djdmx0uuMTLP1AOsIiegbyX+OkQLrymnx/h9o2Xzi6OUNn4+QKD
 0BuAnt2M7lzQUBJQZMIbJcWCU8vzoJI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-pr3OZsNRNJG-rPNOD9NZrQ-1; Mon,
 14 Sep 2026 10:42:42 -0400
X-MC-Unique: pr3OZsNRNJG-rPNOD9NZrQ-1
X-Mimecast-MFC-AGG-ID: pr3OZsNRNJG-rPNOD9NZrQ_1789396960
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6D5B1955DBF; Mon, 14 Sep 2026 14:42:40 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 755E5180056E; Mon, 14 Sep 2026 14:42:38 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: dsosnowski@nvidia.com, rjarry@redhat.com, cfontain@redhat.com,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v7 1/5] net/mlx5: remove MAC addresses flush helper on Linux
Date: Mon, 14 Sep 2026 16:42:29 +0200
Message-ID: <20260914144234.1540150-1-david.marchand@redhat.com>
In-Reply-To: <20260403091836.1073484-1-david.marchand@redhat.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: D1CDKnKJSPu4Q68qgd7Hyn42ahlP6EWIksShPYlWw44_1789396960
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
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/common/mlx5/linux/mlx5_nl.c | 40 -----------------------------
 drivers/common/mlx5/linux/mlx5_nl.h |  5 ----
 drivers/net/mlx5/linux/mlx5_os.c    | 13 +++++++---
 3 files changed, 10 insertions(+), 48 deletions(-)

diff --git a/drivers/common/mlx5/linux/mlx5_nl.c b/drivers/common/mlx5/linux/mlx5_nl.c
index 42ccb73e36..40a8b8a2cc 100644
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
index 8ccdd244b0..0242342c47 100644
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
index 592e233844..49a8751761 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -3529,10 +3529,17 @@ mlx5_os_mac_addr_flush(struct rte_eth_dev *dev)
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

