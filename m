Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFD8C55167
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jul 2026 09:23:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5313D406FF;
	Fri, 31 Jul 2026 11:23:50 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id C296140288
 for <dev@dpdk.org>; Fri, 31 Jul 2026 11:23:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785489828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JOTxQm5fx2oM+OywWjlUUacHA12KmTwYLoxXJ4E9aRA=;
 b=hbrJRWuw9oy43X7koGl6ALONi5O/XqUvLlqi7nKOxWq9a8YZ7xct/jn7RaPZWWZ2YOf6HF
 0T6kKJbKM3EPg5Jq/+PlaL4UDLiefN4oA/2LT5H2u1ZjhQfk4L9MbChG1qzqYWoQ7x8dY1
 zOCd2GDuo7ybeW/ZaT8YTIqDIlMyCsI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-OApoSHreMCSYhqstUXw7yg-1; Fri,
 31 Jul 2026 05:23:43 -0400
X-MC-Unique: OApoSHreMCSYhqstUXw7yg-1
X-Mimecast-MFC-AGG-ID: OApoSHreMCSYhqstUXw7yg_1785489821
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7EBEF195608D; Fri, 31 Jul 2026 09:23:41 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3724830002E9; Fri, 31 Jul 2026 09:23:37 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Adrien Mazarguil <adrien.mazarguil@6wind.com>,
 Nelio Laranjeiro <nelio.laranjeiro@6wind.com>
Subject: [PATCH 1/2] net/mlx5: fix promiscuous inconsistency on port start
Date: Fri, 31 Jul 2026 11:23:31 +0200
Message-ID: <20260731092332.3833632-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GLSJtM2kJI-mnwtv6-dYiqxUahBKGGrkTTbnOeuIMt8_1785489821
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

The kernel netdev promiscuous or all multicast mode could be enabled
before DPDK starts the port. This would cause an inconsistency between
the kernel state and DPDK's expected state
(dev->data->promiscuous / dev->data->all_multicast).

Add mlx5_os_get_promisc() and mlx5_os_get_allmulti() to query the
current kernel state via netlink. On port start, compare the kernel
state with DPDK's state and sync if they differ.

On Windows, these getters always return false as there seems to be no
API for getting the states.

Fixes: dd4bb90bc3cb ("net/mlx5: use Netlink to enable promisc/allmulti mode")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/common/mlx5/linux/mlx5_nl.c | 116 +++++++++++++++++++++++-----
 drivers/common/mlx5/linux/mlx5_nl.h |   4 +
 drivers/net/mlx5/linux/mlx5_os.c    |  34 ++++++++
 drivers/net/mlx5/mlx5.h             |   2 +
 drivers/net/mlx5/mlx5_trigger.c     |  14 ++++
 drivers/net/mlx5/windows/mlx5_os.c  |  32 ++++++++
 6 files changed, 182 insertions(+), 20 deletions(-)

diff --git a/drivers/common/mlx5/linux/mlx5_nl.c b/drivers/common/mlx5/linux/mlx5_nl.c
index 8b19838a7e..42ccb73e36 100644
--- a/drivers/common/mlx5/linux/mlx5_nl.c
+++ b/drivers/common/mlx5/linux/mlx5_nl.c
@@ -966,6 +966,101 @@ mlx5_nl_allmulti(int nlsk_fd, unsigned int iface_idx, int enable)
 	return ret;
 }
 
+/**
+ * Query link information via Netlink.
+ *
+ * @param[in] nlsk_fd
+ *   Netlink socket file descriptor.
+ * @param[in] iface_idx
+ *   Net device interface index.
+ * @param[in] cb
+ *   Callback to process the response.
+ * @param[out] arg
+ *   Opaque argument for the callback.
+ *
+ * @return
+ *   0 on success, a negative errno value otherwise.
+ */
+static int
+mlx5_nl_link_info(int nlsk_fd, unsigned int iface_idx,
+		  int (*cb)(struct nlmsghdr *, void *), void *arg)
+{
+	struct {
+		struct nlmsghdr hdr;
+		struct ifinfomsg ifi;
+	} req = {
+		.hdr = {
+			.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg)),
+			.nlmsg_type = RTM_GETLINK,
+			.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK,
+		},
+		.ifi = {
+			.ifi_family = AF_UNSPEC,
+			.ifi_index = iface_idx,
+		},
+	};
+	uint32_t sn = MLX5_NL_SN_GENERATE;
+	int ret;
+
+	ret = mlx5_nl_send(nlsk_fd, &req.hdr, sn);
+	if (ret >= 0)
+		ret = mlx5_nl_recv(nlsk_fd, sn, cb, arg);
+	return ret;
+}
+
+static int
+mlx5_nl_get_flags_cb(struct nlmsghdr *nh, void *arg)
+{
+	struct ifinfomsg *ifm = NLMSG_DATA(nh);
+
+	*(uint32_t *)arg = ifm->ifi_flags;
+	return 0;
+}
+
+/**
+ * Get promiscuous mode via Netlink.
+ *
+ * @param[in] nlsk_fd
+ *   Netlink socket file descriptor.
+ * @param[in] iface_idx
+ *   Net device interface index.
+ *
+ * @return
+ *   True if promiscuous mode is enabled, false otherwise.
+ */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_get_promisc)
+bool
+mlx5_nl_get_promisc(int nlsk_fd, unsigned int iface_idx)
+{
+	uint32_t flags = 0;
+
+	if (mlx5_nl_link_info(nlsk_fd, iface_idx, mlx5_nl_get_flags_cb, &flags))
+		return false;
+	return !!(flags & IFF_PROMISC);
+}
+
+/**
+ * Get all multicast mode via Netlink.
+ *
+ * @param[in] nlsk_fd
+ *   Netlink socket file descriptor.
+ * @param[in] iface_idx
+ *   Net device interface index.
+ *
+ * @return
+ *   True if all multicast mode is enabled, false otherwise.
+ */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_get_allmulti)
+bool
+mlx5_nl_get_allmulti(int nlsk_fd, unsigned int iface_idx)
+{
+	uint32_t flags = 0;
+
+	if (mlx5_nl_link_info(nlsk_fd, iface_idx, mlx5_nl_get_flags_cb, &flags))
+		return false;
+	return !!(flags & IFF_ALLMULTI);
+}
+
 /**
  * Process network interface information from Netlink message.
  *
@@ -2313,21 +2408,6 @@ int
 mlx5_nl_get_mtu_bounds(int nl, unsigned int ifindex, uint16_t *min_mtu, uint16_t *max_mtu)
 {
 	struct mlx5_mtu out = { 0 };
-	struct {
-		struct nlmsghdr nh;
-		struct ifinfomsg info;
-	} req = {
-		.nh = {
-			.nlmsg_len = NLMSG_LENGTH(sizeof(req.info)),
-			.nlmsg_type = RTM_GETLINK,
-			.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK,
-		},
-		.info = {
-			.ifi_family = AF_UNSPEC,
-			.ifi_index = ifindex,
-		},
-	};
-	uint32_t sn = MLX5_NL_SN_GENERATE;
 	int ret;
 
 	if (min_mtu == NULL || max_mtu == NULL) {
@@ -2335,11 +2415,7 @@ mlx5_nl_get_mtu_bounds(int nl, unsigned int ifindex, uint16_t *min_mtu, uint16_t
 		return -rte_errno;
 	}
 
-	ret = mlx5_nl_send(nl, &req.nh, sn);
-	if (ret < 0)
-		return ret;
-
-	ret = mlx5_nl_recv(nl, sn, mlx5_nl_get_mtu_bounds_cb, &out);
+	ret = mlx5_nl_link_info(nl, ifindex, mlx5_nl_get_mtu_bounds_cb, &out);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/common/mlx5/linux/mlx5_nl.h b/drivers/common/mlx5/linux/mlx5_nl.h
index 3f79a73c85..8ccdd244b0 100644
--- a/drivers/common/mlx5/linux/mlx5_nl.h
+++ b/drivers/common/mlx5/linux/mlx5_nl.h
@@ -74,6 +74,10 @@ int mlx5_nl_promisc(int nlsk_fd, unsigned int iface_idx, int enable);
 __rte_internal
 int mlx5_nl_allmulti(int nlsk_fd, unsigned int iface_idx, int enable);
 __rte_internal
+bool mlx5_nl_get_promisc(int nlsk_fd, unsigned int iface_idx);
+__rte_internal
+bool mlx5_nl_get_allmulti(int nlsk_fd, unsigned int iface_idx);
+__rte_internal
 unsigned int mlx5_nl_portnum(int nl, const char *name, struct mlx5_dev_info *dev_info);
 __rte_internal
 unsigned int mlx5_nl_ifindex(int nl, const char *name, uint32_t pindex,
diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index adc5878296..592e233844 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -3483,6 +3483,40 @@ mlx5_os_set_allmulti(struct rte_eth_dev *dev, int enable)
 				mlx5_ifindex(dev), !!enable);
 }
 
+/**
+ * Get device promiscuous mode
+ *
+ * @param dev
+ *   Pointer to Ethernet device structure.
+ *
+ * @return
+ *   True if promiscuous mode is enabled, false otherwise.
+ */
+bool
+mlx5_os_get_promisc(struct rte_eth_dev *dev)
+{
+	struct mlx5_priv *priv = dev->data->dev_private;
+
+	return mlx5_nl_get_promisc(priv->nl_socket_route, mlx5_ifindex(dev));
+}
+
+/**
+ * Get device all multicast mode
+ *
+ * @param dev
+ *   Pointer to Ethernet device structure.
+ *
+ * @return
+ *   True if all multicast mode is enabled, false otherwise.
+ */
+bool
+mlx5_os_get_allmulti(struct rte_eth_dev *dev)
+{
+	struct mlx5_priv *priv = dev->data->dev_private;
+
+	return mlx5_nl_get_allmulti(priv->nl_socket_route, mlx5_ifindex(dev));
+}
+
 /**
  * Flush device MAC addresses
  *
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index 27e6f4e31a..190d203c49 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -2639,6 +2639,8 @@ int mlx5_os_vf_mac_addr_modify(struct mlx5_priv *priv, unsigned int iface_idx,
 			       int vf_index);
 int mlx5_os_set_promisc(struct rte_eth_dev *dev, int enable);
 int mlx5_os_set_allmulti(struct rte_eth_dev *dev, int enable);
+bool mlx5_os_get_promisc(struct rte_eth_dev *dev);
+bool mlx5_os_get_allmulti(struct rte_eth_dev *dev);
 int mlx5_os_set_nonblock_channel_fd(int fd);
 void mlx5_os_mac_addr_flush(struct rte_eth_dev *dev);
 void mlx5_os_net_cleanup(void);
diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index 25847c8ba2..2a91e02b45 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -1455,6 +1455,20 @@ mlx5_dev_start(struct rte_eth_dev *dev)
 		}
 	}
 #endif
+	if (priv->sh->dev_cap.vf || priv->sh->dev_cap.sf) {
+		if (mlx5_os_get_promisc(dev) != dev->data->promiscuous) {
+			DRV_LOG(INFO, "port %u forcing promiscuous mode to %s",
+				dev->data->port_id,
+				dev->data->promiscuous ? "enabled" : "disabled");
+			mlx5_os_set_promisc(dev, dev->data->promiscuous);
+		}
+		if (mlx5_os_get_allmulti(dev) != dev->data->all_multicast) {
+			DRV_LOG(INFO, "port %u forcing all multicast mode to %s",
+				dev->data->port_id,
+				dev->data->all_multicast ? "enabled" : "disabled");
+			mlx5_os_set_allmulti(dev, dev->data->all_multicast);
+		}
+	}
 	ret = mlx5_traffic_enable(dev);
 	if (ret) {
 		DRV_LOG(ERR, "port %u failed to set defaults flows",
diff --git a/drivers/net/mlx5/windows/mlx5_os.c b/drivers/net/mlx5/windows/mlx5_os.c
index 9acfa8ec84..cf34e4e1d6 100644
--- a/drivers/net/mlx5/windows/mlx5_os.c
+++ b/drivers/net/mlx5/windows/mlx5_os.c
@@ -829,6 +829,38 @@ mlx5_os_set_allmulti(struct rte_eth_dev *dev, int enable)
 	return mlx5_glue->devx_set_promisc_vport(priv->sh->cdev->ctx, MC_PROMISC, enable);
 }
 
+/**
+ * Get device promiscuous mode
+ *
+ * @param dev
+ *   Pointer to Ethernet device structure.
+ *
+ * @return
+ *   Always false on Windows.
+ */
+bool
+mlx5_os_get_promisc(struct rte_eth_dev *dev)
+{
+	RTE_SET_USED(dev);
+	return false;
+}
+
+/**
+ * Get device all multicast mode
+ *
+ * @param dev
+ *   Pointer to Ethernet device structure.
+ *
+ * @return
+ *   Always false on Windows.
+ */
+bool
+mlx5_os_get_allmulti(struct rte_eth_dev *dev)
+{
+	RTE_SET_USED(dev);
+	return false;
+}
+
 /**
  * DPDK callback to register a PCI device.
  *
-- 
2.54.0

