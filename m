Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30F6CD5BAB
	for <dpdk-dev@archiver.kernel.org>; Sun, 24 May 2026 09:34:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8E3E40A7A;
	Sun, 24 May 2026 11:33:25 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 1FA574065C
 for <dev@dpdk.org>; Sun, 24 May 2026 11:33:10 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowABXd97QxRJq+04kEg--.9115S19;
 Sun, 24 May 2026 17:33:09 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v1 17/23] net/sxe2: implement private dump info
Date: Sun, 24 May 2026 17:32:53 +0800
Message-ID: <20260524093259.397506-18-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260524093259.397506-1-liujie5@linkdatatechnology.com>
References: <20260524093259.397506-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABXd97QxRJq+04kEg--.9115S19
X-Coremail-Antispam: 1UD129KBjvAXoWfJw15ZF1UKF48uryfZF17GFg_yoW8Jry7Ko
 WxXr13Xr1xAryIvwn5Arn7CFW3ZaykWws5Cayaga98uanxtF4UAFWFgw43Z3Z8KF4rtFyY
 934Fyas8JFWqqF1rn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
 Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
 84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r
 4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8
 Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
 x0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
 JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xxMx
 AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
 Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwI
 xGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8
 Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0x
 vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUB89_UUUUU=
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

This patch implements the 'eth_dev_priv_dump' ops for the sxe2 PMD.
This interface allows applications to dump driver-specific internal
state and configuration information to a file stream.

The output includes:
- capabilities.
- device base info.
- device args info.
- device filter info.
- reprenstor info.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/meson.build        |   1 +
 drivers/net/sxe2/sxe2_dump.c        | 289 ++++++++++++++++++++++++++++
 drivers/net/sxe2/sxe2_dump.h        |  12 ++
 drivers/net/sxe2/sxe2_ethdev.c      |   3 +
 drivers/net/sxe2/sxe2_ethdev_repr.c |   3 +
 5 files changed, 308 insertions(+)
 create mode 100644 drivers/net/sxe2/sxe2_dump.c
 create mode 100644 drivers/net/sxe2/sxe2_dump.h

diff --git a/drivers/net/sxe2/meson.build b/drivers/net/sxe2/meson.build
index 61925ee80f..631730bf3e 100644
--- a/drivers/net/sxe2/meson.build
+++ b/drivers/net/sxe2/meson.build
@@ -77,6 +77,7 @@ sources += files(
         'sxe2_flow_parse_action.c',
         'sxe2_flow_parse_pattern.c',
         'sxe2_flow_parse_engine.c',
+        'sxe2_dump.c',
 )
 
 allow_internal_get_api = true
diff --git a/drivers/net/sxe2/sxe2_dump.c b/drivers/net/sxe2/sxe2_dump.c
new file mode 100644
index 0000000000..9898456aea
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_dump.c
@@ -0,0 +1,289 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#include <rte_malloc.h>
+#include <arpa/inet.h>
+
+#include "sxe2_common_log.h"
+#include "sxe2_ethdev.h"
+#include "sxe2_dump.h"
+#include "sxe2_stats.h"
+
+static void
+sxe2_dump_dev_feature_capability(FILE *file, struct rte_eth_dev *dev)
+{
+	uint32_t i;
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	const struct {
+		uint32_t cap_bit;
+		const char *name;
+	} caps_name[] = {
+		{SXE2_DEV_CAPS_OFFLOAD_L2, "L2"},
+		{SXE2_DEV_CAPS_OFFLOAD_VLAN, "VLAN"},
+		{SXE2_DEV_CAPS_OFFLOAD_IPSEC, "IPSEC"},
+		{SXE2_DEV_CAPS_OFFLOAD_RSS, "RSS"},
+		{SXE2_DEV_CAPS_OFFLOAD_FNAV, "FNAV"},
+		{SXE2_DEV_CAPS_OFFLOAD_TM, "TM"},
+		{SXE2_DEV_CAPS_OFFLOAD_PTP, "PTP"},
+	};
+	if (adapter->is_dev_repr)
+		goto l_end;
+
+	fprintf(file, "  - Dev Capability:\n");
+	for (i = 0; i < RTE_DIM(caps_name); i++) {
+		fprintf(file, "\t  -- support %s: %s\n", caps_name[i].name,
+			(adapter->cap_flags & caps_name[i].cap_bit) ? "Yes" :
+									 "No");
+	}
+l_end:
+	return;
+}
+
+static void
+sxe2_dump_device_basic_info(FILE *file, struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+
+	fprintf(file,
+		"  - Device Base Info:\n"
+		"\t  -- name: %s\n"
+		"\t  -- pf_idx: %u port_idx: %u\n"
+		"\t  -- tx_mode_flags: 0x%x rx_mode_flags: 0x%x\n"
+		"\t  -- flow_isolate_cfg: 0x%x flow_isolated: 0x%x\n"
+		"\t  -- dev_type: 0x%x is_switchdev: 0x%x\n"
+		"\t  -- is_dev_repr: 0x%x dev_port_id: 0x%x\n"
+		"\t  -- dev_flags: 0x%x\n"
+		"\t  -- intr_conf lsc: %u rxq: %u rmv: %u\n",
+		dev->data->name,
+		adapter->pf_idx, adapter->port_idx,
+		adapter->tx_mode_flags, adapter->rx_mode_flags,
+		adapter->flow_isolate_cfg, adapter->flow_isolated,
+		adapter->dev_type, adapter->switchdev_info.is_switchdev,
+		adapter->is_dev_repr, adapter->dev_port_id,
+		dev->data->dev_flags,
+		dev->data->dev_conf.intr_conf.lsc,
+		dev->data->dev_conf.intr_conf.rxq,
+		dev->data->dev_conf.intr_conf.rmv);
+}
+
+static void
+sxe2_dump_dev_args_info(FILE *file, struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+
+	if (adapter->is_dev_repr)
+		goto l_end;
+
+	fprintf(file,
+		"  - Device Args Info:\n"
+		"\t  -- sw-stats-en: %s\n"
+		"\t  -- high-performance-mode: %s\n"
+		"\t  -- flow-duplicate-pattern: %u\n"
+		"\t  -- fnav-stat-type: %u\n"
+		"\t  -- sched_layer_mode: %u\n"
+		"\t  -- rx_low_latency: %s\n"
+		"\t  -- function-flow-direct: %s\n",
+		adapter->devargs.sw_stats_en ? "On" : "Off",
+		adapter->devargs.high_performance_mode ? "On" : "Off",
+		adapter->devargs.flow_dup_pattern_mode,
+		adapter->devargs.fnav_stat_type,
+		adapter->devargs.sched_layer_mode,
+		adapter->devargs.rx_low_latency ? "On" : "Off",
+		adapter->devargs.func_flow_direct_en ? "On" : "Off");
+l_end:
+	return;
+}
+
+static void sxe2_dump_filter_info(FILE *file, struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_mac_filter *mac_entry;
+	struct sxe2_mac_filter *next_mac_entry;
+	struct sxe2_vlan_filter *vlan_entry;
+	struct sxe2_vlan_filter *next_vlan_entry;
+
+	if (adapter->is_dev_repr)
+		goto l_end;
+
+	fprintf(file,
+		"  - Device Filter Info:\n"
+		"\t  -- cur_promisc:0x%x hw_promisc:0x%x\n"
+		"\t  -- unicast_num: %u multicast_num: %u\n"
+		"\t  -- vlan_num: %u filter_on: %u hw_filter_on: %u\n"
+		"\t  -- vlan max_cnt: %u cnt: %u\n"
+		"\t  -- tpid: 0x%x vid: 0x%x\n"
+		"\t  -- vlan_outer_insert: 0x%x vlan_outer_strip: 0x%x\n"
+		"\t  -- vlan_inner_insert: 0x%x vlan_inner_strip: 0x%x\n",
+		adapter->filter_ctxt.cur_promisc_flags,
+		adapter->filter_ctxt.hw_promisc_flags,
+		adapter->filter_ctxt.uc_num,
+		adapter->filter_ctxt.mc_num,
+		adapter->filter_ctxt.vlan_num,
+		adapter->filter_ctxt.vlan_info.filter_on,
+		adapter->filter_ctxt.vlan_info.hw_filter_on,
+		adapter->filter_ctxt.vlan_info.max_cnt,
+		adapter->filter_ctxt.vlan_info.cnt,
+		adapter->filter_ctxt.vlan_info.tpid,
+		adapter->filter_ctxt.vlan_info.vid,
+		adapter->filter_ctxt.vlan_info.outer_insert,
+		adapter->filter_ctxt.vlan_info.outer_strip,
+		adapter->filter_ctxt.vlan_info.inner_insert,
+		adapter->filter_ctxt.vlan_info.inner_strip);
+
+	if (adapter->filter_ctxt.uc_num > 0) {
+		fprintf(file,
+			"\t  -- Unicast entry:\n");
+		RTE_TAILQ_FOREACH_SAFE(mac_entry, &adapter->filter_ctxt.uc_list, next,
+				       next_mac_entry) {
+			fprintf(file,
+				"\t  -- addr: %02x:%02x:%02x:%02x:%02x:%02x hw status:%u "
+				"default:%u\n",
+				mac_entry->mac_addr.addr_bytes[0],
+				mac_entry->mac_addr.addr_bytes[1],
+				mac_entry->mac_addr.addr_bytes[2],
+				mac_entry->mac_addr.addr_bytes[3],
+				mac_entry->mac_addr.addr_bytes[4],
+				mac_entry->mac_addr.addr_bytes[5],
+				mac_entry->hw_config,
+				mac_entry->default_config);
+		}
+	}
+
+	if (adapter->filter_ctxt.mc_num > 0) {
+		fprintf(file,
+			"\t  -- Multicast entry:\n");
+		RTE_TAILQ_FOREACH_SAFE(mac_entry, &adapter->filter_ctxt.mc_list,
+				       next, next_mac_entry) {
+			fprintf(file,
+				"\t  -- addr: %02x:%02x:%02x:%02x:%02x:%02x "
+				"hw status:%u default:%u\n",
+				mac_entry->mac_addr.addr_bytes[0],
+				mac_entry->mac_addr.addr_bytes[1],
+				mac_entry->mac_addr.addr_bytes[2],
+				mac_entry->mac_addr.addr_bytes[3],
+				mac_entry->mac_addr.addr_bytes[4],
+				mac_entry->mac_addr.addr_bytes[5],
+				mac_entry->hw_config,
+				mac_entry->default_config);
+		}
+	}
+
+	if (adapter->filter_ctxt.vlan_num > 0) {
+		fprintf(file,
+			"\t  -- Vlan entry:\n");
+		RTE_TAILQ_FOREACH_SAFE(vlan_entry, &adapter->filter_ctxt.vlan_list,
+			next, next_vlan_entry) {
+			fprintf(file,
+				"\t  -- vlan tpid:0x%04x vid:0x%04x prio:%d "
+				"hw status:%u default:%u\n",
+				vlan_entry->vlan_info.tpid,
+				vlan_entry->vlan_info.vid,
+				vlan_entry->vlan_info.prio,
+				vlan_entry->hw_config,
+				vlan_entry->default_config);
+		}
+	}
+l_end:
+	return;
+}
+
+static const char *sxe2_vsi_id_str(uint16_t vsi_id, char *buf, size_t len)
+{
+	if (vsi_id == SXE2_INVALID_VSI_ID)
+		return "NA";
+
+	snprintf(buf, len, "%u", vsi_id);
+	return buf;
+}
+
+static void
+sxe2_dump_switchdev_info(FILE *file, struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	uint32_t idx;
+	char k_vsi_buf[16];
+	char u_vsi_buf[16];
+
+	if (adapter->is_dev_repr && adapter->repr_priv_data) {
+		fprintf(file,
+			"  - Reprenstor Info:\n"
+			"\t  -- repr_id: %u\n"
+			"\t  -- repr_q_id: %u\n"
+			"\t  -- repr_pf_id: %u\n"
+			"\t  -- repr_vf_id: %u\n"
+			"\t  -- repr_vf_vsi_id: %u\n"
+			"\t  -- repr_vf_k_vsi_id: %s\n"
+			"\t  -- repr_vf_u_vsi_id: %s\n",
+			adapter->repr_priv_data->repr_id,
+			adapter->repr_priv_data->repr_q_id,
+			adapter->repr_priv_data->repr_pf_id,
+			adapter->repr_priv_data->repr_vf_id,
+			adapter->repr_priv_data->repr_vf_vsi_id,
+			sxe2_vsi_id_str(adapter->repr_priv_data->repr_vf_k_vsi_id,
+					k_vsi_buf, sizeof(k_vsi_buf)),
+			sxe2_vsi_id_str(adapter->repr_priv_data->repr_vf_u_vsi_id,
+					u_vsi_buf, sizeof(u_vsi_buf)));
+		goto l_end;
+	}
+	if (adapter->switchdev_info.is_switchdev) {
+		fprintf(file,
+			"  - Switchdev Info:\n"
+			"\t  -- master:0x%x\n"
+			"\t  -- representor: 0x%x\n"
+			"\t  -- port_name_type: 0x%x\n"
+			"\t  -- nb_vf: %u nb_repr_vf: %u\n",
+			adapter->switchdev_info.master,
+			adapter->switchdev_info.representor,
+			adapter->switchdev_info.port_name_type,
+			adapter->repr_ctxt.nb_vf,
+			adapter->repr_ctxt.nb_repr_vf);
+		if (adapter->repr_ctxt.nb_vf > 0) {
+			fprintf(file,
+				"\t  -- vf entry:\n");
+			for (idx = 0; idx < adapter->repr_ctxt.nb_vf; idx++) {
+				fprintf(file,
+					"\t  -- func_id:%u vsi_type:%u kernel_vsi_id:%u dpdk_vsi_id:%u\n",
+					adapter->repr_ctxt.repr_vf_id[idx].func_id,
+					adapter->repr_ctxt.repr_vf_id[idx].vsi_type,
+					adapter->repr_ctxt.repr_vf_id[idx].kernel_vsi_id,
+					adapter->repr_ctxt.repr_vf_id[idx].dpdk_vsi_id);
+			}
+		}
+	}
+
+l_end:
+	return;
+}
+
+int32_t sxe2_eth_dev_priv_dump(struct rte_eth_dev *dev, FILE *file)
+{
+	char *buf = NULL;
+	size_t size = 0;
+	FILE *str;
+	int32_t ret = -1;
+
+	str = open_memstream(&buf, &size);
+	if (!str) {
+		PMD_LOG_ERR(DRV, "fopen fail.");
+		goto l_end;
+	}
+
+	sxe2_dump_dev_feature_capability(str, dev);
+	sxe2_dump_device_basic_info(str, dev);
+	sxe2_dump_dev_args_info(str, dev);
+	sxe2_dump_filter_info(str, dev);
+	sxe2_dump_switchdev_info(str, dev);
+
+	(void)fflush(str);
+
+	(void)fwrite(buf, 1, size, file);
+	(void)fflush(file);
+
+	ret = 0;
+
+	(void)fclose(str);
+	free(buf);
+l_end:
+	return ret;
+}
diff --git a/drivers/net/sxe2/sxe2_dump.h b/drivers/net/sxe2/sxe2_dump.h
new file mode 100644
index 0000000000..05d6db9b3d
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_dump.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef __SXE2_DUMP_H__
+#define __SXE2_DUMP_H__
+
+#include <ethdev_driver.h>
+
+int32_t sxe2_eth_dev_priv_dump(struct rte_eth_dev *dev, FILE *file);
+
+#endif /* __SXE2_DUMP_H__ */
diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
index edcedbab45..73a92d99f8 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -38,6 +38,7 @@
 #include "sxe2_host_regs.h"
 #include "sxe2_switchdev.h"
 #include "sxe2_ioctl_chnl_func.h"
+#include "sxe2_dump.h"
 #include "sxe2_ethdev_repr.h"
 #include "sxe2vf_regs.h"
 #include "sxe2_switchdev.h"
@@ -194,6 +195,8 @@ static const struct eth_dev_ops sxe2_eth_dev_ops = {
 
 	.get_module_info            = sxe2_get_module_info,
 	.get_module_eeprom          = sxe2_get_module_eeprom,
+
+	.eth_dev_priv_dump          = sxe2_eth_dev_priv_dump,
 };
 
 static int32_t sxe2_dev_configure(struct rte_eth_dev *dev)
diff --git a/drivers/net/sxe2/sxe2_ethdev_repr.c b/drivers/net/sxe2/sxe2_ethdev_repr.c
index a43991c379..faac1b2701 100644
--- a/drivers/net/sxe2/sxe2_ethdev_repr.c
+++ b/drivers/net/sxe2/sxe2_ethdev_repr.c
@@ -12,6 +12,7 @@
 #include "sxe2_switchdev.h"
 #include "sxe2_ptype.h"
 #include "sxe2_mp.h"
+#include "sxe2_dump.h"
 #include "sxe2_stats.h"
 #include "sxe2_flow.h"
 
@@ -237,6 +238,8 @@ static const struct eth_dev_ops sxe2_switchdev_repr_dev_ops = {
 	.allmulticast_enable        = sxe2_repr_allmulti_enable,
 	.allmulticast_disable       = sxe2_repr_allmulti_disable,
 
+	.eth_dev_priv_dump          = sxe2_eth_dev_priv_dump,
+
 	.stats_get                  = sxe2_stats_info_get,
 	.stats_reset                = sxe2_stats_info_reset,
 	.xstats_get                 = sxe2_xstats_info_get,
-- 
2.47.3

