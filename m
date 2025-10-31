Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D152CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Oct 2025 01:44:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6554402DB;
	Fri, 31 Oct 2025 02:44:27 +0100 (CET)
Received: from out28-50.mail.aliyun.com (out28-50.mail.aliyun.com
 [115.124.28.50]) by mails.dpdk.org (Postfix) with ESMTP id 7E5F540270
 for <dev@dpdk.org>; Fri, 31 Oct 2025 02:44:25 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.fBP37rg_1761875062 cluster:ay29) by smtp.aliyun-inc.com;
 Fri, 31 Oct 2025 09:44:22 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Cc: Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>,
 Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v1 1/1] net/nbl: use hardware MAC address instead of random one
Date: Thu, 30 Oct 2025 18:44:16 -0700
Message-Id: <20251031014417.3424934-2-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251031014417.3424934-1-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20251031014417.3424934-1-dimon.zhao@nebula-matrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The previous implementation used random MAC address for rte_eth_dev.
This change retrieves and uses the actual hardware MAC address from
the network device.

Fixes: bf649059c5ea ("net/nbl: support init and uninit")

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_common/nbl_userdev.c      | 40 +++++++++++++++++++
 drivers/net/nbl/nbl_dev/nbl_dev.c             |  1 +
 drivers/net/nbl/nbl_dispatch.c                | 15 ++++++-
 drivers/net/nbl/nbl_include/nbl_def_channel.h |  1 +
 drivers/net/nbl/nbl_include/nbl_def_common.h  |  1 +
 drivers/net/nbl/nbl_include/nbl_include.h     |  4 ++
 6 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/net/nbl/nbl_common/nbl_userdev.c b/drivers/net/nbl/nbl_common/nbl_userdev.c
index 75e0e2884b..bd0305affe 100644
--- a/drivers/net/nbl/nbl_common/nbl_userdev.c
+++ b/drivers/net/nbl/nbl_common/nbl_userdev.c
@@ -760,3 +760,43 @@ void nbl_pci_unmap_device(struct nbl_adapter *adapter)
 
 	nbl_mdev_unmap_device(adapter);
 }
+
+static int nbl_userdev_ifreq(int ifindex, int req, struct ifreq *ifr)
+{
+	int sock = socket(PF_INET, SOCK_DGRAM, IPPROTO_IP);
+	int ret = 0;
+
+	if (sock == -1) {
+		rte_errno = errno;
+		return -rte_errno;
+	}
+
+	if (!if_indextoname(ifindex, &ifr->ifr_name[0]))
+		goto error;
+
+	ret = ioctl(sock, req, ifr);
+	if (ret == -1) {
+		rte_errno = errno;
+		goto error;
+	}
+	close(sock);
+	return 0;
+error:
+	close(sock);
+	return -rte_errno;
+}
+
+int nbl_userdev_get_mac_addr(struct nbl_common_info *common, u8 *mac)
+{
+	struct ifreq request;
+	int ret;
+
+	ret = nbl_userdev_ifreq(common->ifindex, SIOCGIFHWADDR, &request);
+	if (ret) {
+		NBL_LOG(ERR, "userdev get mac failed: %d", ret);
+		return ret;
+	}
+
+	memcpy(mac, request.ifr_hwaddr.sa_data, RTE_ETHER_ADDR_LEN);
+	return 0;
+}
diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.c b/drivers/net/nbl/nbl_dev/nbl_dev.c
index 8a4a776b22..adfaec22f8 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.c
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.c
@@ -886,6 +886,7 @@ static int nbl_dev_setup_net_dev(struct nbl_dev_mgt *dev_mgt,
 
 	common->vsi_id = net_dev->vsi_id;
 	common->eth_id = net_dev->eth_id;
+	memcpy(common->mac, register_result.mac, RTE_ETHER_ADDR_LEN);
 
 	disp_ops->clear_queues(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), net_dev->vsi_id);
 	disp_ops->register_vsi2q(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), NBL_VSI_DATA, net_dev->vsi_id,
diff --git a/drivers/net/nbl/nbl_dispatch.c b/drivers/net/nbl/nbl_dispatch.c
index fff8e5d184..d0ea15eef1 100644
--- a/drivers/net/nbl/nbl_dispatch.c
+++ b/drivers/net/nbl/nbl_dispatch.c
@@ -298,7 +298,20 @@ static int nbl_disp_get_mac_addr(void *priv __rte_unused, u8 *mac)
 
 static int nbl_disp_get_mac_addr_req(void *priv __rte_unused, u8 *mac)
 {
-	rte_eth_random_addr(mac);
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_common_info *common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+	u8 zero_mac[RTE_ETHER_ADDR_LEN] = {0, 0, 0, 0, 0, 0};
+	int ret = -1;
+
+	if (common->nl_socket_route >= 0 && common->ifindex >= 0)
+		ret = nbl_userdev_get_mac_addr(common, mac);
+
+	if (ret) {
+		if (!memcmp(common->mac, zero_mac, RTE_ETHER_ADDR_LEN))
+			rte_eth_random_addr(mac);
+		else
+			memcpy(mac, common->mac, RTE_ETHER_ADDR_LEN);
+	}
 
 	return 0;
 }
diff --git a/drivers/net/nbl/nbl_include/nbl_def_channel.h b/drivers/net/nbl/nbl_include/nbl_def_channel.h
index dd7057f3b2..6b150ed715 100644
--- a/drivers/net/nbl/nbl_include/nbl_def_channel.h
+++ b/drivers/net/nbl/nbl_include/nbl_def_channel.h
@@ -322,6 +322,7 @@ struct nbl_chan_param_register_net_info {
 	u16 offset;
 	u16 stride;
 	u64 pf_bar_start;
+	u16 is_vdpa;
 };
 
 struct nbl_chan_param_get_vsi_id {
diff --git a/drivers/net/nbl/nbl_include/nbl_def_common.h b/drivers/net/nbl/nbl_include/nbl_def_common.h
index 5480d30f0d..39be8042b9 100644
--- a/drivers/net/nbl/nbl_include/nbl_def_common.h
+++ b/drivers/net/nbl/nbl_include/nbl_def_common.h
@@ -116,5 +116,6 @@ int nbl_userdev_port_config(struct nbl_adapter *adapter, int start);
 int nbl_userdev_port_isolate(struct nbl_adapter *adapter, int set, struct rte_flow_error *error);
 int nbl_pci_map_device(struct nbl_adapter *adapter);
 void nbl_pci_unmap_device(struct nbl_adapter *adapter);
+int nbl_userdev_get_mac_addr(struct nbl_common_info *common, u8 *mac);
 
 #endif
diff --git a/drivers/net/nbl/nbl_include/nbl_include.h b/drivers/net/nbl/nbl_include/nbl_include.h
index 6423ada176..e0f0497e3f 100644
--- a/drivers/net/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/nbl/nbl_include/nbl_include.h
@@ -23,6 +23,7 @@
 #include <sys/ioctl.h>
 #include <sys/types.h>
 #include <unistd.h>
+#include <net/if.h>
 
 #include <rte_ethdev.h>
 #include <ethdev_driver.h>
@@ -146,6 +147,7 @@ struct nbl_common_info {
 	u8 dma_set_msb:1;
 	u8 rsv:2;
 	struct nbl_board_port_info board_info;
+	u8 mac[RTE_ETHER_ADDR_LEN];
 };
 
 struct nbl_register_net_param {
@@ -172,6 +174,8 @@ struct nbl_register_net_result {
 	u16 vlan_tci;
 	u32 rate;
 	bool trusted;
+	u64 vlan_features;
+	u64 hw_enc_features;
 };
 
 struct nbl_eth_link_info {
-- 
2.34.1

