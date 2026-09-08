Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24CBC79F82
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 09:28:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B812F40DF5;
	Tue,  8 Sep 2026 11:28:03 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 68E1F4026E
 for <dev@dpdk.org>; Tue,  8 Sep 2026 11:28:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788859682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OoxP+RZQ6i3+y8GK7n1SdvtCqCMs7o3Q4dfev1I4Wm4=;
 b=L6tUI1d2dO0JN0ePGdD9eUFlXqXdwdzE3r34mBXXgeCtWdBQOkbG43x40nABY25hZPIZ90
 qYUidx7p3u7YRx/od2GDsPBfsHejuCUHLPBxjs4plVbmro2bhRQZXEYzTddVZRiH8rKiNW
 J5ltf1f6YrJH8BiqkxZXF5ihzlRi+tk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-_HXUJlZ4Noy5NwAbHbRm2w-1; Tue,
 08 Sep 2026 05:27:58 -0400
X-MC-Unique: _HXUJlZ4Noy5NwAbHbRm2w-1
X-Mimecast-MFC-AGG-ID: _HXUJlZ4Noy5NwAbHbRm2w_1788859677
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D02619344B9; Tue,  8 Sep 2026 09:27:57 +0000 (UTC)
Received: from dmarchan.home (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 077D81955F0C; Tue,  8 Sep 2026 09:27:54 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com, cfontain@redhat.com,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v6 2/5] net/mlx5: remove redundant MAC address index checks
Date: Tue,  8 Sep 2026 11:27:40 +0200
Message-ID: <20260908092743.3439825-2-david.marchand@redhat.com>
In-Reply-To: <20260908092743.3439825-1-david.marchand@redhat.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260908092743.3439825-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cHlGm2joCAFiBGjcbGx8qybZwQhMkdWuCvDgcg4MzRw_1788859677
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

On the net/mlx5 side, mlx5_mac.c validates that any MAC address and its
index is valid before calling the OS specific helpers.
So those OS helpers do not have to validate again the index.

Cascading this consideration, validating the MAC index against
MLX5_MAX_MAC_ADDRESSES in common code is also redundant.
The common code only deals with netlink, remove any index concern.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/common/mlx5/linux/mlx5_nl.c | 17 ++---------------
 drivers/common/mlx5/linux/mlx5_nl.h |  4 ++--
 drivers/net/mlx5/linux/mlx5_os.c    |  9 ++++-----
 3 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/common/mlx5/linux/mlx5_nl.c b/drivers/common/mlx5/linux/mlx5_nl.c
index 40a8b8a2cc..3207eae563 100644
--- a/drivers/common/mlx5/linux/mlx5_nl.c
+++ b/drivers/common/mlx5/linux/mlx5_nl.c
@@ -719,8 +719,6 @@ mlx5_nl_vf_mac_addr_modify(int nlsk_fd, unsigned int iface_idx,
  *   Net device interface index.
  * @param mac
  *   MAC address to register.
- * @param index
- *   MAC address index.
  *
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
@@ -728,16 +726,11 @@ mlx5_nl_vf_mac_addr_modify(int nlsk_fd, unsigned int iface_idx,
 RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_mac_addr_add)
 int
 mlx5_nl_mac_addr_add(int nlsk_fd, unsigned int iface_idx,
-		     struct rte_ether_addr *mac, uint32_t index)
+		     struct rte_ether_addr *mac)
 {
 	int ret;
 
 	ret = mlx5_nl_mac_addr_modify(nlsk_fd, iface_idx, mac, 1);
-	if (!ret) {
-		MLX5_ASSERT(index < MLX5_MAX_MAC_ADDRESSES);
-		if (index >= MLX5_MAX_MAC_ADDRESSES)
-			return -EINVAL;
-	}
 	if (ret == -EEXIST)
 		return 0;
 	return ret;
@@ -752,8 +745,6 @@ mlx5_nl_mac_addr_add(int nlsk_fd, unsigned int iface_idx,
  *   Net device interface index.
  * @param mac
  *   MAC address to remove.
- * @param index
- *   MAC address index.
  *
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
@@ -761,12 +752,8 @@ mlx5_nl_mac_addr_add(int nlsk_fd, unsigned int iface_idx,
 RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_mac_addr_remove)
 int
 mlx5_nl_mac_addr_remove(int nlsk_fd, unsigned int iface_idx,
-			struct rte_ether_addr *mac, uint32_t index)
+			struct rte_ether_addr *mac)
 {
-	MLX5_ASSERT(index < MLX5_MAX_MAC_ADDRESSES);
-	if (index >= MLX5_MAX_MAC_ADDRESSES)
-		return -EINVAL;
-
 	return mlx5_nl_mac_addr_modify(nlsk_fd, iface_idx, mac, 0);
 }
 
diff --git a/drivers/common/mlx5/linux/mlx5_nl.h b/drivers/common/mlx5/linux/mlx5_nl.h
index 0242342c47..0d6259f4ad 100644
--- a/drivers/common/mlx5/linux/mlx5_nl.h
+++ b/drivers/common/mlx5/linux/mlx5_nl.h
@@ -57,10 +57,10 @@ __rte_internal
 int mlx5_nl_init(int protocol, int groups);
 __rte_internal
 int mlx5_nl_mac_addr_add(int nlsk_fd, unsigned int iface_idx,
-			 struct rte_ether_addr *mac, uint32_t index);
+			 struct rte_ether_addr *mac);
 __rte_internal
 int mlx5_nl_mac_addr_remove(int nlsk_fd, unsigned int iface_idx,
-			    struct rte_ether_addr *mac, uint32_t index);
+			    struct rte_ether_addr *mac);
 __rte_internal
 void mlx5_nl_mac_addr_sync(int nlsk_fd, unsigned int iface_idx,
 			   struct rte_ether_addr *mac_addrs, int n);
diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 49a8751761..c65293cb25 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -3382,9 +3382,8 @@ mlx5_os_mac_addr_remove(struct rte_eth_dev *dev, uint32_t index)
 	if (vf)
 		mlx5_nl_mac_addr_remove(priv->nl_socket_route,
 					mlx5_ifindex(dev),
-					&dev->data->mac_addrs[index], index);
-	if (index < MLX5_MAX_MAC_ADDRESSES)
-		BITFIELD_RESET(priv->mac_own, index);
+					&dev->data->mac_addrs[index]);
+	BITFIELD_RESET(priv->mac_own, index);
 }
 
 /**
@@ -3411,7 +3410,7 @@ mlx5_os_mac_addr_add(struct rte_eth_dev *dev, struct rte_ether_addr *mac,
 	if (vf)
 		ret = mlx5_nl_mac_addr_add(priv->nl_socket_route,
 					   mlx5_ifindex(dev),
-					   mac, index);
+					   mac);
 	if (!ret)
 		BITFIELD_SET(priv->mac_own, index);
 
@@ -3536,7 +3535,7 @@ mlx5_os_mac_addr_flush(struct rte_eth_dev *dev)
 			if (vf)
 				mlx5_nl_mac_addr_remove(priv->nl_socket_route,
 							mlx5_ifindex(dev),
-							&dev->data->mac_addrs[i], i);
+							&dev->data->mac_addrs[i]);
 			BITFIELD_RESET(priv->mac_own, i);
 		}
 	}
-- 
2.54.0

