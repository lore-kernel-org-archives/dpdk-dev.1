Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11A9606A328
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=m77pg9og
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FCFE42E63;
	Tue,  3 Nov 2026 16:11:05 +0100 (CET)
Received: from mta1.migadu.com (out-129.mta1.migadu.com [95.215.58.129])
 by mails.dpdk.org (Postfix) with ESMTPS id 6A37E427DD
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:11:03 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=/naXyEGK+mqZr93hIsazkPgKSKq4mGPn8f1VPz2S4WU=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718663; v=1; x=1794323463;
 b=m77pg9ogLQWYfSjdPz1dUsKrfCCEG/RNQ5vBOWW5T8efoZFhgc2xaWClaXkHHpBbBlgY1Hkh
 HW5dUTRl71AbZBtiFf4jeAuKQX5se1PK8jgY4bTFhW1HZdWvqpsXyqTSqwQCCt4yBsoo2Y0tTLA
 0749EjzhV47N3+veJJHMZxjc=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id fc37b805c9dd3aa5;
 Tue, 03 Nov 2026 15:11:03 +0000
X-Mizu-Trace-ID: fc37b805c9dd3aa5
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 110/227] net/bonding: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:08 +0800
Message-ID: <20261103145306.487255-111-chengwen.feng@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103145306.487255-1-chengwen.feng@linux.dev>
References: <20261103145306.487255-1-chengwen.feng@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chengwen Feng <fengchengwen@huawei.com>

Rename socket_id parameters, internal structure fields, variables
and comments to the NUMA node terminology, and switch calls to
the NUMA-named APIs.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/net/bonding/eth_bond_private.h    |  2 +-
 drivers/net/bonding/rte_eth_bond.h        |  4 +--
 drivers/net/bonding/rte_eth_bond_8023ad.c | 14 ++++-----
 drivers/net/bonding/rte_eth_bond_alb.c    |  4 +--
 drivers/net/bonding/rte_eth_bond_api.c    |  4 +--
 drivers/net/bonding/rte_eth_bond_args.c   | 14 ++++-----
 drivers/net/bonding/rte_eth_bond_flow.c   |  2 +-
 drivers/net/bonding/rte_eth_bond_pmd.c    | 36 +++++++++++------------
 8 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/net/bonding/eth_bond_private.h b/drivers/net/bonding/eth_bond_private.h
index 378bbba4e6..684f8c30cb 100644
--- a/drivers/net/bonding/eth_bond_private.h
+++ b/drivers/net/bonding/eth_bond_private.h
@@ -23,7 +23,7 @@
 #define PMD_BOND_MODE_KVARG					("mode")
 #define PMD_BOND_AGG_MODE_KVARG				("agg_mode")
 #define PMD_BOND_XMIT_POLICY_KVARG			("xmit_policy")
-#define PMD_BOND_SOCKET_ID_KVARG			("socket_id")
+#define PMD_BOND_SOCKET_ID_KVARG			("numa_id")
 #define PMD_BOND_MAC_ADDR_KVARG				("mac")
 #define PMD_BOND_LSC_POLL_PERIOD_KVARG		("lsc_poll_period_ms")
 #define PMD_BOND_LINK_UP_PROP_DELAY_KVARG	("up_delay")
diff --git a/drivers/net/bonding/rte_eth_bond.h b/drivers/net/bonding/rte_eth_bond.h
index 4f79ff9b85..37d780dd34 100644
--- a/drivers/net/bonding/rte_eth_bond.h
+++ b/drivers/net/bonding/rte_eth_bond.h
@@ -97,13 +97,13 @@ extern "C" {
  *
  * @param name			Name of new link bonding device.
  * @param mode			Mode to initialize bonding device in.
- * @param socket_id		Socket Id on which to allocate eth_dev resources.
+ * @param numa_id		Socket Id on which to allocate eth_dev resources.
  *
  * @return
  *	Port Id of created rte_eth_dev on success, negative value otherwise
  */
 int
-rte_eth_bond_create(const char *name, uint8_t mode, uint8_t socket_id);
+rte_eth_bond_create(const char *name, uint8_t mode, uint8_t numa_id);
 
 /**
  * Free a bonding rte_eth_dev device
diff --git a/drivers/net/bonding/rte_eth_bond_8023ad.c b/drivers/net/bonding/rte_eth_bond_8023ad.c
index c445290079..245d535a7a 100644
--- a/drivers/net/bonding/rte_eth_bond_8023ad.c
+++ b/drivers/net/bonding/rte_eth_bond_8023ad.c
@@ -1033,7 +1033,7 @@ bond_mode_8023ad_activate_member(struct rte_eth_dev *bond_dev,
 	};
 
 	char mem_name[RTE_ETH_NAME_MAX_LEN];
-	int socket_id;
+	int numa_id;
 	unsigned element_size;
 	uint32_t total_tx_desc;
 	struct bond_tx_queue *bd_tx_q;
@@ -1073,9 +1073,9 @@ bond_mode_8023ad_activate_member(struct rte_eth_dev *bond_dev,
 	RTE_ASSERT(port->rx_ring == NULL);
 	RTE_ASSERT(port->tx_ring == NULL);
 
-	socket_id = rte_eth_dev_socket_id(member_id);
-	if (socket_id == -1)
-		socket_id = rte_socket_id();
+	numa_id = rte_eth_dev_numa_id(member_id);
+	if (numa_id == -1)
+		numa_id = rte_numa_id();
 
 	element_size = sizeof(struct slow_protocol_frame) +
 				RTE_PKTMBUF_HEADROOM;
@@ -1094,7 +1094,7 @@ bond_mode_8023ad_activate_member(struct rte_eth_dev *bond_dev,
 	port->mbuf_pool = rte_pktmbuf_pool_create(mem_name, total_tx_desc,
 		RTE_MEMPOOL_CACHE_MAX_SIZE >= 32 ?
 			32 : RTE_MEMPOOL_CACHE_MAX_SIZE,
-		0, element_size, socket_id);
+		0, element_size, numa_id);
 
 	/* Any memory allocation failure in initialization is critical because
 	 * resources can't be free, so reinitialization is impossible. */
@@ -1105,7 +1105,7 @@ bond_mode_8023ad_activate_member(struct rte_eth_dev *bond_dev,
 
 	snprintf(mem_name, RTE_DIM(mem_name), "member_%u_rx", member_id);
 	port->rx_ring = rte_ring_create(mem_name,
-			rte_align32pow2(BOND_MODE_8023AX_MEMBER_RX_PKTS), socket_id, 0);
+			rte_align32pow2(BOND_MODE_8023AX_MEMBER_RX_PKTS), numa_id, 0);
 
 	if (port->rx_ring == NULL) {
 		rte_panic("Member %u: Failed to create rx ring '%s': %s\n", member_id,
@@ -1115,7 +1115,7 @@ bond_mode_8023ad_activate_member(struct rte_eth_dev *bond_dev,
 	/* TX ring is at least one pkt longer to make room for marker packet. */
 	snprintf(mem_name, RTE_DIM(mem_name), "member_%u_tx", member_id);
 	port->tx_ring = rte_ring_create(mem_name,
-			rte_align32pow2(BOND_MODE_8023AX_MEMBER_TX_PKTS + 1), socket_id, 0);
+			rte_align32pow2(BOND_MODE_8023AX_MEMBER_TX_PKTS + 1), numa_id, 0);
 
 	if (port->tx_ring == NULL) {
 		rte_panic("Member %u: Failed to create tx ring '%s': %s\n", member_id,
diff --git a/drivers/net/bonding/rte_eth_bond_alb.c b/drivers/net/bonding/rte_eth_bond_alb.c
index 253f38da4a..0720541510 100644
--- a/drivers/net/bonding/rte_eth_bond_alb.c
+++ b/drivers/net/bonding/rte_eth_bond_alb.c
@@ -36,7 +36,7 @@ bond_mode_alb_enable(struct rte_eth_dev *bond_dev)
 
 	uint16_t data_size;
 	char mem_name[RTE_ETH_NAME_MAX_LEN];
-	int socket_id = bond_dev->data->numa_node;
+	int numa_id = bond_dev->data->numa_node;
 
 	/* Fill hash table with initial values */
 	memset(hash_table, 0, sizeof(struct client_data) * ALB_HASH_TABLE_SIZE);
@@ -57,7 +57,7 @@ bond_mode_alb_enable(struct rte_eth_dev *bond_dev)
 			512 * RTE_MAX_ETHPORTS,
 			RTE_MEMPOOL_CACHE_MAX_SIZE >= 32 ?
 				32 : RTE_MEMPOOL_CACHE_MAX_SIZE,
-			0, data_size, socket_id);
+			0, data_size, numa_id);
 
 		if (internals->mode6.mempool == NULL) {
 			RTE_BOND_LOG(ERR, "%s: Failed to initialize ALB mempool.",
diff --git a/drivers/net/bonding/rte_eth_bond_api.c b/drivers/net/bonding/rte_eth_bond_api.c
index a4b54a71dd..6835a516d9 100644
--- a/drivers/net/bonding/rte_eth_bond_api.c
+++ b/drivers/net/bonding/rte_eth_bond_api.c
@@ -152,7 +152,7 @@ deactivate_member(struct rte_eth_dev *eth_dev, uint16_t port_id)
 
 RTE_EXPORT_SYMBOL(rte_eth_bond_create)
 int
-rte_eth_bond_create(const char *name, uint8_t mode, uint8_t socket_id)
+rte_eth_bond_create(const char *name, uint8_t mode, uint8_t numa_id)
 {
 	struct bond_dev_private *internals;
 	struct rte_eth_dev *bond_dev;
@@ -165,7 +165,7 @@ rte_eth_bond_create(const char *name, uint8_t mode, uint8_t socket_id)
 	}
 
 	ret = snprintf(devargs, sizeof(devargs),
-		"driver=net_bonding,mode=%d,socket_id=%d", mode, socket_id);
+		"driver=net_bonding,mode=%d,numa_id=%d", mode, numa_id);
 	if (ret < 0 || ret >= (int)sizeof(devargs))
 		return -ENOMEM;
 
diff --git a/drivers/net/bonding/rte_eth_bond_args.c b/drivers/net/bonding/rte_eth_bond_args.c
index 823ed80f07..cbf6a7fb91 100644
--- a/drivers/net/bonding/rte_eth_bond_args.c
+++ b/drivers/net/bonding/rte_eth_bond_args.c
@@ -201,26 +201,26 @@ int
 bond_ethdev_parse_socket_id_kvarg(const char *key __rte_unused,
 		const char *value, void *extra_args)
 {
-	long socket_id;
+	long numa_id;
 	char *endptr;
 
 	if (value == NULL || extra_args == NULL)
 		return -1;
 
 	errno = 0;
-	socket_id = strtol(value, &endptr, 10);
+	numa_id = strtol(value, &endptr, 10);
 	if (*endptr != 0 || errno != 0)
 		return -1;
 
-	/* SOCKET_ID_ANY also consider a valid socket id */
-	if ((int8_t)socket_id == SOCKET_ID_ANY) {
-		*(int *)extra_args = SOCKET_ID_ANY;
+	/* RTE_NUMA_ID_ANY also consider a valid socket id */
+	if ((int8_t)numa_id == RTE_NUMA_ID_ANY) {
+		*(int *)extra_args = RTE_NUMA_ID_ANY;
 		return 0;
 	}
 
 	/* validate socket id value */
-	if (socket_id >= 0 && socket_id < RTE_MAX_NUMA_NODES) {
-		*(int *)extra_args = (int)socket_id;
+	if (numa_id >= 0 && numa_id < RTE_MAX_NUMA_NODES) {
+		*(int *)extra_args = (int)numa_id;
 		return 0;
 	}
 	return -1;
diff --git a/drivers/net/bonding/rte_eth_bond_flow.c b/drivers/net/bonding/rte_eth_bond_flow.c
index 5d0be5caf5..da77281499 100644
--- a/drivers/net/bonding/rte_eth_bond_flow.c
+++ b/drivers/net/bonding/rte_eth_bond_flow.c
@@ -34,7 +34,7 @@ bond_flow_alloc(int numa_node, const struct rte_flow_attr *attr,
 			     strerror(rte_errno));
 		return NULL;
 	}
-	flow = rte_zmalloc_socket(NULL, offsetof(struct rte_flow, rule) + ret,
+	flow = rte_zmalloc_numa(NULL, offsetof(struct rte_flow, rule) + ret,
 				  RTE_CACHE_LINE_SIZE, numa_node);
 	if (unlikely(flow == NULL)) {
 		RTE_BOND_LOG(ERR, "Could not allocate new flow");
diff --git a/drivers/net/bonding/rte_eth_bond_pmd.c b/drivers/net/bonding/rte_eth_bond_pmd.c
index 526f8118b3..fa538d2493 100644
--- a/drivers/net/bonding/rte_eth_bond_pmd.c
+++ b/drivers/net/bonding/rte_eth_bond_pmd.c
@@ -1741,7 +1741,7 @@ member_configure_slow_queue(struct rte_eth_dev *bonding_eth_dev,
 			slow_rx_conf.rx_free_thresh = nb_rx_desc / 4;
 		errval = rte_eth_rx_queue_setup(member_eth_dev->data->port_id,
 				internals->mode4.dedicated_queues.rx_qid, nb_rx_desc,
-				rte_eth_dev_socket_id(member_eth_dev->data->port_id),
+				rte_eth_dev_numa_id(member_eth_dev->data->port_id),
 				&slow_rx_conf, port->slow_pool);
 		if (errval != 0) {
 			RTE_BOND_LOG(ERR,
@@ -1757,7 +1757,7 @@ member_configure_slow_queue(struct rte_eth_dev *bonding_eth_dev,
 
 		errval = rte_eth_tx_queue_setup(member_eth_dev->data->port_id,
 				internals->mode4.dedicated_queues.tx_qid, nb_tx_desc,
-				rte_eth_dev_socket_id(member_eth_dev->data->port_id),
+				rte_eth_dev_numa_id(member_eth_dev->data->port_id),
 				NULL);
 		if (errval != 0) {
 			RTE_BOND_LOG(ERR,
@@ -1871,7 +1871,7 @@ member_start(struct rte_eth_dev *bonding_eth_dev,
 
 		errval = rte_eth_rx_queue_setup(member_port_id, q_id,
 				bd_rx_q->nb_rx_desc,
-				rte_eth_dev_socket_id(member_port_id),
+				rte_eth_dev_numa_id(member_port_id),
 				&(bd_rx_q->rx_conf), bd_rx_q->mb_pool);
 		if (errval != 0) {
 			RTE_BOND_LOG(ERR,
@@ -1887,7 +1887,7 @@ member_start(struct rte_eth_dev *bonding_eth_dev,
 
 		errval = rte_eth_tx_queue_setup(member_port_id, q_id,
 				bd_tx_q->nb_tx_desc,
-				rte_eth_dev_socket_id(member_port_id),
+				rte_eth_dev_numa_id(member_port_id),
 				&bd_tx_q->tx_conf);
 		if (errval != 0) {
 			RTE_BOND_LOG(ERR,
@@ -2428,11 +2428,11 @@ bond_ethdev_vlan_filter_set(struct rte_eth_dev *dev, uint16_t vlan_id, int on)
 
 static int
 bond_ethdev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t rx_queue_id,
-		uint16_t nb_rx_desc, unsigned int socket_id __rte_unused,
+		uint16_t nb_rx_desc, unsigned int numa_id __rte_unused,
 		const struct rte_eth_rxconf *rx_conf, struct rte_mempool *mb_pool)
 {
 	struct bond_rx_queue *bd_rx_q = (struct bond_rx_queue *)
-			rte_zmalloc_socket(NULL, sizeof(struct bond_rx_queue),
+			rte_zmalloc_numa(NULL, sizeof(struct bond_rx_queue),
 					0, dev->data->numa_node);
 	if (bd_rx_q == NULL)
 		return -1;
@@ -2452,11 +2452,11 @@ bond_ethdev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t rx_queue_id,
 
 static int
 bond_ethdev_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
-		uint16_t nb_tx_desc, unsigned int socket_id __rte_unused,
+		uint16_t nb_tx_desc, unsigned int numa_id __rte_unused,
 		const struct rte_eth_txconf *tx_conf)
 {
 	struct bond_tx_queue *bd_tx_q  = (struct bond_tx_queue *)
-			rte_zmalloc_socket(NULL, sizeof(struct bond_tx_queue),
+			rte_zmalloc_numa(NULL, sizeof(struct bond_tx_queue),
 					0, dev->data->numa_node);
 
 	if (bd_tx_q == NULL)
@@ -3678,7 +3678,7 @@ static int
 bond_alloc(struct rte_vdev_device *dev, uint8_t mode)
 {
 	const char *name = rte_vdev_device_name(dev);
-	int socket_id = dev->device.numa_node;
+	int numa_id = dev->device.numa_node;
 	struct bond_dev_private *internals = NULL;
 	struct rte_eth_dev *eth_dev = NULL;
 	uint32_t vlan_filter_bmp_size;
@@ -3699,8 +3699,8 @@ bond_alloc(struct rte_vdev_device *dev, uint8_t mode)
 	eth_dev->data->nb_tx_queues = (uint16_t)1;
 
 	/* Allocate memory for storing MAC addresses */
-	eth_dev->data->mac_addrs = rte_zmalloc_socket(name, RTE_ETHER_ADDR_LEN *
-			BOND_MAX_MAC_ADDRS, 0, socket_id);
+	eth_dev->data->mac_addrs = rte_zmalloc_numa(name, RTE_ETHER_ADDR_LEN *
+			BOND_MAX_MAC_ADDRS, 0, numa_id);
 	if (eth_dev->data->mac_addrs == NULL) {
 		RTE_BOND_LOG(ERR,
 			     "Failed to allocate %u bytes needed to store MAC addresses",
@@ -3811,7 +3811,7 @@ bond_probe(struct rte_vdev_device *dev)
 	struct rte_kvargs *kvlist;
 	uint8_t bonding_mode;
 	int arg_count, port_id;
-	int socket_id;
+	int numa_id;
 	uint8_t agg_mode;
 	struct rte_eth_dev *eth_dev;
 
@@ -3869,7 +3869,7 @@ bond_probe(struct rte_vdev_device *dev)
 	arg_count = rte_kvargs_count(kvlist, PMD_BOND_SOCKET_ID_KVARG);
 	if (arg_count == 1) {
 		if (rte_kvargs_process(kvlist, PMD_BOND_SOCKET_ID_KVARG,
-				&bond_ethdev_parse_socket_id_kvarg, &socket_id)
+				&bond_ethdev_parse_socket_id_kvarg, &numa_id)
 				!= 0) {
 			RTE_BOND_LOG(ERR, "Invalid socket Id specified for "
 					"bonding device %s", name);
@@ -3880,16 +3880,16 @@ bond_probe(struct rte_vdev_device *dev)
 				"bonding device %s", name);
 		goto parse_error;
 	} else {
-		socket_id = rte_socket_id();
+		numa_id = rte_numa_id();
 	}
 
-	dev->device.numa_node = socket_id;
+	dev->device.numa_node = numa_id;
 
 	/* Create link bonding eth device */
 	port_id = bond_alloc(dev, bonding_mode);
 	if (port_id < 0) {
 		RTE_BOND_LOG(ERR, "Failed to create socket %s in mode %u on "
-				"socket %d.",	name, bonding_mode, socket_id);
+				"socket %d.",	name, bonding_mode, numa_id);
 		goto parse_error;
 	}
 	internals = rte_eth_devices[port_id].data->dev_private;
@@ -3914,7 +3914,7 @@ bond_probe(struct rte_vdev_device *dev)
 
 	rte_eth_dev_probing_finish(&rte_eth_devices[port_id]);
 	RTE_BOND_LOG(INFO, "Create bonding device %s on port %d in mode %u on "
-			"socket %u.",	name, port_id, bonding_mode, socket_id);
+			"socket %u.",	name, port_id, bonding_mode, numa_id);
 	return 0;
 
 parse_error:
@@ -4318,7 +4318,7 @@ RTE_PMD_REGISTER_PARAM_STRING(net_bonding,
 	"mode=[0-6] "
 	"xmit_policy=[l2 | l23 | l34] "
 	"agg_mode=[count | stable | bandwidth] "
-	"socket_id=<int> "
+	"numa_id=<int> "
 	"mac=<mac addr> "
 	"lsc_poll_period_ms=<int> "
 	"up_delay=<int> "
-- 
2.55.0

