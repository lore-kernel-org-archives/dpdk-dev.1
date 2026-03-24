Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F620FEC0F6
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 19:09:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC15440647;
	Tue, 24 Mar 2026 20:09:53 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id BB183402CC
 for <dev@dpdk.org>; Tue, 24 Mar 2026 20:09:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774379391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s83NEskY5OOT173kjK19+lRYV+FM/5NOQ3DPb8D7sK8=;
 b=XlEnDE9t7u/dfByT4bkBMUn0Qm3YEP3DgM69CEXjJu6pdwXcSgibQWetpDhdzcOeAYpNxS
 iALgZcCHWWqj1GsXRyOddU3xjcAo4SJ82Ai/TFb54z3RlUuzuM7nA0j5b185VcCe9eMf75
 BF7pJ5Hdbz15wyjAXd1QmZJKIAO+Zog=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-8po873gENL6tJeCY1YftcA-1; Tue,
 24 Mar 2026 15:09:47 -0400
X-MC-Unique: 8po873gENL6tJeCY1YftcA-1
X-Mimecast-MFC-AGG-ID: 8po873gENL6tJeCY1YftcA_1774379386
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 159D018005B0; Tue, 24 Mar 2026 19:09:46 +0000 (UTC)
Received: from ringo.redhat.com (unknown [10.44.32.115])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7087B19560B1; Tue, 24 Mar 2026 19:09:44 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH dpdk v5] net/tap: add software MAC address filtering
Date: Tue, 24 Mar 2026 20:09:16 +0100
Message-ID: <20260324190916.422283-2-rjarry@redhat.com>
In-Reply-To: <20260319221034.703656-2-rjarry@redhat.com>
References: <20260319221034.703656-2-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ldNrKFaegisiBQjusbSGD85lZU1fscLQxeTW8HyK-s0_1774379386
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

Add a test to ensure it works as expected.

Signed-off-by: Robin Jarry <rjarry@redhat.com>
---

Notes:
    v5:
    
    * Use TEST_ASSERT() instead of manual boilerplate.
    * Keep specific test functions to inject and receive packets. The existing ones
      cannot be reused.
    
    v4:
    
    * removed xstats
    * added test
    
    v3:
    
    * always drop zero destination mac addresses unless promisc is enabled
    
    v2:
    
    * removed opt-in `macfilter=1` flag
    * reorganized filter_match function to check unicast addresses first

 app/test/test_pmd_tap.c       | 180 ++++++++++++++++++++++++++++++++++
 drivers/net/tap/rte_eth_tap.c | 120 ++++++++++++++++++++---
 drivers/net/tap/rte_eth_tap.h |   5 +
 3 files changed, 290 insertions(+), 15 deletions(-)

diff --git a/app/test/test_pmd_tap.c b/app/test/test_pmd_tap.c
index dabd7d350672..6d0e8b4f5450 100644
--- a/app/test/test_pmd_tap.c
+++ b/app/test/test_pmd_tap.c
@@ -26,6 +26,9 @@ test_pmd_tap(void)
 #include <string.h>
 #include <unistd.h>
 #include <limits.h>
+#include <net/if.h>
+#include <sys/socket.h>
+#include <linux/if_packet.h>
 
 #include <rte_ethdev.h>
 #include <rte_bus_vdev.h>
@@ -1106,6 +1109,182 @@ test_tap_tx_burst(void)
 	return TEST_SUCCESS;
 }
 
+/*
+ * Inject a raw Ethernet frame via an AF_PACKET socket bound to the TAP's
+ * Linux interface and attempt to receive it with rte_eth_rx_burst.
+ */
+static int
+tap_inject_packet(const char *ifname, const struct rte_ether_addr *dst)
+{
+	uint8_t frame[RTE_ETHER_MIN_LEN - RTE_ETHER_CRC_LEN];
+	union {
+		struct sockaddr_ll sll;
+		struct sockaddr sock;
+	} addr;
+	struct rte_ether_hdr *eth;
+	unsigned int ifindex;
+	int fd, ret;
+
+	ifindex = if_nametoindex(ifname);
+	TEST_ASSERT(ifindex != 0, "if_nametoindex(%s) failed", ifname);
+
+	fd = socket(AF_PACKET, SOCK_RAW, RTE_BE16(RTE_ETHER_TYPE_IPV4));
+	TEST_ASSERT(fd >= 0, "AF_PACKET socket failed: %s", strerror(errno));
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sll.sll_family = AF_PACKET;
+	addr.sll.sll_ifindex = ifindex;
+	addr.sll.sll_protocol = RTE_BE16(RTE_ETHER_TYPE_IPV4);
+
+	ret = bind(fd, &addr.sock, sizeof(addr.sll));
+	TEST_ASSERT(ret == 0, "bind to %s failed: %s", ifname, strerror(errno));
+
+	memset(frame, 0, sizeof(frame));
+	eth = (struct rte_ether_hdr *)frame;
+	eth->dst_addr = *dst;
+	eth->src_addr = (struct rte_ether_addr){{0x02, 0, 0, 0xbb, 0, 0xaa}};
+	eth->ether_type = RTE_BE16(RTE_ETHER_TYPE_IPV4);
+
+	ret = send(fd, frame, sizeof(frame), 0);
+	TEST_ASSERT(ret == sizeof(frame), "send failed: %s", strerror(errno));
+
+	close(fd);
+	return 0;
+}
+
+static uint16_t
+tap_drain_rx(int port, const struct rte_ether_addr *dst)
+{
+	struct rte_mbuf *mbufs[MAX_PKT_BURST];
+	struct rte_ether_hdr *eth;
+	uint16_t total = 0;
+
+	/* drain the rxq 10 times to ensure the kernel has sent the packet */
+	for (uint16_t i = 0; i < 10; i++) {
+		uint16_t nb_rx = rte_eth_rx_burst(port, 0, mbufs, MAX_PKT_BURST);
+		for (uint16_t j = 0; j < nb_rx; j++) {
+			eth = rte_pktmbuf_mtod(mbufs[j], struct rte_ether_hdr *);
+			if (dst != NULL && rte_is_same_ether_addr(&eth->dst_addr, dst))
+				total += 1;
+			rte_pktmbuf_free(mbufs[j]);
+		}
+		usleep(1000);
+	}
+
+	return total;
+}
+
+static int
+test_tap_mac_filter(void)
+{
+	struct rte_ether_addr bcast_mac = {{0xff, 0xff, 0xff, 0xff, 0xff, 0xff}};
+	struct rte_ether_addr mcast_mac = {{0x01, 0, 0x5e, 0, 0, 0x01}};
+	struct rte_ether_addr foreign_mac = {{0x02, 0, 0, 0, 0, 0xaa}};
+	static const char *ifname = "dtap_test0";
+	struct rte_ether_addr port_mac;
+	uint16_t nb_rx;
+	int ret;
+
+	printf("Testing TAP MAC address filtering\n");
+
+	ret = rte_eth_macaddr_get(tap_port0, &port_mac);
+	TEST_ASSERT(ret == 0, "failed to get MAC for port %d", tap_port0);
+
+	/* Disable promisc so MAC filter is active */
+	rte_eth_promiscuous_disable(tap_port0);
+	rte_eth_allmulticast_disable(tap_port0);
+
+	/* Drain any stale packets */
+	tap_drain_rx(tap_port0, NULL);
+
+	/* Test 1: packet to port's own MAC should be received */
+	printf("  Test: unicast to own MAC\n");
+	ret = tap_inject_packet(ifname, &port_mac);
+	TEST_ASSERT(ret == 0, "packet inject failed");
+	nb_rx = tap_drain_rx(tap_port0, &port_mac);
+	TEST_ASSERT(nb_rx > 0, "packet to own MAC was not received");
+	printf("    Received %u packet(s) - OK\n", nb_rx);
+
+	/* Test 2: packet to foreign unicast MAC should be dropped */
+	printf("  Test: unicast to foreign MAC\n");
+	ret = tap_inject_packet(ifname, &foreign_mac);
+	TEST_ASSERT(ret == 0, "packet inject failed");
+	nb_rx = tap_drain_rx(tap_port0, &foreign_mac);
+	TEST_ASSERT(nb_rx == 0, "packet to foreign MAC was not dropped");
+	printf("    Dropped - OK\n");
+
+	/* Test 3: broadcast should always be received */
+	printf("  Test: broadcast\n");
+	ret = tap_inject_packet(ifname, &bcast_mac);
+	TEST_ASSERT(ret == 0, "packet inject failed");
+	nb_rx = tap_drain_rx(tap_port0, &bcast_mac);
+	TEST_ASSERT(nb_rx > 0, "broadcast packet was not received");
+	printf("    Received %u packet(s) - OK\n", nb_rx);
+
+	/* Test 4: promisc mode should bypass the filter */
+	printf("  Test: promisc receives foreign MAC\n");
+	rte_eth_promiscuous_enable(tap_port0);
+	ret = tap_inject_packet(ifname, &foreign_mac);
+	TEST_ASSERT(ret == 0, "packet inject failed");
+	nb_rx = tap_drain_rx(tap_port0, &foreign_mac);
+	TEST_ASSERT(nb_rx > 0, "promisc mode did not receive foreign MAC");
+	printf("    Received %u packet(s) - OK\n", nb_rx);
+	rte_eth_promiscuous_disable(tap_port0);
+
+	/* Test 5: multicast without allmulti and without mc list should drop */
+	printf("  Test: multicast dropped without mc list\n");
+	ret = tap_inject_packet(ifname, &mcast_mac);
+	TEST_ASSERT(ret == 0, "packet inject failed");
+	nb_rx = tap_drain_rx(tap_port0, &mcast_mac);
+	TEST_ASSERT(nb_rx == 0, "multicast was not dropped");
+	printf("    Dropped - OK\n");
+
+	/* Test 6: multicast with matching mc list should be received */
+	printf("  Test: multicast received with mc list\n");
+	ret = rte_eth_dev_set_mc_addr_list(tap_port0, &mcast_mac, 1);
+	TEST_ASSERT(ret == 0, "set_mc_addr_list failed: %s", rte_strerror(-ret));
+	ret = tap_inject_packet(ifname, &mcast_mac);
+	TEST_ASSERT(ret == 0, "packet inject failed");
+	nb_rx = tap_drain_rx(tap_port0, &mcast_mac);
+	TEST_ASSERT(nb_rx > 0, "multicast with matching mc list was not received");
+	printf("    Received %u packet(s) - OK\n", nb_rx);
+	rte_eth_dev_set_mc_addr_list(tap_port0, NULL, 0);
+
+	/* Test 7: allmulti should receive any multicast */
+	printf("  Test: allmulti receives multicast\n");
+	rte_eth_allmulticast_enable(tap_port0);
+	ret = tap_inject_packet(ifname, &mcast_mac);
+	if (ret < 0)
+		return TEST_FAILED;
+	nb_rx = tap_drain_rx(tap_port0, &mcast_mac);
+	TEST_ASSERT(nb_rx > 0, "allmulti did not receive multicast");
+	printf("    Received %u packet(s) - OK\n", nb_rx);
+	rte_eth_allmulticast_disable(tap_port0);
+
+	/* Test 8: secondary unicast MAC via mac_addr_add */
+	printf("  Test: secondary unicast MAC\n");
+	ret = rte_eth_dev_mac_addr_add(tap_port0, &foreign_mac, 0);
+	TEST_ASSERT(ret == 0, "mac_addr_add failed: %s", rte_strerror(-ret));
+	ret = tap_inject_packet(ifname, &foreign_mac);
+	TEST_ASSERT(ret == 0, "packet inject failed");
+	nb_rx = tap_drain_rx(tap_port0, &foreign_mac);
+	TEST_ASSERT(nb_rx > 0, "packet to added MAC was not received");
+	printf("    Received %u packet(s) - OK\n", nb_rx);
+
+	/* Remove and verify it's dropped again */
+	rte_eth_dev_mac_addr_remove(tap_port0, &foreign_mac);
+	ret = tap_inject_packet(ifname, &foreign_mac);
+	TEST_ASSERT(ret == 0, "packet inject failed");
+	nb_rx = tap_drain_rx(tap_port0, &foreign_mac);
+	TEST_ASSERT(nb_rx == 0, "packet to removed MAC was not dropped");
+	printf("    Dropped after remove - OK\n");
+
+	/* Restore promisc (default state) */
+	rte_eth_promiscuous_enable(tap_port0);
+
+	return TEST_SUCCESS;
+}
+
 static struct unit_test_suite test_pmd_tap_suite = {
 	.setup = test_tap_setup,
 	.teardown = test_tap_cleanup,
@@ -1128,6 +1307,7 @@ static struct unit_test_suite test_pmd_tap_suite = {
 		TEST_CASE(test_tap_multiqueue),
 		TEST_CASE(test_tap_rx_queue_setup),
 		TEST_CASE(test_tap_tx_burst),
+		TEST_CASE(test_tap_mac_filter),
 		TEST_CASES_END()
 	}
 };
diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index 13e0a23c34a1..64b359914bac 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -58,6 +58,7 @@
 #define ETH_TAP_CMP_MAC_FMT     "0123456789ABCDEFabcdef"
 #define ETH_TAP_MAC_ARG_FMT     ETH_TAP_MAC_FIXED "|" ETH_TAP_USR_MAC_FMT
 
+#define TAP_MAX_MAC_ADDRS	16
 #define TAP_GSO_MBUFS_PER_CORE	128
 #define TAP_GSO_MBUF_SEG_SIZE	128
 #define TAP_GSO_MBUF_CACHE_SIZE	4
@@ -437,6 +438,45 @@ tap_rxq_pool_free(struct rte_mbuf *pool)
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
+	if (unlikely(rte_is_zero_ether_addr(dst)))
+		return false;
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
@@ -515,6 +555,12 @@ pmd_rx_burst(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			data_off = 0;
 		}
 		seg->next = NULL;
+
+		if (!tap_mac_filter_match(rxq, mbuf)) {
+			rte_pktmbuf_free(mbuf);
+			continue;
+		}
+
 		mbuf->packet_type = rte_net_get_ptype(mbuf, NULL,
 						      RTE_PTYPE_ALL_MASK);
 		if (rxq->rxmode->offloads & RTE_ETH_RX_OFFLOAD_CHECKSUM)
@@ -933,7 +979,7 @@ tap_dev_info(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	struct pmd_internals *internals = dev->data->dev_private;
 
 	dev_info->if_index = internals->if_index;
-	dev_info->max_mac_addrs = 1;
+	dev_info->max_mac_addrs = TAP_MAX_MAC_ADDRS;
 	dev_info->max_rx_pktlen = RTE_ETHER_MAX_JUMBO_FRAME_LEN;
 	dev_info->max_rx_queues = RTE_PMD_TAP_MAX_QUEUES;
 	dev_info->max_tx_queues = RTE_PMD_TAP_MAX_QUEUES;
@@ -1089,14 +1135,15 @@ tap_dev_close(struct rte_eth_dev *dev)
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
@@ -1574,6 +1621,7 @@ tap_rx_queue_setup(struct rte_eth_dev *dev,
 	}
 	tmp = &rxq->pool;
 
+	rxq->pmd = internals;
 	rxq->mp = mp;
 	rxq->trigger_seen = 1; /* force initial burst */
 	rxq->in_port = dev->data->port_id;
@@ -1692,17 +1740,50 @@ tap_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
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
 
@@ -2038,6 +2119,8 @@ static const struct eth_dev_ops ops = {
 	.allmulticast_enable    = tap_allmulti_enable,
 	.allmulticast_disable   = tap_allmulti_disable,
 	.mac_addr_set           = tap_mac_set,
+	.mac_addr_add           = tap_mac_addr_add,
+	.mac_addr_remove        = tap_mac_addr_remove,
 	.mtu_set                = tap_mtu_set,
 	.set_mc_addr_list       = tap_set_mc_addr_list,
 	.stats_get              = tap_stats_get,
@@ -2102,7 +2185,14 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
 	data->numa_node = numa_node;
 
 	data->dev_link = pmd_link;
-	data->mac_addrs = &pmd->eth_addr;
+	data->mac_addrs = rte_calloc_socket(rte_vdev_device_name(vdev),
+					    TAP_MAX_MAC_ADDRS,
+					    sizeof(*data->mac_addrs),
+					    0, numa_node);
+	if (data->mac_addrs == NULL) {
+		TAP_LOG(ERR, "Failed to allocate mac_addrs");
+		goto error_exit;
+	}
 	/* Set the number of RX and TX queues */
 	data->nb_rx_queues = 0;
 	data->nb_tx_queues = 0;
@@ -2119,7 +2209,6 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
 	for (i = 0; i < RTE_PMD_TAP_MAX_QUEUES; i++)
 		process_private->fds[i] = -1;
 
-
 	if (pmd->type == ETH_TUNTAP_TYPE_TAP) {
 		if (rte_is_zero_ether_addr(mac_addr))
 			rte_eth_random_addr((uint8_t *)&pmd->eth_addr);
@@ -2227,6 +2316,9 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
 	}
 #endif
 
+	/* Copy final MAC to slot 0 (remote path may have overwritten it) */
+	data->mac_addrs[0] = pmd->eth_addr;
+
 	rte_eth_dev_probing_finish(dev);
 	return 0;
 
@@ -2246,8 +2338,6 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
 	free(dev->process_private);
 
 error_exit_nodev_release:
-	/* mac_addrs must not be freed alone because part of dev_private */
-	dev->data->mac_addrs = NULL;
 	rte_eth_dev_release_port(dev);
 
 error_exit_nodev:
diff --git a/drivers/net/tap/rte_eth_tap.h b/drivers/net/tap/rte_eth_tap.h
index b44eaf9a1bdb..f53a5ad077ba 100644
--- a/drivers/net/tap/rte_eth_tap.h
+++ b/drivers/net/tap/rte_eth_tap.h
@@ -40,7 +40,10 @@ struct queue_stats {
 	uint64_t errors;
 };
 
+struct pmd_internals;
+
 struct rx_queue {
+	struct pmd_internals *pmd;      /* back-pointer to driver state */
 	struct rte_mempool *mp;         /* Mempool for RX packets */
 	uint32_t trigger_seen;          /* Last seen Rx trigger value */
 	uint16_t in_port;               /* Port ID */
@@ -70,6 +73,8 @@ struct pmd_internals {
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

