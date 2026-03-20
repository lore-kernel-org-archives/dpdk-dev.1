Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101FC10987A9
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 16:45:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23296402BB;
	Fri, 20 Mar 2026 17:45:38 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7C9CF402B2
 for <dev@dpdk.org>; Fri, 20 Mar 2026 17:45:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774025136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pbBVhib2kytYJMJtIDrlToVm3yuNxllzegtGOvgUctA=;
 b=eAvySIjHYbzbSfdEuju/QE9d6M4OpKxTsbONKpz8757eUQAT5523i0xriMLeKmNTMx4b4O
 xu8GjfFgrI7fcwm9xIgJsotqHYQ87skWxDoPdB5ihnx990nCCyQLymJGBSpeIbH8m+7Ui/
 ERwg8Z+a0P0taxachkAvLV7ZsKL6bxA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-BWIszncMOAqCNAzwAN2uow-1; Fri,
 20 Mar 2026 12:45:33 -0400
X-MC-Unique: BWIszncMOAqCNAzwAN2uow-1
X-Mimecast-MFC-AGG-ID: BWIszncMOAqCNAzwAN2uow_1774025132
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2DBC9195608D; Fri, 20 Mar 2026 16:45:32 +0000 (UTC)
Received: from ringo.home (unknown [10.44.32.239])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E4E5D1800763; Fri, 20 Mar 2026 16:45:30 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH dpdk v2] net/tap: add software MAC address filtering
Date: Fri, 20 Mar 2026 17:45:24 +0100
Message-ID: <20260320164523.810401-2-rjarry@redhat.com>
In-Reply-To: <20260319221034.703656-2-rjarry@redhat.com>
References: <20260319221034.703656-2-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mFcAkKtuO4Ib4FVvy1yi58JH7DJ4noGSqnohPUwimVI_1774025132
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

Linux TAP devices deliver all packets to userspace regardless of the
PROMISC/ALLMULTI flags on the interface. When promiscuous mode is
disabled, drop received packets whose destination MAC does not match
any configured unicast or multicast address.

The receive path checks the destination MAC against the device's
unicast address table (managed by the ethdev layer), the multicast
address list (stored by the driver since the ethdev layer does not keep
a copy), and accepts broadcast unconditionally. Promiscuous and
all-multicast modes bypass the respective checks.

To support multiple unicast addresses via rte_eth_dev_mac_addr_add(),
allocate mac_addrs with rte_zmalloc (TAP_MAX_MAC_ADDRS=16) instead of
pointing into dev_private, and advertise the new limit in dev_infos_get.

Dropped packets are reported via per-queue xstats
(rx_q<N>_mac_filter_drops).

Signed-off-by: Robin Jarry <rjarry@redhat.com>
---

Notes:
    v2:
    
    * removed opt-in `macfilter=1` flag
    * reorganized filter_match function to check unicast addresses first

 drivers/net/tap/rte_eth_tap.c | 159 ++++++++++++++++++++++++++++++----
 drivers/net/tap/rte_eth_tap.h |   6 ++
 2 files changed, 150 insertions(+), 15 deletions(-)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index 13e0a23c34a1..d6c35ce5e788 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -58,6 +58,8 @@
 #define ETH_TAP_CMP_MAC_FMT     "0123456789ABCDEFabcdef"
 #define ETH_TAP_MAC_ARG_FMT     ETH_TAP_MAC_FIXED "|" ETH_TAP_USR_MAC_FMT
 
+#define TAP_MAX_MAC_ADDRS	16
+
 #define TAP_GSO_MBUFS_PER_CORE	128
 #define TAP_GSO_MBUF_SEG_SIZE	128
 #define TAP_GSO_MBUF_CACHE_SIZE	4
@@ -437,6 +439,42 @@ tap_rxq_pool_free(struct rte_mbuf *pool)
 	rte_pktmbuf_free(pool);
 }
 
+static inline bool
+tap_mac_filter_match(struct rx_queue *rxq, struct rte_mbuf *mbuf)
+{
+	struct pmd_internals *pmd = rxq->pmd;
+	struct rte_eth_dev_data *data;
+	struct rte_ether_addr *dst;
+	uint32_t i;
+
+	if (pmd->type != ETH_TUNTAP_TYPE_TAP)
+		return true;
+
+	data = pmd->dev->data;
+	if (data->promiscuous)
+		return true;
+
+	dst = rte_pktmbuf_mtod(mbuf, struct rte_ether_addr *);
+
+	if (likely(rte_is_unicast_ether_addr(dst))) {
+		for (i = 0; i < TAP_MAX_MAC_ADDRS; i++) {
+			if (rte_is_same_ether_addr(dst, &data->mac_addrs[i]))
+				return true;
+		}
+		return false;
+	}
+
+	if (data->all_multicast)
+		return true;
+
+	for (i = 0; i < pmd->nb_mc_addrs; i++) {
+		if (rte_is_same_ether_addr(dst, &pmd->mc_addrs[i]))
+			return true;
+	}
+
+	return rte_is_broadcast_ether_addr(dst);
+}
+
 /* Callback to handle the rx burst of packets to the correct interface and
  * file descriptor(s) in a multi-queue setup.
  */
@@ -515,6 +553,13 @@ pmd_rx_burst(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			data_off = 0;
 		}
 		seg->next = NULL;
+
+		if (!tap_mac_filter_match(rxq, mbuf)) {
+			rxq->stats.mac_drops++;
+			rte_pktmbuf_free(mbuf);
+			continue;
+		}
+
 		mbuf->packet_type = rte_net_get_ptype(mbuf, NULL,
 						      RTE_PTYPE_ALL_MASK);
 		if (rxq->rxmode->offloads & RTE_ETH_RX_OFFLOAD_CHECKSUM)
@@ -933,7 +978,7 @@ tap_dev_info(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	struct pmd_internals *internals = dev->data->dev_private;
 
 	dev_info->if_index = internals->if_index;
-	dev_info->max_mac_addrs = 1;
+	dev_info->max_mac_addrs = TAP_MAX_MAC_ADDRS;
 	dev_info->max_rx_pktlen = RTE_ETHER_MAX_JUMBO_FRAME_LEN;
 	dev_info->max_rx_queues = RTE_PMD_TAP_MAX_QUEUES;
 	dev_info->max_tx_queues = RTE_PMD_TAP_MAX_QUEUES;
@@ -1025,6 +1070,43 @@ tap_stats_reset(struct rte_eth_dev *dev)
 	return 0;
 }
 
+static int
+tap_xstats_get_names(struct rte_eth_dev *dev,
+		     struct rte_eth_xstat_name *names,
+		     unsigned int limit __rte_unused)
+{
+	unsigned int i;
+
+	if (names == NULL)
+		return dev->data->nb_rx_queues;
+
+	for (i = 0; i < dev->data->nb_rx_queues; i++)
+		snprintf(names[i].name, sizeof(names[i].name),
+			 "rx_q%u_mac_filter_drops", i);
+
+	return dev->data->nb_rx_queues;
+}
+
+static int
+tap_xstats_get(struct rte_eth_dev *dev, struct rte_eth_xstat *xstats,
+	       unsigned int n)
+{
+	struct rte_eth_dev_data *data = dev->data;
+	struct rx_queue *rxq;
+	unsigned int i;
+
+	if (n < dev->data->nb_rx_queues)
+		return dev->data->nb_rx_queues;
+
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		rxq = data->rx_queues[i];
+		xstats[i].id = i;
+		xstats[i].value = rxq->stats.mac_drops;
+	}
+
+	return dev->data->nb_rx_queues;
+}
+
 static void
 tap_queue_close(struct pmd_process_private *process_private, uint16_t qid)
 {
@@ -1089,14 +1171,15 @@ tap_dev_close(struct rte_eth_dev *dev)
 	rte_mempool_free(internals->gso_ctx_mp);
 	internals->gso_ctx_mp = NULL;
 
+	rte_free(internals->mc_addrs);
+	internals->mc_addrs = NULL;
+	internals->nb_mc_addrs = 0;
+
 	if (internals->ka_fd != -1) {
 		close(internals->ka_fd);
 		internals->ka_fd = -1;
 	}
 
-	/* mac_addrs must not be freed alone because part of dev_private */
-	dev->data->mac_addrs = NULL;
-
 	internals = dev->data->dev_private;
 	TAP_LOG(DEBUG, "Closing %s Ethernet device on numa %u",
 		tuntap_types[internals->type], rte_socket_id());
@@ -1574,6 +1657,7 @@ tap_rx_queue_setup(struct rte_eth_dev *dev,
 	}
 	tmp = &rxq->pool;
 
+	rxq->pmd = internals;
 	rxq->mp = mp;
 	rxq->trigger_seen = 1; /* force initial burst */
 	rxq->in_port = dev->data->port_id;
@@ -1692,17 +1776,50 @@ tap_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
 }
 
 static int
-tap_set_mc_addr_list(struct rte_eth_dev *dev __rte_unused,
-		     struct rte_ether_addr *mc_addr_set __rte_unused,
-		     uint32_t nb_mc_addr __rte_unused)
+tap_set_mc_addr_list(struct rte_eth_dev *dev,
+		     struct rte_ether_addr *mc_addr_set,
+		     uint32_t nb_mc_addr)
 {
-	/*
-	 * Nothing to do actually: the tap has no filtering whatsoever, every
-	 * packet is received.
-	 */
+	struct pmd_internals *pmd = dev->data->dev_private;
+
+	if (nb_mc_addr == 0) {
+		rte_free(pmd->mc_addrs);
+		pmd->mc_addrs = NULL;
+		pmd->nb_mc_addrs = 0;
+		return 0;
+	}
+
+	pmd->mc_addrs = rte_realloc(pmd->mc_addrs,
+				    nb_mc_addr * sizeof(*pmd->mc_addrs), 0);
+	if (pmd->mc_addrs == NULL) {
+		pmd->nb_mc_addrs = 0;
+		return -ENOMEM;
+	}
+
+	memcpy(pmd->mc_addrs, mc_addr_set,
+	       nb_mc_addr * sizeof(*pmd->mc_addrs));
+	pmd->nb_mc_addrs = nb_mc_addr;
+
 	return 0;
 }
 
+static int
+tap_mac_addr_add(struct rte_eth_dev *dev __rte_unused,
+		 struct rte_ether_addr *mac_addr __rte_unused,
+		 uint32_t index __rte_unused,
+		 uint32_t vmdq __rte_unused)
+{
+	/* ethdev layer already stores the address in mac_addrs[] */
+	return 0;
+}
+
+static void
+tap_mac_addr_remove(struct rte_eth_dev *dev __rte_unused,
+		    uint32_t index __rte_unused)
+{
+	/* ethdev layer already zeroes the slot in mac_addrs[] */
+}
+
 static void tap_dev_intr_handler(void *cb_arg);
 static int tap_lsc_intr_handle_set(struct rte_eth_dev *dev, int set);
 
@@ -2038,10 +2155,15 @@ static const struct eth_dev_ops ops = {
 	.allmulticast_enable    = tap_allmulti_enable,
 	.allmulticast_disable   = tap_allmulti_disable,
 	.mac_addr_set           = tap_mac_set,
+	.mac_addr_add           = tap_mac_addr_add,
+	.mac_addr_remove        = tap_mac_addr_remove,
 	.mtu_set                = tap_mtu_set,
 	.set_mc_addr_list       = tap_set_mc_addr_list,
 	.stats_get              = tap_stats_get,
 	.stats_reset            = tap_stats_reset,
+	.xstats_get             = tap_xstats_get,
+	.xstats_get_names       = tap_xstats_get_names,
+	.xstats_reset           = tap_stats_reset,
 	.dev_supported_ptypes_get = tap_dev_supported_ptypes_get,
 	.rss_hash_update        = tap_rss_hash_update,
 #ifdef HAVE_TCA_FLOWER
@@ -2102,7 +2224,14 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
 	data->numa_node = numa_node;
 
 	data->dev_link = pmd_link;
-	data->mac_addrs = &pmd->eth_addr;
+	data->mac_addrs = rte_zmalloc_socket(rte_vdev_device_name(vdev),
+					     TAP_MAX_MAC_ADDRS *
+					     sizeof(struct rte_ether_addr),
+					     0, numa_node);
+	if (data->mac_addrs == NULL) {
+		TAP_LOG(ERR, "Failed to allocate mac_addrs");
+		goto error_exit;
+	}
 	/* Set the number of RX and TX queues */
 	data->nb_rx_queues = 0;
 	data->nb_tx_queues = 0;
@@ -2119,7 +2248,6 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
 	for (i = 0; i < RTE_PMD_TAP_MAX_QUEUES; i++)
 		process_private->fds[i] = -1;
 
-
 	if (pmd->type == ETH_TUNTAP_TYPE_TAP) {
 		if (rte_is_zero_ether_addr(mac_addr))
 			rte_eth_random_addr((uint8_t *)&pmd->eth_addr);
@@ -2227,6 +2355,9 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
 	}
 #endif
 
+	/* Copy final MAC to slot 0 (remote path may have overwritten it) */
+	data->mac_addrs[0] = pmd->eth_addr;
+
 	rte_eth_dev_probing_finish(dev);
 	return 0;
 
@@ -2246,8 +2377,6 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
 	free(dev->process_private);
 
 error_exit_nodev_release:
-	/* mac_addrs must not be freed alone because part of dev_private */
-	dev->data->mac_addrs = NULL;
 	rte_eth_dev_release_port(dev);
 
 error_exit_nodev:
diff --git a/drivers/net/tap/rte_eth_tap.h b/drivers/net/tap/rte_eth_tap.h
index b44eaf9a1bdb..8aa292bbd013 100644
--- a/drivers/net/tap/rte_eth_tap.h
+++ b/drivers/net/tap/rte_eth_tap.h
@@ -38,9 +38,13 @@ struct queue_stats {
 	uint64_t packets;
 	uint64_t bytes;
 	uint64_t errors;
+	uint64_t mac_drops;             /* Packets dropped by MAC filter */
 };
 
+struct pmd_internals;
+
 struct rx_queue {
+	struct pmd_internals *pmd;      /* back-pointer to driver state */
 	struct rte_mempool *mp;         /* Mempool for RX packets */
 	uint32_t trigger_seen;          /* Last seen Rx trigger value */
 	uint16_t in_port;               /* Port ID */
@@ -70,6 +74,8 @@ struct pmd_internals {
 	int type;                         /* Type field - TUN|TAP */
 	int persist;			  /* 1 if keep link up, else 0 */
 	struct rte_ether_addr eth_addr;   /* Mac address of the device port */
+	struct rte_ether_addr *mc_addrs;  /* multicast address list */
+	uint32_t nb_mc_addrs;             /* multicast address count */
 	unsigned int remote_initial_flags;/* Remote netdevice flags on init */
 	int remote_if_index;              /* remote netdevice IF_INDEX */
 	int if_index;                     /* IF_INDEX for the port */
-- 
2.53.0

