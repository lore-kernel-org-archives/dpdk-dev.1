Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC28DCD5BAB
	for <dpdk-dev@archiver.kernel.org>; Sun, 24 May 2026 09:34:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9EBC240A4B;
	Sun, 24 May 2026 11:33:22 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 699A0402A3
 for <dev@dpdk.org>; Sun, 24 May 2026 11:33:10 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowABXd97QxRJq+04kEg--.9115S14;
 Sun, 24 May 2026 17:33:08 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v1 12/23] net/sxe2: add support for custom UDP tunnel ports
Date: Sun, 24 May 2026 17:32:48 +0800
Message-ID: <20260524093259.397506-13-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260524093259.397506-1-liujie5@linkdatatechnology.com>
References: <20260524093259.397506-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABXd97QxRJq+04kEg--.9115S14
X-Coremail-Antispam: 1UD129KBjvAXoWfAFWxGryUKrW7uw1rZrW3Awb_yoW5WFyUGo
 WxGrWrX3WfA342vay8Xr18CrW7X3y5Wwn3Kanaga1DWasrAryjkFn3Ww17XanrWF4SkFn8
 u3Wxu397Gr47Gr98n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYK7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
 Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
 84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F
 4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4U
 JwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
 IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
 M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24l42
 xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
 GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI4
 8JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4U
 MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I
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

This patch enables the configuration of custom UDP port numbers for
tunneling protocols in the SXE2 PMD.

The change includes:
- Adding a new entry in the tunnel port lookup table.
- Updating the hardware profile to recognize
  the custom UDP port as a tunnel type.
- Enabling inner header parsing for packets arriving on these ports.

This allows the Switch module to correctly apply recipes based on
inner packet fields (e.g., inner MAC or IP).

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_cmd_chnl.c           |  96 ++++++++++
 drivers/net/sxe2/sxe2_cmd_chnl.h           |  17 ++
 drivers/net/sxe2/sxe2_drv_cmd.h            |  16 ++
 drivers/net/sxe2/sxe2_ethdev.c             | 206 ++++++++++++++++++++-
 drivers/net/sxe2/sxe2_ethdev.h             |  12 ++
 drivers/net/sxe2/sxe2_flow.c               |  54 ++++++
 drivers/net/sxe2/sxe2_flow.h               |   3 +-
 drivers/net/sxe2/sxe2_flow_define.h        |   1 +
 drivers/net/sxe2/sxe2_flow_parse_pattern.c | 113 +++++++++++
 drivers/net/sxe2/sxe2_flow_parse_pattern.h |   6 +
 drivers/net/sxe2/sxe2_txrx_poll.c          |  46 ++++-
 11 files changed, 566 insertions(+), 4 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.c b/drivers/net/sxe2/sxe2_cmd_chnl.c
index 6e2dd139a5..926eaee062 100644
--- a/drivers/net/sxe2/sxe2_cmd_chnl.c
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.c
@@ -1455,6 +1455,102 @@ int32_t sxe2_drv_ipsec_txsa_delete(struct sxe2_adapter *adapter,
 	return ret;
 }
 
+int32_t sxe2_drv_udp_tunnel_add(struct sxe2_adapter *adapter,
+			    enum sxe2_udp_tunnel_protocol tunnel_proto,
+			    uint16_t udp_port)
+{
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_udp_tunnel_req req = {};
+	struct sxe2_drv_cmd_params cmd = {};
+	int32_t ret = -1;
+
+	req.type = tunnel_proto;
+	req.port = udp_port;
+	sxe2_drv_cmd_params_fill(adapter, &cmd, SXE2_DRV_CMD_UDPTUNNEL_ADD,
+				 &req, sizeof(req),
+				 NULL, 0);
+	ret = sxe2_drv_cmd_exec(cdev, &cmd);
+	if (ret)
+		PMD_LOG_ERR(DRV, "Failed to add udp proto %d port %d, ret=%d",
+				tunnel_proto, udp_port, ret);
+
+	return ret;
+}
+
+int32_t sxe2_drv_udp_tunnel_del(struct sxe2_adapter *adapter,
+			    enum sxe2_udp_tunnel_protocol tunnel_proto,
+			    uint16_t udp_port)
+{
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_udp_tunnel_req req = {};
+	struct sxe2_drv_cmd_params cmd = {};
+	int32_t ret = -1;
+
+	req.type = tunnel_proto;
+	req.port = udp_port;
+	sxe2_drv_cmd_params_fill(adapter, &cmd, SXE2_DRV_CMD_UDPTUNNEL_DEL,
+				 &req, sizeof(req),
+				 NULL, 0);
+	ret = sxe2_drv_cmd_exec(cdev, &cmd);
+	if (ret)
+		PMD_LOG_ERR(DRV, "Failed to del udp proto %d port %d, ret=%d",
+				tunnel_proto, udp_port, ret);
+
+	return ret;
+}
+
+int32_t sxe2_drv_get_udp_tunnel_port(struct sxe2_adapter *adapter,
+				 enum sxe2_flow_udp_tunnel_protocol proto,
+				 uint16_t *port)
+{
+	int32_t ret = 0;
+	static const uint16_t flow_proto_to_udp_tunnel_proto[SXE2_FLOW_UDP_TUNNEL_MAX] = {
+		[SXE2_FLOW_UDP_TUNNEL_PROTOCOL_VXLAN] = SXE2_UDP_TUNNEL_PROTOCOL_VXLAN,
+		[SXE2_FLOW_UDP_TUNNEL_PROTOCOL_VXLAN_GPE] = SXE2_UDP_TUNNEL_PROTOCOL_VXLAN_GPE,
+		[SXE2_FLOW_UDP_TUNNEL_PROTOCOL_GENEVE] = SXE2_UDP_TUNNEL_PROTOCOL_GENEVE,
+		[SXE2_FLOW_UDP_TUNNEL_PROTOCOL_GTP_U] = SXE2_UDP_TUNNEL_PROTOCOL_GTP_U,
+		[SXE2_FLOW_UDP_TUNNEL_PROTOCOL_NVGRE] = SXE2_UDP_TUNNEL_PROTOCOL_NVGRE,
+	};
+	struct sxe2_udp_tunnel_cfg tunnel_config = {};
+
+	tunnel_config.protocol = flow_proto_to_udp_tunnel_proto[proto];
+	ret = sxe2_drv_udp_tunnel_get(adapter, &tunnel_config);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to get udp tunnel port, ret=%d", ret);
+		goto l_end;
+	}
+
+	*port = tunnel_config.fw_port;
+l_end:
+	return ret;
+}
+
+int32_t sxe2_drv_udp_tunnel_get(struct sxe2_adapter *adapter,
+			    struct sxe2_udp_tunnel_cfg *tunnel_config)
+{
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_udp_tunnel_req req = {};
+	struct sxe2_drv_udp_tunnel_resp resp = {};
+	struct sxe2_drv_cmd_params cmd = {};
+	int32_t ret = -1;
+
+	req.type = tunnel_config->protocol;
+	sxe2_drv_cmd_params_fill(adapter, &cmd, SXE2_DRV_CMD_UDPTUNNEL_GET,
+				 &req, sizeof(req),
+				 &resp, sizeof(resp));
+	ret = sxe2_drv_cmd_exec(cdev, &cmd);
+	if (ret)
+		PMD_LOG_ERR(DRV, "Failed to get udp proto %d port, ret=%d", req.type, ret);
+
+	tunnel_config->fw_port   = resp.port;
+	tunnel_config->fw_status = resp.enable;
+	tunnel_config->fw_dst_en = resp.dst;
+	tunnel_config->fw_src_en = resp.src;
+	tunnel_config->fw_used   = resp.fw_used;
+
+	return ret;
+}
+
 int32_t sxe2_drv_queue_info_get_update(struct sxe2_adapter *adapter, struct eth_queue_stats *qstats)
 {
 	struct sxe2_drv_cmd_params param = {0};
diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.h b/drivers/net/sxe2/sxe2_cmd_chnl.h
index d505f93dc1..43f28c8304 100644
--- a/drivers/net/sxe2/sxe2_cmd_chnl.h
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.h
@@ -67,6 +67,23 @@ int32_t sxe2_drv_ipsec_txsa_delete(struct sxe2_adapter *adapter,
 
 int32_t sxe2_drv_promisc_config(struct sxe2_adapter *adapter, bool set);
 
+int32_t sxe2_drv_udp_tunnel_add(struct sxe2_adapter *adapter,
+			    enum sxe2_udp_tunnel_protocol tunnel_proto,
+			    uint16_t udp_port);
+
+int32_t sxe2_drv_udp_tunnel_del(struct sxe2_adapter *adapter,
+			    enum sxe2_udp_tunnel_protocol tunnel_proto,
+			    uint16_t udp_port);
+
+int32_t sxe2_drv_udp_tunnel_get(struct sxe2_adapter *adapter,
+			    struct sxe2_udp_tunnel_cfg *tunnel_config);
+
+int32_t sxe2_drv_get_udp_tunnel_port(struct sxe2_adapter *adapter,
+				 enum sxe2_flow_udp_tunnel_protocol proto,
+				 uint16_t *port);
+
+int32_t sxe2_drv_vsi_info_get(struct sxe2_adapter *adapter, struct sxe2_vsi *vsi);
+
 int32_t sxe2_drv_vsi_info_get(struct sxe2_adapter *adapter, struct sxe2_vsi *vsi);
 
 int32_t sxe2_drv_mac_link_status_get(struct sxe2_adapter *adapter);
diff --git a/drivers/net/sxe2/sxe2_drv_cmd.h b/drivers/net/sxe2/sxe2_drv_cmd.h
index 48c012367c..5b5ddf9960 100644
--- a/drivers/net/sxe2/sxe2_drv_cmd.h
+++ b/drivers/net/sxe2/sxe2_drv_cmd.h
@@ -261,6 +261,22 @@ struct sxe2_drv_vsi_info_get_resp {
 	struct sxe2_drv_msix_caps used_msix;
 };
 
+struct sxe2_drv_udp_tunnel_req {
+	uint8_t type;
+	uint8_t rsv;
+	uint16_t port;
+};
+
+struct sxe2_drv_udp_tunnel_resp {
+	uint8_t type;
+	uint8_t enable;
+	uint8_t dst;
+	uint8_t src;
+	uint16_t port;
+	uint8_t fw_used;
+	uint8_t rsv;
+};
+
 struct sxe2_drv_link_info_resp {
 	uint32_t speed;
 	uint8_t status;
diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
index 317101fb60..14c8f6c16d 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -40,10 +40,11 @@
 #include "sxe2_ioctl_chnl_func.h"
 #include "sxe2_ethdev_repr.h"
 #include "sxe2vf_regs.h"
+#include "sxe2_switchdev.h"
 
 #define SXE2_PCI_VENDOR_ID_1    0x1ff2
 #define SXE2_PCI_DEVICE_ID_PF_1 0x10b1
-#define SXE2_PCI_DEVICE_ID_VF_1 0x10b2
+#define SXE2_PCI_DEVICE_ID_VF_1 0x10b
 
 #define SXE2_PCI_VENDOR_ID_2    0x1d94
 #define SXE2_PCI_DEVICE_ID_PF_2 0x1260
@@ -115,6 +116,11 @@ static int32_t sxe2_dev_close(struct rte_eth_dev *dev);
 static int32_t sxe2_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info);
 static const uint32_t *sxe2_buffer_split_supported_hdr_ptypes_get(struct rte_eth_dev *dev
 				__rte_unused, size_t *no_of_elements __rte_unused);
+static int32_t sxe2_udp_tunnel_port_add(struct rte_eth_dev *dev,
+					struct rte_eth_udp_tunnel *tunnel_udp);
+static int32_t sxe2_udp_tunnel_port_del(struct rte_eth_dev *dev,
+					struct rte_eth_udp_tunnel *tunnel_udp);
+
 
 static const struct eth_dev_ops sxe2_eth_dev_ops = {
 	.dev_configure              = sxe2_dev_configure,
@@ -162,6 +168,9 @@ static const struct eth_dev_ops sxe2_eth_dev_ops = {
 	.rss_hash_update            = sxe2_dev_rss_hash_update,
 	.rss_hash_conf_get          = sxe2_dev_rss_hash_conf_get,
 
+	.udp_tunnel_port_add        = sxe2_udp_tunnel_port_add,
+	.udp_tunnel_port_del        = sxe2_udp_tunnel_port_del,
+
 	.flow_ops_get               = sxe2_flow_ops_get,
 	.tm_ops_get                 = sxe2_tm_ops_get,
 
@@ -226,6 +235,12 @@ static int32_t sxe2_dev_start(struct rte_eth_dev *dev)
 	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
 	PMD_INIT_FUNC_TRACE();
 
+	ret = sxe2_flow_init_udp_tunnel_port(dev);
+	if (ret) {
+		PMD_LOG_ERR(DRV, "Failed to init udp tunnel port, ret: %d.", ret);
+		goto l_end;
+	}
+
 	ret = sxe2_queues_init(dev);
 	if (ret) {
 		PMD_LOG_ERR(INIT, "Failed to init queues.");
@@ -271,6 +286,188 @@ static int32_t sxe2_dev_start(struct rte_eth_dev *dev)
 	return ret;
 }
 
+static enum sxe2_udp_tunnel_protocol
+sxe2_udp_tunnel_type_rte_to_sxe2(enum rte_eth_tunnel_type rte_type)
+{
+	static enum sxe2_udp_tunnel_protocol sxe2_udp_proto_map[RTE_ETH_TUNNEL_TYPE_MAX] = {
+		[RTE_ETH_TUNNEL_TYPE_NONE] = SXE2_UDP_TUNNEL_MAX,
+		[RTE_ETH_TUNNEL_TYPE_VXLAN] = SXE2_UDP_TUNNEL_PROTOCOL_VXLAN,
+		[RTE_ETH_TUNNEL_TYPE_GENEVE] = SXE2_UDP_TUNNEL_PROTOCOL_GENEVE,
+		[RTE_ETH_TUNNEL_TYPE_TEREDO] = SXE2_UDP_TUNNEL_PROTOCOL_TEREDO,
+		[RTE_ETH_TUNNEL_TYPE_NVGRE] = SXE2_UDP_TUNNEL_PROTOCOL_NVGRE,
+		[RTE_ETH_TUNNEL_TYPE_IP_IN_GRE] = SXE2_UDP_TUNNEL_MAX,
+		[RTE_ETH_L2_TUNNEL_TYPE_E_TAG] = SXE2_UDP_TUNNEL_MAX,
+		[RTE_ETH_TUNNEL_TYPE_VXLAN_GPE] = SXE2_UDP_TUNNEL_PROTOCOL_VXLAN_GPE,
+		[RTE_ETH_TUNNEL_TYPE_ECPRI]  = SXE2_UDP_TUNNEL_PROTOCOL_ECPRI
+	};
+
+	if (rte_type >= RTE_ETH_TUNNEL_TYPE_MAX) {
+		PMD_LOG_ERR(DRV, "Invalid rte_eth_tunnel_type %d!", rte_type);
+		rte_type = RTE_ETH_TUNNEL_TYPE_NONE;
+	}
+
+	return sxe2_udp_proto_map[rte_type];
+}
+
+int32_t sxe2_udp_tunnel_port_add_common(struct sxe2_adapter *ad,
+				    enum sxe2_udp_tunnel_protocol tunnel_proto,
+				    uint16_t udp_port)
+{
+	struct sxe2_udp_tunnel_cfg *tunnel_config;
+	int32_t ret = -1;
+
+	rte_spinlock_lock(&ad->udp_tunnel_ctx.lock);
+
+	tunnel_config = &ad->udp_tunnel_ctx.tunnel_conf[tunnel_proto];
+
+	if (tunnel_config->dev_status == SXE2_UDP_TUNNEL_ENABLE) {
+		if (udp_port == tunnel_config->dev_port &&
+			tunnel_config->dev_ref_cnt < 0xFFFFU) {
+			tunnel_config->dev_ref_cnt++;
+			ret = 0;
+			goto l_unlock_end;
+		} else {
+			PMD_LOG_ERR(DRV, "Adding multiple ports to the same protocol "
+				    "is not supported!");
+			ret = -EINVAL;
+			goto l_unlock_end;
+		}
+	} else {
+		ret = sxe2_drv_udp_tunnel_add(ad, tunnel_proto, udp_port);
+		if (ret != 0)
+			goto l_unlock_end;
+
+		tunnel_config->protocol = tunnel_proto;
+		tunnel_config->dev_port = udp_port;
+		tunnel_config->dev_status  = SXE2_UDP_TUNNEL_ENABLE;
+		tunnel_config->dev_ref_cnt++;
+	}
+
+l_unlock_end:
+	rte_spinlock_unlock(&ad->udp_tunnel_ctx.lock);
+	return ret;
+}
+
+int32_t sxe2_udp_tunnel_port_del_common(struct sxe2_adapter *ad,
+				    enum sxe2_udp_tunnel_protocol tunnel_proto,
+				    uint16_t udp_port)
+{
+	struct sxe2_udp_tunnel_cfg *tunnel_config;
+	int32_t ret = -1;
+
+	rte_spinlock_lock(&ad->udp_tunnel_ctx.lock);
+	tunnel_config = &ad->udp_tunnel_ctx.tunnel_conf[tunnel_proto];
+
+	if (tunnel_config->dev_status == SXE2_UDP_TUNNEL_ENABLE &&
+		udp_port == tunnel_config->dev_port) {
+		if (tunnel_config->dev_ref_cnt > 1) {
+			tunnel_config->dev_ref_cnt--;
+			ret = 0;
+			goto l_unlock_end;
+		} else {
+			ret = sxe2_drv_udp_tunnel_del(ad, tunnel_proto, udp_port);
+			if (ret != 0)
+				goto l_unlock_end;
+
+			tunnel_config->dev_status  = SXE2_UDP_TUNNEL_DISABLE;
+			tunnel_config->dev_ref_cnt = 0;
+		}
+		goto l_unlock_end;
+	}
+
+	ret = -EINVAL;
+
+l_unlock_end:
+	rte_spinlock_unlock(&ad->udp_tunnel_ctx.lock);
+	return ret;
+}
+
+int32_t sxe2_udp_tunnel_port_get_common(struct sxe2_adapter *ad,
+				    struct sxe2_udp_tunnel_cfg *tunnel_config)
+{
+	return sxe2_drv_udp_tunnel_get(ad, tunnel_config);
+}
+
+static int32_t sxe2_udp_tunnel_port_clear(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *ad = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_udp_tunnel_cfg *tunnel_config;
+	int32_t ret = 0;
+	uint16_t tunnel_proto = 0;
+
+	rte_spinlock_lock(&ad->udp_tunnel_ctx.lock);
+
+	for (tunnel_proto = 0; tunnel_proto < SXE2_UDP_TUNNEL_MAX; tunnel_proto++) {
+		tunnel_config = &ad->udp_tunnel_ctx.tunnel_conf[tunnel_proto];
+		if (tunnel_config->dev_status == SXE2_UDP_TUNNEL_ENABLE) {
+			ret = sxe2_drv_udp_tunnel_del(ad, tunnel_config->protocol,
+					tunnel_config->dev_port);
+			if (ret) {
+				PMD_LOG_ERR(DRV, "Failed to delete udp tunnel port %d, proto %d",
+					    tunnel_config->dev_port, tunnel_config->protocol);
+				goto l_unlock_end;
+			}
+
+			tunnel_config->dev_status  = SXE2_UDP_TUNNEL_DISABLE;
+			tunnel_config->dev_ref_cnt = 0;
+		}
+	}
+l_unlock_end:
+	rte_spinlock_unlock(&ad->udp_tunnel_ctx.lock);
+	return ret;
+}
+
+static int32_t sxe2_udp_tunnel_port_add(struct rte_eth_dev *dev,
+			struct rte_eth_udp_tunnel *tunnel_udp)
+{
+	int32_t ret = 0;
+	enum sxe2_udp_tunnel_protocol tunnel_proto;
+	struct sxe2_adapter *ad = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+
+	if (tunnel_udp->udp_port == 0) {
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	tunnel_proto = sxe2_udp_tunnel_type_rte_to_sxe2(tunnel_udp->prot_type);
+	if (tunnel_proto >= SXE2_UDP_TUNNEL_MAX) {
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	ret = sxe2_udp_tunnel_port_add_common(ad, tunnel_proto, tunnel_udp->udp_port);
+	if (ret) {
+		PMD_LOG_ERR(DRV, "Add tunnel port failed, ret = %d", ret);
+		goto l_end;
+	}
+
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_udp_tunnel_port_del(struct rte_eth_dev *dev,
+			struct rte_eth_udp_tunnel *tunnel_udp)
+{
+	int32_t ret = 0;
+	enum sxe2_udp_tunnel_protocol tunnel_proto;
+	struct sxe2_adapter *ad = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+
+	tunnel_proto = sxe2_udp_tunnel_type_rte_to_sxe2(tunnel_udp->prot_type);
+	if (tunnel_proto >= SXE2_UDP_TUNNEL_MAX) {
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	ret = sxe2_udp_tunnel_port_del_common(ad, tunnel_proto, tunnel_udp->udp_port);
+	if (ret) {
+		PMD_LOG_ERR(DRV, "Delete tunnel port failed, ret = %d", ret);
+		goto l_end;
+	}
+
+l_end:
+	return ret;
+}
+
 static int32_t sxe2_dev_infos_get(struct rte_eth_dev *dev,
 			struct rte_eth_dev_info *dev_info)
 {
@@ -1300,15 +1497,20 @@ static int32_t sxe2_dev_close(struct rte_eth_dev *dev)
 	(void)sxe2_dev_stop(dev);
 	(void)sxe2_queues_release(dev);
 	sxe2_mp_uninit(dev);
-	(void)sxe2_rss_disable(dev);
 	(void)sxe2_sched_uinit(dev);
+	(void)sxe2_rss_disable(dev);
+	(void)sxe2_flow_uninit(dev);
+	(void)sxe2_udp_tunnel_port_clear(dev);
 	sxe2_vsi_uninit(dev);
 	sxe2_security_uinit(dev);
 	sxe2_intr_uninit(dev);
 	(void)sxe2_switchdev_uninit(dev);
 	sxe2_sw_uninit(dev);
+	(void)sxe2_switchdev_uninit(dev);
+	sxe2_dev_pci_map_uinit(dev);
 	sxe2_eth_uinit(dev);
 	sxe2_dev_pci_map_uinit(dev);
+	sxe2_free_repr_info(dev);
 
 l_end:
 	return 0;
diff --git a/drivers/net/sxe2/sxe2_ethdev.h b/drivers/net/sxe2/sxe2_ethdev.h
index 6397a2e5c6..d6c6a152e7 100644
--- a/drivers/net/sxe2/sxe2_ethdev.h
+++ b/drivers/net/sxe2/sxe2_ethdev.h
@@ -318,6 +318,7 @@ struct sxe2_adapter {
 	struct sxe2_sched_hw_cap      sched_ctxt;
 	struct sxe2_tm_context        tm_ctxt;
 	struct sxe2_devargs           devargs;
+	struct sxe2_udp_tunnel_ctx    udp_tunnel_ctx;
 	struct sxe2_security_ctx      security_ctx;
 	struct sxe2_repr_context      repr_ctxt;
 	struct sxe2_switchdev_info    switchdev_info;
@@ -373,6 +374,17 @@ void sxe2_dev_pci_seg_unmap(struct sxe2_adapter *adapter, uint32_t res_type);
 
 int32_t sxe2_dev_pci_map_init(struct rte_eth_dev *dev);
 
+void sxe2_dev_pci_seg_unmap(struct sxe2_adapter *adapter, uint32_t res_type);
+
+int32_t sxe2_udp_tunnel_port_get_common(struct sxe2_adapter *ad,
+		struct sxe2_udp_tunnel_cfg *tunnel_config);
+
+int32_t sxe2_udp_tunnel_port_del_common(struct sxe2_adapter *ad,
+		enum sxe2_udp_tunnel_protocol tunnel_proto, uint16_t udp_port);
+
+int32_t sxe2_udp_tunnel_port_add_common(struct sxe2_adapter *ad,
+		enum sxe2_udp_tunnel_protocol tunnel_proto, uint16_t udp_port);
+
 void sxe2_dev_pci_map_uinit(struct rte_eth_dev *dev);
 
 void sxe2_eth_uinit(struct rte_eth_dev *dev);
diff --git a/drivers/net/sxe2/sxe2_flow.c b/drivers/net/sxe2/sxe2_flow.c
index 6999cb0725..63cfc36968 100644
--- a/drivers/net/sxe2/sxe2_flow.c
+++ b/drivers/net/sxe2/sxe2_flow.c
@@ -523,6 +523,51 @@ static int32_t sxe2_flow_adjust_action(struct rte_eth_dev *dev __rte_unused,
 	return ret;
 }
 
+int32_t sxe2_flow_init_udp_tunnel_port(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	int32_t ret = 0;
+	uint16_t i = 0;
+	uint16_t *flow_udp_tunnel_port = NULL;
+
+	memset(adapter->flow_ctxt.tunnel_port_list, 0,
+	       sizeof(adapter->flow_ctxt.tunnel_port_list));
+
+	flow_udp_tunnel_port = adapter->flow_ctxt.tunnel_port_list;
+	for (i = 0; i < SXE2_FLOW_UDP_TUNNEL_MAX; i++) {
+		if (flow_udp_tunnel_port[i] == 0) {
+			ret = sxe2_drv_get_udp_tunnel_port(adapter, i,
+							   &flow_udp_tunnel_port[i]);
+			if (ret != 0) {
+				PMD_LOG_ERR(DRV, "Failed to get udp tunnel port, proto: %d,"
+					    "ret: %d", i, ret);
+				goto l_end;
+			}
+		}
+	}
+
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_flowlist_add_tunnel_port(struct rte_eth_dev *dev,
+			struct rte_flow *flow_list,
+			struct rte_flow_error *error)
+{
+	struct sxe2_flow_list_t *sxe2_flow_list = &flow_list->sxe2_flow_list;
+	struct sxe2_flow *flow = TAILQ_FIRST(sxe2_flow_list);
+	enum sxe2_flow_tunnel_type tunnel_type = flow->meta.tunnel_type;
+	DECLARE_BITMAP(flow_type, SXE2_EXPANSION_MAX);
+	sxe2_bitmap_zero(flow_type, SXE2_EXPANSION_MAX);
+	sxe2_bitmap_copy(flow_type, flow->flow_type, SXE2_EXPANSION_MAX);
+	int32_t ret = 0;
+
+	if (flow->engine_type == SXE2_FLOW_ENGINE_FNAV)
+		return sxe2_flow_add_tunnel_port(dev, error, flow, flow_type, tunnel_type);
+
+	return ret;
+}
+
 static int32_t sxe2_flow_check_item_empty(uint8_t *item, uint16_t size)
 {
 	uint16_t i = 0;
@@ -679,6 +724,10 @@ static int32_t sxe2_flow_post_proc(struct rte_eth_dev *dev,
 {
 	int32_t ret = 0;
 
+	ret = sxe2_flowlist_add_tunnel_port(dev, flow_list, error);
+	if (ret)
+		goto l_end;
+
 	ret = sxe2_flowlist_add_proto_type(dev, flow_list, error);
 	if (ret)
 		goto l_end;
@@ -1308,6 +1357,11 @@ int32_t sxe2_flow_init(struct rte_eth_dev *dev)
 
 	adapter->flow_ctxt.fnav_inited = 1;
 	rte_spinlock_init(&adapter->flow_ctxt.flow_list_lock);
+
+	ret = sxe2_flow_init_udp_tunnel_port(dev);
+	if (ret)
+		PMD_LOG_ERR(DRV, "Failed to init udp tunnel port, ret: %d.", ret);
+
 	return ret;
 }
 
diff --git a/drivers/net/sxe2/sxe2_flow.h b/drivers/net/sxe2/sxe2_flow.h
index 9970fddcf0..daaeedd4dc 100644
--- a/drivers/net/sxe2/sxe2_flow.h
+++ b/drivers/net/sxe2/sxe2_flow.h
@@ -8,7 +8,6 @@
 #include "sxe2_osal.h"
 #include "sxe2_common.h"
 
-
 int32_t sxe2_flow_ops_get(struct rte_eth_dev *dev, const struct rte_flow_ops **ops);
 
 int32_t sxe2_flow_init(struct rte_eth_dev *dev);
@@ -26,4 +25,6 @@ int32_t sxe2_flow_query_mgr(struct sxe2_adapter *adapter,
 			struct sxe2_flow *flow,
 			struct sxe2_fnav_cid_mgr **mgr_ptr,
 			struct rte_flow_error *error);
+
+int32_t sxe2_flow_init_udp_tunnel_port(struct rte_eth_dev *dev);
 #endif /* __SXE2_FLOW_H__ */
diff --git a/drivers/net/sxe2/sxe2_flow_define.h b/drivers/net/sxe2/sxe2_flow_define.h
index d2f6000efa..263a573f04 100644
--- a/drivers/net/sxe2/sxe2_flow_define.h
+++ b/drivers/net/sxe2/sxe2_flow_define.h
@@ -119,6 +119,7 @@ struct sxe2_flow_context {
 	struct rte_flow_list_t rte_flow_list;
 	rte_spinlock_t flow_list_lock;
 	struct sxe2_fnav_count_resource hw_res;
+	uint16_t tunnel_port_list[SXE2_FLOW_UDP_TUNNEL_MAX];
 	uint32_t fnav_inited;
 };
 #define SXE2_INVALID_RSS_ATTR	\
diff --git a/drivers/net/sxe2/sxe2_flow_parse_pattern.c b/drivers/net/sxe2/sxe2_flow_parse_pattern.c
index 189abb1a33..f5bf8922c6 100644
--- a/drivers/net/sxe2/sxe2_flow_parse_pattern.c
+++ b/drivers/net/sxe2/sxe2_flow_parse_pattern.c
@@ -1637,6 +1637,119 @@ static int32_t sxe2_flow_parse_pattern_vxlan_gpe(const struct rte_flow_item *ite
 	return ret;
 }
 
+static int32_t sxe2_flow_parse_pattern_ipip(struct sxe2_flow *flow, BITMAP_TYPE *flow_type)
+{
+	sxe2_set_bit(SXE2_EXPANSION_IPIP, flow_type);
+	if (sxe2_test_bit(SXE2_EXPANSION_OUTER_IPV4, flow_type)) {
+		sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV4_PROT, flow->pattern_outer.map_spec);
+		if (sxe2_test_bit(SXE2_EXPANSION_IPV4, flow_type))
+			flow->pattern_outer.item_spec.ipv4.protocol = SXE2_FLOW_IP_PROTOCOL_IPV4;
+		if (sxe2_test_bit(SXE2_EXPANSION_IPV6, flow_type))
+			flow->pattern_outer.item_spec.ipv4.protocol = SXE2_FLOW_IP_PROTOCOL_IPV6;
+	}
+	if (sxe2_test_bit(SXE2_EXPANSION_OUTER_IPV6, flow_type)) {
+		sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV6_PROT, flow->pattern_outer.map_spec);
+		if (sxe2_test_bit(SXE2_EXPANSION_ETH, flow_type)) {
+			flow->pattern_outer.item_spec.ipv6.nexthdr = SXE2_FLOW_IP_PROTOCOL_ETH;
+		} else {
+			if (sxe2_test_bit(SXE2_EXPANSION_IPV4, flow_type))
+				flow->pattern_outer.item_spec.ipv6.nexthdr =
+					SXE2_FLOW_IP_PROTOCOL_IPV4;
+			if (sxe2_test_bit(SXE2_EXPANSION_IPV6, flow_type))
+				flow->pattern_outer.item_spec.ipv6.nexthdr =
+					SXE2_FLOW_IP_PROTOCOL_IPV6;
+		}
+	}
+	return 0;
+}
+
+static int32_t sxe2_flow_add_udp_tunnel_port(struct sxe2_adapter *adapter,
+					 enum sxe2_flow_udp_tunnel_protocol proto,
+					 struct sxe2_flow *flow,
+					 BITMAP_TYPE *flow_type)
+{
+	int32_t ret = 0;
+	uint16_t tun_port;
+
+	tun_port = adapter->flow_ctxt.tunnel_port_list[proto];
+	if (tun_port == 0xffff || tun_port == 0) {
+		ret = -EINVAL;
+		PMD_LOG_ERR(DRV, "UDP tunnel port not initialized, proto: %d", proto);
+		goto l_end;
+	}
+	if (!sxe2_test_bit(SXE2_EXPANSION_OUTER_UDP, flow_type)) {
+		ret = -EINVAL;
+		PMD_LOG_ERR(DRV, "UDP must be over tunnel");
+		goto l_end;
+	}
+	sxe2_set_bit(SXE2_FLOW_FLD_ID_UDP_DST_PORT, flow->pattern_outer.map_spec);
+	flow->pattern_outer.item_spec.udp.dest = rte_cpu_to_be_16(tun_port);
+l_end:
+	return ret;
+}
+
+int32_t sxe2_flow_add_tunnel_port(struct rte_eth_dev *dev,
+			struct rte_flow_error *error,
+			struct sxe2_flow *flow, BITMAP_TYPE *flow_type,
+			enum sxe2_flow_tunnel_type tunnel_type)
+{
+	int32_t ret = 0;
+	enum sxe2_flow_udp_tunnel_protocol proto = SXE2_FLOW_UDP_TUNNEL_MAX;
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_flow_pattern *pattern = &flow->pattern_outer;
+	switch (tunnel_type) {
+	case SXE2_FLOW_TUNNEL_TYPE_VXLAN:
+		if (sxe2_test_bit(SXE2_EXPANSION_ETH, flow_type)) {
+			proto = SXE2_FLOW_UDP_TUNNEL_PROTOCOL_VXLAN;
+		} else if (sxe2_test_bit(SXE2_EXPANSION_IPV4, flow_type) ||
+			sxe2_test_bit(SXE2_EXPANSION_IPV6, flow_type)) {
+			proto = SXE2_FLOW_UDP_TUNNEL_PROTOCOL_VXLAN_GPE;
+		}
+		break;
+	case SXE2_FLOW_TUNNEL_TYPE_GTPU:
+		proto = SXE2_FLOW_UDP_TUNNEL_PROTOCOL_GTP_U;
+		break;
+	case SXE2_FLOW_TUNNEL_TYPE_GENEVE:
+		proto = SXE2_FLOW_UDP_TUNNEL_PROTOCOL_GENEVE;
+		break;
+	case SXE2_FLOW_TUNNEL_TYPE_GRE:
+		if (sxe2_test_bit(SXE2_EXPANSION_OUTER_UDP, flow_type)) {
+			proto = SXE2_FLOW_UDP_TUNNEL_PROTOCOL_NVGRE;
+		} else {
+			if (sxe2_test_bit(SXE2_EXPANSION_OUTER_IPV4, flow_type)) {
+				pattern->item_spec.ipv4.protocol = SXE2_FLOW_IP_PROTOCOL_GRE;
+				sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV4_PROT, pattern->map_spec);
+			}
+			if (sxe2_test_bit(SXE2_EXPANSION_OUTER_IPV6, flow_type)) {
+				pattern->item_spec.ipv6.nexthdr = SXE2_FLOW_IP_PROTOCOL_GRE;
+				sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV6_PROT, pattern->map_spec);
+			}
+		}
+		break;
+	case SXE2_FLOW_TUNNEL_TYPE_IPIP:
+		ret = sxe2_flow_parse_pattern_ipip(flow, flow_type);
+		break;
+	default:
+		break;
+	}
+	if (proto != SXE2_FLOW_UDP_TUNNEL_MAX) {
+		ret = sxe2_flow_add_udp_tunnel_port(adapter, proto, flow, flow_type);
+		if (ret != 0) {
+			rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ITEM,
+					NULL, "Failed to add udp port for tunnel.");
+			PMD_LOG_ERR(DRV, "Failed to add udp port for tunnel, ret %d.", ret);
+			goto l_end;
+		}
+	}
+	if (tunnel_type != SXE2_FLOW_TUNNEL_TYPE_NONE) {
+		if (!sxe2_test_bit(SXE2_EXPANSION_OUTER_UDP, flow_type))
+			sxe2_set_bit(SXE2_FLOW_HDR_IPV_OTHER, pattern->hdrs);
+	}
+l_end:
+	return ret;
+}
+
 struct sxe2_flow_parse_pattern_ops sxe2_flow_parse_pattern_list[] = {
 	[SXE2_EXPANSION_OUTER_ETH] = {
 		.is_inner = false,
diff --git a/drivers/net/sxe2/sxe2_flow_parse_pattern.h b/drivers/net/sxe2/sxe2_flow_parse_pattern.h
index 69d83a6ea6..8442c35cae 100644
--- a/drivers/net/sxe2/sxe2_flow_parse_pattern.h
+++ b/drivers/net/sxe2/sxe2_flow_parse_pattern.h
@@ -37,4 +37,10 @@ int32_t sxe2_flow_parse_pattern(struct rte_eth_dev *dev,
 			    struct rte_flow_error *error,
 			    struct sxe2_flow *flow);
 
+int32_t sxe2_flow_add_tunnel_port(struct rte_eth_dev *dev,
+			      struct rte_flow_error *error,
+			      struct sxe2_flow *flow,
+			      BITMAP_TYPE *flow_type,
+			      enum sxe2_flow_tunnel_type tunnel_type);
+
 #endif /* SXE2_FLOW_PARSE_PATTERN_H_ */
diff --git a/drivers/net/sxe2/sxe2_txrx_poll.c b/drivers/net/sxe2/sxe2_txrx_poll.c
index f3c4fa0d91..746f9cc2d5 100644
--- a/drivers/net/sxe2/sxe2_txrx_poll.c
+++ b/drivers/net/sxe2/sxe2_txrx_poll.c
@@ -234,6 +234,44 @@ sxe2_tx_pkt_data_desc_count(struct rte_mbuf *tx_pkt)
 	return count;
 }
 
+static __rte_always_inline void sxe2_tx_desc_tunneling_params_fill(uint64_t offloads,
+					union sxe2_tx_offload_info ol_info,
+					uint32_t *desc_tunneling_params)
+{
+	if (offloads & RTE_MBUF_F_TX_OUTER_IP_CKSUM)
+		*desc_tunneling_params |= SXE2_TX_CTXT_DESC_EIPT_IPV4;
+	else if (offloads & RTE_MBUF_F_TX_OUTER_IPV4)
+		*desc_tunneling_params |= SXE2_TX_CTXT_DESC_EIPT_IPV4_NO_CSUM;
+	else if (offloads & RTE_MBUF_F_TX_OUTER_IPV6)
+		*desc_tunneling_params |= SXE2_TX_CTXT_DESC_EIPT_IPV6;
+
+	*desc_tunneling_params |=
+			SXE2_TX_CTXT_DESC_EIPLEN_VAL(ol_info.outer_l3_len);
+	switch (offloads & RTE_MBUF_F_TX_TUNNEL_MASK) {
+	case RTE_MBUF_F_TX_TUNNEL_IPIP:
+		break;
+	case RTE_MBUF_F_TX_TUNNEL_VXLAN:
+	case RTE_MBUF_F_TX_TUNNEL_VXLAN_GPE:
+	case RTE_MBUF_F_TX_TUNNEL_GTP:
+	case RTE_MBUF_F_TX_TUNNEL_GENEVE:
+		*desc_tunneling_params |= SXE2_TX_CTXT_DESC_UDP_TUNNE;
+		break;
+	case RTE_MBUF_F_TX_TUNNEL_GRE:
+		*desc_tunneling_params |= SXE2_TX_CTXT_DESC_GRE_TUNNE;
+		break;
+	default:
+		PMD_LOG_ERR(TX, "Tunnel type [0x%" PRIx64 "] is not supported.",
+			    (uint64_t)(offloads & RTE_MBUF_F_TX_TUNNEL_MASK));
+		return;
+	}
+	*desc_tunneling_params |= SXE2_TX_CTXT_DESC_NATLEN_VAL(ol_info.l2_len);
+	if (!(*desc_tunneling_params & SXE2_TX_CTXT_DESC_EIPT_NONE) &&
+			(*desc_tunneling_params & SXE2_TX_CTXT_DESC_UDP_TUNNE) &&
+			(offloads & RTE_MBUF_F_TX_OUTER_UDP_CKSUM)) {
+		*desc_tunneling_params |= SXE2_TX_CTXT_DESC_L4T_CS_MASK;
+	}
+}
+
 static __rte_always_inline void
 sxe2_tx_desc_checksum_fill(uint64_t offloads, uint32_t *desc_cmd, uint32_t *desc_offset,
 		union sxe2_tx_offload_info ol_info)
@@ -414,7 +452,13 @@ uint16_t sxe2_tx_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkt
 			}
 		}
 
-		desc_offset |= SXE2_TX_DATA_DESC_MACLEN_VAL(ol_info.l2_len);
+		if ((offloads & RTE_MBUF_F_TX_TUNNEL_MASK) && ctxt_desc_num) {
+			desc_offset |= SXE2_TX_DATA_DESC_MACLEN_VAL(ol_info.outer_l2_len);
+			sxe2_tx_desc_tunneling_params_fill(offloads, ol_info,
+						&desc_tunneling_params);
+		} else {
+			desc_offset |= SXE2_TX_DATA_DESC_MACLEN_VAL(ol_info.l2_len);
+		}
 
 		if (offloads & SXE2_TX_OFFLOAD_CKSUM_MASK) {
 			sxe2_tx_desc_checksum_fill(offloads, &desc_cmd,
-- 
2.47.3

