Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0690C531CA
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 12:43:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 318E8406B6;
	Thu, 23 Jul 2026 14:43:02 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8F01040A76
 for <dev@dpdk.org>; Thu, 23 Jul 2026 14:43:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784810580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Wfj1iN1lJnY2caOkfi8ujFMmIAw58Ah1mPFxAyWHWM=;
 b=cOACoLJtlZZzpHXeJFuJdORULGVbcWQE1Opf4Vcha8snU3WG9H0tBjEAn7sdIt0nTkW7px
 AqfjC5PRGAJzxxCVwXIW8wBMP0E4KUQ08uqKzm5Xsyadf9iEIgS+oJauwcs8KJN9e423qZ
 QCbqUH9i8ptNzrs0rNFLZl+f6zr8n5E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-97-uvdNWFKiOq6zbPKaVX6s7w-1; Thu,
 23 Jul 2026 08:42:58 -0400
X-MC-Unique: uvdNWFKiOq6zbPKaVX6s7w-1
X-Mimecast-MFC-AGG-ID: uvdNWFKiOq6zbPKaVX6s7w_1784810577
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A14B19539A4; Thu, 23 Jul 2026 12:42:57 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 90AAC1800361; Thu, 23 Jul 2026 12:42:54 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com, cfontain@redhat.com,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v5 09/10] net/mlx5: use bitset for tracking MAC addresses
Date: Thu, 23 Jul 2026 14:41:55 +0200
Message-ID: <20260723124200.3069410-10-david.marchand@redhat.com>
In-Reply-To: <20260723124200.3069410-1-david.marchand@redhat.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260723124200.3069410-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mCk1QWiw8rqIjwPlqTOjIHRAo8WEb_0moia7-EF0o-0_1784810577
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

EAL provides bitset that does the same as this set of mlx5 macros.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/common/mlx5/mlx5_common.h  | 16 ----------------
 drivers/net/mlx5/linux/mlx5_os.c   |  8 ++++----
 drivers/net/mlx5/mlx5.h            |  3 ++-
 drivers/net/mlx5/mlx5_trigger.c    |  2 +-
 drivers/net/mlx5/windows/mlx5_os.c |  8 ++++----
 5 files changed, 11 insertions(+), 26 deletions(-)

diff --git a/drivers/common/mlx5/mlx5_common.h b/drivers/common/mlx5/mlx5_common.h
index 8aed3dbabe..8b8f20e2f4 100644
--- a/drivers/common/mlx5/mlx5_common.h
+++ b/drivers/common/mlx5/mlx5_common.h
@@ -30,22 +30,6 @@
 #define MLX5_PCI_DRIVER_NAME "mlx5_pci"
 #define MLX5_AUXILIARY_DRIVER_NAME "mlx5_auxiliary"
 
-/* Bit-field manipulation. */
-#define BITFIELD_DECLARE(bf, type, size) \
-	type bf[(((size_t)(size) / (sizeof(type) * CHAR_BIT)) + \
-		!!((size_t)(size) % (sizeof(type) * CHAR_BIT)))]
-#define BITFIELD_DEFINE(bf, type, size) \
-	BITFIELD_DECLARE((bf), type, (size)) = { 0 }
-#define BITFIELD_SET(bf, b) \
-	(void)((bf)[((b) / (sizeof((bf)[0]) * CHAR_BIT))] |= \
-		((size_t)1 << ((b) % (sizeof((bf)[0]) * CHAR_BIT))))
-#define BITFIELD_RESET(bf, b) \
-	(void)((bf)[((b) / (sizeof((bf)[0]) * CHAR_BIT))] &= \
-		~((size_t)1 << ((b) % (sizeof((bf)[0]) * CHAR_BIT))))
-#define BITFIELD_ISSET(bf, b) \
-	!!(((bf)[((b) / (sizeof((bf)[0]) * CHAR_BIT))] & \
-		((size_t)1 << ((b) % (sizeof((bf)[0]) * CHAR_BIT)))))
-
 /*
  * Helper macros to work around __VA_ARGS__ limitations in a C99 compliant
  * manner.
diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 5b6e45df2a..1cad6e1091 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -3384,7 +3384,7 @@ mlx5_os_mac_addr_remove(struct rte_eth_dev *dev, uint32_t index)
 		mlx5_nl_mac_addr_remove(priv->nl_socket_route,
 					mlx5_ifindex(dev),
 					&dev->data->mac_addrs[index]);
-	BITFIELD_RESET(priv->mac_own, index);
+	rte_bitset_clear(priv->mac_own, index);
 }
 
 /**
@@ -3413,7 +3413,7 @@ mlx5_os_mac_addr_add(struct rte_eth_dev *dev, struct rte_ether_addr *mac,
 					   mlx5_ifindex(dev),
 					   mac);
 	if (!ret)
-		BITFIELD_SET(priv->mac_own, index);
+		rte_bitset_set(priv->mac_own, index);
 
 	return ret;
 }
@@ -3498,12 +3498,12 @@ mlx5_os_mac_addr_flush(struct rte_eth_dev *dev)
 	int i;
 
 	for (i = MLX5_MAX_MAC_ADDRESSES - 1; i >= 0; --i) {
-		if (BITFIELD_ISSET(priv->mac_own, i)) {
+		if (rte_bitset_test(priv->mac_own, i)) {
 			if (vf)
 				mlx5_nl_mac_addr_remove(priv->nl_socket_route,
 							mlx5_ifindex(dev),
 							&dev->data->mac_addrs[i]);
-			BITFIELD_RESET(priv->mac_own, i);
+			rte_bitset_clear(priv->mac_own, i);
 		}
 	}
 }
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index 3ad8bad02f..f7ba8df108 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -14,6 +14,7 @@
 
 #include <rte_pci.h>
 #include <rte_ether.h>
+#include <rte_bitset.h>
 #include <ethdev_driver.h>
 #include <rte_rwlock.h>
 #include <rte_interrupts.h>
@@ -2018,7 +2019,7 @@ struct mlx5_priv {
 	uint32_t dev_port; /* Device port number. */
 	struct rte_pci_device *pci_dev; /* Backend PCI device. */
 	struct rte_ether_addr mac[MLX5_MAX_MAC_ADDRESSES]; /* MAC addresses. */
-	BITFIELD_DECLARE(mac_own, uint64_t, MLX5_MAX_MAC_ADDRESSES);
+	RTE_BITSET_DECLARE(mac_own, MLX5_MAX_MAC_ADDRESSES);
 	/* Bit-field of MAC addresses owned by the PMD. */
 	uint16_t vlan_filter[MLX5_MAX_VLAN_IDS]; /* VLAN filters table. */
 	unsigned int vlan_filter_n; /* Number of configured VLAN filters. */
diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index 25847c8ba2..e41e4643e0 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -1907,7 +1907,7 @@ mlx5_traffic_enable(struct rte_eth_dev *dev)
 
 		/* Add flows for unicast and multicast mac addresses added by API. */
 		if (!memcmp(mac, &cmp, sizeof(*mac)) ||
-		    !BITFIELD_ISSET(priv->mac_own, i) ||
+		    !rte_bitset_test(priv->mac_own, i) ||
 		    (dev->data->all_multicast && rte_is_multicast_ether_addr(mac)))
 			continue;
 		memcpy(&unicast.hdr.dst_addr.addr_bytes,
diff --git a/drivers/net/mlx5/windows/mlx5_os.c b/drivers/net/mlx5/windows/mlx5_os.c
index 9acfa8ec84..15de5c22a9 100644
--- a/drivers/net/mlx5/windows/mlx5_os.c
+++ b/drivers/net/mlx5/windows/mlx5_os.c
@@ -699,8 +699,8 @@ mlx5_os_mac_addr_flush(struct rte_eth_dev *dev)
 	int i;
 
 	for (i = MLX5_MAX_MAC_ADDRESSES - 1; i >= 0; --i) {
-		if (BITFIELD_ISSET(priv->mac_own, i))
-			BITFIELD_RESET(priv->mac_own, i);
+		if (rte_bitset_test(priv->mac_own, i))
+			rte_bitset_clear(priv->mac_own, i);
 	}
 }
 
@@ -719,7 +719,7 @@ mlx5_os_mac_addr_remove(struct rte_eth_dev *dev, uint32_t index)
 	struct mlx5_priv *priv = dev->data->dev_private;
 
 	if (index < MLX5_MAX_MAC_ADDRESSES)
-		BITFIELD_RESET(priv->mac_own, index);
+		rte_bitset_clear(priv->mac_own, index);
 }
 
 /**
@@ -757,7 +757,7 @@ mlx5_os_mac_addr_add(struct rte_eth_dev *dev, struct rte_ether_addr *mac,
 		return -ENOTSUP;
 	}
 	/* Mark this MAC address as owned by the PMD */
-	BITFIELD_SET(priv->mac_own, index);
+	rte_bitset_set(priv->mac_own, index);
 	return 0;
 }
 
-- 
2.54.0

