Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA87DCD5BAB
	for <dpdk-dev@archiver.kernel.org>; Sun, 24 May 2026 09:35:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D9D740691;
	Sun, 24 May 2026 11:33:34 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 7FA14402CC
 for <dev@dpdk.org>; Sun, 24 May 2026 11:33:13 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowABXd97QxRJq+04kEg--.9115S9;
 Sun, 24 May 2026 17:33:06 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v1 07/23] net/sxe2: support IPsec inline protocol offload
Date: Sun, 24 May 2026 17:32:43 +0800
Message-ID: <20260524093259.397506-8-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260524093259.397506-1-liujie5@linkdatatechnology.com>
References: <20260524093259.397506-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABXd97QxRJq+04kEg--.9115S9
X-Coremail-Antispam: 1UD129KBjvAXoWkJw4rWw1xZFW7tFy7KrW3KFg_yoW3tFW3Ao
 WxGw47Wry7Xrs7A3yxWr1I9FW7J398u3WDArWS9anruwsrCayrKay7JFy5XFnrXF40yFsx
 W3sak393XFWjyrWxn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
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

This patch adds support for IPsec inline protocol offload for both
inbound and outbound traffic.

- Implement rte_security_ops: session_create, session_destroy.
- Add hardware SA table management.
- Update Rx/Tx data path to handle security offload flags.

The hardware offloads the ESP encapsulation/decapsulation and
cryptographic processing.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/meson.build      |    2 +
 drivers/net/sxe2/sxe2_cmd_chnl.c  |  197 ++++
 drivers/net/sxe2/sxe2_cmd_chnl.h  |   20 +
 drivers/net/sxe2/sxe2_drv_cmd.h   |   61 ++
 drivers/net/sxe2/sxe2_ethdev.c    |   14 +
 drivers/net/sxe2/sxe2_ethdev.h    |    3 +
 drivers/net/sxe2/sxe2_ipsec.c     | 1565 +++++++++++++++++++++++++++++
 drivers/net/sxe2/sxe2_ipsec.h     |  254 +++++
 drivers/net/sxe2/sxe2_rx.c        |    5 +
 drivers/net/sxe2/sxe2_security.c  |  335 ++++++
 drivers/net/sxe2/sxe2_security.h  |   77 ++
 drivers/net/sxe2/sxe2_tx.c        |    8 +
 drivers/net/sxe2/sxe2_txrx_poll.c |   55 +
 13 files changed, 2596 insertions(+)
 create mode 100644 drivers/net/sxe2/sxe2_ipsec.c
 create mode 100644 drivers/net/sxe2/sxe2_ipsec.h
 create mode 100644 drivers/net/sxe2/sxe2_security.c
 create mode 100644 drivers/net/sxe2/sxe2_security.h

diff --git a/drivers/net/sxe2/meson.build b/drivers/net/sxe2/meson.build
index d0aa7fecf0..e3bcfc2876 100644
--- a/drivers/net/sxe2/meson.build
+++ b/drivers/net/sxe2/meson.build
@@ -64,6 +64,8 @@ sources += files(
         'sxe2_filter.c',
         'sxe2_rss.c',
         'sxe2_tm.c',
+        'sxe2_ipsec.c',
+        'sxe2_security.c',
 )
 
 allow_internal_get_api = true
\ No newline at end of file
diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.c b/drivers/net/sxe2/sxe2_cmd_chnl.c
index 19323ffcc4..7711e8e57d 100644
--- a/drivers/net/sxe2/sxe2_cmd_chnl.c
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.c
@@ -877,3 +877,200 @@ int32_t sxe2_drv_tm_commit(struct sxe2_adapter *adapter)
 l_end:
 	return ret;
 }
+
+
+int32_t sxe2_drv_ipsec_get_capa(struct sxe2_adapter *adapter)
+{
+	int32_t ret = -1;
+	struct sxe2_drv_cmd_params cmd = { 0 };
+	struct sxe2_drv_ipsec_capa_resq resp;
+	struct sxe2_common_device *cdev = adapter->cdev;
+
+	sxe2_drv_cmd_params_fill(adapter, &cmd, SXE2_DRV_CMD_IPSEC_CAP_GET,
+				 NULL, 0,
+				 &resp, sizeof(resp));
+	ret = sxe2_drv_cmd_exec(cdev, &cmd);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to get ipsec specifications, ret=%d", ret);
+		goto l_end;
+	}
+
+	adapter->security_ctx.ipsec_ctx.max_tx_sa = rte_le_to_cpu_16(resp.tx_sa_cnt);
+	adapter->security_ctx.ipsec_ctx.max_rx_sa = rte_le_to_cpu_16(resp.rx_sa_cnt);
+	adapter->security_ctx.ipsec_ctx.max_tcam = rte_le_to_cpu_16(resp.ip_id_cnt);
+	adapter->security_ctx.ipsec_ctx.max_udp_group = rte_le_to_cpu_16(resp.udp_group_cnt);
+
+	PMD_DEV_LOG_INFO(adapter, DRV, "Max tx sa:%u, max rx sa:%u, max tcam:%u, udp group:%u.",
+			 rte_le_to_cpu_16(resp.tx_sa_cnt),
+			 rte_le_to_cpu_16(resp.rx_sa_cnt),
+			 rte_le_to_cpu_16(resp.ip_id_cnt),
+			 rte_le_to_cpu_16(resp.udp_group_cnt));
+
+l_end:
+	return ret;
+}
+
+int32_t sxe2_drv_ipsec_resource_clear(struct sxe2_adapter *adapter)
+{
+	int32_t ret = -1;
+	struct sxe2_drv_cmd_params cmd = { 0 };
+	struct sxe2_common_device *cdev = adapter->cdev;
+
+	sxe2_drv_cmd_params_fill(adapter, &cmd, SXE2_DRV_CMD_IPSEC_RESOURCE_CLEAR,
+				 NULL, 0,
+				 NULL, 0);
+	ret = sxe2_drv_cmd_exec(cdev, &cmd);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to clear ipsec resource, ret=%d", ret);
+		goto l_end;
+	}
+
+l_end:
+	return ret;
+}
+
+int32_t sxe2_drv_ipsec_txsa_add(struct sxe2_adapter *adapter,
+		struct sxe2_ipsec_tx_sa *tx_sa)
+{
+	struct sxe2_drv_cmd_params cmd               = { 0 };
+	struct sxe2_drv_ipsec_txsa_add_req req   = { 0 };
+	struct sxe2_drv_ipsec_txsa_add_resp resp = { 0 };
+	struct sxe2_common_device *cdev = adapter->cdev;
+	int32_t ret                                   = -1;
+	uint32_t mode                                  = 0;
+	uint32_t i                                     = 0;
+
+	if (tx_sa->algo == SXE2_IPSEC_ALGO_SM4_CBC_AND_SM3_96_HMAC)
+		mode |= IPSEC_TX_ENGINE_SM4;
+	if (tx_sa->mode == SXE2_IPSEC_MODE_ENC_AND_AUTH)
+		mode |= IPSEC_TX_ENCRYPT;
+	req.mode = rte_cpu_to_le_32(mode);
+	for (i = 0; i < SXE2_IPSEC_KEY_LEN; i++) {
+		req.encrypt_keys[i] = tx_sa->enc_key[i];
+		req.auth_keys[i] = tx_sa->auth_key[i];
+	}
+
+	sxe2_drv_cmd_params_fill(adapter, &cmd, SXE2_DRV_CMD_IPSEC_TXSA_ADD,
+				 &req, sizeof(req),
+				 &resp, sizeof(resp));
+
+	ret = sxe2_drv_cmd_exec(cdev, &cmd);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "failed to add tx sa, ret=%d", ret);
+		goto l_end;
+	}
+	tx_sa->hw_sa_id = rte_le_to_cpu_16(resp.index);
+
+l_end:
+	return ret;
+}
+
+int32_t sxe2_drv_ipsec_rxsa_add(struct sxe2_adapter *adapter,
+		struct sxe2_ipsec_rx_sa *rx_sa,
+		struct sxe2_ipsec_rx_tcam *rx_tcam,
+		struct sxe2_ipsec_rx_udp_group *rx_udp_group)
+{
+	struct sxe2_drv_cmd_params cmd               = { 0 };
+	struct sxe2_drv_ipsec_rxsa_add_req req   = { 0 };
+	struct sxe2_drv_ipsec_rxsa_add_resp resp = { 0 };
+	struct sxe2_common_device *cdev = adapter->cdev;
+	int32_t ret                                   = -1;
+	uint32_t mode                                  = 0;
+	uint32_t i                                     = 0;
+
+	if (rx_sa->algo == SXE2_IPSEC_ALGO_SM4_CBC_AND_SM3_96_HMAC)
+		mode |= IPSEC_RX_ENGINE_SM4;
+	if (rx_sa->mode == SXE2_IPSEC_MODE_ENC_AND_AUTH)
+		mode |= IPSEC_RX_DECRYPT;
+	if (rx_tcam->ip_addr.type == RTE_SECURITY_IPSEC_TUNNEL_IPV6) {
+		mode |= IPSEC_RX_IPV6;
+		memcpy(req.ipaddr, rx_tcam->ip_addr.dst_ipv6, sizeof(req.ipaddr));
+	} else {
+		req.ipaddr[0] = rx_tcam->ip_addr.dst_ipv4;
+	}
+	req.mode = rte_cpu_to_le_32(mode);
+	req.spi = rte_cpu_to_le_32(rx_sa->spi);
+	if (rx_udp_group != NULL) {
+		req.udp_port = rte_cpu_to_le_32((uint32_t)rx_udp_group->udp_port);
+		req.sport_en = rx_udp_group->sport_en;
+		req.dport_en = rx_udp_group->dport_en;
+	}
+
+	PMD_DEV_LOG_INFO(adapter, DRV, "Add rx sa, mode: 0x%x, spi: 0x%x, udp_port: %u, "
+			 "sport_en: %u, dport_en: %u.",
+			 req.mode, req.spi, req.udp_port, req.sport_en, req.dport_en);
+
+	/* encrypt and auth keys */
+	for (i = 0; i < SXE2_IPSEC_KEY_LEN; i++) {
+		req.encrypt_keys[i] = rx_sa->enc_key[i];
+		req.auth_keys[i] = rx_sa->auth_key[i];
+	}
+
+	sxe2_drv_cmd_params_fill(adapter, &cmd, SXE2_DRV_CMD_IPSEC_RXSA_ADD,
+				 &req, sizeof(req),
+				 &resp, sizeof(resp));
+
+	ret = sxe2_drv_cmd_exec(cdev, &cmd);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to add rx sa, ret=%d", ret);
+		goto l_end;
+	}
+	rx_sa->hw_sa_id = rte_le_to_cpu_16(resp.sa_idx);
+	rx_sa->hw_ip_id = resp.ip_id;
+	rx_tcam->hw_ip_id = resp.ip_id;
+	rx_sa->hw_udp_group_id = resp.udp_group_id;
+	if (rx_udp_group != NULL)
+		rx_udp_group->hw_group_id = resp.udp_group_id;
+
+l_end:
+	return ret;
+}
+
+int32_t sxe2_drv_ipsec_rxsa_delete(struct sxe2_adapter *adapter,
+					struct sxe2_ipsec_rx_sa *rx_sa)
+{
+	struct sxe2_drv_ipsec_rxsa_del_req req = { 0 };
+	struct sxe2_drv_cmd_params cmd             = { 0 };
+	struct sxe2_common_device *cdev = adapter->cdev;
+	int32_t ret                                 = -1;
+
+	req.sa_idx = rte_cpu_to_le_16(rx_sa->hw_sa_id);
+	req.spi = rte_cpu_to_le_32(rx_sa->spi);
+	req.ip_id = rx_sa->hw_ip_id;
+	req.group_id = rx_sa->hw_udp_group_id;
+
+	sxe2_drv_cmd_params_fill(adapter, &cmd, SXE2_DRV_CMD_IPSEC_RXSA_DEL,
+				 &req, sizeof(req),
+				 NULL, 0);
+	ret = sxe2_drv_cmd_exec(cdev, &cmd);
+	if (ret)
+		PMD_DEV_LOG_ERR(adapter, DRV,
+				"Failed to delete rx sa, sa id: %u, spi: %u, "
+				"ip id: %u, udp group id: %u, ret: %d.",
+				rx_sa->hw_sa_id, rx_sa->spi, rx_sa->hw_ip_id,
+				rx_sa->hw_udp_group_id, ret);
+
+	return ret;
+}
+
+int32_t sxe2_drv_ipsec_txsa_delete(struct sxe2_adapter *adapter,
+					   uint16_t sa_id)
+{
+	struct sxe2_drv_ipsec_txsa_del_req req = { 0 };
+	struct sxe2_drv_cmd_params cmd             = { 0 };
+	struct sxe2_common_device *cdev = adapter->cdev;
+	int32_t ret                                 = -1;
+
+	req.sa_idx = rte_cpu_to_le_16(sa_id);
+	sxe2_drv_cmd_params_fill(adapter, &cmd, SXE2_DRV_CMD_IPSEC_TXSA_DEL,
+				 &req, sizeof(req),
+				 NULL, 0);
+	ret = sxe2_drv_cmd_exec(cdev, &cmd);
+	if (ret)
+		PMD_DEV_LOG_ERR(adapter, DRV,
+				"Failed to delete tx sa, sa id: %u, ret: %d.",
+				sa_id, ret);
+
+	return ret;
+}
+
diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.h b/drivers/net/sxe2/sxe2_cmd_chnl.h
index 6e209377c7..d8e09a4453 100644
--- a/drivers/net/sxe2/sxe2_cmd_chnl.h
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.h
@@ -44,6 +44,26 @@ int32_t sxe2_drv_root_tree_alloc(struct rte_eth_dev *dev);
 
 int32_t sxe2_drv_tm_commit(struct sxe2_adapter *adapter);
 
+int32_t sxe2_drv_ipsec_resource_clear(struct sxe2_adapter *adapter);
+
+int32_t sxe2_drv_ipsec_get_capa(struct sxe2_adapter *adapter);
+
+int32_t sxe2_drv_ipsec_rxsa_add(struct sxe2_adapter *adapter,
+			    struct sxe2_ipsec_rx_sa *rx_sa,
+			    struct sxe2_ipsec_rx_tcam *rx_tcam,
+			    struct sxe2_ipsec_rx_udp_group *rx_udp_group);
+
+int32_t sxe2_drv_ipsec_txsa_add(struct sxe2_adapter *adapter,
+			    struct sxe2_ipsec_tx_sa *tx_sa);
+
+int32_t sxe2_drv_ipsec_rxsa_delete(struct sxe2_adapter *adapter,
+			       struct sxe2_ipsec_rx_sa *rx_sa);
+
+int32_t sxe2_drv_ipsec_txsa_delete(struct sxe2_adapter *adapter,
+			       uint16_t sa_id);
+
+int32_t sxe2_drv_promisc_config(struct sxe2_adapter *adapter, bool set);
+
 int32_t sxe2_drv_allmulti_config(struct sxe2_adapter *adapter, bool set);
 
 int32_t sxe2_drv_uc_config(struct sxe2_adapter *adapter, struct rte_ether_addr *addr, bool add);
diff --git a/drivers/net/sxe2/sxe2_drv_cmd.h b/drivers/net/sxe2/sxe2_drv_cmd.h
index 07f083644c..4d9c2e05a8 100644
--- a/drivers/net/sxe2/sxe2_drv_cmd.h
+++ b/drivers/net/sxe2/sxe2_drv_cmd.h
@@ -373,6 +373,67 @@ struct sxe2_tm_add_queue_msg {
 	struct sxe2_tm_info info;
 };
 
+struct sxe2_drv_ipsec_capa_resq {
+	__le16 tx_sa_cnt;
+	__le16 rx_sa_cnt;
+	__le16 ip_id_cnt;
+	__le16 udp_group_cnt;
+};
+
+#define SXE2_IPSEC_KEY_LEN (32)
+#define SXE2_IPV6_ADDR_LEN (4)
+struct sxe2_drv_ipsec_txsa_add_req {
+	__le32 mode;
+	uint8_t encrypt_keys[SXE2_IPSEC_KEY_LEN];
+	uint8_t auth_keys[SXE2_IPSEC_KEY_LEN];
+	bool func_type;
+	uint8_t func_id;
+	uint8_t drv_id;
+};
+
+struct sxe2_drv_ipsec_txsa_add_resp {
+	__le16 index;
+};
+
+struct sxe2_drv_ipsec_rxsa_add_req {
+	__le32 mode;
+	__le32 spi;
+	__le32 ipaddr[SXE2_IPV6_ADDR_LEN];
+	__le32 udp_port;
+	uint8_t sport_en;
+	uint8_t dport_en;
+	uint8_t is_over_sdn;
+	uint8_t sdn_group_id;
+	uint8_t encrypt_keys[SXE2_IPSEC_KEY_LEN];
+	uint8_t auth_keys[SXE2_IPSEC_KEY_LEN];
+	bool func_type;
+	uint8_t func_id;
+	uint8_t drv_id;
+};
+
+struct sxe2_drv_ipsec_rxsa_add_resp {
+	uint8_t ip_id;
+	uint8_t udp_group_id;
+	__le16 sa_idx;
+};
+
+struct sxe2_drv_ipsec_txsa_del_req {
+	__le16 sa_idx;
+	bool func_type;
+	uint8_t func_id;
+	uint8_t drv_id;
+};
+
+struct sxe2_drv_ipsec_rxsa_del_req {
+	uint8_t ip_id;
+	uint8_t group_id;
+	__le16 sa_idx;
+	__le32 spi;
+	bool func_type;
+	uint8_t func_id;
+	uint8_t drv_id;
+};
+
 enum sxe2_drv_cmd_module {
 	SXE2_DRV_CMD_MODULE_HANDSHAKE = 0,
 	SXE2_DRV_CMD_MODULE_DEV = 1,
diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
index a095888c00..00c0552d4a 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -298,6 +298,11 @@ static int32_t sxe2_dev_infos_get(struct rte_eth_dev *dev,
 	if (adapter->cap_flags & SXE2_DEV_CAPS_OFFLOAD_PTP)
 		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_TIMESTAMP;
 
+	if (sxe2_ipsec_supported(adapter)) {
+		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_SECURITY;
+		dev_info->tx_offload_capa |= RTE_ETH_TX_OFFLOAD_SECURITY;
+	}
+
 	if (adapter->cap_flags & SXE2_DEV_CAPS_OFFLOAD_RSS) {
 		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_RSS_HASH;
 		dev_info->flow_type_rss_offloads  |= SXE2_RSS_HF_SUPPORT_ALL;
@@ -1053,6 +1058,12 @@ static int32_t sxe2_dev_init(struct rte_eth_dev *dev,
 		goto init_eth_err;
 	}
 
+	ret = sxe2_security_init(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to initialize security, ret=%d", ret);
+		goto init_security_err;
+	}
+
 	ret = sxe2_rss_disable(dev);
 	if (ret) {
 		PMD_LOG_ERR(INIT, "Failed to disable rss, ret=%d", ret);
@@ -1067,6 +1078,8 @@ static int32_t sxe2_dev_init(struct rte_eth_dev *dev,
 
 	goto l_end;
 
+init_security_err:
+	sxe2_eth_uinit(dev);
 init_sched_err:
 init_rss_err:
 init_eth_err:
@@ -1085,6 +1098,7 @@ static int32_t sxe2_dev_close(struct rte_eth_dev *dev)
 	(void)sxe2_rss_disable(dev);
 	(void)sxe2_sched_uinit(dev);
 	sxe2_vsi_uninit(dev);
+	sxe2_security_uinit(dev);
 	sxe2_dev_pci_map_uinit(dev);
 	sxe2_eth_uinit(dev);
 
diff --git a/drivers/net/sxe2/sxe2_ethdev.h b/drivers/net/sxe2/sxe2_ethdev.h
index 609e1e92ba..32a67ed344 100644
--- a/drivers/net/sxe2/sxe2_ethdev.h
+++ b/drivers/net/sxe2/sxe2_ethdev.h
@@ -19,6 +19,8 @@
 #include "sxe2_queue.h"
 #include "sxe2_mac.h"
 #include "sxe2_osal.h"
+#include "sxe2_security.h"
+#include "sxe2_ipsec.h"
 #include "sxe2_tm.h"
 #include "sxe2_filter.h"
 
@@ -312,6 +314,7 @@ struct sxe2_adapter {
 	struct sxe2_sched_hw_cap      sched_ctxt;
 	struct sxe2_tm_context        tm_ctxt;
 	struct sxe2_devargs           devargs;
+	struct sxe2_security_ctx      security_ctx;
 	struct sxe2_switchdev_info    switchdev_info;
 	bool                          rule_started;
 	bool                          flow_isolated;
diff --git a/drivers/net/sxe2/sxe2_ipsec.c b/drivers/net/sxe2/sxe2_ipsec.c
new file mode 100644
index 0000000000..9fd29bd6e5
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_ipsec.c
@@ -0,0 +1,1565 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#include <rte_malloc.h>
+#include <rte_bitmap.h>
+
+#include "sxe2_ethdev.h"
+#include "sxe2_security.h"
+#include "sxe2_ipsec.h"
+#include "sxe2_cmd_chnl.h"
+#include "sxe2_common_log.h"
+
+bool sxe2_ipsec_supported(struct sxe2_adapter *adapter)
+{
+	uint64_t cap = adapter->cap_flags;
+
+	return !!(cap & SXE2_DEV_CAPS_OFFLOAD_IPSEC);
+}
+
+bool sxe2_ipsec_valid_tx_offloads(uint64_t offloads)
+{
+	bool ret = true;
+	uint64_t tso_features = 0;
+	uint64_t cksum_features = 0;
+
+	if (offloads & RTE_ETH_TX_OFFLOAD_SECURITY) {
+		tso_features = RTE_ETH_TX_OFFLOAD_TCP_TSO |
+			RTE_ETH_TX_OFFLOAD_UDP_TSO |
+			RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO |
+			RTE_ETH_TX_OFFLOAD_GRE_TNL_TSO |
+			RTE_ETH_TX_OFFLOAD_IPIP_TNL_TSO |
+			RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO;
+		if (offloads & tso_features) {
+			PMD_LOG_ERR(DRV, "Security offload is not compatible with TSO offload.");
+			ret = false;
+			goto l_end;
+		}
+
+		cksum_features = RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |
+			RTE_ETH_TX_OFFLOAD_UDP_CKSUM |
+			RTE_ETH_TX_OFFLOAD_TCP_CKSUM |
+			RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |
+			RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |
+			RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM;
+		if (offloads & cksum_features) {
+			PMD_LOG_ERR(DRV, "Security offload is not compatible with checksum offload.");
+			ret = false;
+			goto l_end;
+		}
+
+		if (offloads & (RTE_ETH_TX_OFFLOAD_VLAN_INSERT | RTE_ETH_TX_OFFLOAD_QINQ_INSERT)) {
+			PMD_LOG_ERR(DRV, "Security offload is not compatible with vlan offload.");
+			ret = false;
+			goto l_end;
+		}
+	}
+
+l_end:
+	return ret;
+}
+
+bool sxe2_ipsec_valid_rx_offloads(uint64_t offloads)
+{
+	bool ret = true;
+
+	if (offloads & RTE_ETH_RX_OFFLOAD_SECURITY) {
+		if (offloads & RTE_ETH_RX_OFFLOAD_TCP_LRO) {
+			PMD_LOG_ERR(DRV, "Security offload is not compatible with LRO offload.");
+			ret = false;
+			goto l_end;
+		}
+
+		if (offloads & RTE_ETH_RX_OFFLOAD_CHECKSUM) {
+			PMD_LOG_ERR(DRV, "Security offload is not compatible with checksum offload.");
+			ret = false;
+			goto l_end;
+		}
+
+		if (offloads & RTE_ETH_RX_OFFLOAD_KEEP_CRC) {
+			PMD_LOG_ERR(DRV, "Security offload is not compatible with keep CRC offload.");
+			ret = false;
+			goto l_end;
+		}
+
+		if (offloads & RTE_ETH_RX_OFFLOAD_VLAN) {
+			PMD_LOG_ERR(DRV, "Security offload is not compatible with vlan offload.");
+			ret = false;
+			goto l_end;
+		}
+	}
+
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_ipsec_bitmap_mem_init(struct rte_bitmap **d_bmp, void **d_mem, uint32_t bits)
+{
+	struct rte_bitmap *bmp = NULL;
+	uint32_t bmp_size           = 0;
+	void *mem              = NULL;
+	int32_t ret                = -1;
+
+	bmp_size = rte_bitmap_get_memory_footprint(bits);
+
+	mem = rte_zmalloc("ipsec bitmap", bmp_size, RTE_CACHE_LINE_SIZE);
+	if (mem == NULL) {
+		PMD_LOG_ERR(DRV, "Alloc ipsec bitmap memory failed.");
+		ret = -ENOMEM;
+		goto l_end;
+	}
+
+	bmp = rte_bitmap_init(bits, mem, bmp_size);
+	if (bmp == NULL) {
+		PMD_LOG_ERR(DRV, "Failed to init ipsec bitmap.");
+		rte_free(mem);
+		ret = -ENOMEM;
+		goto l_end;
+	}
+
+	*d_bmp = bmp;
+	*d_mem = mem;
+
+	ret = 0;
+
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_ipsec_bitmap_init(struct sxe2_security_ctx *sxe2_sctx)
+{
+	int32_t ret  = -1;
+
+	ret = sxe2_ipsec_bitmap_mem_init(&sxe2_sctx->ipsec_ctx.bmp.tx_sa_bmp,
+			&sxe2_sctx->ipsec_ctx.bmp.tx_sa_mem, sxe2_sctx->ipsec_ctx.max_tx_sa);
+	if (ret)
+		goto l_end;
+
+	ret = sxe2_ipsec_bitmap_mem_init(&sxe2_sctx->ipsec_ctx.bmp.rx_sa_bmp,
+			&sxe2_sctx->ipsec_ctx.bmp.rx_sa_mem, sxe2_sctx->ipsec_ctx.max_rx_sa);
+	if (ret) {
+		rte_free(sxe2_sctx->ipsec_ctx.bmp.tx_sa_mem);
+		sxe2_sctx->ipsec_ctx.bmp.tx_sa_mem = NULL;
+		goto l_end;
+	}
+
+	ret = sxe2_ipsec_bitmap_mem_init(&sxe2_sctx->ipsec_ctx.bmp.rx_tcam_bmp,
+			&sxe2_sctx->ipsec_ctx.bmp.rx_tcam_mem, sxe2_sctx->ipsec_ctx.max_tcam);
+	if (ret) {
+		rte_free(sxe2_sctx->ipsec_ctx.bmp.tx_sa_mem);
+		rte_free(sxe2_sctx->ipsec_ctx.bmp.rx_sa_mem);
+		sxe2_sctx->ipsec_ctx.bmp.tx_sa_mem = NULL;
+		sxe2_sctx->ipsec_ctx.bmp.rx_sa_mem = NULL;
+		goto l_end;
+	}
+
+	ret = sxe2_ipsec_bitmap_mem_init(&sxe2_sctx->ipsec_ctx.bmp.rx_udp_bmp,
+			&sxe2_sctx->ipsec_ctx.bmp.rx_udp_mem, sxe2_sctx->ipsec_ctx.max_udp_group);
+	if (ret) {
+		rte_free(sxe2_sctx->ipsec_ctx.bmp.tx_sa_mem);
+		rte_free(sxe2_sctx->ipsec_ctx.bmp.rx_sa_mem);
+		rte_free(sxe2_sctx->ipsec_ctx.bmp.rx_tcam_mem);
+		sxe2_sctx->ipsec_ctx.bmp.tx_sa_mem = NULL;
+		sxe2_sctx->ipsec_ctx.bmp.rx_sa_mem = NULL;
+		sxe2_sctx->ipsec_ctx.bmp.rx_tcam_mem = NULL;
+		goto l_end;
+	}
+
+l_end:
+	return ret;
+}
+
+static uint16_t sxe2_ipsec_id_alloc(struct rte_bitmap *bmp, uint16_t bits)
+{
+	uint16_t i = 0;
+	uint16_t index = 0XFFFF;
+
+	for (i = 0; i < bits; i++) {
+		if (!rte_bitmap_get(bmp, i)) {
+			index = i;
+			rte_bitmap_set(bmp, i);
+			break;
+		}
+	}
+
+	return index;
+}
+
+static void sxe2_ipsec_id_free(struct rte_bitmap *bmp, uint16_t pos)
+{
+	rte_bitmap_clear(bmp, pos);
+}
+
+static struct rte_cryptodev_symmetric_capability *
+sxe2_ipsec_cipher_cap_get(struct rte_cryptodev_capabilities *crypto_cap,
+			enum rte_crypto_cipher_algorithm algo)
+{
+	struct rte_cryptodev_symmetric_capability *capability = NULL;
+	uint8_t index                                              = 0;
+
+	for (index = 0; index < SXE2_IPSEC_CAP_MAX; index++) {
+		if (crypto_cap[index].sym.xform_type == RTE_CRYPTO_SYM_XFORM_CIPHER &&
+			crypto_cap[index].sym.cipher.algo == algo) {
+			capability = &crypto_cap[index].sym;
+			goto l_end;
+		}
+	}
+
+l_end:
+	return capability;
+}
+
+static struct rte_cryptodev_symmetric_capability *
+sxe2_ipsec_auth_cap_get(struct rte_cryptodev_capabilities *crypto_cap,
+			enum rte_crypto_auth_algorithm algo)
+{
+	struct rte_cryptodev_symmetric_capability *capability = NULL;
+	uint8_t index                                              = 0;
+
+	for (index = 0; index < SXE2_IPSEC_CAP_MAX; index++) {
+		if (crypto_cap[index].sym.xform_type == RTE_CRYPTO_SYM_XFORM_AUTH &&
+			crypto_cap[index].sym.auth.algo == algo) {
+			capability = &crypto_cap[index].sym;
+			goto l_end;
+		}
+	}
+
+l_end:
+	return capability;
+}
+
+static bool sxe2_security_valid_key(uint16_t src_key, uint16_t max_key,
+				    uint16_t min_key, uint16_t increment)
+{
+	bool is_valid = false;
+
+	if (src_key < min_key || src_key > max_key) {
+		is_valid = false;
+		goto l_end;
+	}
+
+	if (increment == 0) {
+		is_valid = true;
+		goto l_end;
+	}
+
+	if ((uint16_t)(src_key - min_key) % increment) {
+		is_valid = false;
+		goto l_end;
+	}
+
+	if (src_key > SXE2_IPSEC_MAX_KEY_LEN) {
+		is_valid = false;
+		goto l_end;
+	}
+
+	is_valid = true;
+
+l_end:
+	return is_valid;
+}
+
+static int32_t
+sxe2_ipsec_valid_cipher(enum rte_crypto_cipher_operation cipher_op,
+			struct rte_cryptodev_capabilities *crypto_cap,
+			struct rte_crypto_sym_xform *xform)
+{
+	const struct rte_cryptodev_symmetric_capability *capability = NULL;
+	uint16_t src_key                                = 0;
+	uint16_t max_key                                = 0;
+	uint16_t min_key                                = 0;
+	uint16_t increment                              = 0;
+	int32_t ret                                    = -1;
+
+	if (xform->cipher.op != cipher_op) {
+		PMD_LOG_ERR(DRV, "Invalid cipher direction specified");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	capability = sxe2_ipsec_cipher_cap_get(crypto_cap, xform->cipher.algo);
+	if (!capability) {
+		PMD_LOG_ERR(DRV, "Invalid cipher algo specified");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	src_key = xform->cipher.key.length;
+	min_key = capability->cipher.key_size.min;
+	max_key = capability->cipher.key_size.max;
+	increment = capability->cipher.key_size.increment;
+	if (!sxe2_security_valid_key(src_key, max_key, min_key, increment)) {
+		PMD_LOG_ERR(DRV, "Invalid cipher key size specified");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	ret = 0;
+
+l_end:
+	return ret;
+}
+
+static int32_t
+sxe2_ipsec_valid_auth(enum rte_crypto_auth_operation auth_op,
+		      struct rte_cryptodev_capabilities *crypto_cap,
+		      struct rte_crypto_sym_xform *xform)
+{
+	const struct rte_cryptodev_symmetric_capability *capability = NULL;
+	uint16_t src_key                                = 0;
+	uint16_t max_key                                = 0;
+	uint16_t min_key                                = 0;
+	uint16_t increment                              = 0;
+	int32_t ret                                    = -1;
+
+	if (xform->auth.op != auth_op) {
+		PMD_LOG_ERR(DRV, "Invalid auth direction specified");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	capability = sxe2_ipsec_auth_cap_get(crypto_cap, xform->auth.algo);
+	if (!capability) {
+		PMD_LOG_ERR(DRV, "Invalid auth algo specified");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	src_key = xform->auth.key.length;
+	min_key = capability->auth.key_size.min;
+	max_key = capability->auth.key_size.max;
+	increment = capability->auth.key_size.increment;
+	if (!sxe2_security_valid_key(src_key, max_key, min_key, increment)) {
+		PMD_LOG_ERR(DRV, "Invalid auth key size specified");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	ret = 0;
+
+l_end:
+	return ret;
+}
+
+static bool
+sxe2_ipsec_valid_algo(enum rte_crypto_auth_algorithm auth_algo,
+		      enum rte_crypto_cipher_algorithm cipher_algo)
+{
+	bool ret = false;
+
+	if ((cipher_algo == SXE2_RTE_CRYPTO_CIPHER_AES_CBC &&
+		 auth_algo == SXE2_RTE_CRYPTO_AUTH_SHA256_HMAC) ||
+		(cipher_algo == SXE2_RTE_RTE_CRYPTO_CIPHER_SM4_CBC &&
+		 auth_algo == SXE2_RTE_CRYPTO_AUTH_SM3_HMAC)) {
+		ret = true;
+		goto l_end;
+	}
+
+l_end:
+	return ret;
+}
+
+static enum sxe2_ipsec_algorithm
+sxe2_ipsec_algo_gen(enum rte_crypto_cipher_algorithm cipher_algo)
+{
+	enum sxe2_ipsec_algorithm algo = SXE2_IPSEC_ALGO_INVALID;
+
+	if (cipher_algo == SXE2_RTE_CRYPTO_CIPHER_AES_CBC)
+		algo = SXE2_IPSEC_ALGO_AES_CBC_AND_SHA256_128_HMAC;
+	else if (cipher_algo == SXE2_RTE_RTE_CRYPTO_CIPHER_SM4_CBC)
+		algo = SXE2_IPSEC_ALGO_SM4_CBC_AND_SM3_96_HMAC;
+
+	return algo;
+}
+
+static int32_t
+	sxe2_ipsec_valid_xform(struct sxe2_security_ctx *sxe2_sctx,
+			       struct rte_security_session_conf *conf)
+{
+	struct rte_crypto_sym_xform *xform = NULL;
+	struct rte_cryptodev_capabilities *crypto_cap =
+		sxe2_sctx->sxe2_capabilities[SXE2_SECURITY_PROTOCOL_IPSEC].crypto_capabilities;
+	enum rte_crypto_auth_algorithm auth_algo = RTE_CRYPTO_AUTH_NULL;
+	enum rte_crypto_cipher_algorithm cipher_algo = RTE_CRYPTO_CIPHER_NULL;
+	int32_t ret = -1;
+
+	if (conf->ipsec.direction == RTE_SECURITY_IPSEC_SA_DIR_EGRESS &&
+		conf->crypto_xform->type == RTE_CRYPTO_SYM_XFORM_CIPHER) {
+		xform = conf->crypto_xform;
+		cipher_algo = xform->cipher.algo;
+		ret = sxe2_ipsec_valid_cipher(RTE_CRYPTO_CIPHER_OP_ENCRYPT,
+					      crypto_cap, xform);
+		if (ret)
+			goto l_end;
+
+		if (conf->crypto_xform->next) {
+			if (conf->crypto_xform->next->type == RTE_CRYPTO_SYM_XFORM_AUTH) {
+				auth_algo = conf->crypto_xform->next->auth.algo;
+				if (!sxe2_ipsec_valid_algo(auth_algo, cipher_algo)) {
+					PMD_LOG_ERR(DRV, "Invalid algo group.");
+					ret = -EINVAL;
+					goto l_end;
+				}
+				xform = conf->crypto_xform->next;
+				ret = sxe2_ipsec_valid_auth(RTE_CRYPTO_AUTH_OP_GENERATE,
+									crypto_cap, xform);
+				if (ret)
+					goto l_end;
+			} else {
+				PMD_LOG_ERR(DRV, "Encrypt direction next xform only verify.");
+				ret = -EINVAL;
+				goto l_end;
+			}
+		}
+	} else if (conf->ipsec.direction == RTE_SECURITY_IPSEC_SA_DIR_INGRESS &&
+		conf->crypto_xform->type == RTE_CRYPTO_SYM_XFORM_CIPHER) {
+		xform = conf->crypto_xform;
+		ret = sxe2_ipsec_valid_cipher(RTE_CRYPTO_CIPHER_OP_DECRYPT,
+										crypto_cap, xform);
+		if (ret)
+			goto l_end;
+
+	} else if (conf->ipsec.direction == RTE_SECURITY_IPSEC_SA_DIR_INGRESS &&
+		conf->crypto_xform->type == RTE_CRYPTO_SYM_XFORM_AUTH) {
+		xform = conf->crypto_xform;
+		ret = sxe2_ipsec_valid_auth(RTE_CRYPTO_AUTH_OP_VERIFY, crypto_cap, xform);
+		if (ret)
+			goto l_end;
+
+		if (conf->crypto_xform->next &&
+			conf->crypto_xform->next->type == RTE_CRYPTO_SYM_XFORM_CIPHER) {
+			auth_algo = conf->crypto_xform->auth.algo;
+			cipher_algo = conf->crypto_xform->next->cipher.algo;
+			if (!sxe2_ipsec_valid_algo(auth_algo, cipher_algo)) {
+				PMD_LOG_ERR(DRV, "Invalid algo group.");
+				ret = -EINVAL;
+				goto l_end;
+			}
+			xform = conf->crypto_xform->next;
+			ret = sxe2_ipsec_valid_cipher(RTE_CRYPTO_CIPHER_OP_DECRYPT,
+										crypto_cap, xform);
+			if (ret)
+				goto l_end;
+		} else {
+			PMD_LOG_ERR(DRV, "Not support decrypt direction only verify, but not decrypt.");
+			ret = -EINVAL;
+			goto l_end;
+		}
+	} else {
+		PMD_LOG_ERR(DRV, "Encrypt/decrypt xform invalid.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	ret = 0;
+
+l_end:
+	return ret;
+}
+
+static int32_t
+sxe2_ipsec_valid_udp(struct rte_security_session_conf *conf)
+{
+	int32_t ret = -1;
+	uint16_t sport = conf->ipsec.udp.sport;
+	uint16_t dport = conf->ipsec.udp.dport;
+
+	if (conf->ipsec.options.udp_encap == 0) {
+		ret = 0;
+		goto l_end;
+	}
+
+	if (sport == 0 && dport == 0) {
+		PMD_LOG_ERR(DRV, "Invalid udp port, cannot be zero.");
+		ret = -1;
+		goto l_end;
+	}
+
+	if (sport != 0 && dport != 0 && sport != dport) {
+		PMD_LOG_ERR(DRV, "Invalid udp port, if sport and dport is not zero, must be equal.");
+		ret = -1;
+		goto l_end;
+	}
+
+	ret = 0;
+
+l_end:
+	return ret;
+}
+
+static int32_t
+sxe2_ipsec_session_conf_valid(struct sxe2_security_ctx *sxe2_sctx,
+			      struct rte_security_session_conf *conf)
+{
+	int32_t ret = -1;
+
+	if (sxe2_sctx == NULL) {
+		PMD_LOG_ERR(DRV, "Invalid  security ctx.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (conf->action_type !=
+		sxe2_sctx->sxe2_capabilities[SXE2_SECURITY_PROTOCOL_IPSEC].action) {
+		PMD_LOG_ERR(DRV, "Invalid action specified");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (conf->ipsec.mode !=
+		sxe2_sctx->sxe2_capabilities[SXE2_SECURITY_PROTOCOL_IPSEC].ipsec.mode) {
+		PMD_LOG_ERR(DRV, "Invalid IPsec mode specified");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (conf->ipsec.proto !=
+	    sxe2_sctx->sxe2_capabilities[SXE2_SECURITY_PROTOCOL_IPSEC].ipsec.proto) {
+		PMD_LOG_ERR(DRV, "Invalid IPsec protocol specified");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (conf->ipsec.options.esn) {
+		PMD_LOG_ERR(DRV, "Not support esn.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (conf->ipsec.direction == RTE_SECURITY_IPSEC_SA_DIR_INGRESS &&
+		conf->ipsec.spi == 0) {
+		PMD_LOG_ERR(DRV, "spi cannot be zero.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (conf->crypto_xform == NULL) {
+		PMD_LOG_ERR(DRV, "Invalid ipsec xform specified");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	ret = sxe2_ipsec_valid_udp(conf);
+	if (ret)
+		goto l_end;
+
+	ret = sxe2_ipsec_valid_xform(sxe2_sctx, conf);
+	if (ret)
+		goto l_end;
+
+l_end:
+	return ret;
+}
+
+static void
+sxe2_ipsec_session_save(struct sxe2_security_ctx *sxe2_sctx,
+			struct rte_security_session_conf *conf,
+			struct sxe2_security_session *sxe2_sess, uint16_t sa_id, uint16_t index)
+{
+	enum rte_crypto_cipher_algorithm cipher_algo   = RTE_CRYPTO_CIPHER_NULL;
+
+	sxe2_sess->adapter = sxe2_sctx->adapter;
+	sxe2_sess->direction = conf->ipsec.direction;
+	sxe2_sess->protocol = conf->protocol;
+	sxe2_sess->mode = conf->ipsec.mode;
+	sxe2_sess->sa_proto = conf->ipsec.proto;
+	sxe2_sess->sa.spi = conf->ipsec.spi;
+	sxe2_sess->sa.hw_idx = sa_id;
+	sxe2_sess->sa.sw_idx = index;
+
+	if (conf->ipsec.options.esn) {
+		sxe2_sess->esn.enabled = true;
+		sxe2_sess->esn.value = conf->ipsec.esn.value;
+	}
+
+	if (sxe2_sess->mode == RTE_SECURITY_IPSEC_SA_MODE_TUNNEL)
+		sxe2_sess->type = conf->ipsec.tunnel.type;
+
+	if (conf->ipsec.options.udp_encap) {
+		sxe2_sess->udp_cap.enabled = true;
+		memcpy(&sxe2_sess->udp_cap.value, &conf->ipsec.udp,
+			sizeof(struct rte_security_ipsec_udp_param));
+	}
+
+	sxe2_sess->pkt_metadata_template.sa_idx = sa_id;
+	sxe2_sess->pkt_metadata_template.ol_flags |= SXE2_IPSEC_OL_FLAGS_IS_TUN;
+	sxe2_sess->pkt_metadata_template.ol_flags |= SXE2_IPSEC_OL_FLAGS_IS_ESP;
+
+	if (conf->ipsec.direction == RTE_SECURITY_IPSEC_SA_DIR_EGRESS &&
+		conf->crypto_xform->type == RTE_CRYPTO_SYM_XFORM_CIPHER) {
+		cipher_algo = conf->crypto_xform->cipher.algo;
+		sxe2_sess->pkt_metadata_template.algo = sxe2_ipsec_algo_gen(cipher_algo);
+		if (conf->crypto_xform->next)
+			sxe2_sess->pkt_metadata_template.mode = SXE2_IPSEC_MODE_ENC_AND_AUTH;
+		else
+			sxe2_sess->pkt_metadata_template.mode = SXE2_IPSEC_MODE_ONLY_ENCRYPT;
+	}
+
+	PMD_LOG_INFO(DRV,
+		"Save security info to session ctx, said:%u, spi:%u, mode:%u, algo:%u",
+		sa_id, sxe2_sess->sa.spi,
+		sxe2_sess->pkt_metadata_template.mode,
+		sxe2_sess->pkt_metadata_template.algo);
+}
+
+static void
+sxe2_ipsec_tx_sa_fill(struct sxe2_ipsec_tx_sa *tx_sa,
+		      struct rte_security_session_conf *conf)
+{
+	uint8_t *dst = NULL;
+	uint8_t len  = 0;
+
+	memcpy(&tx_sa->xform, &conf->ipsec, sizeof(struct rte_security_ipsec_xform));
+
+	if (conf->crypto_xform->next)
+		tx_sa->mode = SXE2_IPSEC_MODE_ENC_AND_AUTH;
+	else
+		tx_sa->mode = SXE2_IPSEC_MODE_ONLY_ENCRYPT;
+
+	if (conf->crypto_xform->cipher.algo == SXE2_RTE_RTE_CRYPTO_CIPHER_SM4_CBC)
+		tx_sa->algo = SXE2_IPSEC_ALGO_SM4_CBC_AND_SM3_96_HMAC;
+	else
+		tx_sa->algo = SXE2_IPSEC_ALGO_AES_CBC_AND_SHA256_128_HMAC;
+
+	dst = tx_sa->enc_key;
+	len = conf->crypto_xform->cipher.key.length;
+	memcpy(dst, conf->crypto_xform->cipher.key.data, len);
+
+	if (conf->crypto_xform->next) {
+		dst = tx_sa->auth_key;
+		len = conf->crypto_xform->next->auth.key.length;
+		memcpy(dst, conf->crypto_xform->next->auth.key.data, len);
+	}
+}
+
+static int32_t
+sxe2_ipsec_tx_sa_add(struct sxe2_security_ctx *sxe2_sctx,
+		     struct rte_security_session_conf *conf,
+		     struct sxe2_security_session *sxe2_sess)
+{
+	struct sxe2_ipsec_tx_sa *tx_sa = NULL;
+	struct rte_bitmap *bmp          = sxe2_sctx->ipsec_ctx.bmp.tx_sa_bmp;
+	uint16_t bits                        = sxe2_sctx->ipsec_ctx.max_tx_sa;
+	uint16_t index                       = 0xFFFF;
+	int32_t ret                         = -1;
+
+	rte_spinlock_lock(&sxe2_sctx->security_lock);
+	index = sxe2_ipsec_id_alloc(bmp, bits);
+	rte_spinlock_unlock(&sxe2_sctx->security_lock);
+	if (index == 0xFFFF) {
+		PMD_LOG_ERR(DRV, "Failed to allocate ipsec tx sa index.");
+		ret = -ENOMEM;
+		goto l_end;
+	}
+	tx_sa = &sxe2_sctx->ipsec_ctx.tx_sa[index];
+
+	sxe2_ipsec_tx_sa_fill(tx_sa, conf);
+
+	ret = sxe2_drv_ipsec_txsa_add(sxe2_sctx->adapter, tx_sa);
+	if (ret) {
+		PMD_LOG_ERR(DRV, "Failed to add tx sa.");
+		ret = -EIO;
+		rte_spinlock_lock(&sxe2_sctx->security_lock);
+		sxe2_ipsec_id_free(bmp, index);
+		rte_spinlock_unlock(&sxe2_sctx->security_lock);
+		goto l_end;
+	}
+
+	sxe2_ipsec_session_save(sxe2_sctx, conf, sxe2_sess, tx_sa->hw_sa_id, tx_sa->id);
+
+	PMD_LOG_INFO(DRV, "Add tx sa success, tx sa id: %u, index: %u.",
+		tx_sa->hw_sa_id, tx_sa->id);
+
+l_end:
+	return ret;
+}
+
+static uint16_t
+sxe2_ipsec_tcam_id_find(struct sxe2_ipsec_rx_tcam *rx_tcam,
+			struct rte_security_ipsec_tunnel_param tunnel, uint16_t len)
+{
+	struct sxe2_ipsec_rx_tcam *per = NULL;
+	uint16_t tcam_id = 0XFFFF;
+	uint16_t i       = 0;
+
+	for (i = 0; i < len; i++) {
+		per = &rx_tcam[i];
+		if (per->ip_addr.type == tunnel.type) {
+			if (tunnel.type == RTE_SECURITY_IPSEC_TUNNEL_IPV4 &&
+			per->ip_addr.dst_ipv4 == (uint32_t)tunnel.ipv4.dst_ip.s_addr) {
+				tcam_id = i;
+				goto l_end;
+			}
+			if (tunnel.type == RTE_SECURITY_IPSEC_TUNNEL_IPV6) {
+				if (!memcmp(&tunnel.ipv6, &per->ip_addr.dst_ipv6,
+				sizeof(tunnel.ipv6))) {
+					tcam_id = i;
+					goto l_end;
+				}
+			}
+		}
+	}
+
+l_end:
+	return tcam_id;
+}
+
+static uint16_t
+sxe2_ipsec_group_id_find(struct sxe2_ipsec_rx_udp_group *rx_udp_group,
+			 uint16_t udp_port, uint8_t sport_en, uint8_t dport_en, uint16_t len)
+{
+	struct sxe2_ipsec_rx_udp_group *per = NULL;
+	uint16_t group_id = 0XFFFF;
+	uint16_t i;
+
+	for (i = 0; i < len; i++) {
+		per = &rx_udp_group[i];
+		if (per->udp_port == udp_port && per->sport_en == sport_en &&
+			per->dport_en == dport_en) {
+			group_id = i;
+			goto l_end;
+		}
+	}
+
+l_end:
+	return group_id;
+}
+
+static void
+sxe2_ipsec_rx_sa_fill(struct sxe2_ipsec_rx_sa *rx_sa,
+		      struct rte_security_session_conf *conf)
+{
+	uint8_t *dst = NULL;
+	uint8_t len = 0;
+
+	memcpy(&rx_sa->xform, &conf->ipsec, sizeof(struct rte_security_ipsec_xform));
+
+	if (conf->crypto_xform->next)
+		rx_sa->mode = SXE2_IPSEC_MODE_ENC_AND_AUTH;
+	else
+		rx_sa->mode = SXE2_IPSEC_MODE_ONLY_ENCRYPT;
+
+	if (conf->crypto_xform->type == RTE_CRYPTO_SYM_XFORM_CIPHER) {
+		if (conf->crypto_xform->cipher.algo == SXE2_RTE_RTE_CRYPTO_CIPHER_SM4_CBC)
+			rx_sa->algo = SXE2_IPSEC_ALGO_SM4_CBC_AND_SM3_96_HMAC;
+		else
+			rx_sa->algo = SXE2_IPSEC_ALGO_AES_CBC_AND_SHA256_128_HMAC;
+	} else {
+		if (conf->crypto_xform->auth.algo == SXE2_RTE_CRYPTO_AUTH_SM3_HMAC)
+			rx_sa->algo = SXE2_IPSEC_ALGO_SM4_CBC_AND_SM3_96_HMAC;
+		else
+			rx_sa->algo = SXE2_IPSEC_ALGO_AES_CBC_AND_SHA256_128_HMAC;
+	}
+
+	if (conf->crypto_xform->next) {
+		dst = rx_sa->auth_key;
+		len = conf->crypto_xform->auth.key.length;
+		memcpy(dst, conf->crypto_xform->auth.key.data, len);
+
+		dst = rx_sa->enc_key;
+		len = conf->crypto_xform->next->cipher.key.length;
+		memcpy(dst, conf->crypto_xform->next->cipher.key.data, len);
+	} else {
+		dst = rx_sa->enc_key;
+		len = conf->crypto_xform->cipher.key.length;
+		memcpy(dst, conf->crypto_xform->cipher.key.data, len);
+	}
+
+	rx_sa->spi = conf->ipsec.spi;
+}
+
+static int32_t
+sxe2_ipsec_rx_tcam_fill(struct sxe2_security_ctx *sxe2_sctx, uint16_t *tcam_id,
+			struct rte_security_session_conf *conf)
+{
+	int32_t ret = -1;
+	uint16_t len = sxe2_sctx->ipsec_ctx.max_tcam;
+	struct sxe2_ipsec_rx_tcam *rx_tcam = NULL;
+
+	*tcam_id = sxe2_ipsec_tcam_id_find(sxe2_sctx->ipsec_ctx.rx_tcam,
+			conf->ipsec.tunnel, len);
+	if (*tcam_id == 0XFFFF) {
+		*tcam_id = sxe2_ipsec_id_alloc(sxe2_sctx->ipsec_ctx.bmp.rx_tcam_bmp, len);
+		if (*tcam_id == 0xFFFF) {
+			ret = -ENOMEM;
+			goto l_end;
+		}
+		rx_tcam = &sxe2_sctx->ipsec_ctx.rx_tcam[*tcam_id];
+
+		rx_tcam->ip_addr.type = conf->ipsec.tunnel.type;
+		if (rx_tcam->ip_addr.type == RTE_SECURITY_IPSEC_TUNNEL_IPV4) {
+			rx_tcam->ip_addr.dst_ipv4 = (uint32_t)conf->ipsec.tunnel.ipv4.dst_ip.s_addr;
+		} else {
+			memcpy(&rx_tcam->ip_addr.dst_ipv6, &conf->ipsec.tunnel.ipv6.dst_addr,
+				sizeof(rx_tcam->ip_addr.dst_ipv6));
+		}
+	} else {
+		rx_tcam = &sxe2_sctx->ipsec_ctx.rx_tcam[*tcam_id];
+	}
+	rx_tcam->ref_cnt++;
+	ret = 0;
+
+l_end:
+	return ret;
+}
+
+static int32_t
+sxe2_ipsec_rx_udp_group_fill(struct sxe2_security_ctx *sxe2_sctx, uint16_t *udp_group_id,
+			     struct rte_security_session_conf *conf)
+{
+	int32_t ret = -1;
+	uint16_t len = sxe2_sctx->ipsec_ctx.max_udp_group;
+	struct sxe2_ipsec_rx_udp_group *rx_udp_group = NULL;
+	uint8_t sport_en = 0;
+	uint8_t dport_en = 0;
+	uint16_t udp_port = 0;
+
+	if (!conf->ipsec.options.udp_encap) {
+		ret = 0;
+		goto l_end;
+	}
+
+	if (conf->ipsec.udp.sport) {
+		sport_en = 1;
+		udp_port = conf->ipsec.udp.sport;
+	} else {
+		sport_en = 0;
+	}
+	if (conf->ipsec.udp.dport) {
+		dport_en = 1;
+		udp_port = conf->ipsec.udp.dport;
+	} else {
+		dport_en = 0;
+	}
+
+	*udp_group_id = sxe2_ipsec_group_id_find(sxe2_sctx->ipsec_ctx.rx_udp_group,
+			udp_port, sport_en, dport_en, len);
+	if (*udp_group_id == 0XFFFF) {
+		*udp_group_id = sxe2_ipsec_id_alloc(sxe2_sctx->ipsec_ctx.bmp.rx_udp_bmp, len);
+		if (*udp_group_id == 0xFFFF) {
+			ret = -ENOMEM;
+			goto l_end;
+		}
+		rx_udp_group = &sxe2_sctx->ipsec_ctx.rx_udp_group[*udp_group_id];
+		rx_udp_group->sport_en = sport_en;
+		rx_udp_group->dport_en = dport_en;
+		rx_udp_group->udp_port = udp_port;
+	} else {
+		rx_udp_group = &sxe2_sctx->ipsec_ctx.rx_udp_group[*udp_group_id];
+	}
+	rx_udp_group->ref_cnt++;
+	ret = 0;
+
+l_end:
+	return ret;
+}
+
+static int32_t
+sxe2_ipsec_rx_sa_add(struct sxe2_security_ctx *sxe2_sctx,
+		     struct rte_security_session_conf *conf,
+		     struct sxe2_security_session *sxe2_sess)
+{
+	struct sxe2_ipsec_rx_tcam *rx_tcam = NULL;
+	struct sxe2_ipsec_rx_sa *rx_sa     = NULL;
+	struct sxe2_ipsec_rx_udp_group *rx_udp_group = NULL;
+	struct rte_bitmap *rx_sa_bmp        = sxe2_sctx->ipsec_ctx.bmp.rx_sa_bmp;
+	struct rte_bitmap *rx_tcam_bmp      = sxe2_sctx->ipsec_ctx.bmp.rx_tcam_bmp;
+	uint16_t sa_bits                         = sxe2_sctx->ipsec_ctx.max_rx_sa;
+	uint16_t sa_id                           = 0xFFFF;
+	uint16_t tcam_id                         = 0xFFFF;
+	uint16_t udp_group_id                    = 0xFFFF;
+	int32_t ret                             = -1;
+
+	rte_spinlock_lock(&sxe2_sctx->security_lock);
+	sa_id = sxe2_ipsec_id_alloc(rx_sa_bmp, sa_bits);
+	if (sa_id == 0xFFFF) {
+		PMD_LOG_ERR(DRV, "Failed to allocate ipsec rx sa index.");
+		ret = -ENOMEM;
+		goto l_end;
+	}
+	rx_sa = &sxe2_sctx->ipsec_ctx.rx_sa[sa_id];
+	sxe2_ipsec_rx_sa_fill(rx_sa, conf);
+
+	ret = sxe2_ipsec_rx_tcam_fill(sxe2_sctx, &tcam_id, conf);
+	if (ret) {
+		PMD_LOG_ERR(DRV, "Failed to allocate ipsec rx tcam index.");
+		sxe2_ipsec_id_free(rx_sa_bmp, sa_id);
+		goto l_end;
+	}
+	rx_sa->tcam_id = tcam_id;
+	rx_tcam = &sxe2_sctx->ipsec_ctx.rx_tcam[tcam_id];
+
+	ret = sxe2_ipsec_rx_udp_group_fill(sxe2_sctx, &udp_group_id, conf);
+	if (ret) {
+		PMD_LOG_ERR(DRV, "Failed to allocate ipsec rx udp group index.");
+		sxe2_ipsec_id_free(rx_sa_bmp, sa_id);
+		sxe2_ipsec_id_free(rx_tcam_bmp, tcam_id);
+		goto l_end;
+	}
+
+	if (udp_group_id != 0XFFFF) {
+		rx_sa->udp_group_id = (uint8_t)udp_group_id;
+		rx_udp_group = &sxe2_sctx->ipsec_ctx.rx_udp_group[udp_group_id];
+	} else {
+		rx_sa->udp_group_id = 0XFF;
+	}
+
+	ret = sxe2_drv_ipsec_rxsa_add(sxe2_sctx->adapter, rx_sa, rx_tcam, rx_udp_group);
+	if (ret) {
+		PMD_LOG_ERR(DRV, "Failed to add rx sa.");
+		sxe2_ipsec_id_free(rx_sa_bmp, sa_id);
+		rx_tcam->ref_cnt--;
+		if (rx_tcam->ref_cnt == 0)
+			sxe2_ipsec_id_free(rx_tcam_bmp, tcam_id);
+
+		if (rx_udp_group != NULL) {
+			rx_udp_group->ref_cnt--;
+			if (rx_udp_group->ref_cnt == 0)
+				sxe2_ipsec_id_free(sxe2_sctx->ipsec_ctx.bmp.rx_udp_bmp,
+						   udp_group_id);
+		}
+
+		ret = -EIO;
+		goto l_end;
+	}
+
+	sxe2_ipsec_session_save(sxe2_sctx, conf, sxe2_sess, rx_sa->hw_sa_id, rx_sa->id);
+
+	PMD_LOG_INFO(DRV, "Add rx sa success, rx sa id: %u, rx ip id: %u, group id: %u, index: %u.",
+				rx_sa->hw_sa_id, rx_sa->hw_ip_id, rx_sa->udp_group_id, rx_sa->id);
+
+l_end:
+	rte_spinlock_unlock(&sxe2_sctx->security_lock);
+	return ret;
+}
+
+static int32_t
+sxe2_ipsec_hw_table_add(struct sxe2_security_ctx *sxe2_sctx,
+			struct rte_security_session_conf *conf,
+			struct sxe2_security_session *sxe2_sess)
+{
+	int32_t ret = -1;
+
+	switch (conf->ipsec.direction) {
+	case RTE_SECURITY_IPSEC_SA_DIR_EGRESS:
+		ret = sxe2_ipsec_tx_sa_add(sxe2_sctx, conf, sxe2_sess);
+		break;
+	case RTE_SECURITY_IPSEC_SA_DIR_INGRESS:
+		ret = sxe2_ipsec_rx_sa_add(sxe2_sctx, conf, sxe2_sess);
+		break;
+	default:
+		PMD_LOG_ERR(DRV, "Invalid sa direction.");
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+int sxe2_ipsec_session_create(void *device,
+			      struct rte_security_session_conf *conf,
+			      struct sxe2_security_session *sxe2_sess)
+{
+	struct rte_eth_dev *eth_dev = (struct rte_eth_dev *)device;
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(eth_dev);
+	struct sxe2_security_ctx *sxe2_sctx = &adapter->security_ctx;
+	int32_t ret = -1;
+
+	ret = sxe2_ipsec_session_conf_valid(sxe2_sctx, conf);
+	if (ret) {
+		PMD_LOG_ERR(DRV, "Input ipsec session conf invalid.");
+		goto l_end;
+	}
+
+	ret = sxe2_ipsec_hw_table_add(sxe2_sctx, conf, sxe2_sess);
+	if (ret)
+		goto l_end;
+
+l_end:
+	return ret;
+}
+
+static int32_t
+sxe2_ipsec_tx_sa_delete(struct sxe2_security_ctx *sxe2_sctx,
+			struct sxe2_security_session *sxe2_sess)
+{
+	struct sxe2_ipsec_tx_sa *tx_sa = NULL;
+	uint16_t sa_id = sxe2_sess->sa.hw_idx;
+	uint16_t sw_sa_id = sxe2_sess->sa.sw_idx;
+	int32_t ret   = -1;
+
+	if (sw_sa_id >= sxe2_sctx->ipsec_ctx.max_tx_sa) {
+		ret = 0;
+		PMD_LOG_WARN(DRV, "invalid sw sa id: %u.", sw_sa_id);
+		goto l_end;
+	}
+
+	if (!rte_bitmap_get(sxe2_sctx->ipsec_ctx.bmp.tx_sa_bmp, sw_sa_id)) {
+		ret = 0;
+		PMD_LOG_WARN(DRV, "bitmap not set, index: %u.", sw_sa_id);
+		goto l_end;
+	}
+
+	tx_sa = &sxe2_sctx->ipsec_ctx.tx_sa[sw_sa_id];
+
+	if (tx_sa->hw_sa_id != sa_id) {
+		ret = 0;
+		PMD_LOG_WARN(DRV, "invalid hw sa id: %u != %u.", sa_id, tx_sa->hw_sa_id);
+		goto l_end;
+	}
+
+	ret = sxe2_drv_ipsec_txsa_delete(sxe2_sctx->adapter, sa_id);
+	if (ret)
+		goto l_end;
+
+	rte_spinlock_lock(&sxe2_sctx->security_lock);
+	sxe2_ipsec_id_free(sxe2_sctx->ipsec_ctx.bmp.tx_sa_bmp, sw_sa_id);
+	rte_spinlock_unlock(&sxe2_sctx->security_lock);
+
+l_end:
+	return ret;
+}
+
+static int32_t
+sxe2_ipsec_rx_sa_delete(struct sxe2_security_ctx *sxe2_sctx,
+			struct sxe2_security_session *sxe2_sess)
+{
+	struct sxe2_ipsec_rx_udp_group *rx_udp = NULL;
+	struct sxe2_ipsec_rx_tcam *rx_tcam = NULL;
+	struct sxe2_ipsec_rx_sa *rx_sa = NULL;
+	uint16_t sa_id                            = sxe2_sess->sa.hw_idx;
+	uint16_t sw_sa_id                         = sxe2_sess->sa.sw_idx;
+	int32_t ret                              = -1;
+
+	if (sw_sa_id >= sxe2_sctx->ipsec_ctx.max_rx_sa) {
+		ret = 0;
+		PMD_LOG_WARN(DRV, "invalid sw sa id: %u.", sw_sa_id);
+		goto l_end;
+	}
+
+	if (!rte_bitmap_get(sxe2_sctx->ipsec_ctx.bmp.rx_sa_bmp, sw_sa_id)) {
+		ret = 0;
+		PMD_LOG_INFO(DRV, "bitmap not set, id: %u.", sw_sa_id);
+		goto l_end;
+	}
+
+	rx_sa = &sxe2_sctx->ipsec_ctx.rx_sa[sw_sa_id];
+
+	if (rx_sa->hw_sa_id != sa_id) {
+		ret = 0;
+		PMD_LOG_WARN(DRV, "invalid hw sa id: %u != %u.", sa_id, rx_sa->hw_sa_id);
+		goto l_end;
+	}
+
+	ret = sxe2_drv_ipsec_rxsa_delete(sxe2_sctx->adapter, rx_sa);
+	if (ret)
+		goto l_end;
+
+	rte_spinlock_lock(&sxe2_sctx->security_lock);
+	sxe2_ipsec_id_free(sxe2_sctx->ipsec_ctx.bmp.rx_sa_bmp, sw_sa_id);
+
+	rx_tcam = &sxe2_sctx->ipsec_ctx.rx_tcam[rx_sa->tcam_id];
+	rx_tcam->ref_cnt--;
+	if (rx_tcam->ref_cnt == 0)
+		sxe2_ipsec_id_free(sxe2_sctx->ipsec_ctx.bmp.rx_tcam_bmp, rx_sa->tcam_id);
+
+	if (rx_sa->udp_group_id == 0xFF) {
+		PMD_LOG_INFO(DRV, "Not need to release udp group resource.");
+		rte_spinlock_unlock(&sxe2_sctx->security_lock);
+		goto l_end;
+	}
+	rx_udp = &sxe2_sctx->ipsec_ctx.rx_udp_group[rx_sa->udp_group_id];
+	rx_udp->ref_cnt--;
+	if (rx_udp->ref_cnt == 0)
+		sxe2_ipsec_id_free(sxe2_sctx->ipsec_ctx.bmp.rx_udp_bmp, rx_sa->udp_group_id);
+	rte_spinlock_unlock(&sxe2_sctx->security_lock);
+
+l_end:
+	return ret;
+}
+
+static int32_t
+sxe2_ipsec_hw_table_delete(struct sxe2_security_ctx *sxe2_sctx,
+			   struct sxe2_security_session *sxe2_sess)
+{
+	int32_t ret = -1;
+
+	switch (sxe2_sess->direction) {
+	case RTE_SECURITY_IPSEC_SA_DIR_EGRESS:
+		ret = sxe2_ipsec_tx_sa_delete(sxe2_sctx, sxe2_sess);
+		break;
+	case RTE_SECURITY_IPSEC_SA_DIR_INGRESS:
+		ret = sxe2_ipsec_rx_sa_delete(sxe2_sctx, sxe2_sess);
+		break;
+	default:
+		PMD_LOG_ERR(DRV, "Invalid sa direction.");
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+int sxe2_ipsec_session_destroy(void *device, struct rte_security_session *session)
+{
+	struct rte_eth_dev *eth_dev = (struct rte_eth_dev *)device;
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(eth_dev);
+	struct sxe2_security_ctx *sxe2_sctx = &adapter->security_ctx;
+	struct sxe2_security_session *sxe2_sess = NULL;
+	sxe2_sess = SECURITY_GET_SESS_PRIV(session);
+	int32_t ret = -1;
+
+	if (unlikely(sxe2_sess == NULL || sxe2_sess->adapter != adapter)) {
+		PMD_LOG_ERR(DRV, "Invalid device adapter.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	ret = sxe2_ipsec_hw_table_delete(sxe2_sctx, sxe2_sess);
+	if (ret) {
+		ret = -EIO;
+		PMD_LOG_ERR(DRV, "Failed to delete ipsec hw tables.");
+		goto l_end;
+	}
+
+	memset(sxe2_sess, 0, sizeof(struct sxe2_security_session));
+
+	PMD_LOG_INFO(DRV, "Delete ipsec session success, sa_id: %u, spi: %u.",
+			sxe2_sess->sa.hw_idx, sxe2_sess->sa.spi);
+
+l_end:
+	return ret;
+}
+
+int sxe2_ipsec_pkt_metadata_set(void *device, struct rte_security_session *session,
+				struct rte_mbuf *m, void *params)
+{
+	struct rte_eth_dev *eth_dev = (struct rte_eth_dev *)device;
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(eth_dev);
+	struct sxe2_security_ctx *sxe2_sctx = &adapter->security_ctx;
+	struct sxe2_security_session *sxe2_sess = NULL;
+	struct sxe2_ipsec_pkt_metadata *md             = NULL;
+	uint16_t offset                                      = 0;
+	int32_t ret                                         = -1;
+
+	sxe2_sess = SECURITY_GET_SESS_PRIV(session);
+	if (unlikely(sxe2_sess == NULL || sxe2_sess->adapter != adapter)) {
+		PMD_LOG_ERR(DRV, "Invalid parameters.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	offset = ((struct sxe2_ipsec_metadata_params *)params)->esp_header_offset;
+	if (offset <= IPSEC_ESP_OFFSET_MIN || offset >= IPSEC_ESP_OFFSET_MAX) {
+		PMD_LOG_ERR(DRV, "Invalid esp header offset.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	md = RTE_MBUF_DYNFIELD(m, sxe2_sctx->ipsec_ctx.md_offset, struct sxe2_ipsec_pkt_metadata *);
+
+	memcpy(md, &sxe2_sess->pkt_metadata_template, sizeof(struct sxe2_ipsec_pkt_metadata));
+	md->esp_head_offset = offset;
+
+	PMD_LOG_INFO(DRV, "ipsec metadata set, offset:%u, said:%u, mode:%u, algo:%u.", offset,
+		sxe2_sess->pkt_metadata_template.sa_idx, sxe2_sess->pkt_metadata_template.mode,
+		sxe2_sess->pkt_metadata_template.algo);
+
+	ret = 0;
+
+l_end:
+	return ret;
+}
+
+int sxe2_ipsec_pkt_md_offset_get(struct sxe2_adapter *adapter)
+{
+	return adapter->security_ctx.ipsec_ctx.md_offset;
+}
+
+static void sxe2_ipsec_enc_aes_cbc_fill(struct rte_cryptodev_capabilities *cap)
+{
+	cap->sym.xform_type = RTE_CRYPTO_SYM_XFORM_CIPHER;
+
+	cap->sym.cipher.algo = SXE2_RTE_CRYPTO_CIPHER_AES_CBC;
+
+	cap->sym.cipher.block_size = SXE2_SECURITY_BLOCK_SIZE_16;
+
+	cap->sym.cipher.key_size.min = SXE2_IPSEC_AES_KEY_MIN;
+	cap->sym.cipher.key_size.max = SXE2_IPSEC_AES_KEY_MAX;
+	cap->sym.cipher.key_size.increment = SXE2_IPSEC_AES_KEY_INC;
+
+	cap->sym.cipher.iv_size.min = SXE2_IPSEC_AES_IV_MIN;
+	cap->sym.cipher.iv_size.max = SXE2_IPSEC_AES_IV_MAX;
+	cap->sym.cipher.iv_size.increment = SXE2_IPSEC_AES_IV_INC;
+
+	cap->sym.cipher.dataunit_set |= RTE_CRYPTO_CIPHER_DATA_UNIT_LEN_512_BYTES;
+}
+
+static void sxe2_ipsec_enc_sm4_cbc_fill(struct rte_cryptodev_capabilities *cap)
+{
+	cap->sym.xform_type = RTE_CRYPTO_SYM_XFORM_CIPHER;
+
+	cap->sym.cipher.algo = SXE2_RTE_RTE_CRYPTO_CIPHER_SM4_CBC;
+
+	cap->sym.cipher.block_size = SXE2_SECURITY_BLOCK_SIZE_16;
+
+	cap->sym.cipher.key_size.min = SXE2_IPSEC_SM4_KEY_MIN;
+	cap->sym.cipher.key_size.max = SXE2_IPSEC_SM4_KEY_MAX;
+	cap->sym.cipher.key_size.increment = SXE2_IPSEC_SM4_KEY_INC;
+
+	cap->sym.cipher.iv_size.min = SXE2_IPSEC_SM4_IV_MIN;
+	cap->sym.cipher.iv_size.max = SXE2_IPSEC_SM4_IV_MAX;
+	cap->sym.cipher.iv_size.increment = SXE2_IPSEC_SM4_IV_INC;
+
+	cap->sym.cipher.dataunit_set |= RTE_CRYPTO_CIPHER_DATA_UNIT_LEN_512_BYTES;
+}
+
+static void sxe2_ipsec_auth_sha_hmac_fill(struct rte_cryptodev_capabilities *cap)
+{
+	cap->sym.xform_type = RTE_CRYPTO_SYM_XFORM_AUTH;
+
+	cap->sym.auth.algo = SXE2_RTE_CRYPTO_AUTH_SHA256_HMAC;
+
+	cap->sym.auth.block_size = SXE2_SECURITY_BLOCK_SIZE_64;
+
+	cap->sym.auth.key_size.min = SXE2_IPSEC_SHA_KEY_MIN;
+	cap->sym.auth.key_size.max = SXE2_IPSEC_SHA_KEY_MAX;
+	cap->sym.auth.key_size.increment = SXE2_IPSEC_SHA_KEY_INC;
+
+	cap->sym.auth.iv_size.min = SXE2_IPSEC_SHA_IV_MIN;
+	cap->sym.auth.iv_size.max = SXE2_IPSEC_SHA_IV_MAX;
+	cap->sym.auth.iv_size.increment = SXE2_IPSEC_SHA_IV_INC;
+
+	cap->sym.auth.digest_size.min = SXE2_IPSEC_SHA_DIGEST_MIN;
+	cap->sym.auth.digest_size.max = SXE2_IPSEC_SHA_DIGEST_MAX;
+	cap->sym.auth.digest_size.increment = SXE2_IPSEC_SHA_DIGEST_INC;
+
+	cap->sym.auth.aad_size.min = SXE2_IPSEC_AAD_MIN;
+	cap->sym.auth.aad_size.max = SXE2_IPSEC_AAD_MAX;
+	cap->sym.auth.aad_size.increment = SXE2_IPSEC_AAD_INC;
+}
+
+static void sxe2_ipsec_auth_sm3_hmac_fill(struct rte_cryptodev_capabilities *cap)
+{
+	cap->sym.xform_type = RTE_CRYPTO_SYM_XFORM_AUTH;
+
+	cap->sym.auth.algo = SXE2_RTE_CRYPTO_AUTH_SM3_HMAC;
+
+	cap->sym.auth.block_size = SXE2_SECURITY_BLOCK_SIZE_64;
+
+	cap->sym.auth.key_size.min = SXE2_IPSEC_SM3_KEY_MIN;
+	cap->sym.auth.key_size.max = SXE2_IPSEC_SM3_KEY_MAX;
+	cap->sym.auth.key_size.increment = SXE2_IPSEC_SM3_KEY_INC;
+
+	cap->sym.auth.iv_size.min = SXE2_IPSEC_SM3_IV_MIN;
+	cap->sym.auth.iv_size.max = SXE2_IPSEC_SM3_IV_MAX;
+	cap->sym.auth.iv_size.increment = SXE2_IPSEC_SM3_IV_INC;
+
+	cap->sym.auth.digest_size.min = SXE2_IPSEC_SM3_DIGEST_MIN;
+	cap->sym.auth.digest_size.max = SXE2_IPSEC_SM3_DIGEST_MAX;
+	cap->sym.auth.digest_size.increment = SXE2_IPSEC_SM3_DIGEST_INC;
+
+	cap->sym.auth.aad_size.min = SXE2_IPSEC_AAD_MIN;
+	cap->sym.auth.aad_size.max = SXE2_IPSEC_AAD_MAX;
+	cap->sym.auth.aad_size.increment = SXE2_IPSEC_AAD_INC;
+}
+
+static int32_t
+sxe2_ipsec_capabilities_init(struct sxe2_security_ctx *sxe2_sctx)
+{
+	struct rte_cryptodev_capabilities *capabilities = NULL;
+	struct sxe2_security_capabilities *sxe2_cap   =
+			&sxe2_sctx->sxe2_capabilities[SXE2_SECURITY_PROTOCOL_IPSEC];
+	int32_t ret                                         = -1;
+	uint8_t index                                        = 0;
+
+	sxe2_cap->action = RTE_SECURITY_ACTION_TYPE_INLINE_CRYPTO;
+	sxe2_cap->ipsec.proto = RTE_SECURITY_IPSEC_SA_PROTO_ESP;
+	sxe2_cap->ipsec.mode = RTE_SECURITY_IPSEC_SA_MODE_TUNNEL;
+	sxe2_cap->ipsec.options.stats = 1;
+
+	capabilities = rte_zmalloc("security_caps",
+				sizeof(struct rte_cryptodev_capabilities) * SXE2_IPSEC_CAP_MAX, 0);
+	if (capabilities == NULL) {
+		ret = -ENOMEM;
+		goto l_end;
+	}
+
+	for (index = 0; index < SXE2_IPSEC_CAP_MAX; index++) {
+		capabilities[index].op = RTE_CRYPTO_OP_TYPE_SYMMETRIC;
+		switch (index) {
+		case SXE2_IPSEC_CAP_ENC_AES_CBC:
+			sxe2_ipsec_enc_aes_cbc_fill(&capabilities[index]);
+			break;
+		case SXE2_IPSEC_CAP_ENC_SM4_CBC:
+			sxe2_ipsec_enc_sm4_cbc_fill(&capabilities[index]);
+			break;
+		case SXE2_IPSEC_CAP_AUTH_SHA256_HMAC:
+			sxe2_ipsec_auth_sha_hmac_fill(&capabilities[index]);
+			break;
+		case SXE2_IPSEC_CAP_AUTH_SM3_HMAC:
+			sxe2_ipsec_auth_sm3_hmac_fill(&capabilities[index]);
+			break;
+		default:
+			break;
+		}
+	}
+
+	sxe2_cap->crypto_capabilities = capabilities;
+	ret = 0;
+
+l_end:
+	return ret;
+}
+
+static void
+sxe2_ipsec_tx_sa_init(struct sxe2_ipsec_tx_sa *tx_sa, uint16_t len)
+{
+	struct sxe2_ipsec_tx_sa *per = NULL;
+	uint16_t i;
+
+	memset(tx_sa, 0, sizeof(struct sxe2_ipsec_tx_sa) * len);
+	for (i = 0; i < len; i++) {
+		per = &tx_sa[i];
+		per->id = i;
+	}
+}
+
+static void
+sxe2_ipsec_rx_sa_init(struct sxe2_ipsec_rx_sa *rx_sa, uint16_t len)
+{
+	struct sxe2_ipsec_rx_sa *per = NULL;
+	uint16_t i;
+
+	memset(rx_sa, 0, sizeof(struct sxe2_ipsec_rx_sa) * len);
+	for (i = 0; i < len; i++) {
+		per = &rx_sa[i];
+		per->id = i;
+	}
+}
+
+static void
+sxe2_ipsec_rx_tcam_init(struct sxe2_ipsec_rx_tcam *rx_tcam, uint16_t len)
+{
+	struct sxe2_ipsec_rx_tcam *per = NULL;
+	uint16_t i;
+
+	memset(rx_tcam, 0, sizeof(struct sxe2_ipsec_rx_tcam) * len);
+	for (i = 0; i < len; i++) {
+		per = &rx_tcam[i];
+		per->id = i;
+	}
+}
+
+static void
+sxe2_ipsec_rx_udp_group_init(struct sxe2_ipsec_rx_udp_group *rx_udp_group, uint16_t len)
+{
+	struct sxe2_ipsec_rx_udp_group *per = NULL;
+	uint16_t i;
+
+	memset(rx_udp_group, 0, sizeof(struct sxe2_ipsec_rx_udp_group) * len);
+	for (i = 0; i < len; i++) {
+		per = &rx_udp_group[i];
+		per->id = i;
+	}
+}
+
+static int32_t
+sxe2_ipsec_hw_table_init(struct sxe2_security_ctx *sxe2_sctx)
+{
+	struct sxe2_ipsec_tx_sa *tx_sa = NULL;
+	struct sxe2_ipsec_rx_sa *rx_sa = NULL;
+	struct sxe2_ipsec_rx_tcam *rx_tcam = NULL;
+	struct sxe2_ipsec_rx_udp_group *rx_udp_group = NULL;
+	uint16_t max_tx_sa = sxe2_sctx->ipsec_ctx.max_tx_sa;
+	uint16_t max_rx_sa = sxe2_sctx->ipsec_ctx.max_rx_sa;
+	uint16_t max_tcam  = sxe2_sctx->ipsec_ctx.max_tcam;
+	uint16_t max_udp_group  = sxe2_sctx->ipsec_ctx.max_udp_group;
+	int32_t ret       = -1;
+
+	tx_sa = rte_zmalloc("sxe2_ipsec_tx_sa", sizeof(struct sxe2_ipsec_tx_sa) * max_tx_sa, 0);
+	if (tx_sa == NULL) {
+		ret = -ENOMEM;
+		goto l_end;
+	}
+	sxe2_ipsec_tx_sa_init(tx_sa, max_tx_sa);
+	sxe2_sctx->ipsec_ctx.tx_sa = tx_sa;
+
+	rx_sa = rte_zmalloc("sxe2_ipsec_rx_sa", sizeof(struct sxe2_ipsec_rx_sa) * max_rx_sa, 0);
+	if (rx_sa == NULL) {
+		ret = -ENOMEM;
+		goto l_end;
+	}
+	sxe2_ipsec_rx_sa_init(rx_sa, max_rx_sa);
+	sxe2_sctx->ipsec_ctx.rx_sa = rx_sa;
+
+	rx_tcam = rte_zmalloc("sxe2_ipsec_rx_tcam",
+				sizeof(struct sxe2_ipsec_rx_tcam) * max_tcam, 0);
+	if (rx_tcam == NULL) {
+		ret = -ENOMEM;
+		goto l_end;
+	}
+	sxe2_ipsec_rx_tcam_init(rx_tcam, max_tcam);
+	sxe2_sctx->ipsec_ctx.rx_tcam = rx_tcam;
+
+	rx_udp_group = rte_zmalloc("sxe2_ipsec_rx_udp_group",
+				sizeof(struct sxe2_ipsec_rx_udp_group) * max_udp_group, 0);
+	if (rx_udp_group == NULL) {
+		ret = -ENOMEM;
+		goto l_end;
+	}
+	sxe2_ipsec_rx_udp_group_init(rx_udp_group, max_udp_group);
+	sxe2_sctx->ipsec_ctx.rx_udp_group = rx_udp_group;
+
+	ret = 0;
+
+l_end:
+	if (ret) {
+		if (tx_sa != NULL) {
+			rte_free(tx_sa);
+			sxe2_sctx->ipsec_ctx.tx_sa = NULL;
+		}
+		if (rx_sa != NULL) {
+			rte_free(rx_sa);
+			sxe2_sctx->ipsec_ctx.rx_sa = NULL;
+		}
+		if (rx_tcam != NULL) {
+			rte_free(rx_tcam);
+			sxe2_sctx->ipsec_ctx.rx_tcam = NULL;
+		}
+		if (rx_udp_group != NULL) {
+			rte_free(rx_udp_group);
+			sxe2_sctx->ipsec_ctx.rx_udp_group = NULL;
+		}
+	}
+	return ret;
+}
+
+int32_t sxe2_ipsec_init(struct sxe2_adapter *adapter)
+{
+	struct sxe2_security_ctx *sxe2_sctx = &adapter->security_ctx;
+	struct sxe2_security_capabilities *sxe2_cap = NULL;
+	int32_t ret                               = -1;
+	struct rte_mbuf_dynfield pkt_md_dynfield = {
+	.name = "sxe2_ipsec_pkt_metadata",
+		.size = sizeof(struct sxe2_ipsec_pkt_metadata),
+		.align = alignof(struct sxe2_ipsec_pkt_metadata)
+	};
+
+	PMD_LOG_INFO(INIT, "Init ipsec.");
+
+	sxe2_sctx->ipsec_ctx.md_offset = rte_mbuf_dynfield_register(&pkt_md_dynfield);
+	if (sxe2_sctx->ipsec_ctx.md_offset < 0) {
+		PMD_LOG_ERR(INIT, "Failed to register ipsec mbuf dynamic field.");
+		ret = -EIO;
+		goto l_end;
+	}
+
+	ret = sxe2_ipsec_capabilities_init(sxe2_sctx);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to init ipsec capabilities.");
+		goto l_end;
+	}
+
+	ret = sxe2_drv_ipsec_get_capa(adapter);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to get ipsec capabilities.");
+		goto l_caps_free;
+	}
+
+	ret = sxe2_ipsec_bitmap_init(sxe2_sctx);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to init ipsec bitmap.");
+		goto l_caps_free;
+	}
+
+	ret = sxe2_ipsec_hw_table_init(sxe2_sctx);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to init ipsec hw table.");
+		goto l_bitmap_free;
+	}
+
+	goto l_end;
+
+l_bitmap_free:
+
+	if (sxe2_sctx->ipsec_ctx.bmp.tx_sa_mem != NULL) {
+		rte_free(sxe2_sctx->ipsec_ctx.bmp.tx_sa_mem);
+		sxe2_sctx->ipsec_ctx.bmp.tx_sa_mem = NULL;
+	}
+	if (sxe2_sctx->ipsec_ctx.bmp.rx_sa_mem != NULL) {
+		rte_free(sxe2_sctx->ipsec_ctx.bmp.rx_sa_mem);
+		sxe2_sctx->ipsec_ctx.bmp.rx_sa_mem = NULL;
+	}
+	if (sxe2_sctx->ipsec_ctx.bmp.rx_tcam_mem != NULL) {
+		rte_free(sxe2_sctx->ipsec_ctx.bmp.rx_tcam_mem);
+		sxe2_sctx->ipsec_ctx.bmp.rx_tcam_mem = NULL;
+	}
+	if (sxe2_sctx->ipsec_ctx.bmp.rx_udp_mem != NULL) {
+		rte_free(sxe2_sctx->ipsec_ctx.bmp.rx_udp_mem);
+		sxe2_sctx->ipsec_ctx.bmp.rx_udp_mem = NULL;
+	}
+l_caps_free:
+	sxe2_cap = &sxe2_sctx->sxe2_capabilities[SXE2_SECURITY_PROTOCOL_IPSEC];
+	if (sxe2_cap->crypto_capabilities != NULL) {
+		rte_free(sxe2_cap->crypto_capabilities);
+		sxe2_cap->crypto_capabilities = NULL;
+	}
+l_end:
+	return ret;
+}
+
+void sxe2_ipsec_uinit(struct sxe2_adapter *adapter)
+{
+	struct sxe2_security_ctx *sxe2_sctx = &adapter->security_ctx;
+	struct sxe2_security_capabilities *sxe2_cap   =
+			&sxe2_sctx->sxe2_capabilities[SXE2_SECURITY_PROTOCOL_IPSEC];
+	struct sxe2_ipsec_tx_sa *tx_sa = sxe2_sctx->ipsec_ctx.tx_sa;
+	struct sxe2_ipsec_rx_sa *rx_sa = sxe2_sctx->ipsec_ctx.rx_sa;
+	struct sxe2_ipsec_rx_tcam *rx_tcam = sxe2_sctx->ipsec_ctx.rx_tcam;
+	struct sxe2_ipsec_rx_udp_group *rx_udp_group = sxe2_sctx->ipsec_ctx.rx_udp_group;
+
+	PMD_LOG_INFO(INIT, "Uinit ipsec.");
+
+	(void)sxe2_drv_ipsec_resource_clear(adapter);
+
+	if (sxe2_sctx->ipsec_ctx.bmp.tx_sa_mem != NULL) {
+		rte_free(sxe2_sctx->ipsec_ctx.bmp.tx_sa_mem);
+		sxe2_sctx->ipsec_ctx.bmp.tx_sa_mem = NULL;
+	}
+	if (sxe2_sctx->ipsec_ctx.bmp.rx_sa_mem != NULL) {
+		rte_free(sxe2_sctx->ipsec_ctx.bmp.rx_sa_mem);
+		sxe2_sctx->ipsec_ctx.bmp.rx_sa_mem = NULL;
+	}
+	if (sxe2_sctx->ipsec_ctx.bmp.rx_tcam_mem != NULL) {
+		rte_free(sxe2_sctx->ipsec_ctx.bmp.rx_tcam_mem);
+		sxe2_sctx->ipsec_ctx.bmp.rx_tcam_mem = NULL;
+	}
+	if (sxe2_sctx->ipsec_ctx.bmp.rx_udp_mem != NULL) {
+		rte_free(sxe2_sctx->ipsec_ctx.bmp.rx_udp_mem);
+		sxe2_sctx->ipsec_ctx.bmp.rx_udp_mem = NULL;
+	}
+
+	if (tx_sa != NULL) {
+		rte_free(tx_sa);
+		sxe2_sctx->ipsec_ctx.tx_sa = NULL;
+	}
+	if (rx_sa != NULL) {
+		rte_free(rx_sa);
+		sxe2_sctx->ipsec_ctx.rx_sa = NULL;
+	}
+	if (rx_tcam != NULL) {
+		rte_free(rx_tcam);
+		sxe2_sctx->ipsec_ctx.rx_tcam = NULL;
+	}
+	if (rx_udp_group != NULL) {
+		rte_free(rx_udp_group);
+		sxe2_sctx->ipsec_ctx.rx_udp_group = NULL;
+	}
+
+	if (sxe2_cap->crypto_capabilities != NULL) {
+		rte_free(sxe2_cap->crypto_capabilities);
+		sxe2_cap->crypto_capabilities = NULL;
+	}
+}
diff --git a/drivers/net/sxe2/sxe2_ipsec.h b/drivers/net/sxe2/sxe2_ipsec.h
new file mode 100644
index 0000000000..02930ddb4f
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_ipsec.h
@@ -0,0 +1,254 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+#ifndef __SXE2_IPSEC_H__
+#define __SXE2_IPSEC_H__
+
+#include <rte_security.h>
+#include <rte_security_driver.h>
+
+struct sxe2_adapter;
+struct sxe2_security_session;
+
+#define        SXE2_IPSEC_AES_KEY_MIN    (32)
+#define        SXE2_IPSEC_AES_KEY_MAX    (32)
+#define        SXE2_IPSEC_AES_KEY_INC    (0)
+
+#define        SXE2_IPSEC_SM4_KEY_MIN    (16)
+#define        SXE2_IPSEC_SM4_KEY_MAX    (16)
+#define        SXE2_IPSEC_SM4_KEY_INC    (0)
+
+#define        SXE2_IPSEC_SHA_KEY_MIN    (32)
+#define        SXE2_IPSEC_SHA_KEY_MAX    (32)
+#define        SXE2_IPSEC_SHA_KEY_INC    (0)
+
+#define        SXE2_IPSEC_SM3_KEY_MIN    (32)
+#define        SXE2_IPSEC_SM3_KEY_MAX    (32)
+#define        SXE2_IPSEC_SM3_KEY_INC    (0)
+
+#define        SXE2_IPSEC_AES_IV_MIN    (16)
+#define        SXE2_IPSEC_AES_IV_MAX    (16)
+#define        SXE2_IPSEC_AES_IV_INC    (0)
+
+#define        SXE2_IPSEC_SM4_IV_MIN    (16)
+#define        SXE2_IPSEC_SM4_IV_MAX    (16)
+#define        SXE2_IPSEC_SM4_IV_INC    (0)
+
+#define        SXE2_IPSEC_SHA_IV_MIN    (0)
+#define        SXE2_IPSEC_SHA_IV_MAX    (32)
+#define        SXE2_IPSEC_SHA_IV_INC    (16)
+
+#define        SXE2_IPSEC_SM3_IV_MIN    (0)
+#define        SXE2_IPSEC_SM3_IV_MAX    (32)
+#define        SXE2_IPSEC_SM3_IV_INC    (16)
+
+#define        SXE2_IPSEC_SHA_DIGEST_MIN    (32)
+#define        SXE2_IPSEC_SHA_DIGEST_MAX    (32)
+#define        SXE2_IPSEC_SHA_DIGEST_INC    (0)
+
+#define        SXE2_IPSEC_SM3_DIGEST_MIN    (32)
+#define        SXE2_IPSEC_SM3_DIGEST_MAX    (32)
+#define        SXE2_IPSEC_SM3_DIGEST_INC    (0)
+
+#define        SXE2_IPSEC_AAD_MIN           (0)
+#define        SXE2_IPSEC_AAD_MAX           (0)
+#define        SXE2_IPSEC_AAD_INC           (0)
+
+#define        SXE2_IPSEC_MAX_KEY_LEN		 (32)
+#define        SXE2_IPSEC_MIN_KEY_LEN       (0)
+
+#define SXE2_IPSEC_OL_FLAGS_IS_TUN    (0x1 << 0)
+#define SXE2_IPSEC_OL_FLAGS_IS_ESP    (0x1 << 1)
+
+#define SXE2_IPSEC_DEFAULT_SA_OFFSET  (0)
+#define SXE2_IPSEC_DEFAULT_SA_LEN     (1024)
+
+#define IPSEC_TX_ENCRYPT    (RTE_BIT32(0))
+#define IPSEC_TX_ENGINE_SM4 (RTE_BIT32(1))
+
+#define IPSEC_RX_VALID      (RTE_BIT32(0))
+#define IPSEC_RX_IPV6       (RTE_BIT32(2))
+#define IPSEC_RX_DECRYPT    (RTE_BIT32(3))
+#define IPSEC_RX_ENGINE_SM4 (RTE_BIT32(4))
+
+#define IPSEC_IPV6_LEN                 (4)
+#define IPSEC_ESP_OFFSET_MIN           (16)
+#define IPSEC_ESP_OFFSET_MAX           (256)
+
+enum sxe2_ipsec_cap {
+	SXE2_IPSEC_CAP_ENC_AES_CBC      = 0,
+	SXE2_IPSEC_CAP_ENC_SM4_CBC      = 1,
+	SXE2_IPSEC_CAP_AUTH_SHA256_HMAC = 2,
+	SXE2_IPSEC_CAP_AUTH_SM3_HMAC    = 3,
+	SXE2_IPSEC_CAP_MAX              = 4,
+};
+
+enum sxe2_ipsec_icv_len {
+	SXE2_IPSEC_ICV_0_BYTES = 0,
+	SXE2_IPSEC_ICV_12_BYTES,
+	SXE2_IPSEC_ICV_16_BYTES,
+	SXE2_IPSEC_ICV_INVALID,
+};
+
+enum sxe2_ipsec_bypass_dir {
+	SXE2_IPSEC_BYPASS_DIR_RX = 0,
+	SXE2_IPSEC_BYPASS_DIR_TX,
+	SXE2_IPSEC_BYPASS_DIR_INVALID,
+};
+
+enum sxe2_ipsec_bypass_status {
+	SXE2_IPSEC_BYPASS_STATUS_DISABLE = 0,
+	SXE2_IPSEC_BYPASS_STATUS_ENABLE,
+	SXE2_IPSEC_BYPASS_STATUS_INVALID,
+};
+
+enum sxe2_ipsec_status {
+	SXE2_IPSEC_ENC_BYPASS = 0,
+	SXE2_IPSEC_ENC_ENABLE,
+	SXE2_IPSEC_ENC_INVALID,
+};
+
+enum sxe2_ipsec_mode {
+	SXE2_IPSEC_MODE_ENC_AND_AUTH = 0,
+	SXE2_IPSEC_MODE_ONLY_ENCRYPT,
+	SXE2_IPSEC_MODE_INVALID,
+};
+
+struct sxe2_ipsec_ip_param {
+	enum rte_security_ipsec_tunnel_type type;
+	union {
+		uint32_t dst_ipv4;
+		uint32_t dst_ipv6[IPSEC_IPV6_LEN];
+	};
+};
+
+enum sxe2_ipsec_algorithm {
+	SXE2_IPSEC_ALGO_AES_CBC_AND_SHA256_128_HMAC = 0,
+	SXE2_IPSEC_ALGO_SM4_CBC_AND_SM3_96_HMAC,
+	SXE2_IPSEC_ALGO_INVALID,
+};
+
+struct sxe2_ipsec_pkt_metadata {
+	uint16_t                  sa_idx;
+	uint16_t                  esp_head_offset;
+	uint8_t                   ol_flags;
+	uint8_t                   mode;
+	uint8_t                   algo;
+};
+
+struct sxe2_ipsec_bitmap {
+	struct rte_bitmap *tx_sa_bmp;
+	struct rte_bitmap *rx_sa_bmp;
+	struct rte_bitmap *rx_tcam_bmp;
+	struct rte_bitmap *rx_udp_bmp;
+	void *tx_sa_mem;
+	void *rx_sa_mem;
+	void *rx_tcam_mem;
+	void *rx_udp_mem;
+};
+
+struct sxe2_ipsec_security_sa {
+	uint32_t spi;
+	uint16_t hw_idx;
+	uint16_t sw_idx;
+};
+
+struct sxe2_ipsec_esn {
+	union {
+		uint64_t value;
+		struct {
+			uint32_t hi;
+			uint32_t low;
+		};
+	};
+	uint8_t enabled;
+};
+
+struct sxe2_ipsec_udp {
+	struct rte_security_ipsec_udp_param value;
+	uint8_t enabled;
+};
+
+struct sxe2_ipsec_tx_sa {
+	struct rte_security_ipsec_xform xform;
+	uint16_t id;
+	uint16_t hw_sa_id;
+	enum sxe2_ipsec_mode mode;
+	enum sxe2_ipsec_algorithm algo;
+	uint8_t enc_key[SXE2_IPSEC_MAX_KEY_LEN];
+	uint8_t auth_key[SXE2_IPSEC_MAX_KEY_LEN];
+};
+
+struct sxe2_ipsec_rx_sa {
+	struct rte_security_ipsec_xform xform;
+	uint32_t spi;
+	uint16_t id;
+	uint16_t hw_sa_id;
+	uint8_t hw_ip_id;
+	uint8_t hw_udp_group_id;
+	uint8_t tcam_id;
+	uint8_t udp_group_id;
+	uint8_t sdn_group_id;
+	enum sxe2_ipsec_mode mode;
+	enum sxe2_ipsec_algorithm algo;
+	uint8_t enc_key[SXE2_IPSEC_MAX_KEY_LEN];
+	uint8_t auth_key[SXE2_IPSEC_MAX_KEY_LEN];
+};
+
+struct sxe2_ipsec_rx_tcam {
+	struct sxe2_ipsec_ip_param ip_addr;
+	uint16_t id;
+	uint8_t hw_ip_id;
+	uint8_t ref_cnt;
+};
+
+struct sxe2_ipsec_rx_udp_group {
+	uint16_t udp_port;
+	uint8_t sport_en;
+	uint8_t dport_en;
+	uint8_t id;
+	uint8_t hw_group_id;
+	uint8_t ref_cnt;
+};
+
+struct sxe2_ipsec_ctx {
+	struct sxe2_ipsec_tx_sa             *tx_sa;
+	struct sxe2_ipsec_rx_sa             *rx_sa;
+	struct sxe2_ipsec_rx_tcam           *rx_tcam;
+	struct sxe2_ipsec_rx_udp_group      *rx_udp_group;
+	struct sxe2_ipsec_bitmap            bmp;
+	int                                  md_offset;
+	uint16_t                                  max_tx_sa;
+	uint16_t                                  max_rx_sa;
+	uint16_t                                  max_tcam;
+	uint8_t                                   max_udp_group;
+};
+
+struct sxe2_ipsec_metadata_params {
+	uint16_t esp_header_offset;
+	uint16_t reserved;
+};
+
+bool sxe2_ipsec_supported(struct sxe2_adapter *adapter);
+
+bool sxe2_ipsec_valid_tx_offloads(uint64_t offloads);
+
+bool sxe2_ipsec_valid_rx_offloads(uint64_t offloads);
+
+int sxe2_ipsec_pkt_md_offset_get(struct sxe2_adapter *adapter);
+
+int sxe2_ipsec_session_create(void *device,
+			      struct rte_security_session_conf *conf,
+			      struct sxe2_security_session *sxe2_sess);
+
+int sxe2_ipsec_session_destroy(void *device,
+		struct rte_security_session *session);
+
+int sxe2_ipsec_pkt_metadata_set(void *device, struct rte_security_session *session,
+				struct rte_mbuf *m, void *params);
+
+int32_t sxe2_ipsec_init(struct sxe2_adapter *adapter);
+
+void sxe2_ipsec_uinit(struct sxe2_adapter *adapter);
+
+#endif /* __SXE2_IPSEC_H__ */
diff --git a/drivers/net/sxe2/sxe2_rx.c b/drivers/net/sxe2/sxe2_rx.c
index 28832d5f71..007192c7d8 100644
--- a/drivers/net/sxe2/sxe2_rx.c
+++ b/drivers/net/sxe2/sxe2_rx.c
@@ -294,6 +294,11 @@ int32_t __rte_cold sxe2_rx_queue_setup(struct rte_eth_dev *dev,
 		goto l_end;
 	}
 
+	if (!sxe2_ipsec_valid_rx_offloads(offloads)) {
+		ret = -EINVAL;
+		goto l_end;
+	}
+
 	rxq = sxe2_rx_queue_alloc(dev, queue_idx, nb_desc, socket_id);
 	if (rxq == NULL) {
 		PMD_LOG_ERR(RX, "rx queue[%d] resource alloc failed", queue_idx);
diff --git a/drivers/net/sxe2/sxe2_security.c b/drivers/net/sxe2/sxe2_security.c
new file mode 100644
index 0000000000..bc59d1b880
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_security.c
@@ -0,0 +1,335 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#include <rte_malloc.h>
+
+#include "sxe2_ethdev.h"
+#include "sxe2_security.h"
+#include "sxe2_ipsec.h"
+#include "sxe2_common_log.h"
+
+static unsigned int
+sxe2_security_session_size_get(void *device __rte_unused)
+{
+	return sizeof(struct sxe2_security_session);
+}
+
+static int
+sxe2_security_session_create(void *device,
+			     struct rte_security_session_conf *conf,
+			     struct rte_security_session *session)
+{
+	int32_t ret = -1;
+	struct sxe2_security_session *sxe2_sess = NULL;
+	sxe2_sess = SECURITY_GET_SESS_PRIV(session);
+
+	switch (conf->protocol) {
+	case RTE_SECURITY_PROTOCOL_IPSEC:
+		ret = sxe2_ipsec_session_create(device, conf, sxe2_sess);
+		break;
+	default:
+		PMD_LOG_ERR(DRV, "Invalid security protocol.");
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int
+sxe2_security_session_destroy(void *device, struct rte_security_session *session)
+{
+	int32_t ret = -1;
+	struct sxe2_security_session *sxe2_sess = NULL;
+	sxe2_sess = SECURITY_GET_SESS_PRIV(session);
+
+	switch (sxe2_sess->protocol) {
+	case RTE_SECURITY_PROTOCOL_IPSEC:
+		ret = sxe2_ipsec_session_destroy(device, session);
+		break;
+	default:
+		PMD_LOG_ERR(DRV, "Invalid security protocol.");
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
+static int
+sxe2_security_pkt_metadata_set(void *device,
+			       struct rte_security_session *session,
+			       struct rte_mbuf *m, void *params)
+{
+	struct sxe2_security_session *sxe2_sess = NULL;
+	sxe2_sess = SECURITY_GET_SESS_PRIV(session);
+	int32_t ret = -1;
+
+	switch (sxe2_sess->protocol) {
+	case RTE_SECURITY_PROTOCOL_IPSEC:
+		ret = sxe2_ipsec_pkt_metadata_set(device, session, m, params);
+		break;
+	default:
+		PMD_LOG_ERR(DRV, "Invalid security protocol.");
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static const struct rte_security_capability *
+sxe2_security_capabilities_get(void *device __rte_unused)
+{
+	static const struct rte_cryptodev_capabilities
+	ipsec_crypto_capabilities[] = {
+		{
+			.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+			{.sym = {
+				.xform_type = RTE_CRYPTO_SYM_XFORM_CIPHER,
+				{.cipher = {
+					.algo = SXE2_RTE_CRYPTO_CIPHER_AES_CBC,
+					.block_size = SXE2_SECURITY_BLOCK_SIZE_16,
+					.key_size = {
+						.min = SXE2_IPSEC_AES_KEY_MIN,
+						.max = SXE2_IPSEC_AES_KEY_MAX,
+						.increment = SXE2_IPSEC_AES_KEY_INC
+					},
+					.iv_size = {
+						.min = SXE2_IPSEC_AES_IV_MIN,
+						.max = SXE2_IPSEC_AES_IV_MAX,
+						.increment = SXE2_IPSEC_AES_IV_INC
+					},
+					.dataunit_set = RTE_CRYPTO_CIPHER_DATA_UNIT_LEN_512_BYTES,
+				}, }
+			}, }
+		},
+		{
+			.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+			{.sym = {
+				.xform_type = RTE_CRYPTO_SYM_XFORM_CIPHER,
+				{.cipher = {
+					.algo = SXE2_RTE_RTE_CRYPTO_CIPHER_SM4_CBC,
+					.block_size = SXE2_SECURITY_BLOCK_SIZE_16,
+					.key_size = {
+						.min = SXE2_IPSEC_SM4_KEY_MIN,
+						.max = SXE2_IPSEC_SM4_KEY_MAX,
+						.increment = SXE2_IPSEC_SM4_KEY_INC
+					},
+					.iv_size = {
+						.min = SXE2_IPSEC_SM4_IV_MIN,
+						.max = SXE2_IPSEC_SM4_IV_MAX,
+						.increment = SXE2_IPSEC_SM4_IV_INC
+					},
+					.dataunit_set = RTE_CRYPTO_CIPHER_DATA_UNIT_LEN_512_BYTES,
+				}, }
+			}, }
+		},
+		{
+			.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+			{.sym = {
+				.xform_type = RTE_CRYPTO_SYM_XFORM_AUTH,
+				{.auth = {
+					.algo = SXE2_RTE_CRYPTO_AUTH_SHA256_HMAC,
+					.block_size = SXE2_SECURITY_BLOCK_SIZE_64,
+					.key_size = {
+						.min = SXE2_IPSEC_SHA_KEY_MIN,
+						.max = SXE2_IPSEC_SHA_KEY_MAX,
+						.increment = SXE2_IPSEC_SHA_KEY_INC
+					},
+					.digest_size = {
+						.min = SXE2_IPSEC_SHA_DIGEST_MIN,
+						.max = SXE2_IPSEC_SHA_DIGEST_MAX,
+						.increment = SXE2_IPSEC_SHA_DIGEST_INC
+					},
+					.iv_size = {
+						.min = SXE2_IPSEC_SHA_IV_MIN,
+						.max = SXE2_IPSEC_SHA_IV_MAX,
+						.increment = SXE2_IPSEC_SHA_IV_INC
+					},
+					.aad_size = {
+						.min = SXE2_IPSEC_AAD_MIN,
+						.max = SXE2_IPSEC_AAD_MAX,
+						.increment = SXE2_IPSEC_AAD_INC
+					}
+				}, }
+			}, }
+		},
+		{
+			.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+			{.sym = {
+				.xform_type = RTE_CRYPTO_SYM_XFORM_AUTH,
+				{.auth = {
+					.algo = SXE2_RTE_CRYPTO_AUTH_SM3_HMAC,
+					.block_size = SXE2_SECURITY_BLOCK_SIZE_64,
+					.key_size = {
+						.min = SXE2_IPSEC_SM3_KEY_MIN,
+						.max = SXE2_IPSEC_SM3_KEY_MAX,
+						.increment = SXE2_IPSEC_SM3_KEY_INC
+					},
+					.digest_size = {
+						.min = SXE2_IPSEC_SM3_DIGEST_MIN,
+						.max = SXE2_IPSEC_SM3_DIGEST_MAX,
+						.increment = SXE2_IPSEC_SM3_DIGEST_INC
+					},
+					.iv_size = {
+						.min = SXE2_IPSEC_SM3_IV_MIN,
+						.max = SXE2_IPSEC_SM3_IV_MAX,
+						.increment = SXE2_IPSEC_SM3_IV_INC
+					},
+					.aad_size = {
+						.min = SXE2_IPSEC_AAD_MIN,
+						.max = SXE2_IPSEC_AAD_MAX,
+						.increment = SXE2_IPSEC_AAD_INC
+					}
+				}, }
+			}, }
+		},
+		{
+			.op = RTE_CRYPTO_OP_TYPE_UNDEFINED,
+			{.sym = {
+				.xform_type = RTE_CRYPTO_SYM_XFORM_NOT_SPECIFIED
+			}, }
+		}
+	};
+
+	static const struct rte_security_capability
+	sxe2_security_capabilities[] = {
+		{
+			.action = RTE_SECURITY_ACTION_TYPE_INLINE_CRYPTO,
+			.protocol = RTE_SECURITY_PROTOCOL_IPSEC,
+			{.ipsec = {
+				.proto = RTE_SECURITY_IPSEC_SA_PROTO_ESP,
+				.mode = RTE_SECURITY_IPSEC_SA_MODE_TUNNEL,
+				.direction = RTE_SECURITY_IPSEC_SA_DIR_EGRESS,
+				.options = {
+					.esn = 0,
+					.udp_encap = 1,
+					.copy_dscp = 0,
+					.copy_flabel = 0,
+					.copy_df = 0,
+					.dec_ttl = 0,
+					.ecn = 0,
+					.stats = 1,
+					.iv_gen_disable = 0,
+					.tunnel_hdr_verify = 1,
+					.udp_ports_verify = 1,
+					.ip_csum_enable = 0,
+					.l4_csum_enable = 0,
+					.ip_reassembly_en = 0,
+					.ingress_oop = 0
+			} } },
+			.crypto_capabilities = ipsec_crypto_capabilities,
+			.ol_flags = RTE_SECURITY_TX_OLOAD_NEED_MDATA
+		},
+		{
+			.action = RTE_SECURITY_ACTION_TYPE_INLINE_CRYPTO,
+			.protocol = RTE_SECURITY_PROTOCOL_IPSEC,
+			{.ipsec = {
+				.proto = RTE_SECURITY_IPSEC_SA_PROTO_ESP,
+				.mode = RTE_SECURITY_IPSEC_SA_MODE_TUNNEL,
+				.direction = RTE_SECURITY_IPSEC_SA_DIR_INGRESS,
+				.options = {
+					.esn = 0,
+					.udp_encap = 1,
+					.copy_dscp = 0,
+					.copy_flabel = 0,
+					.copy_df = 0,
+					.dec_ttl = 0,
+					.ecn = 0,
+					.stats = 1,
+					.iv_gen_disable = 0,
+					.tunnel_hdr_verify = 1,
+					.udp_ports_verify = 1,
+					.ip_csum_enable = 0,
+					.l4_csum_enable = 0,
+					.ip_reassembly_en = 0,
+					.ingress_oop = 0
+			} } },
+			.crypto_capabilities = ipsec_crypto_capabilities,
+			.ol_flags = 0
+		},
+		{
+			.action = RTE_SECURITY_ACTION_TYPE_NONE
+		}
+	};
+
+	return sxe2_security_capabilities;
+}
+
+static struct rte_security_ops sxe2_security_ops = {
+	.session_get_size		= sxe2_security_session_size_get,
+	.session_create			= sxe2_security_session_create,
+	.session_destroy		= sxe2_security_session_destroy,
+	.set_pkt_metadata		= sxe2_security_pkt_metadata_set,
+	.capabilities_get		= sxe2_security_capabilities_get,
+};
+
+int32_t sxe2_security_init(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct rte_security_ctx *sctx = NULL;
+	struct sxe2_security_ctx *sxe2_sctx = &adapter->security_ctx;
+	int32_t ret = -1;
+
+	if (!sxe2_ipsec_supported(adapter)) {
+		ret = 0;
+		PMD_LOG_INFO(INIT, "Not support security feature.");
+		goto l_end;
+	}
+
+	PMD_LOG_INFO(INIT, "Init security feature.");
+
+	sctx = rte_zmalloc("security_ctx", sizeof(struct rte_security_ctx), 0);
+	if (sctx == NULL) {
+		ret = -ENOMEM;
+		goto l_end;
+	}
+
+	sctx->device = dev;
+	sctx->ops = &sxe2_security_ops;
+	sctx->sess_cnt = 0;
+	sctx->flags = 0;
+	dev->security_ctx = (void *)sctx;
+
+	rte_spinlock_init(&sxe2_sctx->security_lock);
+	sxe2_sctx->adapter = adapter;
+
+	if (sxe2_ipsec_supported(adapter)) {
+		ret = sxe2_ipsec_init(adapter);
+		if (ret) {
+			rte_free(sctx);
+			sctx = NULL;
+			dev->security_ctx = NULL;
+			goto l_end;
+		}
+	}
+
+	ret = 0;
+
+l_end:
+	return ret;
+}
+
+void sxe2_security_uinit(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct rte_security_ctx *sctx = dev->security_ctx;
+
+	if (!sxe2_ipsec_supported(adapter)) {
+		PMD_LOG_INFO(INIT, "Not support security feature.");
+		goto l_end;
+	}
+
+	PMD_LOG_INFO(INIT, "Uinit security feature.");
+
+	if (sctx != NULL) {
+		rte_free(sctx);
+		sctx = NULL;
+	}
+
+	sxe2_ipsec_uinit(adapter);
+
+l_end:
+	return;
+}
diff --git a/drivers/net/sxe2/sxe2_security.h b/drivers/net/sxe2/sxe2_security.h
new file mode 100644
index 0000000000..366c0614bd
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_security.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef __SXE2_SECURITY_H__
+#define __SXE2_SECURITY_H__
+
+#include <rte_security.h>
+#include <rte_cryptodev.h>
+#include <rte_security_driver.h>
+
+#include "sxe2_ipsec.h"
+
+#define SXE2_DEV_TO_SECURITY(eth) \
+	((struct rte_security_ctx *)(((struct rte_eth_dev *)eth)->security_ctx))
+
+#define SXE2_RTE_CRYPTO_CIPHER_AES_CBC   (RTE_CRYPTO_CIPHER_AES_CBC)
+
+#define SXE2_RTE_RTE_CRYPTO_CIPHER_SM4_CBC   (RTE_CRYPTO_CIPHER_SM4_CBC)
+
+#define SXE2_RTE_CRYPTO_AUTH_SHA256_HMAC  (RTE_CRYPTO_AUTH_SHA256_HMAC)
+
+#define SXE2_RTE_CRYPTO_AUTH_SM3_HMAC   (RTE_CRYPTO_AUTH_SM3_HMAC)
+
+enum sxe2_security_protocol {
+	SXE2_SECURITY_PROTOCOL_IPSEC       = 0,
+	SXE2_SECURITY_PROTOCOL_MAX         = 1,
+};
+
+enum sxe2_security_xform {
+	SXE2_SECURITY_IPSEC_EN       = 0,
+	SXE2_SECURITY_IPSEC_DE       = 1,
+	SXE2_SECURITY_NUM_MAX        = 2,
+};
+
+enum sxe2_security_block_size {
+	SXE2_SECURITY_BLOCK_SIZE_16        = 16,
+	SXE2_SECURITY_BLOCK_SIZE_64        = 64,
+};
+
+struct sxe2_security_ipsec_caps {
+	enum rte_security_ipsec_sa_protocol   proto;
+	enum rte_security_ipsec_sa_mode       mode;
+	struct rte_security_ipsec_sa_options  options;
+};
+
+struct sxe2_security_capabilities {
+	struct rte_cryptodev_capabilities     *crypto_capabilities;
+	enum rte_security_session_action_type action;
+	struct sxe2_security_ipsec_caps      ipsec;
+};
+
+struct sxe2_security_session {
+	struct sxe2_adapter                   *adapter;
+	struct sxe2_ipsec_pkt_metadata        pkt_metadata_template;
+	struct sxe2_ipsec_security_sa         sa;
+	struct sxe2_ipsec_esn                 esn;
+	struct sxe2_ipsec_udp                 udp_cap;
+	enum rte_security_session_protocol     protocol;
+	enum rte_security_ipsec_sa_direction   direction;
+	enum rte_security_ipsec_sa_mode        mode;
+	enum rte_security_ipsec_sa_protocol    sa_proto;
+	enum rte_security_ipsec_tunnel_type    type;
+};
+
+struct sxe2_security_ctx {
+	struct sxe2_adapter                 *adapter;
+	struct sxe2_security_capabilities   sxe2_capabilities[SXE2_SECURITY_PROTOCOL_MAX];
+	struct sxe2_ipsec_ctx               ipsec_ctx;
+	rte_spinlock_t                       security_lock;
+};
+
+int32_t sxe2_security_init(struct rte_eth_dev *dev);
+
+void sxe2_security_uinit(struct rte_eth_dev *dev);
+
+#endif /* __SXE2_SECURITY_H__ */
diff --git a/drivers/net/sxe2/sxe2_tx.c b/drivers/net/sxe2/sxe2_tx.c
index a280edc9c5..f49238ceef 100644
--- a/drivers/net/sxe2/sxe2_tx.c
+++ b/drivers/net/sxe2/sxe2_tx.c
@@ -304,6 +304,11 @@ int32_t __rte_cold sxe2_tx_queue_setup(struct rte_eth_dev *dev,
 	}
 
 	offloads = tx_conf->offloads | dev->data->dev_conf.txmode.offloads;
+	if (!sxe2_ipsec_valid_tx_offloads(offloads)) {
+		ret = -EINVAL;
+		goto end;
+	}
+
 	txq = sxe2_tx_queue_alloc(dev, queue_idx, nb_desc, socket_id);
 	if (txq == NULL) {
 		PMD_LOG_ERR(TX, "failed to alloc sxe2vf tx queue:%u resource", queue_idx);
@@ -327,6 +332,9 @@ int32_t __rte_cold sxe2_tx_queue_setup(struct rte_eth_dev *dev,
 	txq->ops               = sxe2_tx_default_ops_get();
 	txq->ops.queue_reset(txq);
 
+	if (sxe2_ipsec_supported(adapter) && txq->offloads & RTE_ETH_TX_OFFLOAD_SECURITY)
+		txq->ipsec_pkt_md_offset = sxe2_ipsec_pkt_md_offset_get(adapter);
+
 	dev->data->tx_queues[queue_idx] = txq;
 	ret = 0;
 
diff --git a/drivers/net/sxe2/sxe2_txrx_poll.c b/drivers/net/sxe2/sxe2_txrx_poll.c
index 3c6fe37404..8b6e585c36 100644
--- a/drivers/net/sxe2/sxe2_txrx_poll.c
+++ b/drivers/net/sxe2/sxe2_txrx_poll.c
@@ -307,6 +307,25 @@ static __rte_always_inline void sxe2_desc_tso_fill(struct rte_mbuf *tx_pkt,
 	return;
 }
 
+static __rte_always_inline void sxe2_desc_ipsec_fill(struct rte_mbuf *tx_pkt,
+			struct sxe2_tx_queue *txq, uint16_t *ipsec_offset,
+			uint64_t *desc_type_cmd_tso_mss)
+{
+	struct sxe2_ipsec_pkt_metadata *md = NULL;
+	uint16_t ipsec_pkt_md_offset = txq->ipsec_pkt_md_offset;
+
+	md = RTE_MBUF_DYNFIELD(tx_pkt, ipsec_pkt_md_offset, struct sxe2_ipsec_pkt_metadata *);
+	*ipsec_offset = md->esp_head_offset;
+	*desc_type_cmd_tso_mss |= SXE2_TX_CTXT_DESC_IPSEC_EN;
+	if (md->mode == SXE2_IPSEC_MODE_ONLY_ENCRYPT)
+		*desc_type_cmd_tso_mss |= SXE2_TX_CTXT_DESC_IPSEC_MODE;
+
+	if (md->algo == SXE2_IPSEC_ALGO_SM4_CBC_AND_SM3_96_HMAC)
+		*desc_type_cmd_tso_mss |= SXE2_TX_CTXT_DESC_IPSEC_ENGINE;
+
+	*desc_type_cmd_tso_mss |= (uint64_t)(md->sa_idx) << SXE2_TX_CTXT_DESC_IPSEC_SA_SHIFT;
+}
+
 static __rte_always_inline uint64_t
 sxe2_tx_data_desc_build_cobt(uint32_t cmd, uint32_t offset, uint16_t buf_size, uint16_t l2tag)
 {
@@ -426,6 +445,11 @@ uint16_t sxe2_tx_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkt
 			else if (offloads & RTE_MBUF_F_TX_IEEE1588_TMST)
 				desc_type_cmd_tso_mss |= SXE2_TX_CTXT_DESC_CMD_TSYN_MASK;
 
+			if (offloads & RTE_MBUF_F_TX_SEC_OFFLOAD) {
+				sxe2_desc_ipsec_fill(tx_pkt, txq, &ipsec_offset,
+						     &desc_type_cmd_tso_mss);
+			}
+
 			if (offloads & RTE_MBUF_F_TX_QINQ) {
 				desc_l2tag2 = tx_pkt->vlan_tci_outer;
 				desc_type_cmd_tso_mss |= SXE2_TX_CTXT_DESC_CMD_IL2TAG2_MASK;
@@ -786,6 +810,36 @@ static inline void sxe2_rx_desc_ptp_para_fill(struct sxe2_rx_queue *rxq,
 			     rxq->ts_low);
 	}
 }
+
+static inline void sxe2_rx_desc_ipsec_para_fill(struct sxe2_rx_queue *rxq __rte_unused,
+		struct rte_mbuf *mbuf, union sxe2_rx_desc *desc)
+{
+	uint32_t status_lrocnt_fdpf_id = rte_le_to_cpu_32(desc->wb.status_lrocnt_fdpf_id);
+	enum sxe2_rx_desc_ipsec_status ipsec_status;
+
+	if (status_lrocnt_fdpf_id & SXE2_RX_DESC_IPSEC_PKT_MASK) {
+		mbuf->ol_flags |= RTE_MBUF_F_RX_SEC_OFFLOAD;
+		ipsec_status = SXE2_RX_DESC_IPSEC_STATUS_VAL_GET(status_lrocnt_fdpf_id);
+		switch (ipsec_status) {
+		case SXE2_RX_DESC_IPSEC_STATUS_SUCCESS:
+			break;
+		case SXE2_RX_DESC_IPSEC_STATUS_PKG_OVER_2K:
+		case SXE2_RX_DESC_IPSEC_STATUS_SPI_IP_INVALID:
+		case SXE2_RX_DESC_IPSEC_STATUS_SA_INVALID:
+		case SXE2_RX_DESC_IPSEC_STATUS_NOT_ALIGN:
+		case SXE2_RX_DESC_IPSEC_STATUS_ICV_ERROR:
+		case SXE2_RX_DESC_IPSEC_STATUS_BY_PASSH:
+		case SXE2_RX_DESC_IPSEC_STATUS_MAC_BY_PASSH:
+			PMD_LOG_INFO(RX, "IPsec status error:%d", ipsec_status);
+			mbuf->ol_flags |= RTE_MBUF_F_RX_SEC_OFFLOAD_FAILED;
+			break;
+		default:
+			PMD_LOG_INFO(RX, "Invalid ipsec status:%d", ipsec_status);
+			mbuf->ol_flags |= RTE_MBUF_F_RX_SEC_OFFLOAD_FAILED;
+			break;
+		}
+	}
+}
 #endif
 
 static __rte_always_inline void
@@ -803,6 +857,7 @@ sxe2_rx_mbuf_common_fields_fill(struct sxe2_rx_queue *rxq, struct rte_mbuf *mbuf
 	sxe2_rx_desc_vlan_para_fill(mbuf, rxd);
 	sxe2_rx_desc_filter_para_fill(rxq, mbuf, rxd);
 #ifndef RTE_LIBRTE_SXE2_16BYTE_RX_DESC
+	sxe2_rx_desc_ipsec_para_fill(rxq, mbuf, rxd);
 	sxe2_rx_desc_ptp_para_fill(rxq, mbuf, rxd);
 #endif
 
-- 
2.47.3

