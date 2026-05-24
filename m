Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54128CD4F54
	for <dpdk-dev@archiver.kernel.org>; Sun, 24 May 2026 09:33:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9604440676;
	Sun, 24 May 2026 11:33:17 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id D0FC340041
 for <dev@dpdk.org>; Sun, 24 May 2026 11:33:08 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowABXd97QxRJq+04kEg--.9115S6;
 Sun, 24 May 2026 17:33:05 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v1 04/23] net/sxe2: support L2 filtering and MAC config
Date: Sun, 24 May 2026 17:32:40 +0800
Message-ID: <20260524093259.397506-5-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260524093259.397506-1-liujie5@linkdatatechnology.com>
References: <20260524093259.397506-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABXd97QxRJq+04kEg--.9115S6
X-Coremail-Antispam: 1UD129KBjvAXoWDJF1kJr4UXw4fZF43XF1xuFg_yoWxGw17uo
 WIgrsrXr1xA342kay8Jr18GFyUZw4Fgw45tay29rs8uwsxJw15KFs5Zw1Yv3WvgF4vqryv
 gw1Iva93Jr4DtFW8n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYK7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
 Ia0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
 84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F
 4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4U
 JwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
 IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
 M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24l42
 xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
 GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI4
 8JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4U
 MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
 8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU17KsUUUUU
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

- Support primary/secondary MAC address setup.
- Enable L2 broadcast/multicast filter bits.
- Add multicast address update logic.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/meson.build      |   1 +
 drivers/net/sxe2/sxe2_cmd_chnl.c  | 198 ++++++++
 drivers/net/sxe2/sxe2_cmd_chnl.h  |  17 +
 drivers/net/sxe2/sxe2_drv_cmd.h   |  89 +++-
 drivers/net/sxe2/sxe2_ethdev.c    |  70 ++-
 drivers/net/sxe2/sxe2_ethdev.h    |  43 +-
 drivers/net/sxe2/sxe2_filter.c    | 784 ++++++++++++++++++++++++++++++
 drivers/net/sxe2/sxe2_filter.h    |  98 ++++
 drivers/net/sxe2/sxe2_mac.c       | 432 ++++++++++++++++
 drivers/net/sxe2/sxe2_mac.h       |  36 +-
 drivers/net/sxe2/sxe2_txrx_poll.c |  49 ++
 11 files changed, 1809 insertions(+), 8 deletions(-)
 create mode 100644 drivers/net/sxe2/sxe2_filter.c
 create mode 100644 drivers/net/sxe2/sxe2_filter.h

diff --git a/drivers/net/sxe2/meson.build b/drivers/net/sxe2/meson.build
index e22204e850..8ff74e5233 100644
--- a/drivers/net/sxe2/meson.build
+++ b/drivers/net/sxe2/meson.build
@@ -61,6 +61,7 @@ sources += files(
         'sxe2_txrx.c',
         'sxe2_txrx_vec.c',
         'sxe2_mac.c',
+        'sxe2_filter.c',
 )
 
 allow_internal_get_api = true
diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.c b/drivers/net/sxe2/sxe2_cmd_chnl.c
index 07eeb7f38c..1fa9ad718e 100644
--- a/drivers/net/sxe2/sxe2_cmd_chnl.c
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.c
@@ -343,3 +343,201 @@ int32_t sxe2_drv_mac_link_status_get(struct sxe2_adapter *adapter)
 l_end:
 	return ret;
 }
+
+int32_t sxe2_drv_promisc_config(struct sxe2_adapter *adapter, bool set)
+{
+	int32_t ret = 0;
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+	struct sxe2_promisc_filter_cfg_req promisc_filter_cfg_req = {0};
+
+	promisc_filter_cfg_req.vsi_id = adapter->vsi_ctxt.dpdk_vsi_id;
+	promisc_filter_cfg_req.is_add = set;
+	promisc_filter_cfg_req.type = SXE2_PROMISC_FILTER_TYPE_PROMISC;
+
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_PROMISC_CFG,
+				 &promisc_filter_cfg_req,
+				 sizeof(promisc_filter_cfg_req),
+				 NULL, 0);
+
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret)
+		PMD_DEV_LOG_WARN(adapter, DRV, "promic config failed, ret=%d", ret);
+
+	return ret;
+}
+
+int32_t sxe2_drv_allmulti_config(struct sxe2_adapter *adapter, bool set)
+{
+	int32_t ret = 0;
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+	struct sxe2_promisc_filter_cfg_req promisc_filter_cfg_req = {0};
+
+	promisc_filter_cfg_req.vsi_id = adapter->vsi_ctxt.dpdk_vsi_id;
+	promisc_filter_cfg_req.is_add = set;
+	promisc_filter_cfg_req.type = SXE2_PROMISC_FILTER_TYPE_ALLMULTI;
+
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_ALLMULTI_CFG,
+				 &promisc_filter_cfg_req,
+				 sizeof(promisc_filter_cfg_req),
+				 NULL, 0);
+
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret)
+		PMD_DEV_LOG_WARN(adapter, DRV, "allmulti config failed, ret=%d", ret);
+
+	return ret;
+}
+
+int32_t sxe2_drv_uc_config(struct sxe2_adapter *adapter, struct rte_ether_addr *addr, bool add)
+{
+	int32_t ret = 0;
+	int32_t i;
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+	struct sxe2_mac_filter_cfg_req mac_filter_cfg_req = {0};
+
+	mac_filter_cfg_req.vsi_id = adapter->vsi_ctxt.dpdk_vsi_id;
+	for (i = 0; i < SXE2_ETH_ALEN; i++)
+		mac_filter_cfg_req.addr[i] = addr->addr_bytes[i];
+	mac_filter_cfg_req.is_add = add;
+	mac_filter_cfg_req.type = SXE2_MAC_FILTER_TYPE_UC;
+
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_MAC_ADDR_UC,
+		 &mac_filter_cfg_req, sizeof(mac_filter_cfg_req),
+		 NULL, 0);
+
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret)
+		PMD_DEV_LOG_WARN(adapter, DRV, "uc config query failed, ret=%d", ret);
+
+	return ret;
+}
+
+int32_t sxe2_drv_mc_config(struct sxe2_adapter *adapter, struct rte_ether_addr *addr, bool add)
+{
+	int32_t ret = 0;
+	int32_t i;
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+	struct sxe2_mac_filter_cfg_req mac_filter_cfg_req = {0};
+
+	mac_filter_cfg_req.vsi_id = adapter->vsi_ctxt.dpdk_vsi_id;
+	for (i = 0; i < SXE2_ETH_ALEN; i++)
+		mac_filter_cfg_req.addr[i] = addr->addr_bytes[i];
+
+	mac_filter_cfg_req.is_add = add;
+	mac_filter_cfg_req.type = SXE2_MAC_FILTER_TYPE_MC;
+
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_MAC_ADDR_MC,
+		 &mac_filter_cfg_req, sizeof(mac_filter_cfg_req),
+		 NULL, 0);
+
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret)
+		PMD_DEV_LOG_WARN(adapter, DRV, "mac config query failed, ret=%d", ret);
+
+	return ret;
+}
+
+int32_t sxe2_drv_vlan_config_query(struct sxe2_adapter *adapter)
+{
+	int32_t ret = 0;
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+	struct sxe2_drv_vlan_cfg_query_resp vlan_cfg_query_resp = {0};
+
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_VLAN_CFG_QUERY,
+				 NULL, 0,
+				 &vlan_cfg_query_resp,
+	 sizeof(vlan_cfg_query_resp));
+
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret)
+		PMD_DEV_LOG_WARN(adapter, DRV, "vlan config query failed, ret=%d", ret);
+
+	adapter->filter_ctxt.vlan_info.port_vlan_exist = vlan_cfg_query_resp.port_vlan_exist;
+	adapter->filter_ctxt.vlan_info.is_switchdev = vlan_cfg_query_resp.is_switchdev;
+
+
+	adapter->filter_ctxt.vlan_info.tpid = vlan_cfg_query_resp.tpid;
+	adapter->filter_ctxt.vlan_info.vid = vlan_cfg_query_resp.vid;
+
+	adapter->filter_ctxt.vlan_info.outer_insert = vlan_cfg_query_resp.outer_insert;
+	adapter->filter_ctxt.vlan_info.outer_strip = vlan_cfg_query_resp.outer_strip;
+	adapter->filter_ctxt.vlan_info.inner_insert = vlan_cfg_query_resp.inner_insert;
+	adapter->filter_ctxt.vlan_info.inner_strip = vlan_cfg_query_resp.inner_strip;
+
+	return ret;
+}
+
+int32_t sxe2_drv_vlan_filter_id_config(struct sxe2_adapter *adapter,
+				       struct sxe2_vlan *vlan, bool on)
+{
+	int32_t ret = 0;
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+	struct sxe2_vlan_filter_cfg_req vlan_filter_cfg_req = {0};
+
+	vlan_filter_cfg_req.vsi_id = adapter->vsi_ctxt.dpdk_vsi_id;
+	vlan_filter_cfg_req.tpid_id = vlan->tpid;
+	vlan_filter_cfg_req.vlan_id = vlan->vid;
+	vlan_filter_cfg_req.prio = vlan->prio;
+	vlan_filter_cfg_req.is_add = on;
+
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_VLAN_FILTER_ADD_DEL,
+				 &vlan_filter_cfg_req, sizeof(vlan_filter_cfg_req),
+				 NULL, 0);
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret)
+		PMD_DEV_LOG_WARN(adapter, DRV, "vlan config failed, ret=%d", ret);
+
+	return ret;
+}
+
+int32_t sxe2_drv_vlan_insert_strip_cfg(struct sxe2_adapter *adapter)
+{
+	int32_t ret = 0;
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+	struct sxe2_drv_vlan_offload_cfg_req vlan_offload_cfg_req = {0};
+
+	vlan_offload_cfg_req.vsi_id = adapter->vsi_ctxt.dpdk_vsi_id;
+	vlan_offload_cfg_req.tpid = adapter->filter_ctxt.vlan_info.tpid;
+	vlan_offload_cfg_req.outer_insert = adapter->filter_ctxt.vlan_info.outer_insert;
+	vlan_offload_cfg_req.outer_strip = adapter->filter_ctxt.vlan_info.outer_strip;
+	vlan_offload_cfg_req.inner_insert = adapter->filter_ctxt.vlan_info.inner_insert;
+	vlan_offload_cfg_req.inner_strip = adapter->filter_ctxt.vlan_info.inner_strip;
+
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_VLAN_OFFLOAD_CFG,
+				 &vlan_offload_cfg_req,
+				 sizeof(vlan_offload_cfg_req),
+				 NULL, 0);
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret)
+		PMD_DEV_LOG_WARN(adapter, DRV, "vlan config query failed, ret=%d", ret);
+
+	return ret;
+}
+
+int32_t sxe2_drv_vlan_filter_switch(struct sxe2_adapter *adapter, bool on)
+{
+	int32_t ret = 0;
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+	struct sxe2_vlan_filter_switch_req vlan_filter_switch_req = {0};
+
+	vlan_filter_switch_req.vsi_id = adapter->vsi_ctxt.dpdk_vsi_id;
+	vlan_filter_switch_req.is_oper_enable = on;
+
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_VLAN_FILTER_SWITCH,
+				 &vlan_filter_switch_req,
+				 sizeof(vlan_filter_switch_req),
+				 NULL, 0);
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret)
+		PMD_DEV_LOG_WARN(adapter, DRV, "vlan config filter failed, ret=%d", ret);
+
+	return ret;
+}
diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.h b/drivers/net/sxe2/sxe2_cmd_chnl.h
index 34004d37e2..fb01c41aad 100644
--- a/drivers/net/sxe2/sxe2_cmd_chnl.h
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.h
@@ -36,4 +36,21 @@ int32_t sxe2_drv_txq_ctxt_cfg(struct sxe2_adapter *adapter,
 
 int32_t sxe2_drv_mac_link_status_get(struct sxe2_adapter *adapter);
 
+int32_t sxe2_drv_promisc_config(struct sxe2_adapter *adapter, bool set);
+
+int32_t sxe2_drv_allmulti_config(struct sxe2_adapter *adapter, bool set);
+
+int32_t sxe2_drv_uc_config(struct sxe2_adapter *adapter, struct rte_ether_addr *addr, bool add);
+
+int32_t sxe2_drv_mc_config(struct sxe2_adapter *adapter, struct rte_ether_addr *addr, bool add);
+
+int32_t sxe2_drv_vlan_config_query(struct sxe2_adapter *adapter);
+
+int32_t sxe2_drv_vlan_filter_id_config(struct sxe2_adapter *adapter,
+				       struct sxe2_vlan *vlan, bool on);
+
+int32_t sxe2_drv_vlan_insert_strip_cfg(struct sxe2_adapter *adapter);
+
+int32_t sxe2_drv_vlan_filter_switch(struct sxe2_adapter *adapter, bool on);
+
 #endif /* __SXE2_CMD_CHNL_H__ */
diff --git a/drivers/net/sxe2/sxe2_drv_cmd.h b/drivers/net/sxe2/sxe2_drv_cmd.h
index e0ec70638e..c9d7cc719b 100644
--- a/drivers/net/sxe2/sxe2_drv_cmd.h
+++ b/drivers/net/sxe2/sxe2_drv_cmd.h
@@ -111,6 +111,17 @@ enum sxe2_phys_port_name_type {
 	SXE2_PHYS_PORT_NAME_TYPE_UNKNOWN,
 };
 
+struct sxe2_switchdev_info {
+	uint8_t is_switchdev;
+	uint8_t master;
+	uint8_t representor;
+	uint8_t port_name_type;
+	uint32_t ctrl_num;
+	uint32_t pf_num;
+	uint32_t vf_num;
+	uint32_t mpesw_owner;
+};
+
 struct sxe2_switchdev_mode_info {
 	uint8_t pf_id;
 	uint8_t is_switchdev;
@@ -228,11 +239,87 @@ struct sxe2_drv_vsi_info_get_resp {
 };
 
 struct sxe2_drv_link_info_resp {
-	__le32 speed;
+	uint32_t speed;
 	uint8_t status;
 	uint8_t rsv[3];
 };
 
+struct sxe2_drv_vlan_cfg_query_resp {
+	uint16_t vsi_id;
+	uint8_t port_vlan_exist;
+	uint8_t is_switchdev;
+	uint16_t tpid;
+	uint16_t vid;
+	uint8_t outer_insert;
+	uint8_t outer_strip;
+	uint8_t inner_insert;
+	uint8_t inner_strip;
+};
+
+struct sxe2_drv_vlan_offload_cfg_req {
+	uint16_t vsi_id;
+	uint16_t tpid;
+	uint8_t outer_insert;
+	uint8_t outer_strip;
+	uint8_t inner_insert;
+	uint8_t inner_strip;
+};
+
+struct sxe2_drv_port_vlan_cfg_req {
+	uint16_t vsi_id;
+	uint16_t tpid;
+	uint16_t vid;
+	uint8_t prio;
+	uint8_t rsv;
+};
+
+enum sxe2_mac_filter_type {
+	SXE2_MAC_FILTER_TYPE_UC = 0,
+	SXE2_MAC_FILTER_TYPE_MC,
+	SXE2_MAC_FILTER_TYPE_MAX,
+};
+
+struct sxe2_mac_filter_cfg_req {
+	uint16_t vsi_id;
+	uint8_t addr[SXE2_ETH_ALEN];
+	uint8_t type;
+	uint8_t is_add;
+	uint8_t rsv[2];
+};
+
+enum sxe2_promisc_filter_type {
+	SXE2_PROMISC_FILTER_TYPE_PROMISC = 0,
+	SXE2_PROMISC_FILTER_TYPE_ALLMULTI,
+	SXE2_PROMISC_FILTER_TYPE_MAX,
+};
+
+struct sxe2_promisc_filter_cfg_req {
+	uint16_t vsi_id;
+	uint8_t type;
+	uint8_t is_add;
+};
+
+struct sxe2_srcvsi_ext_cfg_req {
+	uint16_t vsi_id;
+	uint16_t srcvsi_list[SXE2_SRCVSI_PRUNE_MAX_NUM];
+	uint8_t srcvsi_cnt;
+	uint8_t is_add;
+};
+
+struct sxe2_vlan_filter_cfg_req {
+	uint16_t vsi_id;
+	uint16_t vlan_id;
+	uint16_t tpid_id;
+	uint8_t prio;
+	uint8_t is_add;
+};
+
+struct sxe2_vlan_filter_switch_req {
+	uint16_t vsi_id;
+	uint8_t is_oper_enable;
+	uint8_t rsv;
+};
+
 enum sxe2_drv_cmd_module {
 	SXE2_DRV_CMD_MODULE_HANDSHAKE = 0,
 	SXE2_DRV_CMD_MODULE_DEV = 1,
diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
index 01552a8202..9b117f097e 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -111,8 +111,20 @@ static const struct eth_dev_ops sxe2_eth_dev_ops = {
 	.tx_burst_mode_get          = sxe2_tx_burst_mode_get,
 	.tx_done_cleanup            = sxe2_tx_done_cleanup,
 
+	.promiscuous_enable         = sxe2_promisc_enable,
+	.promiscuous_disable        = sxe2_promisc_disable,
+	.allmulticast_enable        = sxe2_allmulti_enable,
+	.allmulticast_disable       = sxe2_allmulti_disable,
+
+	.mac_addr_add               = sxe2_mac_addr_add,
+	.mac_addr_remove            = sxe2_mac_addr_del,
+	.mac_addr_set               = sxe2_mac_addr_set,
+	.set_mc_addr_list           = sxe2_set_mc_addr_list,
 	.mtu_set                    = sxe2_mtu_set,
 	.buffer_split_supported_hdr_ptypes_get = sxe2_buffer_split_supported_hdr_ptypes_get,
+
+	.vlan_filter_set            = sxe2_dev_vlan_filter_set,
+	.vlan_offload_set           = sxe2_dev_vlan_offload_set,
 };
 
 static int32_t sxe2_dev_configure(struct rte_eth_dev *dev)
@@ -123,6 +135,13 @@ static int32_t sxe2_dev_configure(struct rte_eth_dev *dev)
 	if (dev->data->dev_conf.rxmode.mq_mode  & RTE_ETH_MQ_RX_RSS_FLAG)
 		dev->data->dev_conf.rxmode.offloads |= RTE_ETH_RX_OFFLOAD_RSS_HASH;
 
+	ret = sxe2_vlan_default_cfg(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to init vlan, ret=%d", ret);
+		goto end;
+	}
+
+end:
 	return ret;
 }
 
@@ -138,6 +157,8 @@ static int32_t sxe2_dev_stop(struct rte_eth_dev *dev)
 	sxe2_txqs_all_stop(dev);
 	sxe2_rxqs_all_stop(dev);
 
+	(void)sxe2_filter_rule_stop(dev);
+
 	dev->data->dev_started = 0;
 	adapter->started = 0;
 l_end:
@@ -165,16 +186,23 @@ static int32_t sxe2_dev_start(struct rte_eth_dev *dev)
 		goto l_end;
 	}
 
+	ret = sxe2_filter_rule_start(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to add all mc addr to fw.");
+		goto l_end;
+	}
+
 	ret = sxe2_queues_start(dev);
 	if (ret) {
 		PMD_LOG_ERR(INIT, "enable queues failed");
-		goto l_end;
+		goto l_start_queues_err;
 	}
 
 	dev->data->dev_started = 1;
 	adapter->started = 1;
 	goto l_end;
-
+l_start_queues_err:
+	(void)sxe2_filter_rule_stop(dev);
 l_end:
 	return ret;
 }
@@ -194,6 +222,7 @@ static int32_t sxe2_dev_infos_get(struct rte_eth_dev *dev,
 	dev_info->min_mtu = RTE_ETHER_MIN_MTU;
 
 	dev_info->rx_offload_capa =
+		RTE_ETH_RX_OFFLOAD_VLAN_STRIP |
 		RTE_ETH_RX_OFFLOAD_KEEP_CRC |
 		RTE_ETH_RX_OFFLOAD_SCATTER |
 		RTE_ETH_RX_OFFLOAD_IPV4_CKSUM |
@@ -202,9 +231,15 @@ static int32_t sxe2_dev_infos_get(struct rte_eth_dev *dev,
 		RTE_ETH_RX_OFFLOAD_SCTP_CKSUM |
 		RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM |
 		RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT |
+#ifndef RTE_LIBRTE_SXE2_16BYTE_RX_DESC
+		RTE_ETH_RX_OFFLOAD_QINQ_STRIP |
+#endif
+		RTE_ETH_RX_OFFLOAD_VLAN_EXTEND |
 		RTE_ETH_RX_OFFLOAD_TCP_LRO;
 
 	dev_info->tx_offload_capa =
+		RTE_ETH_TX_OFFLOAD_VLAN_INSERT |
+		RTE_ETH_TX_OFFLOAD_QINQ_INSERT |
 		RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
 		RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE |
 		RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |
@@ -428,6 +463,12 @@ static int32_t sxe2_eth_init(struct rte_eth_dev *dev)
 {
 	int32_t ret = 0;
 
+	ret = sxe2_filter_init(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to initialize l2 filter, ret:%d", ret);
+		goto l_end;
+	}
+
 	ret = sxe2_link_update_init(dev);
 	if (ret) {
 		PMD_LOG_ERR(INIT, "Failed to initialize link update, ret:%d", ret);
@@ -439,12 +480,37 @@ static int32_t sxe2_eth_init(struct rte_eth_dev *dev)
 		PMD_LOG_ERR(INIT, "Failed to set mtu, ret=%d", ret);
 		goto l_end;
 	}
+
+	ret = sxe2_mac_addr_init(dev);
+	if (ret != 0) {
+		PMD_LOG_ERR(INIT, "Failed to initialize mac address, ret:%d", ret);
+		goto l_end;
+	}
+
+	ret = sxe2_mac_default_cfg(dev);
+	if (ret != 0) {
+		PMD_LOG_ERR(INIT, "Failed to configure default mac address, ret:%d", ret);
+		goto l_err;
+	}
+
+	ret = sxe2_vlan_cfg_init(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to initialize vlan config, ret:%d", ret);
+		goto l_err;
+	}
+	goto l_end;
+
+l_err:
+	sxe2_mac_addr_uinit(dev);
+	(void)sxe2_filter_uinit(dev);
 l_end:
 	return ret;
 }
 
 static void sxe2_eth_uinit(struct rte_eth_dev *dev __rte_unused)
 {
+	sxe2_mac_addr_uinit(dev);
+	(void)sxe2_filter_uinit(dev);
 }
 
 static void sxe2_drv_dev_caps_set(struct sxe2_adapter *adapter,
diff --git a/drivers/net/sxe2/sxe2_ethdev.h b/drivers/net/sxe2/sxe2_ethdev.h
index 66f49ac0cc..cc8a84c0a0 100644
--- a/drivers/net/sxe2/sxe2_ethdev.h
+++ b/drivers/net/sxe2/sxe2_ethdev.h
@@ -13,9 +13,11 @@
 
 #include "sxe2_common.h"
 #include "sxe2_vsi.h"
-#include "sxe2_queue.h"
 #include "sxe2_irq.h"
+#include "sxe2_queue.h"
+#include "sxe2_mac.h"
 #include "sxe2_osal.h"
+#include "sxe2_filter.h"
 
 struct sxe2_link_msg {
 	uint32_t speed;
@@ -33,7 +35,7 @@ enum sxe2_fnav_tunnel_flag_type {
 #define SXE2_FRAME_SIZE_MAX    9832
 #define SXE2_VLAN_TAG_SIZE     4
 #define SXE2_ETH_OVERHEAD \
-	(RTE_ETHER_HDR_LEN + RTE_ETHER_CRC_LEN + SXE2_VLAN_TAG_SIZE)
+	(RTE_ETHER_HDR_LEN + RTE_ETHER_CRC_LEN + 2 * SXE2_VLAN_TAG_SIZE)
 #define SXE2_ETH_MAX_LEN (RTE_ETHER_MTU + SXE2_ETH_OVERHEAD)
 
 #ifdef SXE2_TEST
@@ -265,6 +267,27 @@ struct sxe2_link_context {
 	uint32_t  speed;
 };
 
+struct sxe2_filter_context {
+	rte_spinlock_t filter_lock;
+	struct sxe2_vlan_info               vlan_info;
+	struct sxe2_uc_filter_list_head    uc_list;
+	struct sxe2_mc_filter_list_head    mc_list;
+	struct sxe2_vlan_filter_list_head  vlan_list;
+	uint8_t                                 uc_num;
+	uint8_t                                 mc_num;
+	uint8_t                                 vlan_num;
+	uint8_t                                 rsv;
+	uint32_t hw_promisc_flags;
+	uint32_t cur_promisc_flags;
+
+	bool hw_uplink_config;
+	bool cur_uplink_config;
+	bool hw_repr_config;
+	bool cur_repr_config;
+	bool hw_l2_config;
+	bool cur_l2_config;
+};
+
 struct sxe2_adapter {
 	struct sxe2_common_device      *cdev;
 	struct sxe2_dev_info            dev_info;
@@ -274,10 +297,14 @@ struct sxe2_adapter {
 	struct sxe2_irq_context       irq_ctxt;
 	struct sxe2_queue_context     q_ctxt;
 	struct sxe2_vsi_context       vsi_ctxt;
+	struct sxe2_filter_context    filter_ctxt;
 	struct sxe2_link_context      link_ctxt;
 	struct sxe2_devargs           devargs;
-	uint16_t                      dev_port_id;
-	uint64_t                      cap_flags;
+	struct sxe2_switchdev_info    switchdev_info;
+	bool                          rule_started;
+	bool                          flow_isolated;
+	uint16_t                           dev_port_id;
+	uint64_t                           cap_flags;
 	enum sxe2_dev_type            dev_type;
 	uint32_t    ptype_tbl[SXE2_MAX_PTYPE_NUM];
 	struct rte_ether_addr           mac_addr;
@@ -316,4 +343,12 @@ int32_t sxe2_dev_pci_map_init(struct rte_eth_dev *dev);
 
 void sxe2_dev_pci_map_uinit(struct rte_eth_dev *dev);
 
+static inline bool
+sxe2_dev_port_vlan_check(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *ad = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+
+	return ad->filter_ctxt.vlan_info.port_vlan_exist;
+}
+
 #endif /* __SXE2_ETHDEV_H__ */
diff --git a/drivers/net/sxe2/sxe2_filter.c b/drivers/net/sxe2/sxe2_filter.c
new file mode 100644
index 0000000000..cfeeb7a6c3
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_filter.c
@@ -0,0 +1,784 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#include <rte_os.h>
+#include <rte_tailq.h>
+#include "sxe2_osal.h"
+#include "sxe2_mac.h"
+#include "sxe2_common_log.h"
+#include "sxe2_ethdev.h"
+#include "sxe2_cmd_chnl.h"
+
+static struct sxe2_mac_filter *sxe2_uc_filter_find(struct sxe2_adapter *adapter,
+			struct rte_ether_addr *macaddr)
+{
+	struct sxe2_mac_filter *filter      = NULL;
+	struct sxe2_mac_filter *entry       = NULL;
+	struct sxe2_mac_filter *next_entry  = NULL;
+
+	rte_spinlock_lock(&adapter->filter_ctxt.filter_lock);
+	RTE_TAILQ_FOREACH_SAFE(entry, &adapter->filter_ctxt.uc_list, next, next_entry) {
+		if (rte_is_same_ether_addr(macaddr, &entry->mac_addr)) {
+			filter = entry;
+			break;
+		}
+	}
+	rte_spinlock_unlock(&adapter->filter_ctxt.filter_lock);
+
+	return filter;
+}
+
+int32_t sxe2_uc_filter_add(struct sxe2_adapter *adapter,
+			struct rte_ether_addr *mac_addr, bool default_config)
+{
+	struct sxe2_mac_filter *filter = NULL;
+	bool hw_config = false;
+	int32_t ret = 0;
+
+	filter = sxe2_uc_filter_find(adapter, mac_addr);
+	if (filter) {
+		if (default_config && !filter->default_config)
+			filter->default_config = true;
+		PMD_DEV_LOG_INFO(adapter, DRV, "This MAC filter already exists.");
+		goto l_end;
+	}
+
+	if (!adapter->rule_started) {
+		PMD_DEV_LOG_DEBUG(adapter, DRV, "cannot add hw uc addr in port stop status");
+	} else if (adapter->flow_isolated) {
+		PMD_DEV_LOG_WARN(adapter, DRV, "cannot add hw uc addr in flow isolation mode");
+	} else if (adapter->switchdev_info.is_switchdev) {
+		PMD_DEV_LOG_WARN(adapter, DRV, "cannot add hw uc addr in switchdev mode");
+	} else {
+		ret = sxe2_drv_uc_config(adapter, mac_addr, true);
+		if (ret && ret != -EEXIST) {
+			PMD_DEV_LOG_ERR(adapter, DRV, "Failed to add uc rule");
+			ret = -EINVAL;
+			goto l_end;
+		}
+		hw_config = true;
+	}
+
+	filter = rte_zmalloc("sxe2_uc_filter",
+			     sizeof(struct sxe2_mac_filter), 0);
+	if (!filter) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to allocate memory");
+		ret = -ENOMEM;
+		goto l_end;
+	}
+	filter->hw_config = hw_config;
+	filter->default_config = default_config;
+	rte_ether_addr_copy(mac_addr, &filter->mac_addr);
+	rte_spinlock_lock(&adapter->filter_ctxt.filter_lock);
+	TAILQ_INSERT_TAIL(&adapter->filter_ctxt.uc_list, filter, next);
+	adapter->filter_ctxt.uc_num++;
+	rte_spinlock_unlock(&adapter->filter_ctxt.filter_lock);
+
+	PMD_DEV_LOG_INFO(adapter, DRV, "add mac rule, mac num %u.", adapter->filter_ctxt.uc_num);
+	ret = 0;
+
+l_end:
+	return ret;
+}
+
+int32_t sxe2_uc_filter_del(struct sxe2_adapter *adapter,
+			struct rte_ether_addr *mac_addr)
+{
+	struct sxe2_mac_filter *filter = NULL;
+	int32_t ret                         = -1;
+
+	filter = sxe2_uc_filter_find(adapter, mac_addr);
+	if (!filter) {
+		PMD_DEV_LOG_INFO(adapter, DRV, "This MAC filter not exists.");
+		ret = 0;
+		goto l_end;
+	}
+	if (filter->hw_config) {
+		ret = sxe2_drv_uc_config(adapter, mac_addr, false);
+		if (ret) {
+			PMD_DEV_LOG_ERR(adapter, DRV, "Failed to delete mac rule");
+			if (ret == -EPERM)
+				goto l_free;
+			ret = -EINVAL;
+			goto l_end;
+		}
+	}
+	PMD_DEV_LOG_INFO(adapter, DRV, "remove mac rule, uc num %u.", adapter->filter_ctxt.uc_num);
+	ret = 0;
+
+l_free:
+
+	rte_spinlock_lock(&adapter->filter_ctxt.filter_lock);
+	TAILQ_REMOVE(&adapter->filter_ctxt.uc_list, filter, next);
+	adapter->filter_ctxt.uc_num--;
+	rte_spinlock_unlock(&adapter->filter_ctxt.filter_lock);
+	rte_free(filter);
+	filter = NULL;
+l_end:
+	return ret;
+}
+
+void sxe2_uc_filter_clear(struct sxe2_adapter *adapter, bool default_config)
+{
+	struct sxe2_mac_filter *entry;
+	struct sxe2_mac_filter *next_entry;
+
+	RTE_TAILQ_FOREACH_SAFE(entry, &adapter->filter_ctxt.uc_list, next, next_entry) {
+		if (entry->default_config && !default_config)
+			continue;
+
+		if (sxe2_uc_filter_del(adapter, &entry->mac_addr))
+			PMD_DEV_LOG_ERR(adapter, DRV, "This MAC filter delete fail.");
+	}
+}
+
+static struct sxe2_mac_filter *sxe2_mc_filter_find(struct sxe2_adapter *adapter,
+			struct rte_ether_addr *macaddr)
+{
+	struct sxe2_mac_filter *filter      = NULL;
+	struct sxe2_mac_filter *entry       = NULL;
+	struct sxe2_mac_filter *next_entry  = NULL;
+
+	rte_spinlock_lock(&adapter->filter_ctxt.filter_lock);
+	RTE_TAILQ_FOREACH_SAFE(entry, &adapter->filter_ctxt.mc_list, next, next_entry) {
+		if (rte_is_same_ether_addr(macaddr, &entry->mac_addr)) {
+			filter = entry;
+			break;
+		}
+	}
+	rte_spinlock_unlock(&adapter->filter_ctxt.filter_lock);
+
+	return filter;
+}
+
+int32_t sxe2_mc_filter_add(struct sxe2_adapter *adapter,
+			struct rte_ether_addr *mac_addr, bool default_config)
+{
+	struct sxe2_mac_filter *filter = NULL;
+	bool hw_config = false;
+	int32_t ret = 0;
+
+	filter = sxe2_mc_filter_find(adapter, mac_addr);
+	if (filter) {
+		if (default_config && !filter->default_config)
+			filter->default_config = true;
+		PMD_DEV_LOG_INFO(adapter, DRV, "This MAC filter already exists.");
+		goto l_end;
+	}
+
+	if (!adapter->rule_started) {
+		PMD_DEV_LOG_DEBUG(adapter, DRV, "cannot add hw mc addr in port stop status");
+	} else if (adapter->flow_isolated) {
+		PMD_DEV_LOG_WARN(adapter, DRV, "cannot add hw mc addr in flow isolation mode");
+	} else if (adapter->switchdev_info.is_switchdev) {
+		PMD_DEV_LOG_WARN(adapter, DRV, "cannot add hw mc addr in switchdev mode");
+	} else {
+		ret = sxe2_drv_mc_config(adapter, mac_addr, true);
+		if (ret && ret != -EEXIST) {
+			PMD_DEV_LOG_ERR(adapter, DRV, "Failed to add mac rule");
+			ret = -EINVAL;
+			goto l_end;
+		}
+		hw_config = true;
+	}
+
+	filter = rte_zmalloc("sxe2_mc_filter",
+			     sizeof(struct sxe2_mac_filter), 0);
+	if (!filter) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to allocate memory");
+		ret = -ENOMEM;
+		goto l_end;
+	}
+	filter->hw_config = hw_config;
+	filter->default_config = default_config;
+	rte_ether_addr_copy(mac_addr, &filter->mac_addr);
+	rte_spinlock_lock(&adapter->filter_ctxt.filter_lock);
+	TAILQ_INSERT_TAIL(&adapter->filter_ctxt.mc_list, filter, next);
+	adapter->filter_ctxt.mc_num++;
+	rte_spinlock_unlock(&adapter->filter_ctxt.filter_lock);
+
+	PMD_DEV_LOG_INFO(adapter, DRV, "add mc rule, mc num %u.", adapter->filter_ctxt.mc_num);
+	ret = 0;
+
+l_end:
+	return ret;
+}
+
+int32_t sxe2_mc_filter_del(struct sxe2_adapter *adapter,
+			struct rte_ether_addr *mac_addr)
+{
+	struct sxe2_mac_filter *filter = NULL;
+	int32_t ret                         = -1;
+
+	filter = sxe2_mc_filter_find(adapter, mac_addr);
+	if (!filter) {
+		PMD_DEV_LOG_INFO(adapter, DRV, "This MAC filter not exists.");
+		ret = 0;
+		goto l_end;
+	}
+
+	if (filter->hw_config) {
+		ret = sxe2_drv_mc_config(adapter, mac_addr, false);
+		if (ret) {
+			PMD_DEV_LOG_ERR(adapter, DRV, "Failed to delete mc rule");
+			if (ret == -EPERM)
+				goto l_free;
+			ret = -EINVAL;
+			goto l_end;
+		}
+	}
+	PMD_DEV_LOG_INFO(adapter, DRV, "remove mc rule, mc num %u.", adapter->filter_ctxt.mc_num);
+	ret = 0;
+
+l_free:
+
+	rte_spinlock_lock(&adapter->filter_ctxt.filter_lock);
+	TAILQ_REMOVE(&adapter->filter_ctxt.mc_list, filter, next);
+	adapter->filter_ctxt.mc_num--;
+	rte_spinlock_unlock(&adapter->filter_ctxt.filter_lock);
+	rte_free(filter);
+	filter = NULL;
+l_end:
+	return ret;
+}
+
+void sxe2_mc_filter_clear(struct sxe2_adapter *adapter, bool default_config)
+{
+	struct sxe2_mac_filter *entry;
+	struct sxe2_mac_filter *next_entry;
+
+	RTE_TAILQ_FOREACH_SAFE(entry, &adapter->filter_ctxt.mc_list, next, next_entry) {
+		if (entry->default_config && !default_config)
+			continue;
+		if (sxe2_mc_filter_del(adapter, &entry->mac_addr))
+			PMD_DEV_LOG_ERR(adapter, DRV, "This MAC filter delete fail.");
+	}
+}
+
+static struct sxe2_vlan_filter *sxe2_vlan_filter_find(struct sxe2_adapter *adapter,
+			struct sxe2_vlan *vlan)
+{
+	struct sxe2_vlan_filter *f;
+	struct sxe2_vlan_filter *save_f = NULL;
+
+	rte_spinlock_lock(&adapter->filter_ctxt.filter_lock);
+	TAILQ_FOREACH(f, &adapter->filter_ctxt.vlan_list, next)
+	{
+		if (vlan->tpid == f->vlan_info.tpid &&
+			vlan->vid == f->vlan_info.vid) {
+			save_f = f;
+			break;
+		}
+	}
+	rte_spinlock_unlock(&adapter->filter_ctxt.filter_lock);
+
+	return save_f;
+}
+
+int32_t sxe2_vlan_filter_add(struct sxe2_adapter *adapter,
+			     struct sxe2_vlan *vlan, bool default_config)
+{
+	struct sxe2_vlan_filter *filter = NULL;
+	bool hw_config                 = false;
+	int32_t ret                    = 0;
+
+	if (!vlan || vlan->vid > RTE_ETHER_MAX_VLAN_ID) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "This vlan filter is invalid.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	filter = sxe2_vlan_filter_find(adapter, vlan);
+	if (filter) {
+		PMD_DEV_LOG_INFO(adapter, DRV, "This vlan filter already exists.");
+		ret = 0;
+		goto l_end;
+	}
+	if (!adapter->rule_started) {
+		PMD_DEV_LOG_DEBUG(adapter, DRV, "cannot add vlan in port stop status");
+	} else if (adapter->flow_isolated) {
+		PMD_DEV_LOG_WARN(adapter, DRV, "cannot add vlan in flow isolation mode");
+	} else if (adapter->switchdev_info.is_switchdev) {
+		PMD_DEV_LOG_WARN(adapter, DRV, "cannot add vlan in switchdev mode");
+	} else {
+		ret = sxe2_drv_vlan_filter_id_config(adapter, vlan, true);
+		if (ret && ret != -EEXIST) {
+			PMD_DEV_LOG_ERR(adapter, DRV, "Failed to add vlan rule");
+			ret = -EINVAL;
+			goto l_end;
+		}
+		hw_config = true;
+	}
+
+	filter = rte_zmalloc("sxe2_vlan_filter", sizeof(*filter), 0);
+	if (!filter) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to allocate memory");
+		ret = -ENOMEM;
+		goto l_end;
+	}
+
+	filter->hw_config = hw_config;
+	filter->default_config = default_config;
+
+	filter->vlan_info.tpid = vlan->tpid;
+	filter->vlan_info.vid = vlan->vid;
+	filter->vlan_info.prio = vlan->prio;
+
+	rte_spinlock_lock(&adapter->filter_ctxt.filter_lock);
+	TAILQ_INSERT_TAIL(&adapter->filter_ctxt.vlan_list, filter, next);
+	adapter->filter_ctxt.vlan_num++;
+	rte_spinlock_unlock(&adapter->filter_ctxt.filter_lock);
+
+	ret = 0;
+
+l_end:
+	return ret;
+}
+
+int32_t sxe2_vlan_filter_del(struct sxe2_adapter *adapter, struct sxe2_vlan *vlan)
+{
+	struct sxe2_vlan_filter *filter = NULL;
+	int32_t ret                         = -1;
+
+	if (!vlan || vlan->vid > RTE_ETHER_MAX_VLAN_ID) {
+		PMD_DEV_LOG_INFO(adapter, DRV, "This vlan filter is invalid.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	filter = sxe2_vlan_filter_find(adapter, vlan);
+	if (!filter) {
+		PMD_DEV_LOG_INFO(adapter, DRV, "This vlan filter not exists.");
+		ret = 0;
+		goto l_end;
+	}
+
+	if (filter->hw_config) {
+		ret = sxe2_drv_vlan_filter_id_config(adapter, vlan, false);
+		if (ret) {
+			PMD_DEV_LOG_ERR(adapter, DRV, "Failed to delete vlan rule");
+			if (ret == -EPERM)
+				goto l_free;
+			ret = -EINVAL;
+			goto l_end;
+		}
+	}
+	ret = 0;
+
+l_free:
+
+	rte_spinlock_lock(&adapter->filter_ctxt.filter_lock);
+	TAILQ_REMOVE(&adapter->filter_ctxt.vlan_list, filter, next);
+	adapter->filter_ctxt.vlan_num--;
+	rte_spinlock_unlock(&adapter->filter_ctxt.filter_lock);
+	rte_free(filter);
+	filter = NULL;
+l_end:
+	return ret;
+}
+
+void sxe2_vlan_filters_clear(struct sxe2_adapter *adapter, bool default_config)
+{
+	int32_t ret = 0;
+	struct sxe2_vlan_filter *v_f;
+	void *temp;
+
+	if (adapter->filter_ctxt.vlan_num == 0)
+		goto l_end;
+
+	RTE_TAILQ_FOREACH_SAFE(v_f, &adapter->filter_ctxt.vlan_list, next, temp)
+	{
+		if (v_f->default_config && !default_config)
+			continue;
+		ret = sxe2_vlan_filter_del(adapter, &v_f->vlan_info);
+		if (ret)
+			PMD_DEV_LOG_ERR(adapter, DRV, "This vlan filter delete fail.");
+	}
+
+l_end:
+}
+
+int32_t sxe2_vlan_filter_ctrl(struct sxe2_adapter *adapter, bool flag)
+{
+	struct sxe2_vlan_info *vlan_info = &adapter->filter_ctxt.vlan_info;
+	int32_t ret = 0;
+
+	if (vlan_info->filter_on == flag)
+		goto l_end;
+	if (!adapter->rule_started) {
+		PMD_DEV_LOG_DEBUG(adapter, DRV, "cannot add vlan filter ctrl in port stop status");
+	} else if (adapter->flow_isolated) {
+		PMD_DEV_LOG_WARN(adapter, DRV, "cannot add vlan filter ctrl in flow isolation mode");
+	} else if (adapter->switchdev_info.is_switchdev) {
+		PMD_DEV_LOG_WARN(adapter, DRV, "cannot add vlan filter ctrl in switchdev mode");
+	} else {
+		ret = sxe2_drv_vlan_filter_switch(adapter, flag);
+		if (ret) {
+			PMD_DEV_LOG_ERR(adapter, DRV, "Failed to add vlan filter ctrl");
+			goto l_end;
+		}
+		vlan_info->hw_filter_on = flag;
+	}
+	vlan_info->filter_on = flag;
+
+l_end:
+	return ret;
+}
+
+int32_t sxe2_promisc_add(struct sxe2_adapter *adapter)
+{
+	int32_t ret = 0;
+
+	if (!adapter->rule_started) {
+		PMD_DEV_LOG_DEBUG(adapter, DRV, "cannot enable promiscuous in port stop status");
+	} else if (adapter->flow_isolated) {
+		PMD_DEV_LOG_WARN(adapter, DRV, "cannot enable promiscuous in flow isolation mode");
+	} else if (adapter->switchdev_info.is_switchdev) {
+		PMD_DEV_LOG_WARN(adapter, DRV, "cannot enable promiscuous in switchdev mode");
+	} else if (!(adapter->filter_ctxt.hw_promisc_flags & SXE2_PROMISC)) {
+		ret = sxe2_drv_promisc_config(adapter, true);
+		if (ret && ret != -EEXIST) {
+			PMD_DEV_LOG_ERR(adapter, DRV, "failed to cfg promiscuous, ret:%d", ret);
+			goto l_end;
+		}
+		adapter->filter_ctxt.hw_promisc_flags |= SXE2_PROMISC;
+	}
+	adapter->filter_ctxt.cur_promisc_flags |= SXE2_PROMISC;
+
+l_end:
+	return ret;
+}
+
+int32_t sxe2_promisc_del(struct sxe2_adapter *adapter)
+{
+	int32_t ret = 0;
+
+	if (!adapter->flow_isolated &&
+	    (adapter->filter_ctxt.hw_promisc_flags & SXE2_PROMISC)) {
+		ret = sxe2_drv_promisc_config(adapter, false);
+		if (ret) {
+			PMD_DEV_LOG_ERR(adapter, DRV, "failed to cfg promiscuous, ret:%d", ret);
+			goto l_end;
+		}
+		adapter->filter_ctxt.hw_promisc_flags &= ~SXE2_PROMISC;
+	}
+
+	adapter->filter_ctxt.cur_promisc_flags &= ~SXE2_PROMISC;
+
+l_end:
+	return ret;
+}
+
+int32_t sxe2_allmulti_add(struct sxe2_adapter *adapter)
+{
+	int32_t ret = 0;
+
+	if (!adapter->rule_started) {
+		PMD_DEV_LOG_DEBUG(adapter, DRV, "cannot enable allmulticast in port stop status");
+	} else if (adapter->flow_isolated) {
+		PMD_DEV_LOG_WARN(adapter, DRV, "cannot enable allmulticast in flow isolation mode");
+	} else if (adapter->switchdev_info.is_switchdev) {
+		PMD_DEV_LOG_WARN(adapter, DRV, "cannot enable allmulticast in switchdev mode");
+	} else if (!(adapter->filter_ctxt.hw_promisc_flags & SXE2_PROMISC_MULTICAST)) {
+		ret = sxe2_drv_allmulti_config(adapter, true);
+		if (ret && ret != -EEXIST) {
+			PMD_DEV_LOG_ERR(adapter, DRV, "failed to cfg allmulticast, ret:%d", ret);
+			goto l_end;
+		}
+		adapter->filter_ctxt.hw_promisc_flags |= SXE2_PROMISC_MULTICAST;
+	}
+	adapter->filter_ctxt.cur_promisc_flags |= SXE2_PROMISC_MULTICAST;
+
+l_end:
+	return ret;
+}
+
+int32_t sxe2_allmulti_del(struct sxe2_adapter *adapter)
+{
+	int32_t ret = 0;
+
+	if (!adapter->flow_isolated &&
+	    (adapter->filter_ctxt.hw_promisc_flags & SXE2_PROMISC_MULTICAST)) {
+		ret = sxe2_drv_allmulti_config(adapter, false);
+		if (ret) {
+			PMD_DEV_LOG_ERR(adapter, DRV, "failed to cfg allmulticast, ret:%d", ret);
+			goto l_end;
+		}
+		adapter->filter_ctxt.hw_promisc_flags &= ~SXE2_PROMISC_MULTICAST;
+	}
+
+	adapter->filter_ctxt.cur_promisc_flags &= ~SXE2_PROMISC_MULTICAST;
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_all_filter_hw_clear(struct sxe2_adapter *adapter)
+{
+	int32_t ret = 0;
+	struct sxe2_mac_filter *mac_entry;
+	struct sxe2_mac_filter *next_mac_entry;
+	struct sxe2_vlan_filter *vlan_entry;
+	struct sxe2_vlan_filter *next_vlan_entry;
+
+	if (adapter->filter_ctxt.uc_num > 0) {
+		RTE_TAILQ_FOREACH_SAFE(mac_entry, &adapter->filter_ctxt.uc_list, next,
+			    next_mac_entry) {
+			if (mac_entry->hw_config) {
+				ret = sxe2_drv_uc_config(adapter, &mac_entry->mac_addr, false);
+				if (ret) {
+					PMD_DEV_LOG_ERR(adapter, DRV, "Failed to delete mac rule");
+					ret = -EINVAL;
+					goto l_end;
+				}
+				mac_entry->hw_config = false;
+			}
+		}
+	}
+
+	if (adapter->filter_ctxt.mc_num > 0) {
+		RTE_TAILQ_FOREACH_SAFE(mac_entry, &adapter->filter_ctxt.mc_list, next,
+			    next_mac_entry) {
+			if (mac_entry->hw_config) {
+				ret = sxe2_drv_mc_config(adapter, &mac_entry->mac_addr, false);
+				if (ret) {
+					PMD_DEV_LOG_ERR(adapter, DRV, "Failed to delete mc rule");
+					ret = -EINVAL;
+					goto l_end;
+				}
+				mac_entry->hw_config = false;
+			}
+		}
+	}
+
+	if (adapter->filter_ctxt.vlan_num > 0) {
+		RTE_TAILQ_FOREACH_SAFE(vlan_entry, &adapter->filter_ctxt.vlan_list, next,
+			    next_vlan_entry) {
+			if (vlan_entry->hw_config) {
+				ret = sxe2_drv_vlan_filter_id_config(adapter,
+				    &vlan_entry->vlan_info, false);
+				if (ret) {
+					PMD_DEV_LOG_ERR(adapter, DRV, "Failed to delete vlan rule");
+					ret = -EINVAL;
+					goto l_end;
+				}
+				vlan_entry->hw_config = false;
+			}
+		}
+	}
+
+	if (adapter->filter_ctxt.vlan_info.hw_filter_on) {
+		ret = sxe2_drv_vlan_filter_switch(adapter, false);
+		if (ret) {
+			PMD_DEV_LOG_ERR(adapter, DRV, "Failed to delete vlan rule");
+			ret = -EINVAL;
+			goto l_end;
+		}
+		adapter->filter_ctxt.vlan_info.hw_filter_on = false;
+	}
+
+	if (adapter->filter_ctxt.hw_promisc_flags & SXE2_PROMISC) {
+		ret = sxe2_drv_promisc_config(adapter, false);
+		if (ret) {
+			PMD_DEV_LOG_ERR(adapter, DRV, "failed to cfg promiscuous, ret:%d", ret);
+			goto l_end;
+		}
+		adapter->filter_ctxt.hw_promisc_flags &= ~SXE2_PROMISC;
+	}
+
+	if (adapter->filter_ctxt.hw_promisc_flags & SXE2_PROMISC_MULTICAST) {
+		ret = sxe2_drv_allmulti_config(adapter, false);
+		if (ret) {
+			PMD_DEV_LOG_ERR(adapter, DRV, "failed to cfg allmulticast, ret:%d", ret);
+			goto l_end;
+		}
+		adapter->filter_ctxt.hw_promisc_flags &= ~SXE2_PROMISC_MULTICAST;
+	}
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_all_filter_hw_set(struct sxe2_adapter *adapter)
+{
+	int32_t ret = 0;
+	struct sxe2_mac_filter *mac_entry;
+	struct sxe2_mac_filter *next_mac_entry;
+	struct sxe2_vlan_filter *vlan_entry;
+	struct sxe2_vlan_filter *next_vlan_entry;
+
+	if (adapter->filter_ctxt.uc_num > 0) {
+		RTE_TAILQ_FOREACH_SAFE(mac_entry, &adapter->filter_ctxt.uc_list, next,
+				       next_mac_entry) {
+			if (!mac_entry->hw_config) {
+				ret = sxe2_drv_uc_config(adapter, &mac_entry->mac_addr,
+							 true);
+				if (ret && ret != -EEXIST) {
+					PMD_DEV_LOG_ERR(adapter, DRV,
+							"Failed to add uc rule, ret:%d", ret);
+					ret = -EINVAL;
+					goto l_end;
+				}
+				mac_entry->hw_config = true;
+				ret = 0;
+			}
+		}
+	}
+
+	if (adapter->filter_ctxt.mc_num > 0) {
+		RTE_TAILQ_FOREACH_SAFE(mac_entry, &adapter->filter_ctxt.mc_list, next,
+				       next_mac_entry) {
+			if (!mac_entry->hw_config) {
+				ret = sxe2_drv_mc_config(adapter, &mac_entry->mac_addr, true);
+				if (ret && ret != -EEXIST) {
+					PMD_DEV_LOG_ERR(adapter, DRV,
+							"Failed to add mc rule, ret:%d", ret);
+					ret = -EINVAL;
+					goto l_end;
+				}
+				mac_entry->hw_config = true;
+				ret = 0;
+			}
+		}
+	}
+
+	if (adapter->filter_ctxt.vlan_num > 0) {
+		RTE_TAILQ_FOREACH_SAFE(vlan_entry, &adapter->filter_ctxt.vlan_list, next,
+				       next_vlan_entry) {
+			if (!vlan_entry->hw_config) {
+				ret = sxe2_drv_vlan_filter_id_config(adapter,
+				    &vlan_entry->vlan_info, true);
+				if (ret && ret != -EEXIST) {
+					PMD_DEV_LOG_ERR(adapter, DRV,
+							"Failed to add vlan rule, ret:%d", ret);
+					ret = -EINVAL;
+					goto l_end;
+				}
+				vlan_entry->hw_config = true;
+				ret = 0;
+			}
+		}
+	}
+
+	if (adapter->filter_ctxt.vlan_info.filter_on) {
+		if (!(adapter->filter_ctxt.vlan_info.hw_filter_on)) {
+			ret = sxe2_drv_vlan_filter_switch(adapter, true);
+			if (ret && ret != -EEXIST) {
+				PMD_DEV_LOG_ERR(adapter, DRV,
+						"Failed to add vlan ctrl, ret:%d", ret);
+				ret = -EINVAL;
+				goto l_end;
+			}
+			adapter->filter_ctxt.vlan_info.hw_filter_on = true;
+			ret = 0;
+		}
+	}
+
+	if ((adapter->filter_ctxt.cur_promisc_flags & SXE2_PROMISC) &&
+	    (!(adapter->filter_ctxt.hw_promisc_flags & SXE2_PROMISC))) {
+		ret = sxe2_drv_promisc_config(adapter, true);
+		if (ret && ret != -EEXIST) {
+			PMD_DEV_LOG_ERR(adapter, DRV,
+					"Failed to set promisc, ret:%d", ret);
+			goto l_end;
+		}
+		adapter->filter_ctxt.hw_promisc_flags |= SXE2_PROMISC;
+		ret = 0;
+	}
+
+	if ((adapter->filter_ctxt.cur_promisc_flags & SXE2_PROMISC_MULTICAST) &&
+	    (!(adapter->filter_ctxt.hw_promisc_flags & SXE2_PROMISC_MULTICAST))) {
+		ret = sxe2_drv_allmulti_config(adapter, true);
+		if (ret && ret != -EEXIST) {
+			PMD_DEV_LOG_ERR(adapter, DRV,
+					"Failed to set allmulti, ret:%d", ret);
+			goto l_end;
+		}
+		adapter->filter_ctxt.hw_promisc_flags |= SXE2_PROMISC_MULTICAST;
+		ret = 0;
+	}
+l_end:
+	return ret;
+}
+
+int32_t sxe2_l2_rule_update(struct sxe2_adapter *adapter)
+{
+	int32_t ret = 0;
+
+	if (!adapter->flow_isolated && !adapter->switchdev_info.is_switchdev &&
+	    adapter->rule_started) {
+		adapter->filter_ctxt.cur_l2_config = true;
+	} else {
+		adapter->filter_ctxt.cur_l2_config = false;
+	}
+
+	if (adapter->filter_ctxt.cur_l2_config !=
+	    adapter->filter_ctxt.hw_l2_config) {
+		if (adapter->filter_ctxt.cur_l2_config) {
+			ret = sxe2_all_filter_hw_set(adapter);
+			if (!ret)
+				adapter->filter_ctxt.hw_l2_config = true;
+		} else {
+			ret = sxe2_all_filter_hw_clear(adapter);
+			if (!ret)
+				adapter->filter_ctxt.hw_l2_config = false;
+		}
+	}
+	return ret;
+}
+
+int32_t sxe2_filter_rule_stop(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	int32_t ret = 0;
+	adapter->rule_started = 0;
+
+	ret = sxe2_l2_rule_update(adapter);
+	if (ret != 0)
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to update l2 rule");
+
+	return ret;
+}
+
+int32_t sxe2_filter_rule_start(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	int32_t ret = 0;
+	adapter->rule_started = 1;
+
+	ret = sxe2_l2_rule_update(adapter);
+	if (ret != 0)
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to update l2 rule");
+
+	return ret;
+}
+
+int32_t sxe2_filter_init(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+
+	rte_spinlock_init(&adapter->filter_ctxt.filter_lock);
+
+	TAILQ_INIT(&adapter->filter_ctxt.uc_list);
+	adapter->filter_ctxt.uc_num = 0;
+
+	TAILQ_INIT(&adapter->filter_ctxt.mc_list);
+	adapter->filter_ctxt.mc_num = 0;
+
+	TAILQ_INIT(&adapter->filter_ctxt.vlan_list);
+	adapter->filter_ctxt.vlan_num = 0;
+	return 0;
+}
+
+int32_t sxe2_filter_uinit(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	sxe2_uc_filter_clear(adapter, true);
+	adapter->filter_ctxt.uc_num = 0;
+
+	sxe2_mc_filter_clear(adapter, true);
+	adapter->filter_ctxt.mc_num = 0;
+
+	sxe2_vlan_filters_clear(adapter, true);
+	adapter->filter_ctxt.vlan_num = 0;
+	return 0;
+}
diff --git a/drivers/net/sxe2/sxe2_filter.h b/drivers/net/sxe2/sxe2_filter.h
new file mode 100644
index 0000000000..6262e8c845
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_filter.h
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef __SXE2_FILTER_H__
+#define __SXE2_FILTER_H__
+#include <ethdev_driver.h>
+
+#define SXE2_PROMISC  (1UL << 0UL)
+#define SXE2_PROMISC_MULTICAST  (1UL << 1UL)
+
+struct sxe2_vlan_info {
+	uint8_t port_vlan_exist;
+	uint8_t is_switchdev;
+	uint16_t max_cnt;
+	uint16_t cnt;
+
+	bool filter_on;
+	bool hw_filter_on;
+
+	uint16_t tpid;
+	uint16_t vid;
+
+	uint8_t outer_insert;
+	uint8_t outer_strip;
+	uint8_t inner_insert;
+	uint8_t inner_strip;
+};
+
+struct sxe2_vlan {
+	uint16_t tpid;
+	uint16_t vid;
+	uint8_t prio;
+};
+
+struct sxe2_vlan_filter {
+	TAILQ_ENTRY(sxe2_vlan_filter) next;
+	bool hw_config;
+	bool default_config;
+	struct sxe2_vlan vlan_info;
+};
+
+TAILQ_HEAD(sxe2_vlan_filter_list_head, sxe2_vlan_filter);
+
+struct sxe2_mac_filter {
+	TAILQ_ENTRY(sxe2_mac_filter) next;
+	bool hw_config;
+	bool default_config;
+	struct rte_ether_addr mac_addr;
+};
+
+TAILQ_HEAD(sxe2_uc_filter_list_head, sxe2_mac_filter);
+TAILQ_HEAD(sxe2_mc_filter_list_head, sxe2_mac_filter);
+
+int32_t sxe2_uc_filter_add(struct sxe2_adapter *adapter,
+			struct rte_ether_addr *mac_addr, bool default_config);
+
+int32_t sxe2_uc_filter_del(struct sxe2_adapter *adapter,
+			struct rte_ether_addr *mac_addr);
+
+void sxe2_uc_filter_clear(struct sxe2_adapter *adapter, bool default_config);
+
+int32_t sxe2_mc_filter_add(struct sxe2_adapter *adapter,
+			struct rte_ether_addr *mac_addr, bool default_config);
+
+int32_t sxe2_mc_filter_del(struct sxe2_adapter *adapter,
+			struct rte_ether_addr *mac_addr);
+
+void sxe2_mc_filter_clear(struct sxe2_adapter *adapter, bool default_config);
+
+int32_t sxe2_vlan_filter_add(struct sxe2_adapter *adapter,
+	struct sxe2_vlan *vlan, bool default_config);
+
+int32_t sxe2_vlan_filter_del(struct sxe2_adapter *adapter, struct sxe2_vlan *vlan);
+
+void sxe2_vlan_filters_clear(struct sxe2_adapter *adapter, bool default_config);
+
+int32_t sxe2_vlan_filter_ctrl(struct sxe2_adapter *adapter, bool flag);
+
+int32_t sxe2_promisc_add(struct sxe2_adapter *adapter);
+
+int32_t sxe2_promisc_del(struct sxe2_adapter *adapter);
+
+int32_t sxe2_allmulti_add(struct sxe2_adapter *adapter);
+
+int32_t sxe2_allmulti_del(struct sxe2_adapter *adapter);
+
+int32_t sxe2_l2_rule_update(struct sxe2_adapter *adapter);
+
+int32_t sxe2_filter_rule_stop(struct rte_eth_dev *dev);
+
+int32_t sxe2_filter_rule_start(struct rte_eth_dev *dev);
+
+int32_t sxe2_filter_init(struct rte_eth_dev *dev);
+
+int32_t sxe2_filter_uinit(struct rte_eth_dev *dev);
+
+#endif /* __SXE2_FILTER_H__ */
diff --git a/drivers/net/sxe2/sxe2_mac.c b/drivers/net/sxe2/sxe2_mac.c
index 3c2f909002..d94936a742 100644
--- a/drivers/net/sxe2/sxe2_mac.c
+++ b/drivers/net/sxe2/sxe2_mac.c
@@ -10,6 +10,438 @@
 #include "sxe2_cmd_chnl.h"
 #include "sxe2_host_regs.h"
 
+int32_t sxe2_mac_default_cfg(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	int32_t                     ret;
+	struct rte_ether_addr broadcast = {
+		.addr_bytes = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff} };
+	struct rte_ether_addr mac_addr;
+
+	rte_ether_addr_copy((struct rte_ether_addr *)
+		adapter->dev_info.mac.perm_addr, &mac_addr);
+	ret = sxe2_uc_filter_add(adapter, &mac_addr, true);
+	if (ret != 0) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to add default MAC filter");
+		goto l_end;
+	}
+
+	rte_ether_addr_copy(&broadcast, &mac_addr);
+	ret = sxe2_mc_filter_add(adapter, &mac_addr, true);
+	if (ret != 0) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to add broadcast MAC filter");
+		goto l_end;
+	}
+
+	ret = 0;
+l_end:
+	return ret;
+}
+
+int32_t sxe2_mac_addr_init(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	int32_t ret                         = -1;
+	PMD_INIT_FUNC_TRACE();
+
+	if (!rte_is_unicast_ether_addr
+		((struct rte_ether_addr *)adapter->dev_info.mac.perm_addr)) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "Invalid MAC address");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	dev->data->mac_addrs = rte_zmalloc("sxe2_mac_adds",
+					sizeof(struct rte_ether_addr) * SXE2_NUM_MACADDR_MAX, 0);
+	if (!dev->data->mac_addrs) {
+		PMD_LOG_ERR(DRV, "Failed to allocate memory to store mac address");
+		ret = -ENOMEM;
+		goto l_end;
+	}
+
+	rte_ether_addr_copy((struct rte_ether_addr *)adapter->dev_info.mac.perm_addr,
+		&dev->data->mac_addrs[0]);
+
+	ret = 0;
+
+l_end:
+	return ret;
+}
+
+void sxe2_mac_addr_uinit(struct rte_eth_dev *dev)
+{
+	PMD_INIT_FUNC_TRACE();
+	if (dev != NULL && dev->data->mac_addrs != NULL) {
+		rte_free(dev->data->mac_addrs);
+		dev->data->mac_addrs = NULL;
+	}
+}
+
+int32_t sxe2_mac_addr_add(struct rte_eth_dev *dev, struct rte_ether_addr *mac_addr,
+		      __rte_unused uint32_t index, __rte_unused uint32_t pool)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	int32_t ret = -1;
+
+	if (rte_is_zero_ether_addr(mac_addr)) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "Invalid MAC Address");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (rte_is_multicast_ether_addr(mac_addr))
+		ret = sxe2_mc_filter_add(adapter, mac_addr, true);
+	else
+		ret = sxe2_uc_filter_add(adapter, mac_addr, false);
+
+	if (ret)
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to add MAC filter");
+
+l_end:
+	return ret;
+}
+
+void sxe2_mac_addr_del(struct rte_eth_dev *dev,  uint32_t index)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct rte_ether_addr *mac_addr = &dev->data->mac_addrs[index];
+	int32_t ret = -1;
+
+	if (rte_is_multicast_ether_addr(mac_addr))
+		ret = sxe2_mc_filter_del(adapter, mac_addr);
+	else
+		ret = sxe2_uc_filter_del(adapter, mac_addr);
+
+	if (ret)
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to remove MAC filter");
+}
+
+int32_t sxe2_mac_addr_set(struct rte_eth_dev *dev, struct rte_ether_addr *mac_addr)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	int32_t ret = 0;
+	struct rte_ether_addr *old_addr = (struct rte_ether_addr *)&adapter->dev_info.mac.perm_addr;
+	struct rte_ether_addr temp_addr;
+
+	if (rte_is_same_ether_addr(old_addr, mac_addr))
+		goto l_end;
+
+	if (rte_is_multicast_ether_addr(mac_addr)) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to set multicast addr");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	ret = sxe2_uc_filter_del(adapter, old_addr);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to remove MAC filter");
+		goto l_end;
+	}
+
+	rte_ether_addr_copy(old_addr, &temp_addr);
+
+	rte_ether_addr_copy(mac_addr, old_addr);
+
+	ret = sxe2_uc_filter_add(adapter, mac_addr, true);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to add MAC filter");
+		rte_ether_addr_copy(&temp_addr, old_addr);
+		(void)sxe2_uc_filter_add(adapter, old_addr, true);
+		goto l_end;
+	}
+l_end:
+	return ret;
+}
+
+int32_t sxe2_set_mc_addr_list(struct rte_eth_dev *dev,
+			struct rte_ether_addr *mc_addrs,
+			uint32_t mc_addrs_num)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	int32_t ret = 0;
+	uint32_t i;
+	const uint8_t *mac;
+
+	if (mc_addrs_num > SXE2_NUM_MACADDR_MAX) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "Too many multicast MAC addresses, ");
+		ret =  -1;
+		goto l_end;
+	}
+
+	sxe2_mc_filter_clear(adapter, false);
+
+	for (i = 0; i < mc_addrs_num; i++) {
+		if (!rte_is_multicast_ether_addr(&mc_addrs[i])) {
+			mac = mc_addrs[i].addr_bytes;
+			PMD_DEV_LOG_ERR(adapter, DRV,
+					"Invalid mac: %02x:%02x:%02x:%02x:%02x:%02x",
+					mac[0], mac[1], mac[2], mac[3], mac[4],
+					mac[5]);
+			ret = -EINVAL;
+			goto add_err;
+		}
+
+		ret = sxe2_mc_filter_add(adapter, &mc_addrs[i], false);
+		if (ret) {
+			PMD_DEV_LOG_ERR(adapter, DRV,
+			    "Failed to remove old multicast MAC filter list");
+			goto add_err;
+		}
+	}
+	goto l_end;
+add_err:
+	sxe2_mc_filter_clear(adapter, false);
+l_end:
+	return ret;
+}
+
+int32_t sxe2_dev_vlan_filter_set(struct rte_eth_dev *dev, uint16_t vlan_id, int32_t on)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_vlan vlan = {
+		.tpid = RTE_ETHER_TYPE_VLAN,
+		.vid = vlan_id,
+		.prio = 0
+	};
+	int32_t ret = 0;
+
+	if (sxe2_dev_port_vlan_check(dev)) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "Filter not supported with Port VLAN");
+		ret = -ENOTSUP;
+		goto l_end;
+	}
+
+	if (vlan_id == 0)
+		goto l_end;
+
+	if (on) {
+		ret = sxe2_vlan_filter_add(adapter, &vlan, false);
+		if (ret < 0) {
+			PMD_DEV_LOG_ERR(adapter, DRV, "Failed to add vlan filter");
+			goto l_end;
+		}
+	} else {
+		ret = sxe2_vlan_filter_del(adapter, &vlan);
+		if (ret < 0) {
+			PMD_DEV_LOG_ERR(adapter, DRV, "Failed to remove vlan filter");
+			goto l_end;
+		}
+	}
+
+l_end:
+	return ret;
+}
+
+int32_t sxe2_dev_vlan_offload_set(struct rte_eth_dev *dev, int32_t mask)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	int32_t ret = 0;
+	struct rte_eth_rxmode *rxmode = &dev->data->dev_conf.rxmode;
+	struct rte_eth_txmode *txmode = &dev->data->dev_conf.txmode;
+	struct sxe2_vlan_info new_info = adapter->filter_ctxt.vlan_info;
+	bool port_vlan = new_info.port_vlan_exist;
+
+	uint8_t out_strip_mask = SXE2_DPDK_OFFLOAD_OUTER_STRIP_8021Q |
+			    SXE2_DPDK_OFFLOAD_OUTER_STRIP_8021AD |
+			    SXE2_DPDK_OFFLOAD_OUTER_STRIP_QINQ1;
+
+	if (txmode->offloads & RTE_ETH_TX_OFFLOAD_QINQ_INSERT) {
+		if (!(txmode->offloads & RTE_ETH_TX_OFFLOAD_VLAN_INSERT)) {
+			PMD_DEV_LOG_ERR(adapter, DRV,
+			    "VLAN INSERT must be enabled when QinQ INSERT is enabled");
+			return -EINVAL;
+		}
+		if (port_vlan) {
+			PMD_DEV_LOG_ERR(adapter, DRV,
+					"QINQ INSERT not supported with Port VLAN");
+			return -EINVAL;
+		}
+	}
+
+	if (mask & RTE_ETH_QINQ_STRIP_MASK) {
+		if (rxmode->offloads & RTE_ETH_RX_OFFLOAD_QINQ_STRIP) {
+			if (port_vlan) {
+				PMD_DEV_LOG_ERR(adapter, DRV,
+						"QinQ strip not supported with Port VLAN");
+				return -EINVAL;
+			}
+			new_info.inner_strip = SXE2_VSI_TSR_ID_VLAN;
+		} else {
+			new_info.inner_strip = 0;
+		}
+	}
+
+	if (mask & RTE_ETH_VLAN_STRIP_MASK) {
+		if (rxmode->offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP) {
+			new_info.outer_strip =
+				port_vlan ? 0 : out_strip_mask;
+			new_info.inner_strip =
+				port_vlan ? new_info.inner_strip : new_info.inner_strip;
+		} else {
+			if (new_info.inner_strip != 0) {
+				PMD_DEV_LOG_ERR(adapter, DRV,
+					"Must disable QinQ strip before disabling VLAN strip");
+				return -EINVAL;
+			}
+			new_info.outer_strip = 0;
+		}
+	}
+
+	if (mask & (RTE_ETH_VLAN_STRIP_MASK | RTE_ETH_QINQ_STRIP_MASK)) {
+		struct sxe2_vlan_info old_info = adapter->filter_ctxt.vlan_info;
+		adapter->filter_ctxt.vlan_info = new_info;
+
+		ret = sxe2_drv_vlan_insert_strip_cfg(adapter);
+		if (ret) {
+			adapter->filter_ctxt.vlan_info = old_info;
+			return ret;
+		}
+	}
+	if (mask & RTE_ETH_VLAN_FILTER_MASK) {
+		if (adapter->filter_ctxt.vlan_info.port_vlan_exist) {
+			ret = 0;
+			PMD_DEV_LOG_INFO(adapter, INIT, "vlan filter is not support when port vlan is enabled");
+			goto l_end;
+		}
+
+		ret = sxe2_vlan_filter_ctrl(adapter,
+			    !!(rxmode->offloads & RTE_ETH_RX_OFFLOAD_VLAN_FILTER));
+		if (ret) {
+			PMD_DEV_LOG_ERR(adapter, DRV,
+			    "sxe2_drv_vlan_filter_switch failed ret:%d", ret);
+			goto l_end;
+		}
+	}
+
+	PMD_DEV_LOG_DEBUG(adapter, DRV,
+	    "mask:0x%x rx mode offload:0x%" PRIx64 " vlan offload set done",
+	    mask, rxmode->offloads);
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_vlan_filter_zero(struct sxe2_adapter *adapter)
+{
+	struct sxe2_vlan vlan;
+	int32_t ret;
+	uint16_t tpids[] = {RTE_ETHER_TYPE_VLAN, RTE_ETHER_TYPE_QINQ, RTE_ETHER_TYPE_QINQ1};
+	uint8_t i;
+
+	vlan = (struct sxe2_vlan){0, 0, 0};
+	ret = sxe2_vlan_filter_add(adapter, &vlan, true);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to add VLAN ID 0");
+		goto l_end;
+	}
+
+	for (i = 0; i < RTE_DIM(tpids); i++) {
+		vlan = (struct sxe2_vlan){tpids[i], 0, 0};
+		ret = sxe2_vlan_filter_add(adapter, &vlan, true);
+		if (ret) {
+			PMD_DEV_LOG_ERR(adapter, DRV, "Failed to add VLAN ID 0 when tpid:0x%x",
+					tpids[i]);
+			goto l_end;
+		}
+	}
+
+l_end:
+	return ret;
+}
+
+int32_t sxe2_vlan_cfg_init(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	int32_t ret = 0;
+
+	ret = sxe2_drv_vlan_config_query(adapter);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to query vlan config, ret=%d", ret);
+		goto l_end;
+	}
+
+	if (!sxe2_dev_port_vlan_check(dev))
+		adapter->filter_ctxt.vlan_info.outer_insert =
+			SXE2_DPDK_OFFLOAD_OUTER_INSERT_8021Q |
+			SXE2_DPDK_OFFLOAD_INSERT_ENABLE;
+	else
+		adapter->filter_ctxt.vlan_info.outer_insert = 0;
+
+	adapter->filter_ctxt.vlan_info.inner_insert =
+			SXE2_DPDK_OFFLOAD_INNER_INSERT_QINQ1 | SXE2_DPDK_OFFLOAD_INSERT_ENABLE;
+
+	if (!sxe2_dev_port_vlan_check(dev)) {
+		ret = sxe2_vlan_filter_zero(adapter);
+		if (ret != 0)
+			PMD_DEV_LOG_ERR(adapter, DRV, "Failed to add vlan filter switch:0 "
+					"for port:%d", adapter->port_idx);
+	}
+
+l_end:
+	return ret;
+}
+
+int32_t sxe2_vlan_default_cfg(struct rte_eth_dev *dev)
+{
+	int32_t ret = 0;
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+
+	ret = sxe2_dev_vlan_offload_set(dev, RTE_ETH_VLAN_STRIP_MASK |
+					RTE_ETH_QINQ_STRIP_MASK |
+					RTE_ETH_VLAN_FILTER_MASK);
+	if (ret)
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to cfg vlan offload, ret:%d", ret);
+
+	return ret;
+}
+
+int32_t sxe2_promisc_enable(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	int32_t ret = 0;
+
+	ret = sxe2_promisc_add(adapter);
+	if (ret)
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to enable promisc, ret:%d", ret);
+
+	return ret;
+}
+
+int32_t sxe2_promisc_disable(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	int32_t ret = 0;
+
+	ret = sxe2_promisc_del(adapter);
+	if (ret)
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to disable promisc, ret:%d", ret);
+
+	return ret;
+}
+
+int32_t sxe2_allmulti_enable(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	int32_t ret = 0;
+
+	ret = sxe2_allmulti_add(adapter);
+	if (ret)
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to enable allmulti, ret:%d", ret);
+
+	return ret;
+}
+
+int32_t sxe2_allmulti_disable(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	int32_t ret = 0;
+
+	ret = sxe2_allmulti_del(adapter);
+	if (ret)
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to disable allmulti, ret:%d", ret);
+
+	return ret;
+}
+
 int32_t sxe2_link_update_init(struct rte_eth_dev *dev)
 {
 	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
diff --git a/drivers/net/sxe2/sxe2_mac.h b/drivers/net/sxe2/sxe2_mac.h
index 28dc05e125..55fd1829a0 100644
--- a/drivers/net/sxe2/sxe2_mac.h
+++ b/drivers/net/sxe2/sxe2_mac.h
@@ -34,7 +34,7 @@
 					SXE2_DPDK_OFFLOAD_OUTER_STRIP_QINQ1)
 #define SXE2_DPDK_OFFLOAD_STRIP_OFFSET SXE2_VSI_TSR_SHOW_TAG_S
 
-#define SXE2_DPDK_OFFLOAD_INSERT_ENABLE (BIT(3))
+#define SXE2_DPDK_OFFLOAD_INSERT_ENABLE (RTE_BIT32(3))
 
 struct sxe2_mac_mc_list {
 	uint32_t count;
@@ -43,6 +43,40 @@ struct sxe2_mac_mc_list {
 
 int32_t sxe2_link_update_init(struct rte_eth_dev *dev);
 
+int32_t sxe2_mac_default_cfg(struct rte_eth_dev *dev);
+
+int32_t sxe2_vlan_cfg_init(struct rte_eth_dev *dev);
+
+int32_t sxe2_mac_addr_init(struct rte_eth_dev *dev);
+
+void sxe2_mac_addr_uinit(struct rte_eth_dev *dev);
+
+int32_t sxe2_mac_addr_add(struct rte_eth_dev *dev,
+			struct rte_ether_addr *mac_addr,
+			__rte_unused uint32_t index, __rte_unused uint32_t pool);
+
+void sxe2_mac_addr_del(struct rte_eth_dev *dev,  uint32_t index);
+
+int32_t sxe2_mac_addr_set(struct rte_eth_dev *dev, struct rte_ether_addr *mac_addr);
+
+int32_t sxe2_set_mc_addr_list(struct rte_eth_dev *dev,
+	struct rte_ether_addr *mc_addrs,
+	uint32_t mc_addrs_num);
+
+int32_t sxe2_promisc_enable(struct rte_eth_dev *dev);
+
+int32_t sxe2_promisc_disable(struct rte_eth_dev *dev);
+
+int32_t sxe2_allmulti_enable(struct rte_eth_dev *dev);
+
+int32_t sxe2_allmulti_disable(struct rte_eth_dev *dev);
+
+int32_t sxe2_dev_vlan_filter_set(struct rte_eth_dev *dev, uint16_t vlan_id, int32_t on);
+
+int32_t sxe2_dev_vlan_offload_set(struct rte_eth_dev *dev, int32_t mask);
+
+int32_t sxe2_vlan_default_cfg(struct rte_eth_dev *dev);
+
 int32_t sxe2_link_update(struct rte_eth_dev *dev, __rte_unused int32_t wait_to_complete);
 
 int32_t sxe2_mtu_set(struct rte_eth_dev *dev, uint16_t mtu);
diff --git a/drivers/net/sxe2/sxe2_txrx_poll.c b/drivers/net/sxe2/sxe2_txrx_poll.c
index b9d34afb31..21d5c38725 100644
--- a/drivers/net/sxe2/sxe2_txrx_poll.c
+++ b/drivers/net/sxe2/sxe2_txrx_poll.c
@@ -660,6 +660,53 @@ sxe2_rx_desc_error_para(__rte_unused struct sxe2_rx_queue *rxq,
 	return flags;
 }
 
+static inline void sxe2_rx_desc_vlan_para_fill(struct rte_mbuf *mbuf,
+			union sxe2_rx_desc *desc)
+{
+	if (0 == (rte_le_to_cpu_64(desc->wb.status_err_ptype_len) &
+		  SXE2_RX_DESC_STATUS_L2TAG1_P_MASK)) {
+		mbuf->vlan_tci = 0;
+	} else {
+		mbuf->ol_flags |= (RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED);
+		mbuf->vlan_tci = rte_le_to_cpu_16(desc->wb.l2tag1);
+		PMD_LOG_DEBUG(RX, "Rx desc mbuf vlan, vlan_tci:%u",
+			mbuf->vlan_tci);
+	}
+#ifndef RTE_LIBRTE_SXE2_16BYTE_RX_DESC
+	if (0 == (rte_le_to_cpu_32(desc->wb.status_lrocnt_fdpf_id) &
+				SXE2_RX_DESC_EXT_STATUS_L2TAG2P_MASK)) {
+		mbuf->vlan_tci_outer = 0;
+	} else {
+		mbuf->ol_flags |= RTE_MBUF_F_RX_QINQ_STRIPPED | RTE_MBUF_F_RX_QINQ |
+				RTE_MBUF_F_RX_VLAN_STRIPPED | RTE_MBUF_F_RX_VLAN;
+		mbuf->vlan_tci_outer = mbuf->vlan_tci;
+		mbuf->vlan_tci = rte_le_to_cpu_16(desc->wb.l2tag2_2nd);
+		PMD_LOG_DEBUG(RX, "Rx desc out vlan, l2tag2_1st:%u l2tag2_2nd:%u.",
+				rte_le_to_cpu_16(desc->wb.l2tag2_1st),
+				rte_le_to_cpu_16(desc->wb.l2tag2_2nd));
+	}
+#endif
+}
+
+static inline void
+sxe2_rx_desc_filter_para_fill(struct sxe2_rx_queue *rxq __rte_unused,
+		struct rte_mbuf *mbuf, union sxe2_rx_desc *desc)
+{
+	if (SXE2_RX_DESC_STATUS_RSS_VLD_MASK &
+				rte_le_to_cpu_64(desc->wb.status_err_ptype_len)) {
+		mbuf->ol_flags |= RTE_MBUF_F_RX_RSS_HASH;
+		mbuf->hash.rss = rte_le_to_cpu_32(desc->wb.filter_status);
+		PMD_LOG_DEBUG(RX, "rss id:%u", mbuf->hash.rss);
+	}
+#ifndef RTE_LIBRTE_SXE2_16BYTE_RX_DESC
+	if (SXE2_RX_DESC_FD_VLD_MASK & desc->wb.rxdid_src) {
+		mbuf->ol_flags |= (RTE_MBUF_F_RX_FDIR | RTE_MBUF_F_RX_FDIR_ID);
+		mbuf->hash.fdir.hi = rte_le_to_cpu_32(desc->wb.fd_filter_id);
+		PMD_LOG_DEBUG(RX, "fdir id:%u", mbuf->hash.fdir.hi);
+	}
+#endif
+}
+
 static __rte_always_inline void
 sxe2_rx_mbuf_common_fields_fill(struct sxe2_rx_queue *rxq, struct rte_mbuf *mbuf,
 		union sxe2_rx_desc *rxd)
@@ -673,6 +720,8 @@ sxe2_rx_mbuf_common_fields_fill(struct sxe2_rx_queue *rxq, struct rte_mbuf *mbuf
 	mbuf->packet_type = ptype_tbl[SXE2_RX_DESC_PTYPE_VAL_GET(qword1)];
 
 	pkt_flags = sxe2_rx_desc_error_para(rxq, rxd);
+	sxe2_rx_desc_vlan_para_fill(mbuf, rxd);
+	sxe2_rx_desc_filter_para_fill(rxq, mbuf, rxd);
 
 	mbuf->ol_flags |= pkt_flags;
 }
-- 
2.47.3

