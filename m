Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4E7CD98EE
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 08:52:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD14440289;
	Wed, 17 Jun 2026 10:52:57 +0200 (CEST)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com
 [113.46.200.221])
 by mails.dpdk.org (Postfix) with ESMTP id 9B34B4027A
 for <dev@dpdk.org>; Wed, 17 Jun 2026 10:52:55 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=xOhJokYyAd8rs+cDwRgGqyFU282KM09ry2ObAWCMQ68=;
 b=Vy7hqRAFivg7Kf2vEmchttak3V7IYidm/uqGbk/jb3su/KxmyKZJhoB/nH7CYOUI8MR4H9mOB
 AmPJIe+ZIZTuF47/X8UnGmvYF/0RqUAbXbA0qCT+DC6jZo7lDwsO8K0YbBnrK9Jwd61Z6XPj6/k
 5ajpYL3GKe63HjINCJ/hj54=
Received: from mail.maildlp.com (unknown [172.19.162.197])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4ggHVB4QH8zRhRC;
 Wed, 17 Jun 2026 16:44:50 +0800 (CST)
Received: from kwepemj100018.china.huawei.com (unknown [7.202.194.12])
 by mail.maildlp.com (Postfix) with ESMTPS id DD04A40569;
 Wed, 17 Jun 2026 16:52:48 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemj100018.china.huawei.com (7.202.194.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 17 Jun 2026 16:52:48 +0800
From: Xingui Yang <yangxingui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <david.marchand@redhat.com>,
 <aman.deep.singh@intel.com>, <fengchengwen@huawei.com>,
 <yangshuaisong@h-partners.com>, <lihuisong@huawei.com>,
 <liuyonglong@huawei.com>, <kangfenglong@huawei.com>
Subject: [PATCH v3] app/testpmd: add VLAN priority insert support
Date: Wed, 17 Jun 2026 16:52:47 +0800
Message-ID: <20260617085247.2204050-1-yangxingui@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616131001.2955655-1-yangxingui@huawei.com/>
References: <20260616131001.2955655-1-yangxingui@huawei.com/>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemj100018.china.huawei.com (7.202.194.12)
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

The tx_vlan set and tx_qinq set commands now accept full 16-bit VLAN TCI
(Tag Control Information) instead of only 12-bit VLAN ID. This allows
users to set 802.1p priority and CFI/DEI bits for hardware VLAN insertion.

---
v3:
- Remove TX path validation to accept full 16-bit TCI values
- Rename parameter from vlan_id to vlan_tci in code and documentation
- Rename struct fields tx_vlan_id to tx_vlan_tci for consistency
- Rename token variables cmd_tx_vlan_set_vlanid to cmd_tx_vlan_set_vlantci
- Update cmdline.c structure fields, TOKEN definitions, and help strings
- Add documentation with TCI bit layout and calculation examples

Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
Suggested-by: Chengwen Feng <fengchengwen@huawei.com>
Signed-off-by: Xingui Yang <yangxingui@huawei.com>
---
 app/test-pmd/5tswap.h                       |  2 +-
 app/test-pmd/cmdline.c                      | 42 ++++++++++-----------
 app/test-pmd/config.c                       | 22 ++++-------
 app/test-pmd/flowgen.c                      |  4 +-
 app/test-pmd/macfwd.h                       |  4 +-
 app/test-pmd/macswap.h                      |  2 +-
 app/test-pmd/macswap_neon.h                 |  2 +-
 app/test-pmd/macswap_sse.h                  |  2 +-
 app/test-pmd/testpmd.h                      |  8 ++--
 app/test-pmd/txonly.c                       |  4 +-
 doc/guides/rel_notes/release_26_07.rst      | 15 ++++++++
 doc/guides/testpmd_app_ug/testpmd_funcs.rst | 33 +++++++++++++---
 12 files changed, 85 insertions(+), 55 deletions(-)

diff --git a/app/test-pmd/5tswap.h b/app/test-pmd/5tswap.h
index 345c08b4d0..1909d4e2fa 100644
--- a/app/test-pmd/5tswap.h
+++ b/app/test-pmd/5tswap.h
@@ -85,7 +85,7 @@ do_5tswap(struct rte_mbuf *pkts_burst[], uint16_t nb_rx,
 	txp = &ports[fs->tx_port];
 	ol_flags = ol_flags_init(txp->dev_conf.txmode.offloads);
 	vlan_qinq_set(pkts_burst, nb_rx, ol_flags,
-		      txp->tx_vlan_id, txp->tx_vlan_id_outer);
+		      txp->tx_vlan_tci, txp->tx_vlan_tci_outer);
 	for (i = 0; i < nb_rx; i++) {
 		if (likely(i < nb_rx - 1))
 			rte_prefetch0(rte_pktmbuf_mtod(pkts_burst[i+1],
diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 3c39e27aa8..233d3b8ee2 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -447,9 +447,9 @@ static void cmd_help_long_parsed(void *parsed_result,
 			"rx_vxlan_port rm (udp_port) (port_id)\n"
 			"    Remove an UDP port for VXLAN packet filter on a port\n\n"
 
-			"tx_vlan set (port_id) vlan_id[, vlan_id_outer]\n"
-			"    Set hardware insertion of VLAN IDs (single or double VLAN "
-			"depends on the number of VLAN IDs) in packets sent on a port.\n\n"
+			"tx_vlan set (port_id) vlan_tci[, vlan_tci_outer]\n"
+			"    Set hardware insertion of VLAN TCI (single or double VLAN "
+			"depends on the number of VLAN TCIs) in packets sent on a port.\n\n"
 
 			"tx_vlan set pvid port_id vlan_id (on|off)\n"
 			"    Set port based TX VLAN insertion.\n\n"
@@ -4931,7 +4931,7 @@ struct cmd_tx_vlan_set_result {
 	cmdline_fixed_string_t tx_vlan;
 	cmdline_fixed_string_t set;
 	portid_t port_id;
-	uint16_t vlan_id;
+	uint16_t vlan_tci;
 };
 
 static void
@@ -4949,7 +4949,7 @@ cmd_tx_vlan_set_parsed(void *parsed_result,
 		return;
 	}
 
-	tx_vlan_set(res->port_id, res->vlan_id);
+	tx_vlan_set(res->port_id, res->vlan_tci);
 
 	cmd_reconfig_device_queue(res->port_id, 1, 1);
 }
@@ -4963,21 +4963,21 @@ static cmdline_parse_token_string_t cmd_tx_vlan_set_set =
 static cmdline_parse_token_num_t cmd_tx_vlan_set_portid =
 	TOKEN_NUM_INITIALIZER(struct cmd_tx_vlan_set_result,
 			      port_id, RTE_UINT16);
-static cmdline_parse_token_num_t cmd_tx_vlan_set_vlanid =
+static cmdline_parse_token_num_t cmd_tx_vlan_set_vlantci =
 	TOKEN_NUM_INITIALIZER(struct cmd_tx_vlan_set_result,
-			      vlan_id, RTE_UINT16);
+			      vlan_tci, RTE_UINT16);
 
 static cmdline_parse_inst_t cmd_tx_vlan_set = {
 	.f = cmd_tx_vlan_set_parsed,
 	.data = NULL,
-	.help_str = "tx_vlan set <port_id> <vlan_id>: "
+	.help_str = "tx_vlan set <port_id> <vlan_tci>: "
 		"Enable hardware insertion of a single VLAN header "
-		"with a given TAG Identifier in packets sent on a port",
+		"with a given TCI in packets sent on a port",
 	.tokens = {
 		(void *)&cmd_tx_vlan_set_tx_vlan,
 		(void *)&cmd_tx_vlan_set_set,
 		(void *)&cmd_tx_vlan_set_portid,
-		(void *)&cmd_tx_vlan_set_vlanid,
+		(void *)&cmd_tx_vlan_set_vlantci,
 		NULL,
 	},
 };
@@ -4987,8 +4987,8 @@ struct cmd_tx_vlan_set_qinq_result {
 	cmdline_fixed_string_t tx_vlan;
 	cmdline_fixed_string_t set;
 	portid_t port_id;
-	uint16_t vlan_id;
-	uint16_t vlan_id_outer;
+	uint16_t vlan_tci;
+	uint16_t vlan_tci_outer;
 };
 
 static void
@@ -5006,7 +5006,7 @@ cmd_tx_vlan_set_qinq_parsed(void *parsed_result,
 		return;
 	}
 
-	tx_qinq_set(res->port_id, res->vlan_id, res->vlan_id_outer);
+	tx_qinq_set(res->port_id, res->vlan_tci, res->vlan_tci_outer);
 
 	cmd_reconfig_device_queue(res->port_id, 1, 1);
 }
@@ -5020,25 +5020,25 @@ static cmdline_parse_token_string_t cmd_tx_vlan_set_qinq_set =
 static cmdline_parse_token_num_t cmd_tx_vlan_set_qinq_portid =
 	TOKEN_NUM_INITIALIZER(struct cmd_tx_vlan_set_qinq_result,
 		port_id, RTE_UINT16);
-static cmdline_parse_token_num_t cmd_tx_vlan_set_qinq_vlanid =
+static cmdline_parse_token_num_t cmd_tx_vlan_set_qinq_vlantci =
 	TOKEN_NUM_INITIALIZER(struct cmd_tx_vlan_set_qinq_result,
-		vlan_id, RTE_UINT16);
-static cmdline_parse_token_num_t cmd_tx_vlan_set_qinq_vlanid_outer =
+		vlan_tci, RTE_UINT16);
+static cmdline_parse_token_num_t cmd_tx_vlan_set_qinq_vlantci_outer =
 	TOKEN_NUM_INITIALIZER(struct cmd_tx_vlan_set_qinq_result,
-		vlan_id_outer, RTE_UINT16);
+		vlan_tci_outer, RTE_UINT16);
 
 static cmdline_parse_inst_t cmd_tx_vlan_set_qinq = {
 	.f = cmd_tx_vlan_set_qinq_parsed,
 	.data = NULL,
-	.help_str = "tx_vlan set <port_id> <vlan_id> <outer_vlan_id>: "
+	.help_str = "tx_vlan set <port_id> <vlan_tci> <vlan_tci_outer>: "
 		"Enable hardware insertion of double VLAN header "
-		"with given TAG Identifiers in packets sent on a port",
+		"with given TCIs in packets sent on a port",
 	.tokens = {
 		(void *)&cmd_tx_vlan_set_qinq_tx_vlan,
 		(void *)&cmd_tx_vlan_set_qinq_set,
 		(void *)&cmd_tx_vlan_set_qinq_portid,
-		(void *)&cmd_tx_vlan_set_qinq_vlanid,
-		(void *)&cmd_tx_vlan_set_qinq_vlanid_outer,
+		(void *)&cmd_tx_vlan_set_qinq_vlantci,
+		(void *)&cmd_tx_vlan_set_qinq_vlantci_outer,
 		NULL,
 	},
 };
diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index 9d457ca88e..3df7412ef6 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -6918,14 +6918,11 @@ vlan_tpid_set(portid_t port_id, enum rte_vlan_type vlan_type, uint16_t tp_id)
 }
 
 void
-tx_vlan_set(portid_t port_id, uint16_t vlan_id)
+tx_vlan_set(portid_t port_id, uint16_t vlan_tci)
 {
 	struct rte_eth_dev_info dev_info;
 	int ret;
 
-	if (vlan_id_is_invalid(vlan_id))
-		return;
-
 	if (ports[port_id].dev_conf.txmode.offloads &
 	    RTE_ETH_TX_OFFLOAD_QINQ_INSERT) {
 		fprintf(stderr, "Error, as QinQ has been enabled.\n");
@@ -6945,20 +6942,15 @@ tx_vlan_set(portid_t port_id, uint16_t vlan_id)
 
 	tx_vlan_reset(port_id);
 	ports[port_id].dev_conf.txmode.offloads |= RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
-	ports[port_id].tx_vlan_id = vlan_id;
+	ports[port_id].tx_vlan_tci = vlan_tci;
 }
 
 void
-tx_qinq_set(portid_t port_id, uint16_t vlan_id, uint16_t vlan_id_outer)
+tx_qinq_set(portid_t port_id, uint16_t vlan_tci, uint16_t vlan_tci_outer)
 {
 	struct rte_eth_dev_info dev_info;
 	int ret;
 
-	if (vlan_id_is_invalid(vlan_id))
-		return;
-	if (vlan_id_is_invalid(vlan_id_outer))
-		return;
-
 	ret = eth_dev_info_get_print_err(port_id, &dev_info);
 	if (ret != 0)
 		return;
@@ -6973,8 +6965,8 @@ tx_qinq_set(portid_t port_id, uint16_t vlan_id, uint16_t vlan_id_outer)
 	tx_vlan_reset(port_id);
 	ports[port_id].dev_conf.txmode.offloads |= (RTE_ETH_TX_OFFLOAD_VLAN_INSERT |
 						    RTE_ETH_TX_OFFLOAD_QINQ_INSERT);
-	ports[port_id].tx_vlan_id = vlan_id;
-	ports[port_id].tx_vlan_id_outer = vlan_id_outer;
+	ports[port_id].tx_vlan_tci = vlan_tci;
+	ports[port_id].tx_vlan_tci_outer = vlan_tci_outer;
 }
 
 void
@@ -6983,8 +6975,8 @@ tx_vlan_reset(portid_t port_id)
 	ports[port_id].dev_conf.txmode.offloads &=
 				~(RTE_ETH_TX_OFFLOAD_VLAN_INSERT |
 				  RTE_ETH_TX_OFFLOAD_QINQ_INSERT);
-	ports[port_id].tx_vlan_id = 0;
-	ports[port_id].tx_vlan_id_outer = 0;
+	ports[port_id].tx_vlan_tci = 0;
+	ports[port_id].tx_vlan_tci_outer = 0;
 }
 
 void
diff --git a/app/test-pmd/flowgen.c b/app/test-pmd/flowgen.c
index 53b5f24f11..8dac7b9209 100644
--- a/app/test-pmd/flowgen.c
+++ b/app/test-pmd/flowgen.c
@@ -84,8 +84,8 @@ pkt_burst_flow_gen(struct fwd_stream *fs)
 	rte_pktmbuf_free_bulk(pkts_burst, nb_rx);
 
 	mbp = current_fwd_lcore()->mbp;
-	vlan_tci = ports[fs->tx_port].tx_vlan_id;
-	vlan_tci_outer = ports[fs->tx_port].tx_vlan_id_outer;
+	vlan_tci = ports[fs->tx_port].tx_vlan_tci;
+	vlan_tci_outer = ports[fs->tx_port].tx_vlan_tci_outer;
 
 	tx_offloads = ports[fs->tx_port].dev_conf.txmode.offloads;
 	if (tx_offloads	& RTE_ETH_TX_OFFLOAD_VLAN_INSERT)
diff --git a/app/test-pmd/macfwd.h b/app/test-pmd/macfwd.h
index ae2346e589..5209644bb7 100644
--- a/app/test-pmd/macfwd.h
+++ b/app/test-pmd/macfwd.h
@@ -37,8 +37,8 @@ do_macfwd(struct rte_mbuf *pkts_burst[], uint16_t nb_rx,
 		mb->ol_flags |= ol_flags;
 		mb->l2_len = sizeof(struct rte_ether_hdr);
 		mb->l3_len = sizeof(struct rte_ipv4_hdr);
-		mb->vlan_tci = txp->tx_vlan_id;
-		mb->vlan_tci_outer = txp->tx_vlan_id_outer;
+		mb->vlan_tci = txp->tx_vlan_tci;
+		mb->vlan_tci_outer = txp->tx_vlan_tci_outer;
 	}
 }
 
diff --git a/app/test-pmd/macswap.h b/app/test-pmd/macswap.h
index 29c252bb8f..fe15934d96 100644
--- a/app/test-pmd/macswap.h
+++ b/app/test-pmd/macswap.h
@@ -19,7 +19,7 @@ do_macswap(struct rte_mbuf *pkts[], uint16_t nb,
 
 	ol_flags = ol_flags_init(txp->dev_conf.txmode.offloads);
 	vlan_qinq_set(pkts, nb, ol_flags,
-			txp->tx_vlan_id, txp->tx_vlan_id_outer);
+			txp->tx_vlan_tci, txp->tx_vlan_tci_outer);
 
 	for (i = 0; i < nb; i++) {
 		if (likely(i < nb - 1))
diff --git a/app/test-pmd/macswap_neon.h b/app/test-pmd/macswap_neon.h
index df6c260cd4..195c7d1640 100644
--- a/app/test-pmd/macswap_neon.h
+++ b/app/test-pmd/macswap_neon.h
@@ -32,7 +32,7 @@ do_macswap(struct rte_mbuf *pkts[], uint16_t nb,
 
 	ol_flags = ol_flags_init(txp->dev_conf.txmode.offloads);
 	vlan_qinq_set(pkts, nb, ol_flags,
-			txp->tx_vlan_id, txp->tx_vlan_id_outer);
+			txp->tx_vlan_tci, txp->tx_vlan_tci_outer);
 
 	i = 0;
 	r = nb;
diff --git a/app/test-pmd/macswap_sse.h b/app/test-pmd/macswap_sse.h
index 1f547388b7..341c9ba681 100644
--- a/app/test-pmd/macswap_sse.h
+++ b/app/test-pmd/macswap_sse.h
@@ -29,7 +29,7 @@ do_macswap(struct rte_mbuf *pkts[], uint16_t nb,
 
 	ol_flags = ol_flags_init(txp->dev_conf.txmode.offloads);
 	vlan_qinq_set(pkts, nb, ol_flags,
-			txp->tx_vlan_id, txp->tx_vlan_id_outer);
+			txp->tx_vlan_tci, txp->tx_vlan_tci_outer);
 
 	i = 0;
 	r = nb;
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index 3d4b36d668..bf88758118 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -346,8 +346,8 @@ struct rte_port {
 	uint16_t		parse_tunnel:1; /**< Parse internal headers */
 	uint16_t                tso_segsz;  /**< Segmentation offload MSS for non-tunneled packets. */
 	uint16_t                tunnel_tso_segsz; /**< Segmentation offload MSS for tunneled pkts. */
-	uint16_t                tx_vlan_id;/**< The tag ID */
-	uint16_t                tx_vlan_id_outer;/**< The outer tag ID */
+	uint16_t                tx_vlan_tci;/**< The TCI */
+	uint16_t                tx_vlan_tci_outer;/**< The outer TCI */
 	volatile uint16_t        port_status;    /**< port started or not */
 	uint8_t                 need_setup;     /**< port just attached */
 	uint8_t                 need_reconfig;  /**< need reconfiguring port or not */
@@ -1142,8 +1142,8 @@ int rx_vft_set(portid_t port_id, uint16_t vlan_id, int on);
 void vlan_extend_set(portid_t port_id, int on);
 void vlan_tpid_set(portid_t port_id, enum rte_vlan_type vlan_type,
 		   uint16_t tp_id);
-void tx_vlan_set(portid_t port_id, uint16_t vlan_id);
-void tx_qinq_set(portid_t port_id, uint16_t vlan_id, uint16_t vlan_id_outer);
+void tx_vlan_set(portid_t port_id, uint16_t vlan_tci);
+void tx_qinq_set(portid_t port_id, uint16_t vlan_tci, uint16_t vlan_tci_outer);
 void tx_vlan_reset(portid_t port_id);
 void tx_vlan_pvid_set(portid_t port_id, uint16_t vlan_id, int on);
 
diff --git a/app/test-pmd/txonly.c b/app/test-pmd/txonly.c
index 64893fa205..a4acb85d29 100644
--- a/app/test-pmd/txonly.c
+++ b/app/test-pmd/txonly.c
@@ -325,8 +325,8 @@ pkt_burst_transmit(struct fwd_stream *fs)
 	mbp = current_fwd_lcore()->mbp;
 	txp = &ports[fs->tx_port];
 	tx_offloads = txp->dev_conf.txmode.offloads;
-	vlan_tci = txp->tx_vlan_id;
-	vlan_tci_outer = txp->tx_vlan_id_outer;
+	vlan_tci = txp->tx_vlan_tci;
+	vlan_tci_outer = txp->tx_vlan_tci_outer;
 	if (tx_offloads	& RTE_ETH_TX_OFFLOAD_VLAN_INSERT)
 		ol_flags = RTE_MBUF_F_TX_VLAN;
 	if (tx_offloads & RTE_ETH_TX_OFFLOAD_QINQ_INSERT)
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 5d7aa8d1bf..03e24030bc 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -150,6 +150,21 @@ New Features
   * Added ``eof`` devarg to use link state to signal end of receive file input.
   * Added unit test suite.
 
+* **Updated testpmd application.**
+
+  Added support for setting VLAN priority and CFI/DEI bits in ``tx_vlan set``
+  and ``tx_qinq set`` commands. The ``vlan_tci`` parameter now accepts the
+  full 16-bit VLAN Tag Control Information (TCI) format:
+
+  Priority (bits 13-15)
+     802.1p Class of Service value (0-7).
+
+  CFI/DEI (bit 12)
+     Canonical Format Indicator / Drop Eligible Indicator.
+
+  VLAN ID (bits 0-11)
+     VLAN identifier (0-4095).
+
 * **Added AI review helpers.**
 
   Added AGENTS.md file for AI review
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index f0f2b0758b..364d348372 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -1118,17 +1118,40 @@ Remove an UDP port for VXLAN packet filter on a port::
 tx_vlan set
 ~~~~~~~~~~~
 
-Set hardware insertion of VLAN IDs in packets sent on a port::
+Set hardware insertion of VLAN TCI (Tag Control Information) in packets sent on a port::
 
-   testpmd> tx_vlan set (port_id) vlan_id[, vlan_id_outer]
+   testpmd> tx_vlan set (port_id) vlan_tci[, vlan_tci_outer]
+
+The ``vlan_tci`` parameter accepts the full 16-bit VLAN Tag Control Information (TCI):
+
+Bits 0-11
+   VLAN ID (0-4095).
+
+Bit 12
+   CFI (Canonical Format Indicator) / DEI (Drop Eligible Indicator).
+
+Bits 13-15
+   Priority (0-7, 802.1p Class of Service).
 
 For example, set a single VLAN ID (5) insertion on port 0::
 
-   tx_vlan set 0 5
+   testpmd> tx_vlan set 0 5
+
+Or, set a VLAN with priority 3 and VLAN ID 100 on port 0::
+
+   testpmd> tx_vlan set 0 0x6064
+
+Calculation: ``(priority << 13) | vlan_id``.
+Priority 3 in bits 13-15: ``(3 << 13) = 0x6000``.
+VLAN ID 100 in bits 0-11: ``100 = 0x0064``.
+Combined TCI: ``0x6000 | 0x0064 = 0x6064``.
+
+Or, set double VLAN with priority (inner: priority 2, ID 10; outer: priority 5, ID 20)::
 
-Or, set double VLAN ID (inner: 2, outer: 3) insertion on port 1::
+   testpmd> tx_vlan set 1 0x400A 0xA014
 
-   tx_vlan set 1 2 3
+Inner TCI calculation: ``(2 << 13) | 10 = 0x400A``.
+Outer TCI calculation: ``(5 << 13) | 20 = 0xA014``.
 
 
 tx_vlan set pvid
-- 
2.43.0

