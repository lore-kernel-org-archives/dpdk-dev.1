Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD478CD5BAB
	for <dpdk-dev@archiver.kernel.org>; Sun, 24 May 2026 09:33:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92712402EE;
	Sun, 24 May 2026 11:33:13 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 6D8FF402A3
 for <dev@dpdk.org>; Sun, 24 May 2026 11:33:08 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowABXd97QxRJq+04kEg--.9115S10;
 Sun, 24 May 2026 17:33:06 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v1 08/23] net/sxe2: support statistics and multi-process
Date: Sun, 24 May 2026 17:32:44 +0800
Message-ID: <20260524093259.397506-9-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260524093259.397506-1-liujie5@linkdatatechnology.com>
References: <20260524093259.397506-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABXd97QxRJq+04kEg--.9115S10
X-Coremail-Antispam: 1UD129KBjvAXoWDCFWkCw47KrW7Wr4rWrWruFg_yoWxXFW8Ao
 W7WrsxXw18G3sFkaykJr1rGFyUu3y0934UA3yfZFs8ua1ftr15WFnrJw43X3ZIgF4rtF1D
 Wws2yayagrZ5Jr4rn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYK7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
 Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
 84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F
 4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4U
 JwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
 IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
 M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24l42
 xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
 GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI4
 8JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4U
 MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
 8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYGYpUUUUU
X-Originating-IP: [118.112.177.181]
X-CM-SenderInfo: xolxyxrhv6zxpqngt3pdwhux5qro0w31of0z/
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

From: Jie Liu <liujie5@linkdatatechnology.com>

- The statistics support includes:
- Basic statistics (ipackets, opackets, ibytes, obytes, etc.)
- Extended statistics (xstats) for detailed hardware counters.
- Per-queue statistics for both RX and TX.

The multi-process support allows secondary processes to retrieve
statistics. Since secondary processes cannot access hardware registers
directly, an IPC mechanism is implemented using the DPDK MP API.

Atomic operations are used when reading 64-bit counters to ensure
data consistency between processes.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/meson.build     |   2 +
 drivers/net/sxe2/sxe2_cmd_chnl.c | 340 +++++++++++++++++-
 drivers/net/sxe2/sxe2_cmd_chnl.h |  23 ++
 drivers/net/sxe2/sxe2_drv_cmd.h  | 120 +++++++
 drivers/net/sxe2/sxe2_ethdev.c   |  38 +-
 drivers/net/sxe2/sxe2_mp.c       | 413 ++++++++++++++++++++++
 drivers/net/sxe2/sxe2_mp.h       |  73 ++++
 drivers/net/sxe2/sxe2_stats.c    | 586 +++++++++++++++++++++++++++++++
 drivers/net/sxe2/sxe2_stats.h    |  39 ++
 9 files changed, 1621 insertions(+), 13 deletions(-)
 create mode 100644 drivers/net/sxe2/sxe2_mp.c
 create mode 100644 drivers/net/sxe2/sxe2_mp.h
 create mode 100644 drivers/net/sxe2/sxe2_stats.c
 create mode 100644 drivers/net/sxe2/sxe2_stats.h

diff --git a/drivers/net/sxe2/meson.build b/drivers/net/sxe2/meson.build
index e3bcfc2876..d860629def 100644
--- a/drivers/net/sxe2/meson.build
+++ b/drivers/net/sxe2/meson.build
@@ -66,6 +66,8 @@ sources += files(
         'sxe2_tm.c',
         'sxe2_ipsec.c',
         'sxe2_security.c',
+        'sxe2_mp.c',
+        'sxe2_stats.c',
 )
 
 allow_internal_get_api = true
\ No newline at end of file
diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.c b/drivers/net/sxe2/sxe2_cmd_chnl.c
index 7711e8e57d..a1fc8a50e3 100644
--- a/drivers/net/sxe2/sxe2_cmd_chnl.c
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.c
@@ -348,6 +348,184 @@ int32_t sxe2_drv_mac_link_status_get(struct sxe2_adapter *adapter)
 	return ret;
 }
 
+int32_t sxe2_drv_get_mac_stats(struct sxe2_adapter *adapter)
+{
+	int32_t ret = 0;
+	uint8_t i = 0;
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_vsi *vsi = adapter->vsi_ctxt.main_vsi;
+	struct sxe2_stats *stats = &vsi->vsi_stats.vsi_hw_stats;
+	struct sxe2_drv_cmd_params param = {0};
+	struct sxe2_drv_mac_stats_resp resp = {0};
+
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_MAC_STATS_GET,
+				 NULL, 0,
+				 &resp, sizeof(resp));
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "vsi stats get failed, ret=%d", ret);
+		goto l_end;
+	}
+
+	stats->rx_out_of_buffer        = rte_le_to_cpu_64(resp.rx_out_of_buffer);
+	stats->rx_qblock_drop          = rte_le_to_cpu_64(resp.rx_qblock_drop);
+	stats->tx_frame_good           = rte_le_to_cpu_64(resp.tx_frame_good);
+	stats->rx_frame_good           = rte_le_to_cpu_64(resp.rx_frame_good);
+	stats->rx_crc_errors           = rte_le_to_cpu_64(resp.rx_crc_errors);
+	stats->tx_bytes_good           = rte_le_to_cpu_64(resp.tx_bytes_good);
+	stats->rx_bytes_good           = rte_le_to_cpu_64(resp.rx_bytes_good);
+	stats->tx_multicast_good       = rte_le_to_cpu_64(resp.tx_multicast_good);
+	stats->tx_broadcast_good       = rte_le_to_cpu_64(resp.tx_broadcast_good);
+	stats->rx_multicast_good       = rte_le_to_cpu_64(resp.rx_multicast_good);
+	stats->rx_broadcast_good       = rte_le_to_cpu_64(resp.rx_broadcast_good);
+	stats->rx_len_errors           = rte_le_to_cpu_64(resp.rx_len_errors);
+	stats->rx_out_of_range_errors  = rte_le_to_cpu_64(resp.rx_out_of_range_errors);
+	stats->rx_oversize_pkts_phy    = rte_le_to_cpu_64(resp.rx_oversize_pkts_phy);
+	stats->rx_symbol_err	       = rte_le_to_cpu_64(resp.rx_symbol_err);
+	stats->rx_pause_frame	       = rte_le_to_cpu_64(resp.rx_pause_frame);
+	stats->tx_pause_frame	       = rte_le_to_cpu_64(resp.tx_pause_frame);
+	stats->rx_discards_phy	       = rte_le_to_cpu_64(resp.rx_discards_phy);
+	stats->rx_discards_ips_phy     = rte_le_to_cpu_64(resp.rx_discards_ips_phy);
+	stats->tx_dropped_link_down    = rte_le_to_cpu_64(resp.tx_dropped_link_down);
+	stats->rx_undersize_good       = rte_le_to_cpu_64(resp.rx_undersize_good);
+	stats->rx_runt_error	       = rte_le_to_cpu_64(resp.rx_runt_error);
+	stats->tx_bytes_good_bad       = rte_le_to_cpu_64(resp.tx_bytes_good_bad);
+	stats->tx_frame_good_bad       = rte_le_to_cpu_64(resp.tx_frame_good_bad);
+	stats->rx_jabbers              = rte_le_to_cpu_64(resp.rx_jabbers);
+	stats->rx_size_64              = rte_le_to_cpu_64(resp.rx_size_64);
+	stats->rx_size_65_127          = rte_le_to_cpu_64(resp.rx_size_65_127);
+	stats->rx_size_128_255         = rte_le_to_cpu_64(resp.rx_size_128_255);
+	stats->rx_size_256_511         = rte_le_to_cpu_64(resp.rx_size_256_511);
+	stats->rx_size_512_1023        = rte_le_to_cpu_64(resp.rx_size_512_1023);
+	stats->rx_size_1024_1522       = rte_le_to_cpu_64(resp.rx_size_1024_1522);
+	stats->rx_size_1523_max        = rte_le_to_cpu_64(resp.rx_size_1523_max);
+	stats->rx_pcs_symbol_err_phy   = rte_le_to_cpu_64(resp.rx_pcs_symbol_err_phy);
+	stats->rx_corrected_bits_phy   = rte_le_to_cpu_64(resp.rx_corrected_bits_phy);
+	stats->rx_err_lane_0_phy       = rte_le_to_cpu_64(resp.rx_err_lane_0_phy);
+	stats->rx_err_lane_1_phy       = rte_le_to_cpu_64(resp.rx_err_lane_1_phy);
+	stats->rx_err_lane_2_phy       = rte_le_to_cpu_64(resp.rx_err_lane_2_phy);
+	stats->rx_err_lane_3_phy       = rte_le_to_cpu_64(resp.rx_err_lane_3_phy);
+	stats->rx_illegal_bytes        = rte_le_to_cpu_64(resp.rx_illegal_bytes);
+	stats->rx_oversize_good        = rte_le_to_cpu_64(resp.rx_oversize_good);
+	stats->tx_unicast              = rte_le_to_cpu_64(resp.tx_unicast);
+	stats->tx_broadcast            = rte_le_to_cpu_64(resp.tx_broadcast);
+	stats->tx_multicast            = rte_le_to_cpu_64(resp.tx_multicast);
+	stats->tx_vlan_packet_good     = rte_le_to_cpu_64(resp.tx_vlan_packet_good);
+	stats->tx_size_64              = rte_le_to_cpu_64(resp.tx_size_64);
+	stats->tx_size_65_127          = rte_le_to_cpu_64(resp.tx_size_65_127);
+	stats->tx_size_128_255         = rte_le_to_cpu_64(resp.tx_size_128_255);
+	stats->tx_size_256_511         = rte_le_to_cpu_64(resp.tx_size_256_511);
+	stats->tx_size_512_1023        = rte_le_to_cpu_64(resp.tx_size_512_1023);
+	stats->tx_size_1024_1522       = rte_le_to_cpu_64(resp.tx_size_1024_1522);
+	stats->tx_size_1523_max        = rte_le_to_cpu_64(resp.tx_size_1523_max);
+	stats->tx_underflow_error      = rte_le_to_cpu_64(resp.tx_underflow_error);
+	stats->rx_byte_good_bad        = rte_le_to_cpu_64(resp.rx_byte_good_bad);
+	stats->rx_frame_good_bad       = rte_le_to_cpu_64(resp.rx_frame_good_bad);
+	stats->rx_unicast_good         = rte_le_to_cpu_64(resp.rx_unicast_good);
+	stats->rx_vlan_packets         = rte_le_to_cpu_64(resp.rx_vlan_packets);
+
+	for (i = 0; i < SXE2_MAX_USER_PRIORITY; i++) {
+		stats->rx_prio_buf_discard[i]  =
+			rte_le_to_cpu_64(resp.rx_prio_buf_discard[i]);
+		stats->prio_xoff_rx[i]  =
+			rte_le_to_cpu_64(resp.prio_xoff_rx[i]);
+		stats->prio_xoff_tx[i]  =
+			rte_le_to_cpu_64(resp.prio_xoff_tx[i]);
+		stats->prio_xon_rx[i]  =
+			rte_le_to_cpu_64(resp.prio_xon_rx[i]);
+		stats->prio_xon_tx[i]  =
+			rte_le_to_cpu_64(resp.prio_xon_tx[i]);
+		stats->prio_xon_2_xoff[i]  =
+			rte_le_to_cpu_64(resp.prio_xon_2_xoff[i]);
+	}
+
+l_end:
+	return ret;
+}
+
+int32_t sxe2_drv_mac_stats_reset(struct sxe2_adapter *adapter)
+{
+	int32_t ret = 0;
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_MAC_STATS_CLEAR,
+				 NULL, 0,
+				 NULL, 0);
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "mac stats reset failed, ret=%d", ret);
+		goto l_end;
+	}
+
+l_end:
+	return ret;
+}
+
+int32_t sxe2_drv_get_vsi_stats(struct sxe2_adapter *adapter)
+{
+	int32_t ret = 0;
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_vsi *vsi = adapter->vsi_ctxt.main_vsi;
+	struct sxe2_stats *new_stats = &vsi->vsi_stats.vsi_hw_stats;
+	struct sxe2_drv_cmd_params param = {0};
+	struct sxe2_drv_vsi_stats_req req = {0};
+	struct sxe2_drv_vsi_stats_resp resp = {0};
+
+	req.vsi_id = rte_cpu_to_le_16(vsi->vsi_id);
+	req.sw_stats.rx_bytes = rte_cpu_to_le_64(vsi->vsi_stats.stats.ibytes);
+	req.sw_stats.rx_packets = rte_cpu_to_le_64(vsi->vsi_stats.stats.ipackets);
+	req.sw_stats.tx_bytes = rte_cpu_to_le_64(vsi->vsi_stats.stats.obytes);
+	req.sw_stats.tx_packets = rte_cpu_to_le_64(vsi->vsi_stats.stats.opackets);
+
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_VSI_STATS_GET,
+				 &req, sizeof(req),
+				 &resp, sizeof(resp));
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "vsi stats get failed, ret=%d", ret);
+		goto l_end;
+	}
+
+	new_stats->rx_vsi_unicast_packets   = rte_le_to_cpu_64(resp.rx_vsi_unicast_packets);
+	new_stats->rx_vsi_bytes             = rte_le_to_cpu_64(resp.rx_vsi_bytes);
+	new_stats->tx_vsi_unicast_packets   = rte_le_to_cpu_64(resp.tx_vsi_unicast_packets);
+	new_stats->tx_vsi_bytes             = rte_le_to_cpu_64(resp.tx_vsi_bytes);
+	new_stats->rx_vsi_multicast_packets = rte_le_to_cpu_64(resp.rx_vsi_multicast_packets);
+	new_stats->tx_vsi_multicast_packets = rte_le_to_cpu_64(resp.tx_vsi_multicast_packets);
+	new_stats->rx_vsi_broadcast_packets = rte_le_to_cpu_64(resp.rx_vsi_broadcast_packets);
+	new_stats->tx_vsi_broadcast_packets = rte_le_to_cpu_64(resp.tx_vsi_broadcast_packets);
+	new_stats->opackets = new_stats->tx_vsi_unicast_packets +
+			      new_stats->tx_vsi_multicast_packets +
+			      new_stats->tx_vsi_broadcast_packets;
+	new_stats->obytes = new_stats->tx_vsi_bytes;
+	new_stats->ipackets = new_stats->rx_vsi_unicast_packets +
+			      new_stats->rx_vsi_multicast_packets +
+			      new_stats->rx_vsi_broadcast_packets;
+	new_stats->ibytes = new_stats->rx_vsi_bytes;
+
+l_end:
+	return ret;
+}
+
+int32_t sxe2_drv_vsi_stats_reset(struct sxe2_adapter *adapter)
+{
+	int32_t ret = 0;
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_VSI_STATS_CLEAR,
+				 NULL, 0, NULL, 0);
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "vsi stats reset failed, ret=%d", ret);
+		goto l_end;
+	}
+
+l_end:
+	return ret;
+}
+
 int32_t sxe2_drv_promisc_config(struct sxe2_adapter *adapter, bool set)
 {
 	int32_t ret = 0;
@@ -409,8 +587,9 @@ int32_t sxe2_drv_uc_config(struct sxe2_adapter *adapter, struct rte_ether_addr *
 	mac_filter_cfg_req.type = SXE2_MAC_FILTER_TYPE_UC;
 
 	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_MAC_ADDR_UC,
-		 &mac_filter_cfg_req, sizeof(mac_filter_cfg_req),
-		 NULL, 0);
+				 &mac_filter_cfg_req,
+				 sizeof(mac_filter_cfg_req),
+				 NULL, 0);
 
 	ret = sxe2_drv_cmd_exec(cdev, &param);
 	if (ret)
@@ -435,8 +614,8 @@ int32_t sxe2_drv_mc_config(struct sxe2_adapter *adapter, struct rte_ether_addr *
 	mac_filter_cfg_req.type = SXE2_MAC_FILTER_TYPE_MC;
 
 	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_MAC_ADDR_MC,
-		 &mac_filter_cfg_req, sizeof(mac_filter_cfg_req),
-		 NULL, 0);
+				  &mac_filter_cfg_req, sizeof(mac_filter_cfg_req),
+				 NULL, 0);
 
 	ret = sxe2_drv_cmd_exec(cdev, &param);
 	if (ret)
@@ -455,7 +634,7 @@ int32_t sxe2_drv_vlan_config_query(struct sxe2_adapter *adapter)
 	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_VLAN_CFG_QUERY,
 				 NULL, 0,
 				 &vlan_cfg_query_resp,
-	 sizeof(vlan_cfg_query_resp));
+				 sizeof(vlan_cfg_query_resp));
 
 	ret = sxe2_drv_cmd_exec(cdev, &param);
 	if (ret)
@@ -566,7 +745,8 @@ int32_t sxe2_drv_rss_key_set(struct sxe2_adapter *adapter, uint8_t *key, uint16_
 	rte_memcpy(req->key, key, key_size);
 
 	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_RSS_KEY_SET,
-		req, buf_size, NULL, 0);
+				 req, buf_size,
+				 NULL, 0);
 
 	ret = sxe2_drv_cmd_exec(cdev, &param);
 	if (ret) {
@@ -602,7 +782,8 @@ int32_t sxe2_drv_rss_lut_set(struct sxe2_adapter *adapter, uint8_t *lut, uint16_
 	rte_memcpy(req->lut, lut, lut_size);
 
 	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_RSS_LUT_SET,
-		req, buf_size, NULL, 0);
+				 req, buf_size,
+				 NULL, 0);
 
 	ret = sxe2_drv_cmd_exec(cdev, &param);
 	if (ret) {
@@ -629,7 +810,8 @@ int32_t sxe2_drv_rss_hash_ctrl_func(struct sxe2_adapter *adapter, enum sxe2_rss_
 	req.func = func;
 
 	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_RSS_FUNC_SET,
-		&req, sizeof(req), NULL, 0);
+				 &req, sizeof(req),
+				 NULL, 0);
 
 	ret = sxe2_drv_cmd_exec(cdev, &param);
 	if (ret)
@@ -665,7 +847,8 @@ int32_t sxe2_drv_rss_hf_add(struct sxe2_adapter *adapter,
 	sxe2_drv_flow_bitmap_fill(req.hash_flds, rss_conf->flds);
 
 	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_RSS_HF_ADD,
-		&req, sizeof(req), NULL, 0);
+				 &req, sizeof(req),
+				 NULL, 0);
 
 	ret = sxe2_drv_cmd_exec(cdev, &param);
 	if (ret)
@@ -703,7 +886,8 @@ int32_t sxe2_drv_rss_hf_clear(struct sxe2_adapter *adapter)
 	int32_t ret = 0;
 
 	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_RSS_HF_CLEAR,
-		NULL, 0, NULL, 0);
+				 NULL, 0,
+				 NULL, 0);
 
 	ret = sxe2_drv_cmd_exec(cdev, &param);
 	if (ret)
@@ -878,7 +1062,6 @@ int32_t sxe2_drv_tm_commit(struct sxe2_adapter *adapter)
 	return ret;
 }
 
-
 int32_t sxe2_drv_ipsec_get_capa(struct sxe2_adapter *adapter)
 {
 	int32_t ret = -1;
@@ -1074,3 +1257,138 @@ int32_t sxe2_drv_ipsec_txsa_delete(struct sxe2_adapter *adapter,
 	return ret;
 }
 
+int32_t sxe2_drv_queue_info_get_update(struct sxe2_adapter *adapter, struct eth_queue_stats *qstats)
+{
+	struct sxe2_drv_cmd_params param = {0};
+	struct sxe2_queue_map_info resp = {0};
+	struct sxe2_common_device *cdev = adapter->cdev;
+	uint8_t pool_idx;
+	uint8_t index;
+	int32_t ret;
+
+	if (!(adapter->cap_flags & SXE2_DEV_CAPS_OFFLOAD_Q_MAP)) {
+		ret = 0;
+		goto l_end;
+	}
+
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_TX_RX_MAP_GET,
+				 NULL, 0,
+				 &resp, sizeof(resp));
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret) {
+		PMD_LOG_ERR(DRV, "get queue info map failed, ret=%d", ret);
+		goto l_end;
+	}
+
+	for (pool_idx = 0; pool_idx < SXE2_RXQ_STATS_MAP_MAX_NUM; pool_idx++) {
+		qstats->q_ipackets[pool_idx] = resp.rxq_stats_map_info[pool_idx].rxq_lan_in_pkt_cnt;
+		qstats->q_ibytes[pool_idx] = resp.rxq_stats_map_info[pool_idx].rxq_lan_in_byte_cnt;
+	}
+
+	for (index = 0; index < SXE2_TXQ_STATS_MAP_MAX_NUM; index++) {
+		qstats->q_opackets[index] = resp.txq_stats_map_info[index].txq_lan_pkt_cnt;
+		qstats->q_obytes[index] = resp.txq_stats_map_info[index].txq_lan_byte_cnt;
+	}
+
+l_end:
+	return ret;
+}
+
+int32_t sxe2_drv_rxq_mapping_set(struct rte_eth_dev *eth_dev, uint16_t queue_id, uint8_t pool_idx)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(eth_dev);
+	int32_t ret = 0;
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+	struct sxe2_drv_rx_map_req req = {0};
+	struct sxe2_rx_queue *rxq = NULL;
+
+	rxq = eth_dev->data->rx_queues[queue_id];
+	if (rxq == NULL) {
+		PMD_LOG_ERR(DRV, "Rx queue %u is not available or setup",
+				queue_id);
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	req.queue_id = rxq->queue_id;
+	req.pool_idx = pool_idx;
+
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_RX_MAP_SET,
+				 &req, sizeof(req),
+				 NULL, 0);
+
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret)
+		PMD_LOG_ERR(DRV, "get dev caps failed, ret=%d", ret);
+
+l_end:
+	return ret;
+}
+
+int32_t sxe2_drv_txq_mapping_set(struct rte_eth_dev *eth_dev, uint16_t queue_id, uint8_t pool_idx)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(eth_dev);
+	int32_t ret = 0;
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+	struct sxe2_drv_tx_map_req req = {0};
+	struct sxe2_tx_queue *txq = NULL;
+
+	txq = eth_dev->data->tx_queues[queue_id];
+	if (txq == NULL) {
+		PMD_LOG_ERR(DRV, "Rx queue %u is not available or setup", queue_id);
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	req.queue_id = txq->queue_id;
+	req.pool_idx = pool_idx;
+
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_TX_MAP_SET,
+				 &req, sizeof(req),
+				 NULL, 0);
+
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret)
+		PMD_LOG_ERR(DRV, "get dev caps failed, ret=%d", ret);
+
+l_end:
+	return ret;
+}
+
+int32_t sxe2_drv_mapping_reset(struct rte_eth_dev *eth_dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(eth_dev);
+	struct sxe2_drv_cmd_params param = {0};
+	struct sxe2_common_device *cdev = adapter->cdev;
+	int32_t ret;
+
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_TX_RX_MAP_RESET,
+				 NULL, 0,
+				 NULL, 0);
+
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret)
+		PMD_LOG_ERR(DRV, "Reset queue mapping failed, ret=%d", ret);
+
+	return ret;
+}
+
+int32_t sxe2_drv_mapping_stats_info_clear(struct rte_eth_dev *eth_dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(eth_dev);
+	struct sxe2_drv_cmd_params param = {0};
+	struct sxe2_common_device *cdev = adapter->cdev;
+	int32_t ret;
+
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_TX_RX_MAP_INFO_CLEAR,
+				 NULL, 0,
+				 NULL, 0);
+
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret)
+		PMD_LOG_ERR(DRV, "Clear map stats info failed, ret=%d", ret);
+
+	return ret;
+}
diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.h b/drivers/net/sxe2/sxe2_cmd_chnl.h
index d8e09a4453..ff73d2f901 100644
--- a/drivers/net/sxe2/sxe2_cmd_chnl.h
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.h
@@ -64,6 +64,29 @@ int32_t sxe2_drv_ipsec_txsa_delete(struct sxe2_adapter *adapter,
 
 int32_t sxe2_drv_promisc_config(struct sxe2_adapter *adapter, bool set);
 
+int32_t sxe2_drv_mac_link_status_get(struct sxe2_adapter *adapter);
+
+int32_t sxe2_drv_get_mac_stats(struct sxe2_adapter *adapter);
+
+int32_t sxe2_drv_mac_stats_reset(struct sxe2_adapter *adapter);
+
+int32_t sxe2_drv_get_vsi_stats(struct sxe2_adapter *adapter);
+
+int32_t sxe2_drv_vsi_stats_reset(struct sxe2_adapter *adapter);
+
+int32_t sxe2_drv_queue_info_get_update(struct sxe2_adapter *adapter,
+				       struct eth_queue_stats *qstats);
+
+int32_t sxe2_drv_rxq_mapping_set(struct rte_eth_dev *eth_dev, uint16_t queue_id, uint8_t pool_idx);
+
+int32_t sxe2_drv_txq_mapping_set(struct rte_eth_dev *eth_dev, uint16_t queue_id, uint8_t pool_idx);
+
+int32_t sxe2_drv_mapping_reset(struct rte_eth_dev *eth_dev);
+
+int32_t sxe2_drv_mapping_stats_info_clear(struct rte_eth_dev *eth_dev);
+
+int32_t sxe2_drv_rxq_mapping_set(struct rte_eth_dev *eth_dev, uint16_t queue_id, uint8_t pool_idx);
+
 int32_t sxe2_drv_allmulti_config(struct sxe2_adapter *adapter, bool set);
 
 int32_t sxe2_drv_uc_config(struct sxe2_adapter *adapter, struct rte_ether_addr *addr, bool add);
diff --git a/drivers/net/sxe2/sxe2_drv_cmd.h b/drivers/net/sxe2/sxe2_drv_cmd.h
index 4d9c2e05a8..a88e2b24bf 100644
--- a/drivers/net/sxe2/sxe2_drv_cmd.h
+++ b/drivers/net/sxe2/sxe2_drv_cmd.h
@@ -434,6 +434,126 @@ struct sxe2_drv_ipsec_rxsa_del_req {
 	uint8_t drv_id;
 };
 
+struct sxe2_drv_vsi_sw_stats {
+	__le64 rx_packets;
+	__le64 rx_bytes;
+	__le64 tx_packets;
+	__le64 tx_bytes;
+};
+
+struct sxe2_drv_vsi_stats_req {
+	__le16 vsi_id;
+	uint8_t  rsv[2];
+	struct sxe2_drv_vsi_sw_stats sw_stats;
+};
+
+struct sxe2_drv_vsi_stats_resp {
+	__le64 rx_vsi_unicast_packets;
+	__le64 rx_vsi_bytes;
+	__le64 tx_vsi_unicast_packets;
+	__le64 tx_vsi_bytes;
+	__le64 rx_vsi_multicast_packets;
+	__le64 tx_vsi_multicast_packets;
+	__le64 rx_vsi_broadcast_packets;
+	__le64 tx_vsi_broadcast_packets;
+};
+
+#define SXE2_MAX_USER_PRIORITY         (8)
+
+struct sxe2_drv_mac_stats_resp {
+	__le64 rx_out_of_buffer;
+	__le64 rx_qblock_drop;
+	__le64 tx_frame_good;
+	__le64 rx_frame_good;
+	__le64 rx_crc_errors;
+	__le64 tx_bytes_good;
+	__le64 rx_bytes_good;
+	__le64 tx_multicast_good;
+	__le64 tx_broadcast_good;
+	__le64 rx_multicast_good;
+	__le64 rx_broadcast_good;
+	__le64 rx_len_errors;
+	__le64 rx_out_of_range_errors;
+	__le64 rx_oversize_pkts_phy;
+	__le64 rx_symbol_err;
+	__le64 rx_pause_frame;
+	__le64 tx_pause_frame;
+	__le64 rx_discards_phy;
+	__le64 rx_discards_ips_phy;
+	__le64 tx_dropped_link_down;
+	__le64 rx_undersize_good;
+	__le64 rx_runt_error;
+	__le64 tx_bytes_good_bad;
+	__le64 tx_frame_good_bad;
+	__le64 rx_jabbers;
+	__le64 rx_size_64;
+	__le64 rx_size_65_127;
+	__le64 rx_size_128_255;
+	__le64 rx_size_256_511;
+	__le64 rx_size_512_1023;
+	__le64 rx_size_1024_1522;
+	__le64 rx_size_1523_max;
+	__le64 rx_pcs_symbol_err_phy;
+	__le64 rx_corrected_bits_phy;
+	__le64 rx_err_lane_0_phy;
+	__le64 rx_err_lane_1_phy;
+	__le64 rx_err_lane_2_phy;
+	__le64 rx_err_lane_3_phy;
+	__le64 rx_prio_buf_discard[SXE2_MAX_USER_PRIORITY];
+	__le64 rx_illegal_bytes;
+	__le64 rx_oversize_good;
+	__le64 tx_unicast;
+	__le64 tx_broadcast;
+	__le64 tx_multicast;
+	__le64 tx_vlan_packet_good;
+	__le64 tx_size_64;
+	__le64 tx_size_65_127;
+	__le64 tx_size_128_255;
+	__le64 tx_size_256_511;
+	__le64 tx_size_512_1023;
+	__le64 tx_size_1024_1522;
+	__le64 tx_size_1523_max;
+	__le64 tx_underflow_error;
+	__le64 rx_byte_good_bad;
+	__le64 rx_frame_good_bad;
+	__le64 rx_unicast_good;
+	__le64 rx_vlan_packets;
+	__le64 prio_xoff_rx[SXE2_MAX_USER_PRIORITY];
+	__le64 prio_xon_rx[SXE2_MAX_USER_PRIORITY];
+	__le64 prio_xon_tx[SXE2_MAX_USER_PRIORITY];
+	__le64 prio_xoff_tx[SXE2_MAX_USER_PRIORITY];
+	__le64 prio_xon_2_xoff[SXE2_MAX_USER_PRIORITY];
+};
+
+struct sxe2_txq_map_info {
+	__le32 txq_lan_pkt_cnt;
+	__le32 txq_lan_byte_cnt;
+};
+
+struct sxe2_rxq_map_info {
+	__le64 rxq_lan_in_pkt_cnt;
+	__le64 rxq_lan_in_byte_cnt;
+	__le64 rxq_fd_in_pkt_cnt;
+	__le64 rxq_mng_in_pkt_cnt;
+	__le64 rxq_mng_in_byte_cnt;
+	__le64 rxq_mng_out_pkt_cnt;
+};
+
+struct sxe2_queue_map_info {
+	struct sxe2_rxq_map_info rxq_stats_map_info[SXE2_RXQ_STATS_MAP_MAX_NUM];
+	struct sxe2_txq_map_info txq_stats_map_info[SXE2_TXQ_STATS_MAP_MAX_NUM];
+};
+
+struct sxe2_drv_rx_map_req {
+	__le16 queue_id;
+	uint8_t pool_idx;
+};
+
+struct sxe2_drv_tx_map_req {
+	__le16 queue_id;
+	uint8_t pool_idx;
+};
+
 enum sxe2_drv_cmd_module {
 	SXE2_DRV_CMD_MODULE_HANDSHAKE = 0,
 	SXE2_DRV_CMD_MODULE_DEV = 1,
diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
index 00c0552d4a..dbe1a2bce1 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -31,6 +31,8 @@
 #include "sxe2_common.h"
 #include "sxe2_ptype.h"
 #include "sxe2_common_log.h"
+#include "sxe2_mp.h"
+#include "sxe2_stats.h"
 #include "sxe2_host_regs.h"
 #include "sxe2_ioctl_chnl_func.h"
 
@@ -132,6 +134,14 @@ static const struct eth_dev_ops sxe2_eth_dev_ops = {
 	.rss_hash_conf_get          = sxe2_dev_rss_hash_conf_get,
 
 	.tm_ops_get                 = sxe2_tm_ops_get,
+
+	.stats_get                  = sxe2_stats_info_get,
+	.stats_reset                = sxe2_stats_info_reset,
+	.xstats_get                 = sxe2_xstats_info_get,
+	.xstats_get_names           = sxe2_xstats_names_get,
+	.xstats_reset               = sxe2_stats_info_reset,
+
+	.queue_stats_mapping_set    = sxe2_queue_stats_mapping_set,
 };
 
 static int32_t sxe2_dev_configure(struct rte_eth_dev *dev)
@@ -1023,6 +1033,9 @@ static int32_t sxe2_dev_init(struct rte_eth_dev *dev,
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
 		sxe2_rx_mode_func_set(dev);
 		sxe2_tx_mode_func_set(dev);
+		ret = sxe2_mp_init(dev);
+		if (ret != 0)
+			PMD_LOG_ERR(INIT, "Failed to mp init (secondary), ret=%d", ret);
 		goto l_end;
 	}
 
@@ -1076,12 +1089,27 @@ static int32_t sxe2_dev_init(struct rte_eth_dev *dev,
 		goto init_sched_err;
 	}
 
+	ret = sxe2_stats_init(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to stats init, ret=%d", ret);
+		goto init_xstats_err;
+	}
+
+	ret = sxe2_mp_init(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to mp init, ret=%d", ret);
+		goto init_xstats_err;
+	}
+
 	goto l_end;
 
-init_security_err:
-	sxe2_eth_uinit(dev);
+init_xstats_err:
+	(void)sxe2_sched_uinit(dev);
 init_sched_err:
 init_rss_err:
+	sxe2_security_uinit(dev);
+init_security_err:
+	sxe2_eth_uinit(dev);
 init_eth_err:
 init_dev_info_err:
 	sxe2_vsi_uninit(dev);
@@ -1093,8 +1121,13 @@ static int32_t sxe2_dev_init(struct rte_eth_dev *dev,
 
 static int32_t sxe2_dev_close(struct rte_eth_dev *dev)
 {
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
+		sxe2_mp_uninit(dev);
+		goto l_end;
+	}
 	(void)sxe2_dev_stop(dev);
 	(void)sxe2_queues_release(dev);
+	sxe2_mp_uninit(dev);
 	(void)sxe2_rss_disable(dev);
 	(void)sxe2_sched_uinit(dev);
 	sxe2_vsi_uninit(dev);
@@ -1102,6 +1135,7 @@ static int32_t sxe2_dev_close(struct rte_eth_dev *dev)
 	sxe2_dev_pci_map_uinit(dev);
 	sxe2_eth_uinit(dev);
 
+l_end:
 	return 0;
 }
 
diff --git a/drivers/net/sxe2/sxe2_mp.c b/drivers/net/sxe2/sxe2_mp.c
new file mode 100644
index 0000000000..caf044dd24
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_mp.c
@@ -0,0 +1,413 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#include <rte_eal.h>
+#include <rte_ethdev.h>
+#include <ethdev_driver.h>
+#include <rte_log.h>
+#include <rte_malloc.h>
+#include <rte_memzone.h>
+#include <rte_string_fns.h>
+
+#include "sxe2_mp.h"
+#include "sxe2_stats.h"
+#include "sxe2_common_log.h"
+
+static RTE_ATOMIC(uint16_t)primary_ethdev_cnt;
+static RTE_ATOMIC(uint16_t)secondary_ethdev_cnt;
+static const struct rte_memzone *sxe2_mp_mz;
+
+static int32_t sxe2_mp_acquire_token(void);
+static void sxe2_mp_release_token(void);
+
+static int32_t sxe2_mp_primary_handle(const struct rte_mp_msg *mp_msg,
+				   const void *peer);
+
+static int32_t sxe2_mp_secondary_handle(const struct rte_mp_msg *mp_msg,
+					 const void *peer);
+
+static int32_t
+sxe2_mp_primary_handle(const struct rte_mp_msg *mp_msg, const void *peer)
+{
+	struct rte_mp_msg reply;
+	const struct sxe2_mp_param *param =
+			(const struct sxe2_mp_param *)mp_msg->param;
+	struct sxe2_mp_param *reply_param = (struct sxe2_mp_param *)reply.param;
+	struct rte_eth_dev *dev;
+	int32_t ret = 0;
+	struct sxe2_mp_shared_data *mz_data;
+	int32_t send_reply = 0;
+	int32_t cnt = 0;
+
+	if (!rte_eth_dev_is_valid_port(param->port_id)) {
+		PMD_LOG_ERR(DRV, "primary process: invalid port_id %u",
+				param->port_id);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	dev = &rte_eth_devices[param->port_id];
+	sxe2_mp_mz = rte_memzone_lookup(SXE2_MP_MZ_NAME);
+	if (sxe2_mp_mz == NULL) {
+		PMD_LOG_ERR(DRV, "Failed to lookup memzone %s", SXE2_MP_MZ_NAME);
+		ret = -ENOENT;
+		goto out;
+	}
+
+	mz_data = (struct sxe2_mp_shared_data *)sxe2_mp_mz->addr;
+	send_reply = 1;
+
+	memset(&reply, 0, sizeof(reply));
+	(void)strlcpy(reply.name, SXE2_MP_NAME, sizeof(reply.name));
+	reply.len_param = sizeof(*reply_param);
+
+	switch (param->type) {
+	case SXE2_MP_REQ_GET_STATS:
+		ret = sxe2_stats_info_get(dev,
+					  &mz_data->payload.stats_blk.stats,
+					  &mz_data->payload.stats_blk.qstats);
+		break;
+	case SXE2_MP_REQ_GET_XSTATS:
+		cnt = sxe2_xstats_info_get(dev,
+				mz_data->payload.xstats_blk.xstats,
+				SXE2_MP_MAX_XSTATS);
+
+		if (cnt >= 0) {
+			mz_data->payload.xstats_blk.xstats_num = (uint32_t)cnt;
+			ret = 0;
+		} else {
+			mz_data->payload.xstats_blk.xstats_num = 0;
+			ret = cnt;
+		}
+		break;
+	case SXE2_MP_REQ_RESET_STATS:
+		ret = sxe2_stats_hw_reset(dev);
+		break;
+	default:
+		PMD_LOG_ERR(DRV, "primary process: unrecognized msg type: %d",
+				param->type);
+		send_reply = false;
+		ret = -EINVAL;
+		goto out;
+	}
+out:
+	if (!send_reply)
+		return ret;
+
+	reply_param->result = ret;
+	reply_param->type = param->type;
+	reply_param->port_id = param->port_id;
+
+	return rte_mp_reply(&reply, peer);
+}
+
+static int32_t
+sxe2_mp_secondary_handle(const struct rte_mp_msg *mp_msg __rte_unused,
+			 const void *peer __rte_unused)
+{
+	PMD_LOG_WARN(DRV, "the secondary process handler should not be called");
+	return 0;
+}
+
+static int32_t
+sxe2_mp_init_primary(__rte_unused struct rte_eth_dev *dev)
+{
+	int32_t ret;
+
+	if (sxe2_mp_mz == NULL) {
+		sxe2_mp_mz = rte_memzone_reserve(SXE2_MP_MZ_NAME,
+				sizeof(struct sxe2_mp_shared_data),
+				rte_socket_id(), 0);
+		if (sxe2_mp_mz == NULL && rte_errno != EEXIST) {
+			PMD_LOG_ERR(DRV, "Failed to reserve memzone %s, error: %d",
+					SXE2_MP_MZ_NAME, -rte_errno);
+			ret = -rte_errno;
+			goto out;
+		}
+
+		sxe2_mp_mz = rte_memzone_lookup(SXE2_MP_MZ_NAME);
+		if (sxe2_mp_mz == NULL) {
+			PMD_LOG_ERR(DRV, "Failed to lookup memzone %s", SXE2_MP_MZ_NAME);
+			ret = -ENOENT;
+			goto out;
+		}
+
+		struct sxe2_mp_shared_data *mz =
+			(struct sxe2_mp_shared_data *)sxe2_mp_mz->addr;
+		rte_atomic_store_explicit(&mz->in_use, 0, rte_memory_order_release);
+	}
+
+	ret = rte_mp_action_register(SXE2_MP_NAME, sxe2_mp_primary_handle);
+	if (ret && rte_errno == ENOTSUP) {
+		PMD_LOG_INFO(DRV, "Primary not support IPC.");
+		ret = 0;
+		goto out;
+	} else if (ret && rte_errno != EEXIST) {
+		PMD_LOG_ERR(DRV, "Failed to register MP primary handle, error: %d",
+			-rte_errno);
+		goto out;
+	}
+
+	rte_atomic_fetch_add_explicit(&primary_ethdev_cnt, 1, rte_memory_order_relaxed);
+
+	ret = 0;
+out:
+	return ret;
+}
+
+static int32_t
+sxe2_mp_init_secondary(__rte_unused struct rte_eth_dev *dev)
+{
+	int32_t ret;
+
+	sxe2_mp_mz = rte_memzone_lookup(SXE2_MP_MZ_NAME);
+	if (sxe2_mp_mz == NULL) {
+		PMD_LOG_ERR(DRV, "Failed to lookup memzone %s", SXE2_MP_MZ_NAME);
+		ret = -ENOENT;
+		goto out;
+	}
+
+	ret = rte_mp_action_register(SXE2_MP_NAME, sxe2_mp_secondary_handle);
+	if (ret && rte_errno != EEXIST) {
+		PMD_LOG_ERR(DRV, "Failed to register MP secondary handle, error: %d",
+				-rte_errno);
+		goto out;
+	}
+
+	rte_atomic_fetch_add_explicit(&secondary_ethdev_cnt, 1, rte_memory_order_relaxed);
+
+	ret = 0;
+out:
+	return ret;
+}
+
+int32_t
+sxe2_mp_init(struct rte_eth_dev *dev)
+{
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY)
+		return sxe2_mp_init_primary(dev);
+	else
+		return sxe2_mp_init_secondary(dev);
+}
+
+void
+sxe2_mp_uninit(__rte_unused struct rte_eth_dev *dev)
+{
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		if (rte_atomic_fetch_sub_explicit(&primary_ethdev_cnt, 1,
+			rte_memory_order_acq_rel) == 1) {
+			rte_mp_action_unregister(SXE2_MP_NAME);
+			if (sxe2_mp_mz != NULL) {
+				rte_memzone_free(sxe2_mp_mz);
+				sxe2_mp_mz = NULL;
+			}
+		}
+	} else {
+		if (rte_atomic_fetch_sub_explicit(&secondary_ethdev_cnt, 1,
+			rte_memory_order_acq_rel) == 1)
+			rte_mp_action_unregister(SXE2_MP_NAME);
+	}
+}
+
+static int32_t sxe2_mp_acquire_token(void)
+{
+	struct sxe2_mp_shared_data *mz;
+	uint16_t expected;
+
+	if (sxe2_mp_mz == NULL)
+		return -EINVAL;
+
+	mz = (struct sxe2_mp_shared_data *)sxe2_mp_mz->addr;
+
+	for (int32_t i = 0; i < SXE2_MP_MAX_SPIN; i++) {
+		expected = 0;
+		if (rte_atomic_compare_exchange_strong_explicit(&mz->in_use, &expected, 1,
+			rte_memory_order_acquire, rte_memory_order_relaxed))
+			return 0;
+
+		rte_pause();
+	}
+	return -EBUSY;
+}
+
+static void sxe2_mp_release_token(void)
+{
+	struct sxe2_mp_shared_data *mz;
+
+	if (sxe2_mp_mz == NULL)
+		return;
+
+	mz = (struct sxe2_mp_shared_data *)sxe2_mp_mz->addr;
+	rte_atomic_store_explicit(&mz->in_use, 0, rte_memory_order_release);
+}
+
+int32_t sxe2_mp_request_simple(struct rte_eth_dev *dev,
+			   enum sxe2_mp_req_type type,
+			   int32_t *result_out)
+{
+	struct rte_mp_msg msg;
+	struct rte_mp_reply reply = { 0 };
+	struct timespec ts = { .tv_sec = SXE2_MP_MSG_TIMEOUT, .tv_nsec = 0 };
+	struct sxe2_mp_param *param = (struct sxe2_mp_param *)msg.param;
+	struct sxe2_mp_shared_data *mz_data;
+	int32_t ret = 0;
+
+	mz_data = (struct sxe2_mp_shared_data *)sxe2_mp_mz->addr;
+
+	memset(&mz_data->payload, 0, sizeof(mz_data->payload));
+	memset(&msg, 0, sizeof(msg));
+	(void)strlcpy(msg.name, SXE2_MP_NAME, sizeof(msg.name));
+	msg.len_param = sizeof(*param);
+	param->type = type;
+	param->port_id = dev->data->port_id;
+
+	ret = rte_mp_request_sync(&msg, &reply, &ts);
+	if (ret != 0) {
+		PMD_LOG_ERR(DRV,
+				"IPC request(type=%d) failed for port %u: %s",
+				type, dev->data->port_id, rte_strerror(rte_errno));
+		ret = -rte_errno;
+		goto out;
+	}
+
+	if (reply.nb_received == 0) {
+		PMD_LOG_ERR(DRV, "No response received from primary for type=%d, port %u",
+			type, dev->data->port_id);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	*result_out = ((struct sxe2_mp_param *)reply.msgs[0].param)->result;
+
+out:
+	if (reply.msgs != NULL)
+		free(reply.msgs);
+
+	return ret;
+}
+
+int32_t sxe2_mp_req_get_stats(struct rte_eth_dev *dev,
+		      struct rte_eth_stats *stats,
+		      struct eth_queue_stats *qstats)
+{
+	struct sxe2_mp_shared_data *mz_data;
+	int32_t mp_ret;
+	int32_t ret;
+	int32_t token_acquired = 0;
+
+	if (sxe2_mp_mz == NULL)
+		return -EINVAL;
+
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		PMD_LOG_WARN(DRV, "Primary process direct execution for port %u",
+			     dev->data->port_id);
+		return sxe2_stats_info_get(dev, stats, qstats);
+	}
+
+	int32_t token_ret = sxe2_mp_acquire_token();
+	if (token_ret != 0)
+		return token_ret;
+	token_acquired = 1;
+
+	mp_ret = sxe2_mp_request_simple(dev, SXE2_MP_REQ_GET_STATS, &ret);
+	if (mp_ret != 0) {
+		ret = mp_ret;
+		goto out;
+	}
+
+	if (ret != 0) {
+		PMD_LOG_ERR(DRV, "Primary failed to exec request (type=%d), result: %d for port %u",
+			    SXE2_MP_REQ_GET_STATS, ret, dev->data->port_id);
+		goto out;
+	}
+
+	mz_data = (struct sxe2_mp_shared_data *)sxe2_mp_mz->addr;
+	memcpy(stats, &mz_data->payload.stats_blk.stats, sizeof(*stats));
+	memcpy(qstats, &mz_data->payload.stats_blk.qstats, sizeof(*qstats));
+	PMD_LOG_DEBUG(DRV, "sxe2_mp: stats received via IPC for port %u",
+			  dev->data->port_id);
+	ret = 0;
+out:
+	if (token_acquired)
+		sxe2_mp_release_token();
+	return ret;
+}
+
+int32_t sxe2_mp_req_get_xstats(struct rte_eth_dev *dev,
+			   struct rte_eth_xstat *xstats, uint32_t usr_cnt)
+{
+	struct sxe2_mp_shared_data *mz_data;
+	int32_t ret;
+	int32_t mp_ret;
+	int32_t token_acquired = 0;
+
+	if (sxe2_mp_mz == NULL)
+		return -EINVAL;
+
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		PMD_LOG_WARN(DRV, "Primary process direct execution for port %u",
+			     dev->data->port_id);
+		return sxe2_xstats_info_get(dev, xstats, usr_cnt);
+	}
+
+	int32_t token_ret = sxe2_mp_acquire_token();
+	if (token_ret != 0)
+		return token_ret;
+	token_acquired = 1;
+
+	mp_ret = sxe2_mp_request_simple(dev, SXE2_MP_REQ_GET_XSTATS, &ret);
+	if (mp_ret != 0) {
+		ret = mp_ret;
+		goto out;
+	}
+
+	if (ret != 0) {
+		PMD_LOG_ERR(DRV, "Primary failed to exec request (type=%d), result: %d for port %u",
+			    SXE2_MP_REQ_GET_XSTATS, ret, dev->data->port_id);
+		goto out;
+	}
+
+	mz_data = (struct sxe2_mp_shared_data *)sxe2_mp_mz->addr;
+	if (usr_cnt < mz_data->payload.xstats_blk.xstats_num) {
+		PMD_LOG_ERR(DRV, "user usr_cnt:%u less than xstats cnt:%u.",
+			    usr_cnt, mz_data->payload.xstats_blk.xstats_num);
+		ret = (int32_t)mz_data->payload.xstats_blk.xstats_num;
+		goto out;
+	}
+
+	memcpy(xstats, mz_data->payload.xstats_blk.xstats,
+		   mz_data->payload.xstats_blk.xstats_num *
+			   sizeof(struct rte_eth_xstat));
+	ret = (int32_t)mz_data->payload.xstats_blk.xstats_num;
+
+	PMD_LOG_DEBUG(DRV,
+			  "xstats received via IPC for port %u (cnt=%d)",
+			  dev->data->port_id, ret);
+out:
+	if (token_acquired)
+		sxe2_mp_release_token();
+	return ret;
+}
+
+int32_t
+sxe2_mp_req_reset_stats(struct rte_eth_dev *dev)
+{
+	int32_t mp_ret;
+	int32_t ret = 0;
+
+	if (sxe2_mp_mz == NULL)
+		return -EINVAL;
+
+	mp_ret = sxe2_mp_request_simple(dev, SXE2_MP_REQ_RESET_STATS, &ret);
+	if (mp_ret != 0)
+		return mp_ret;
+
+	if (ret != 0) {
+		PMD_LOG_ERR(DRV,
+				"Primary failed SXE2_MP_REQ_RESET_STATS, result: %d for port %u",
+				ret, dev->data->port_id);
+		return ret;
+	}
+	return 0;
+}
diff --git a/drivers/net/sxe2/sxe2_mp.h b/drivers/net/sxe2/sxe2_mp.h
new file mode 100644
index 0000000000..0e97655718
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_mp.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef SXE2_MP_H
+#define SXE2_MP_H
+
+#include <rte_eal.h>
+#include <rte_ethdev.h>
+#include <rte_memzone.h>
+#include <rte_stdatomic.h>
+
+#define SXE2_MP_NAME		"sxe2_mp_msg"
+#define SXE2_MP_MZ_NAME		"sxe2_stats_mz"
+
+#define SXE2_MP_MSG_TIMEOUT 30
+
+#define SXE2_MP_MAX_XSTATS	128
+
+#define SXE2_MP_MAX_SPIN	100000
+
+enum sxe2_mp_req_type {
+	SXE2_MP_REQ_GET_STATS = 1,
+	SXE2_MP_REQ_GET_XSTATS,
+	SXE2_MP_REQ_RESET_STATS,
+};
+
+struct sxe2_mp_param {
+	enum sxe2_mp_req_type type;
+	uint32_t port_id;
+	int result;
+};
+
+union sxe2_mp_shared_payload {
+	struct {
+		struct rte_eth_stats stats;
+		struct eth_queue_stats qstats;
+	} stats_blk;
+	struct {
+		struct rte_eth_xstat xstats[SXE2_MP_MAX_XSTATS];
+		uint32_t xstats_num;
+	} xstats_blk;
+};
+
+struct sxe2_mp_shared_data {
+	RTE_ATOMIC(uint16_t)in_use;
+	union sxe2_mp_shared_payload payload;
+};
+
+static inline void sxe2_unlock_auto(rte_spinlock_t **lock)
+{
+	if (lock && *lock)
+		rte_spinlock_unlock(*lock);
+}
+
+int sxe2_mp_init(struct rte_eth_dev *dev);
+
+void sxe2_mp_uninit(struct rte_eth_dev *dev);
+
+int sxe2_mp_request_simple(struct rte_eth_dev *dev,
+			   enum sxe2_mp_req_type type,
+			   int *result_out);
+
+int sxe2_mp_req_get_stats(struct rte_eth_dev *dev,
+			  struct rte_eth_stats *stats,
+			  struct eth_queue_stats *qstats);
+
+int sxe2_mp_req_get_xstats(struct rte_eth_dev *dev,
+			   struct rte_eth_xstat *xstats, uint32_t usr_cnt);
+
+int sxe2_mp_req_reset_stats(struct rte_eth_dev *dev);
+
+#endif
diff --git a/drivers/net/sxe2/sxe2_stats.c b/drivers/net/sxe2/sxe2_stats.c
new file mode 100644
index 0000000000..7ea2815fa3
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_stats.c
@@ -0,0 +1,586 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#include <rte_eal.h>
+
+#include "sxe2_ethdev.h"
+#include "sxe2_vsi.h"
+#include "sxe2_common_log.h"
+#include "sxe2_stats.h"
+#include "sxe2_queue.h"
+#include "sxe2_cmd_chnl.h"
+#include "sxe2_mp.h"
+
+#define SXE2_XSTAT_CNT_PF RTE_DIM(sxe2_xstats_field_pf)
+#define SXE2_XSTAT_CNT_VF RTE_DIM(sxe2_xstats_field_vf)
+
+static struct sxe2_stats_field sxe2_xstats_field_pf[] = {
+	{"rx_qblock_drop", offsetof(struct sxe2_stats, rx_qblock_drop)},
+	{"rx_out_of_buffer", offsetof(struct sxe2_stats, rx_out_of_buffer)},
+	{"tx_packets_phy", offsetof(struct sxe2_stats, tx_frame_good)},
+	{"rx_packets_phy", offsetof(struct sxe2_stats, rx_frame_good)},
+	{"rx_crc_errors_phy", offsetof(struct sxe2_stats, rx_crc_errors)},
+	{"tx_bytes_phy", offsetof(struct sxe2_stats, tx_bytes_good)},
+	{"rx_bytes_phy", offsetof(struct sxe2_stats, rx_bytes_good)},
+	{"tx_multicast_phy", offsetof(struct sxe2_stats, tx_multicast_good)},
+	{"tx_broadcast_phy", offsetof(struct sxe2_stats, tx_broadcast_good)},
+	{"rx_multicast_phy", offsetof(struct sxe2_stats, rx_multicast_good)},
+	{"rx_broadcast_phy", offsetof(struct sxe2_stats, rx_broadcast_good)},
+	{"rx_in_range_len_errs_phy", offsetof(struct sxe2_stats, rx_len_errors)},
+	{"rx_out_of_range_len_phy", offsetof(struct sxe2_stats, rx_out_of_range_errors)},
+	{"rx_oversize_pkts_phy", offsetof(struct sxe2_stats, rx_oversize_pkts_phy)},
+	{"rx_symbol_err_phy", offsetof(struct sxe2_stats, rx_symbol_err)},
+	{"rx_pause_ctrl_phy", offsetof(struct sxe2_stats, rx_pause_frame)},
+	{"tx_pause_ctrl_phy", offsetof(struct sxe2_stats, tx_pause_frame)},
+	{"rx_discards_phy", offsetof(struct sxe2_stats, rx_discards_phy)},
+	{"rx_discards_ips_phy", offsetof(struct sxe2_stats, rx_discards_ips_phy)},
+	{"tx_dropped_link_down_phy", offsetof(struct sxe2_stats, tx_dropped_link_down)},
+	{"rx_undersize_pkts_phy", offsetof(struct sxe2_stats, rx_undersize_good)},
+	{"rx_fragments_phy", offsetof(struct sxe2_stats, rx_runt_error)},
+	{"tx_bytes_all_phy", offsetof(struct sxe2_stats, tx_bytes_good_bad)},
+	{"tx_packets_all_phy", offsetof(struct sxe2_stats, tx_frame_good_bad)},
+	{"rx_jabbers_phy", offsetof(struct sxe2_stats, rx_jabbers)},
+	{"rx_64_bytes_phy", offsetof(struct sxe2_stats, rx_size_64)},
+	{"rx_65_to_127_bytes_phy", offsetof(struct sxe2_stats, rx_size_65_127)},
+	{"rx_128_to_255_bytes_phy", offsetof(struct sxe2_stats, rx_size_128_255)},
+	{"rx_256_to_511_bytes_phy", offsetof(struct sxe2_stats, rx_size_256_511)},
+	{"rx_512_to_1023_bytes_phy", offsetof(struct sxe2_stats, rx_size_512_1023)},
+	{"rx_1024_to_1522_bytes_phy", offsetof(struct sxe2_stats, rx_size_1024_1522)},
+	{"rx_1523_to_max_bytes_phy", offsetof(struct sxe2_stats, rx_size_1523_max)},
+	{"rx_pcs_symbol_err_phy", offsetof(struct sxe2_stats, rx_pcs_symbol_err_phy)},
+	{"rx_corrected_bits_phy", offsetof(struct sxe2_stats, rx_corrected_bits_phy)},
+	{"rx_err_lane_0_phy", offsetof(struct sxe2_stats, rx_err_lane_0_phy)},
+	{"rx_err_lane_1_phy", offsetof(struct sxe2_stats, rx_err_lane_1_phy)},
+	{"rx_err_lane_2_phy", offsetof(struct sxe2_stats, rx_err_lane_2_phy)},
+	{"rx_err_lane_3_phy", offsetof(struct sxe2_stats, rx_err_lane_3_phy)},
+	{"rx_illegal_bytes_phy", offsetof(struct sxe2_stats, rx_illegal_bytes)},
+	{"rx_oversize_good_phy", offsetof(struct sxe2_stats, rx_oversize_good)},
+	{"tx_unicast_all_phy", offsetof(struct sxe2_stats, tx_unicast)},
+	{"tx_broadcast_all_phy", offsetof(struct sxe2_stats, tx_broadcast)},
+	{"tx_multicast_all_phy", offsetof(struct sxe2_stats, tx_multicast)},
+	{"tx_vlan_packets_good_phy", offsetof(struct sxe2_stats, tx_vlan_packet_good)},
+	{"tx_64_bytes_phy", offsetof(struct sxe2_stats, tx_size_64)},
+	{"tx_65_to_127_bytes_phy", offsetof(struct sxe2_stats, tx_size_65_127)},
+	{"tx_128_to_255_bytes_phy", offsetof(struct sxe2_stats, tx_size_128_255)},
+	{"tx_256_to_511_bytes_phy", offsetof(struct sxe2_stats, tx_size_256_511)},
+	{"tx_512_to_1023_bytes_phy", offsetof(struct sxe2_stats, tx_size_512_1023)},
+	{"tx_1024_to_1522_bytes_phy", offsetof(struct sxe2_stats, tx_size_1024_1522)},
+	{"tx_1523_to_max_bytes_phy", offsetof(struct sxe2_stats, tx_size_1523_max)},
+	{"tx_underflow_error_phy", offsetof(struct sxe2_stats, tx_underflow_error)},
+	{"rx_bytes_all_phy", offsetof(struct sxe2_stats, rx_byte_good_bad)},
+	{"rx_packets_all_phy", offsetof(struct sxe2_stats, rx_frame_good_bad)},
+	{"rx_unicast_phy", offsetof(struct sxe2_stats, rx_unicast_good)},
+	{"rx_vlan_packets_phy", offsetof(struct sxe2_stats, rx_vlan_packets)},
+
+	{"rx_vport_bytes",             offsetof(struct sxe2_stats, rx_vsi_bytes)},
+	{"rx_vport_unicast_packets",   offsetof(struct sxe2_stats, rx_vsi_unicast_packets)},
+	{"rx_vport_broadcast_packets", offsetof(struct sxe2_stats, rx_vsi_broadcast_packets)},
+	{"rx_vport_multicast_packets", offsetof(struct sxe2_stats, rx_vsi_multicast_packets)},
+	{"rx_sw_unicast_packets",      offsetof(struct sxe2_stats, rx_sw_unicast_packets)},
+	{"rx_sw_broadcast_packets",    offsetof(struct sxe2_stats, rx_sw_broadcast_packets)},
+	{"rx_sw_multicast_packets",    offsetof(struct sxe2_stats, rx_sw_multicast_packets)},
+	{"rx_sw_drop_packets",         offsetof(struct sxe2_stats, rx_sw_drop_packets)},
+	{"rx_sw_drop_bytes",           offsetof(struct sxe2_stats, rx_sw_drop_bytes)},
+
+	{"tx_vport_bytes",             offsetof(struct sxe2_stats, tx_vsi_bytes)},
+	{"tx_vport_unicast_packets",   offsetof(struct sxe2_stats, tx_vsi_unicast_packets)},
+	{"tx_vport_broadcast_packets", offsetof(struct sxe2_stats, tx_vsi_broadcast_packets)},
+	{"tx_vport_multicast_packets", offsetof(struct sxe2_stats, tx_vsi_multicast_packets)},
+};
+
+static struct sxe2_stats_field sxe2_xstats_field_vf[] = {
+	{"rx_vport_bytes",             offsetof(struct sxe2_stats, rx_vsi_bytes)},
+	{"rx_vport_unicast_packets",   offsetof(struct sxe2_stats, rx_vsi_unicast_packets)},
+	{"rx_vport_broadcast_packets", offsetof(struct sxe2_stats, rx_vsi_broadcast_packets)},
+	{"rx_vport_multicast_packets", offsetof(struct sxe2_stats, rx_vsi_multicast_packets)},
+	{"rx_sw_unicast_packets",      offsetof(struct sxe2_stats, rx_sw_unicast_packets)},
+	{"rx_sw_broadcast_packets",    offsetof(struct sxe2_stats, rx_sw_broadcast_packets)},
+	{"rx_sw_multicast_packets",    offsetof(struct sxe2_stats, rx_sw_multicast_packets)},
+	{"rx_sw_drop_packets",         offsetof(struct sxe2_stats, rx_sw_drop_packets)},
+	{"rx_sw_drop_bytes",           offsetof(struct sxe2_stats, rx_sw_drop_bytes)},
+
+	{"tx_vport_bytes",             offsetof(struct sxe2_stats, tx_vsi_bytes)},
+	{"tx_vport_unicast_packets",   offsetof(struct sxe2_stats, tx_vsi_unicast_packets)},
+	{"tx_vport_broadcast_packets", offsetof(struct sxe2_stats, tx_vsi_broadcast_packets)},
+	{"tx_vport_multicast_packets", offsetof(struct sxe2_stats, tx_vsi_multicast_packets)},
+};
+
+static int32_t sxe2_xstat_pf_offset_get(uint32_t id, uint32_t *offset)
+{
+	int32_t ret  = 0;
+	uint32_t size = SXE2_XSTAT_CNT_PF;
+
+	if (id < size) {
+		*offset = sxe2_xstats_field_pf[id].offset;
+	} else {
+		ret = -EINVAL;
+		PMD_LOG_ERR(DRV, "invalid id:%u exceed stats size cnt:%u", id, size);
+	}
+	return ret;
+}
+
+static int32_t sxe2_xstat_vf_offset_get(uint32_t id, uint32_t *offset)
+{
+	int32_t ret  = 0;
+	uint32_t size = SXE2_XSTAT_CNT_VF;
+
+	if (id < size) {
+		*offset = sxe2_xstats_field_vf[id].offset;
+	} else {
+		ret = -EINVAL;
+		PMD_LOG_ERR(DRV, "invalid id:%u exceed stats size cnt:%u", id, size);
+	}
+	return ret;
+}
+
+static int32_t sxe2_mac_hw_stats_get_update(struct sxe2_adapter *adapter)
+{
+	int32_t ret = 0;
+
+	ret = sxe2_drv_get_mac_stats(adapter);
+	if (ret) {
+		PMD_LOG_ERR(DRV, "get mac stats failed, ret:%d.", ret);
+		goto l_end;
+	}
+
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_vsi_hw_stats_get_update(struct sxe2_adapter *adapter)
+{
+	int32_t ret = 0;
+
+	ret = sxe2_drv_get_vsi_stats(adapter);
+	if (ret) {
+		PMD_LOG_ERR(DRV, "get vsi stats failed, ret:%d.", ret);
+		goto l_end;
+	}
+
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_vsi_sw_stats_get_update(struct sxe2_adapter *adapter)
+{
+	int32_t ret  = 0;
+	struct sxe2_vsi          *vsi      = adapter->vsi_ctxt.main_vsi;
+	struct sxe2_stats        *sw_stats = &vsi->vsi_stats.vsi_sw_stats;
+	struct sxe2_rx_queue     *rxq;
+	uint32_t rx_queue_id;
+	memset(sw_stats, 0, sizeof(struct sxe2_stats));
+
+	for (rx_queue_id = 0; rx_queue_id < adapter->dev_info.dev_data->nb_rx_queues;
+		     rx_queue_id++) {
+		rxq = adapter->dev_info.dev_data->rx_queues[rx_queue_id];
+		if (rxq) {
+			sw_stats->ipackets += rxq->sw_stats.pkts;
+			sw_stats->ierrors += rxq->sw_stats.drop_pkts;
+			sw_stats->ibytes += rxq->sw_stats.bytes;
+
+			sw_stats->rx_sw_unicast_packets += rxq->sw_stats.unicast_pkts;
+			sw_stats->rx_sw_broadcast_packets += rxq->sw_stats.broadcast_pkts;
+			sw_stats->rx_sw_multicast_packets += rxq->sw_stats.multicast_pkts;
+			sw_stats->rx_sw_drop_packets += rxq->sw_stats.drop_pkts;
+			sw_stats->rx_sw_drop_bytes += rxq->sw_stats.drop_bytes;
+		}
+	}
+
+	return ret;
+}
+
+static void sxe2_stats_update(struct sxe2_adapter *adapter)
+{
+	struct sxe2_vsi          *vsi      = adapter->vsi_ctxt.main_vsi;
+	struct sxe2_stats        *stats = &vsi->vsi_stats.stats;
+	struct sxe2_stats        *hw_stats = &vsi->vsi_stats.vsi_hw_stats;
+	struct sxe2_stats        *sw_stats = &vsi->vsi_stats.vsi_sw_stats;
+	struct sxe2_stats        *sw_stats_prev = &vsi->vsi_stats.vsi_sw_stats_prev;
+	uint8_t i = 0;
+
+	memset(stats, 0, sizeof(struct sxe2_stats));
+
+	stats->opackets = hw_stats->opackets;
+	stats->obytes   = hw_stats->tx_vsi_bytes;
+	stats->tx_vsi_bytes             = hw_stats->tx_vsi_bytes;
+	stats->tx_vsi_unicast_packets   = hw_stats->tx_vsi_unicast_packets;
+	stats->tx_vsi_broadcast_packets = hw_stats->tx_vsi_broadcast_packets;
+	stats->tx_vsi_multicast_packets = hw_stats->tx_vsi_multicast_packets;
+
+	stats->ierrors = sw_stats->ierrors + sw_stats_prev->ierrors;
+	if (adapter->devargs.sw_stats_en) {
+		stats->ipackets = sw_stats->ipackets + sw_stats_prev->ipackets;
+		stats->ibytes = sw_stats->ibytes + sw_stats_prev->ibytes;
+	} else {
+		stats->ipackets = hw_stats->ipackets;
+		stats->ibytes   = hw_stats->rx_vsi_bytes;
+	}
+	stats->rx_vsi_bytes             = hw_stats->rx_vsi_bytes;
+	stats->rx_vsi_unicast_packets   = hw_stats->rx_vsi_unicast_packets;
+	stats->rx_vsi_broadcast_packets = hw_stats->rx_vsi_broadcast_packets;
+	stats->rx_vsi_multicast_packets = hw_stats->rx_vsi_multicast_packets;
+	stats->rx_sw_unicast_packets = sw_stats->rx_sw_unicast_packets +
+			sw_stats_prev->rx_sw_unicast_packets;
+	stats->rx_sw_broadcast_packets = sw_stats->rx_sw_broadcast_packets +
+			sw_stats_prev->rx_sw_broadcast_packets;
+	stats->rx_sw_multicast_packets = sw_stats->rx_sw_multicast_packets +
+			sw_stats_prev->rx_sw_multicast_packets;
+	stats->rx_sw_drop_packets = sw_stats->rx_sw_drop_packets +
+			sw_stats_prev->rx_sw_drop_packets;
+	stats->rx_sw_drop_bytes = sw_stats->rx_sw_drop_bytes +
+			sw_stats_prev->rx_sw_drop_bytes;
+
+	if (adapter->dev_type != SXE2_DEV_T_VF) {
+		stats->rx_out_of_buffer = hw_stats->rx_out_of_buffer;
+		stats->rx_qblock_drop = hw_stats->rx_qblock_drop;
+		stats->tx_frame_good = hw_stats->tx_frame_good;
+		stats->rx_frame_good = hw_stats->rx_frame_good;
+		stats->rx_crc_errors = hw_stats->rx_crc_errors;
+		stats->tx_bytes_good = hw_stats->tx_bytes_good;
+		stats->rx_bytes_good = hw_stats->rx_bytes_good;
+		stats->tx_multicast_good = hw_stats->tx_multicast_good;
+		stats->tx_broadcast_good = hw_stats->tx_broadcast_good;
+		stats->rx_multicast_good = hw_stats->rx_multicast_good;
+		stats->rx_broadcast_good = hw_stats->rx_broadcast_good;
+		stats->rx_len_errors = hw_stats->rx_len_errors;
+		stats->rx_out_of_range_errors = hw_stats->rx_out_of_range_errors;
+		stats->rx_oversize_pkts_phy = hw_stats->rx_oversize_pkts_phy;
+		stats->rx_symbol_err = hw_stats->rx_symbol_err;
+		stats->rx_pause_frame = hw_stats->rx_pause_frame;
+		stats->tx_pause_frame = hw_stats->tx_pause_frame;
+		stats->rx_discards_phy = hw_stats->rx_discards_phy;
+		stats->rx_discards_ips_phy = hw_stats->rx_discards_ips_phy;
+		stats->tx_dropped_link_down = hw_stats->tx_dropped_link_down;
+		stats->rx_undersize_good = hw_stats->rx_undersize_good;
+		stats->rx_runt_error = hw_stats->rx_runt_error;
+		stats->tx_bytes_good_bad = hw_stats->tx_bytes_good_bad;
+		stats->tx_frame_good_bad = hw_stats->tx_frame_good_bad;
+		stats->rx_jabbers = hw_stats->rx_jabbers;
+		stats->rx_size_64 = hw_stats->rx_size_64;
+		stats->rx_size_65_127 = hw_stats->rx_size_65_127;
+		stats->rx_size_128_255 = hw_stats->rx_size_128_255;
+		stats->rx_size_256_511 = hw_stats->rx_size_256_511;
+		stats->rx_size_512_1023 = hw_stats->rx_size_512_1023;
+		stats->rx_size_1024_1522 = hw_stats->rx_size_1024_1522;
+		stats->rx_size_1523_max = hw_stats->rx_size_1523_max;
+		stats->rx_pcs_symbol_err_phy = hw_stats->rx_pcs_symbol_err_phy;
+		stats->rx_corrected_bits_phy = hw_stats->rx_corrected_bits_phy;
+		stats->rx_err_lane_0_phy = hw_stats->rx_err_lane_0_phy;
+		stats->rx_err_lane_1_phy = hw_stats->rx_err_lane_1_phy;
+		stats->rx_err_lane_2_phy = hw_stats->rx_err_lane_2_phy;
+		stats->rx_err_lane_3_phy = hw_stats->rx_err_lane_3_phy;
+		stats->rx_illegal_bytes = hw_stats->rx_illegal_bytes;
+		stats->rx_oversize_good = hw_stats->rx_oversize_good;
+		stats->tx_unicast = hw_stats->tx_unicast;
+		stats->tx_broadcast = hw_stats->tx_broadcast;
+		stats->tx_multicast = hw_stats->tx_multicast;
+		stats->tx_vlan_packet_good = hw_stats->tx_vlan_packet_good;
+		stats->tx_size_64 = hw_stats->tx_size_64;
+		stats->tx_size_65_127 = hw_stats->tx_size_65_127;
+		stats->tx_size_128_255 = hw_stats->tx_size_128_255;
+		stats->tx_size_256_511 = hw_stats->tx_size_256_511;
+		stats->tx_size_512_1023 = hw_stats->tx_size_512_1023;
+		stats->tx_size_1024_1522 = hw_stats->tx_size_1024_1522;
+		stats->tx_size_1523_max = hw_stats->tx_size_1523_max;
+		stats->tx_underflow_error = hw_stats->tx_underflow_error;
+		stats->rx_byte_good_bad = hw_stats->rx_byte_good_bad;
+		stats->rx_frame_good_bad = hw_stats->rx_frame_good_bad;
+		stats->rx_unicast_good = hw_stats->rx_unicast_good;
+		stats->rx_vlan_packets = hw_stats->rx_vlan_packets;
+		rte_memcpy(stats->rx_prio_buf_discard, hw_stats->rx_prio_buf_discard,
+				sizeof(hw_stats->rx_prio_buf_discard));
+		rte_memcpy(stats->prio_xoff_rx, hw_stats->prio_xoff_rx,
+				sizeof(hw_stats->prio_xoff_rx));
+		rte_memcpy(stats->prio_xon_rx, hw_stats->prio_xon_rx,
+				sizeof(hw_stats->prio_xon_rx));
+		rte_memcpy(stats->prio_xon_tx, hw_stats->prio_xon_tx,
+				sizeof(hw_stats->prio_xon_tx));
+		rte_memcpy(stats->prio_xoff_tx, hw_stats->prio_xoff_tx,
+				sizeof(hw_stats->prio_xoff_tx));
+		rte_memcpy(stats->prio_xon_2_xoff, hw_stats->prio_xon_2_xoff,
+				sizeof(hw_stats->prio_xon_2_xoff));
+
+		stats->imissed = hw_stats->rx_out_of_buffer +
+				hw_stats->rx_qblock_drop;
+		for (i = 0; i < SXE2_MAX_USER_PRIORITY; i++)
+			stats->imissed += hw_stats->rx_prio_buf_discard[i];
+	}
+}
+
+int32_t sxe2_stats_info_get(struct rte_eth_dev *dev,
+			struct rte_eth_stats *stats,
+			struct eth_queue_stats *qstats)
+{
+	int32_t ret = 0;
+	struct sxe2_adapter *adapter  = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_vsi     *vsi      = adapter->vsi_ctxt.main_vsi;
+	struct sxe2_stats   *stats_out = &vsi->vsi_stats.stats;
+
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY)
+		return sxe2_mp_req_get_stats(dev, stats, qstats);
+
+	ret = sxe2_vsi_hw_stats_get_update(adapter);
+	if (ret)
+		goto end;
+
+	ret = sxe2_vsi_sw_stats_get_update(adapter);
+	if (ret)
+		goto end;
+
+	ret = sxe2_drv_queue_info_get_update(adapter, qstats);
+	if (ret)
+		goto end;
+
+	sxe2_stats_update(adapter);
+
+	stats->ipackets = stats_out->ipackets;
+	stats->ibytes   = stats_out->ibytes;
+	stats->ierrors  = stats_out->ierrors;
+	stats->imissed  = stats_out->imissed;
+	stats->rx_nombuf = dev->data->rx_mbuf_alloc_failed;
+
+	stats->opackets = stats_out->opackets;
+	stats->obytes   = stats_out->obytes;
+
+	ret = 0;
+
+end:
+	return ret;
+}
+
+int32_t sxe2_xstats_info_get(struct rte_eth_dev *dev,
+		struct rte_eth_xstat *xstats, uint32_t usr_cnt)
+{
+	uint32_t i      = 0;
+	uint32_t cnt    = 0;
+	int32_t ret    = 0;
+	uint32_t offset = 0;
+	uint32_t xstats_cnt = 0;
+	struct sxe2_adapter    *adapter   = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_vsi        *vsi       = adapter->vsi_ctxt.main_vsi;
+	struct sxe2_vsi_stats  *xstats_out = &vsi->vsi_stats;
+
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY)
+		return sxe2_mp_req_get_xstats(dev, xstats, usr_cnt);
+
+	if (adapter->dev_type == SXE2_DEV_T_VF)
+		xstats_cnt = SXE2_XSTAT_CNT_VF;
+	else
+		xstats_cnt = SXE2_XSTAT_CNT_PF;
+
+	if (usr_cnt < xstats_cnt) {
+		ret = xstats_cnt;
+		PMD_LOG_ERR(DRV, "user usr_cnt:%u less than stats cnt:%u", usr_cnt, ret);
+		goto end;
+	}
+
+	ret = sxe2_vsi_hw_stats_get_update(adapter);
+	if (ret) {
+		ret = xstats_cnt;
+		goto end;
+	}
+
+	ret = sxe2_vsi_sw_stats_get_update(adapter);
+	if (ret) {
+		ret = xstats_cnt;
+		goto end;
+	}
+
+	if (adapter->dev_type == SXE2_DEV_T_VF) {
+		sxe2_stats_update(adapter);
+		for (i = 0; i < xstats_cnt; i++) {
+			(void)sxe2_xstat_vf_offset_get(i, &offset);
+			xstats[cnt].value = *(uint64_t *)(((int8_t *)(&xstats_out->stats)) +
+							  offset);
+			xstats[cnt].id    = cnt;
+			cnt++;
+		}
+	} else {
+		ret = sxe2_mac_hw_stats_get_update(adapter);
+		if (ret) {
+			ret = xstats_cnt;
+			goto end;
+		}
+
+		sxe2_stats_update(adapter);
+
+		for (i = 0; i < xstats_cnt; i++) {
+			(void)sxe2_xstat_pf_offset_get(i, &offset);
+			xstats[cnt].value = *(uint64_t *)(((int8_t *)(&xstats_out->stats)) +
+							  offset);
+			xstats[cnt].id = cnt;
+			cnt++;
+		}
+	}
+	ret = cnt;
+	PMD_LOG_DEBUG(DRV, "usr_cnt:%u stats cnt:%u stats done", usr_cnt, cnt);
+
+end:
+	return ret;
+}
+
+int32_t sxe2_xstats_names_get(__rte_unused struct rte_eth_dev *dev,
+	struct rte_eth_xstat_name *xstats_names,
+	__rte_unused unsigned int usr_cnt)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_stats_field *field = NULL;
+	uint32_t i   = 0;
+	uint32_t cnt = 0;
+	int32_t ret = -1;
+	uint32_t xstats_cnt = 0;
+
+	if (adapter->dev_type == SXE2_DEV_T_VF) {
+		field = sxe2_xstats_field_vf;
+		xstats_cnt = SXE2_XSTAT_CNT_VF;
+	} else {
+		field = sxe2_xstats_field_pf;
+		xstats_cnt = SXE2_XSTAT_CNT_PF;
+	}
+
+	if (!xstats_names) {
+		ret = xstats_cnt;
+		PMD_LOG_DEBUG(DRV, "xstats field size:%u", ret);
+		goto l_out;
+	}
+
+	if (usr_cnt < xstats_cnt) {
+		ret = -EINVAL;
+		PMD_LOG_ERR(DRV, "max:%d usr_cnt:%u invalid (err:%d)", xstats_cnt, usr_cnt, ret);
+		goto l_out;
+	}
+
+	for (i = 0; i < xstats_cnt; i++) {
+		(void)strlcpy(xstats_names[cnt].name, field[i].name,
+			      sizeof(xstats_names[cnt].name));
+		cnt++;
+	}
+
+	ret = cnt;
+
+l_out:
+	return ret;
+}
+
+int32_t sxe2_stats_hw_reset(struct rte_eth_dev *dev)
+{
+	int32_t ret = 0;
+	struct sxe2_adapter    *adapter   = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_vsi        *vsi       = adapter->vsi_ctxt.main_vsi;
+	struct sxe2_rx_queue   *rxq;
+	uint32_t rx_queue_id;
+
+	ret = sxe2_drv_vsi_stats_reset(adapter);
+	if (ret) {
+		PMD_LOG_ERR(DRV, "reset vsi stats failed, ret:%d.", ret);
+		goto l_end;
+	}
+	if (adapter->dev_type != SXE2_DEV_T_VF) {
+		ret = sxe2_drv_mac_stats_reset(adapter);
+		if (ret) {
+			PMD_LOG_ERR(DRV, "reset mac stats failed, ret:%d.", ret);
+			goto l_end;
+		}
+	}
+
+	memset(&vsi->vsi_stats, 0, sizeof(vsi->vsi_stats));
+	for (rx_queue_id = 0; rx_queue_id < dev->data->nb_rx_queues; rx_queue_id++) {
+		rxq = dev->data->rx_queues[rx_queue_id];
+		if (rxq)
+			memset(&rxq->sw_stats, 0, sizeof(rxq->sw_stats));
+	}
+
+l_end:
+	return ret;
+}
+
+int32_t sxe2_stats_info_reset(struct rte_eth_dev *dev)
+{
+	int32_t ret;
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY)
+		return sxe2_mp_req_reset_stats(dev);
+
+	if (adapter->cap_flags & SXE2_DEV_CAPS_OFFLOAD_Q_MAP) {
+		ret = sxe2_drv_mapping_stats_info_clear(dev);
+		if (ret)
+			goto l_end;
+	}
+
+	ret = sxe2_stats_hw_reset(dev);
+	if (ret)
+		goto l_end;
+
+l_end:
+	return ret;
+}
+
+int32_t sxe2_stats_init(struct rte_eth_dev *dev)
+{
+	PMD_INIT_FUNC_TRACE();
+	int32_t ret;
+
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return 0;
+
+	ret = sxe2_queue_stats_map_init(dev);
+	if (ret)
+		goto l_end;
+
+	ret = sxe2_stats_hw_reset(dev);
+	if (ret)
+		goto l_end;
+
+l_end:
+	return ret;
+}
+
+int32_t sxe2_queue_stats_mapping_set(struct rte_eth_dev *eth_dev,
+				  uint16_t queue_id, uint8_t pool_idx, uint8_t is_rx)
+{
+	int32_t ret = -1;
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(eth_dev);
+
+	if (!(adapter->cap_flags & SXE2_DEV_CAPS_OFFLOAD_Q_MAP)) {
+		PMD_LOG_ERR(DRV, "VF does not support queue mapping! ");
+		goto l_end;
+	}
+
+	if (is_rx)
+		ret = sxe2_drv_rxq_mapping_set(eth_dev, queue_id, pool_idx);
+	else
+		ret = sxe2_drv_txq_mapping_set(eth_dev, queue_id, pool_idx);
+
+	if (ret) {
+		PMD_LOG_ERR(DRV, "Queue stats mapping failed ! "
+			"queue_id:%u pool_idx:%u", queue_id, pool_idx);
+		goto l_end;
+	}
+
+	PMD_LOG_DEBUG(DRV, "port %u %s queue_id %d stat map to pool[%u] ",
+		     (uint16_t)(eth_dev->data->port_id), is_rx ? "RX" : "TX",
+		     queue_id, pool_idx);
+l_end:
+	return ret;
+}
+
+int32_t sxe2_queue_stats_map_init(struct rte_eth_dev *dev)
+{
+	int32_t ret = 0;
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+
+	if (adapter->cap_flags & SXE2_DEV_CAPS_OFFLOAD_Q_MAP) {
+		dev->data->dev_flags |= RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS;
+
+		ret = sxe2_drv_mapping_reset(dev);
+		if (ret) {
+			PMD_LOG_ERR(DRV, "Queue stats mapping init failed !");
+			goto l_end;
+		}
+	}
+
+l_end:
+	return ret;
+}
diff --git a/drivers/net/sxe2/sxe2_stats.h b/drivers/net/sxe2/sxe2_stats.h
new file mode 100644
index 0000000000..64ac2bb11d
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_stats.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef __SXE2_STATS_H__
+#define __SXE2_STATS_H__
+
+#define SXE2_STATS_FIELD_NAME_SIZE  50
+
+struct sxe2_stats_field {
+	char name[SXE2_STATS_FIELD_NAME_SIZE];
+	uint32_t offset;
+};
+
+struct sxe2_adapter;
+
+int32_t sxe2_stats_info_get(struct rte_eth_dev *dev,
+			struct rte_eth_stats *stats,
+			struct eth_queue_stats *qstats);
+
+int32_t sxe2_xstats_info_get(struct rte_eth_dev *dev,
+	struct rte_eth_xstat *xstats, uint32_t usr_cnt);
+
+int32_t sxe2_xstats_names_get(__rte_unused struct rte_eth_dev *dev,
+			  struct rte_eth_xstat_name *xstats_names,
+			  __rte_unused unsigned int usr_cnt);
+
+int32_t sxe2_stats_hw_reset(struct rte_eth_dev *dev);
+
+int32_t sxe2_stats_info_reset(struct rte_eth_dev *dev);
+
+int32_t sxe2_stats_init(struct rte_eth_dev *dev);
+
+int32_t sxe2_queue_stats_mapping_set(struct rte_eth_dev *eth_dev,
+				  uint16_t queue_id, uint8_t pool_idx, uint8_t is_rx);
+
+int32_t sxe2_queue_stats_map_init(struct rte_eth_dev *dev);
+
+#endif
-- 
2.47.3

