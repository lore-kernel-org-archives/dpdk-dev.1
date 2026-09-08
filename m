Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97563C79FA0
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 09:28:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D9A040E26;
	Tue,  8 Sep 2026 11:28:10 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id D573940E27
 for <dev@dpdk.org>; Tue,  8 Sep 2026 11:28:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788859688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+EZ1KvneMludHe6suJzHOF2QrHP72oYpbsmiGQVQ2ow=;
 b=fB0KHxb63tOGOoYfNi8v+GP2vKsSEN+N30D8p30iz7pC8FFLBfak8ziiQz/AV9eF6QkgN0
 GTFM1s2QrlhxHMnCVzRkzjd7L2nn+jBrK57kH5tqMSCJ9D8gg7SpPigHaENrAmeNZLgXiL
 52BxQiDMZ+L+GcMxelrwkCh51F1nmjE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-2GUf7lC5M0KTIAVLjTy30w-1; Tue,
 08 Sep 2026 05:28:03 -0400
X-MC-Unique: 2GUf7lC5M0KTIAVLjTy30w-1
X-Mimecast-MFC-AGG-ID: 2GUf7lC5M0KTIAVLjTy30w_1788859681
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA96219344B3; Tue,  8 Sep 2026 09:28:01 +0000 (UTC)
Received: from dmarchan.home (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ACA7F427; Tue,  8 Sep 2026 09:27:59 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com, cfontain@redhat.com,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v6 3/5] net/mlx5: pass maximum number of unicast MAC to common
 code
Date: Tue,  8 Sep 2026 11:27:41 +0200
Message-ID: <20260908092743.3439825-3-david.marchand@redhat.com>
In-Reply-To: <20260908092743.3439825-1-david.marchand@redhat.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260908092743.3439825-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VgMf7Bvu8jWxBFNzfvwaKiS7fM_LbvXgz7_Hqxc0QZI_1788859681
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

Isolate how the MAC addresses array is walked through in the common code
by passing the max index at which a unicast MAC address is stored in
dev->data->mac_addrs[].

With this change, only net/mlx5 knows about the max number of
unicast/multicast MAC addresses.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v5:
- fixed mlx5_nl_mac_addr_cb,

---
 drivers/common/mlx5/linux/mlx5_nl.c | 20 ++++++++++++--------
 drivers/common/mlx5/linux/mlx5_nl.h |  2 +-
 drivers/common/mlx5/mlx5_common.h   |  8 --------
 drivers/net/mlx5/linux/mlx5_os.c    |  1 +
 drivers/net/mlx5/mlx5.h             |  8 ++++++++
 5 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/common/mlx5/linux/mlx5_nl.c b/drivers/common/mlx5/linux/mlx5_nl.c
index 3207eae563..12942eefa5 100644
--- a/drivers/common/mlx5/linux/mlx5_nl.c
+++ b/drivers/common/mlx5/linux/mlx5_nl.c
@@ -174,6 +174,7 @@ struct mlx5_nl_mac_addr {
 	struct rte_ether_addr (*mac)[];
 	/**< MAC address handled by the device. */
 	int mac_n; /**< Number of addresses in the array. */
+	int max_macs; /**< Size of the array. */
 };
 
 static RTE_ATOMIC(uint32_t) atomic_sn;
@@ -475,7 +476,7 @@ mlx5_nl_mac_addr_cb(struct nlmsghdr *nh, void *arg)
 	     RTA_OK(attribute, len);
 	     attribute = RTA_NEXT(attribute, len)) {
 		if (attribute->rta_type == NDA_LLADDR) {
-			if (data->mac_n == MLX5_MAX_MAC_ADDRESSES) {
+			if (data->mac_n == data->max_macs) {
 				DRV_LOG(WARNING,
 					"not enough room to finalize the"
 					" request");
@@ -505,9 +506,9 @@ mlx5_nl_mac_addr_cb(struct nlmsghdr *nh, void *arg)
  *   Net device interface index.
  * @param mac[out]
  *   Pointer to the array table of MAC addresses to fill.
- *   Its size should be of MLX5_MAX_MAC_ADDRESSES.
- * @param mac_n[out]
- *   Number of entries filled in MAC array.
+ * @param mac_n[in,out]
+ *   Size of the MAC array on input.
+ *   Number of entries filled in MAC array on output.
  *
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
@@ -533,6 +534,7 @@ mlx5_nl_mac_addr_list(int nlsk_fd, unsigned int iface_idx,
 	struct mlx5_nl_mac_addr data = {
 		.mac = mac,
 		.mac_n = 0,
+		.max_macs = *mac_n,
 	};
 	uint32_t sn = MLX5_NL_SN_GENERATE;
 	int ret;
@@ -766,16 +768,18 @@ mlx5_nl_mac_addr_remove(int nlsk_fd, unsigned int iface_idx,
  *   Net device interface index.
  * @param mac_addrs
  *   Mac addresses array to sync.
+ * @param uc_n
+ *   Number of UC entries in @p mac_addrs.
  * @param n
  *   @p mac_addrs array size.
  */
 RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_mac_addr_sync)
 void
 mlx5_nl_mac_addr_sync(int nlsk_fd, unsigned int iface_idx,
-		      struct rte_ether_addr *mac_addrs, int n)
+		      struct rte_ether_addr *mac_addrs, int uc_n, int n)
 {
 	struct rte_ether_addr macs[n];
-	int macs_n = 0;
+	int macs_n = n;
 	int i;
 	int ret;
 
@@ -794,7 +798,7 @@ mlx5_nl_mac_addr_sync(int nlsk_fd, unsigned int iface_idx,
 			continue;
 		if (rte_is_multicast_ether_addr(&macs[i])) {
 			/* Find the first entry available. */
-			for (j = MLX5_MAX_UC_MAC_ADDRESSES; j != n; ++j) {
+			for (j = uc_n; j != n; ++j) {
 				if (rte_is_zero_ether_addr(&mac_addrs[j])) {
 					mac_addrs[j] = macs[i];
 					break;
@@ -802,7 +806,7 @@ mlx5_nl_mac_addr_sync(int nlsk_fd, unsigned int iface_idx,
 			}
 		} else {
 			/* Find the first entry available. */
-			for (j = 0; j != MLX5_MAX_UC_MAC_ADDRESSES; ++j) {
+			for (j = 0; j != uc_n; ++j) {
 				if (rte_is_zero_ether_addr(&mac_addrs[j])) {
 					mac_addrs[j] = macs[i];
 					break;
diff --git a/drivers/common/mlx5/linux/mlx5_nl.h b/drivers/common/mlx5/linux/mlx5_nl.h
index 0d6259f4ad..07a3b531b5 100644
--- a/drivers/common/mlx5/linux/mlx5_nl.h
+++ b/drivers/common/mlx5/linux/mlx5_nl.h
@@ -63,7 +63,7 @@ int mlx5_nl_mac_addr_remove(int nlsk_fd, unsigned int iface_idx,
 			    struct rte_ether_addr *mac);
 __rte_internal
 void mlx5_nl_mac_addr_sync(int nlsk_fd, unsigned int iface_idx,
-			   struct rte_ether_addr *mac_addrs, int n);
+			   struct rte_ether_addr *mac_addrs, int uc_n, int n);
 __rte_internal
 int mlx5_nl_promisc(int nlsk_fd, unsigned int iface_idx, int enable);
 __rte_internal
diff --git a/drivers/common/mlx5/mlx5_common.h b/drivers/common/mlx5/mlx5_common.h
index 3767020823..8aed3dbabe 100644
--- a/drivers/common/mlx5/mlx5_common.h
+++ b/drivers/common/mlx5/mlx5_common.h
@@ -160,14 +160,6 @@ enum {
 	PCI_DEVICE_ID_MELLANOX_CONNECTX10C2C = 0x2101,
 };
 
-/* Maximum number of simultaneous unicast MAC addresses. */
-#define MLX5_MAX_UC_MAC_ADDRESSES 128
-/* Maximum number of simultaneous Multicast MAC addresses. */
-#define MLX5_MAX_MC_MAC_ADDRESSES 128
-/* Maximum number of simultaneous MAC addresses. */
-#define MLX5_MAX_MAC_ADDRESSES \
-	(MLX5_MAX_UC_MAC_ADDRESSES + MLX5_MAX_MC_MAC_ADDRESSES)
-
 /* Recognized Infiniband device physical port name types. */
 enum mlx5_nl_phys_port_name_type {
 	MLX5_PHYS_PORT_NAME_TYPE_NOTSET = 0, /* Not set. */
diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index c65293cb25..0e59d3f2f5 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -1762,6 +1762,7 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 		mlx5_nl_mac_addr_sync(priv->nl_socket_route,
 				      mlx5_ifindex(eth_dev),
 				      eth_dev->data->mac_addrs,
+				      MLX5_MAX_UC_MAC_ADDRESSES,
 				      MLX5_MAX_MAC_ADDRESSES);
 	priv->ctrl_flows = 0;
 	rte_spinlock_init(&priv->flow_list_lock);
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index 190d203c49..c77cdc48a8 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -82,6 +82,14 @@
 /* Maximum allowed MTU to be reported whenever PMD cannot query it from OS. */
 #define MLX5_ETH_MAX_MTU (9978)
 
+/* Maximum number of simultaneous unicast MAC addresses. */
+#define MLX5_MAX_UC_MAC_ADDRESSES 128
+/* Maximum number of simultaneous Multicast MAC addresses. */
+#define MLX5_MAX_MC_MAC_ADDRESSES 128
+/* Maximum number of simultaneous MAC addresses. */
+#define MLX5_MAX_MAC_ADDRESSES \
+	(MLX5_MAX_UC_MAC_ADDRESSES + MLX5_MAX_MC_MAC_ADDRESSES)
+
 enum mlx5_ipool_index {
 #if defined(HAVE_IBV_FLOW_DV_SUPPORT) || !defined(HAVE_INFINIBAND_VERBS_H)
 	MLX5_IPOOL_DECAP_ENCAP = 0, /* Pool for encap/decap resource. */
-- 
2.54.0

