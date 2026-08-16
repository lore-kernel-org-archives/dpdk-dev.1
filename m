Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EDAC5DF67
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Aug 2026 02:53:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F22B40A4B;
	Sun, 16 Aug 2026 04:52:56 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id D591240653
 for <dev@dpdk.org>; Sun, 16 Aug 2026 04:52:47 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-01 (Coremail) with SMTP id qwCowAAn+u32JYFqrYDQBQ--.14967S13;
 Sun, 16 Aug 2026 10:52:46 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v2 11/13] net/sxe2: clean up duplicate function declarations
Date: Sun, 16 Aug 2026 10:52:31 +0800
Message-ID: <20260816025233.2727226-12-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260816025233.2727226-1-liujie5@linkdatatechnology.com>
References: <20260816025233.2727226-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAAn+u32JYFqrYDQBQ--.14967S13
X-Coremail-Antispam: 1UD129KBjvJXoWxAr4fAFyxGF1kJF4fGw4UArb_yoW5Ww48pF
 48Xw15JFWFqF1kur4UJ3yxua42grW8t3yj9a98W34Fka4DZFZFva45tF1ay3WrC3srXwna
 ywsrWr4DGr1rArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
 1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
 M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
 v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
 F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC0wCF04
 k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
 MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr4
 1lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
 IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4
 A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUB89_UUUUU=
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

This commit removes duplicate function declarations in the sxe2
driver header files.

- Remove duplicate sxe2_drv_promisc_config declaration
  in sxe2_cmd_chnl.h
- Remove duplicate sxe2_drv_vsi_info_get declaration
  in sxe2_cmd_chnl.h
- Remove duplicate sxe2_drv_mac_link_status_get declaration
  in sxe2_cmd_chnl.h
- Remove duplicate sxe2_drv_rxq_mapping_set declaration
  in sxe2_cmd_chnl.h
- Remove duplicate sxe2_dev_pci_seg_unmap declaration
  in sxe2_ethdev.h

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_cmd_chnl.h | 6 ------
 drivers/net/sxe2/sxe2_ethdev.h   | 2 --
 2 files changed, 8 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.h b/drivers/net/sxe2/sxe2_cmd_chnl.h
index 7d75a91061..7d07068bfc 100644
--- a/drivers/net/sxe2/sxe2_cmd_chnl.h
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.h
@@ -65,8 +65,6 @@ int32_t sxe2_drv_ipsec_rxsa_delete(struct sxe2_adapter *adapter,
 int32_t sxe2_drv_ipsec_txsa_delete(struct sxe2_adapter *adapter,
 			       uint16_t sa_id);
 
-int32_t sxe2_drv_promisc_config(struct sxe2_adapter *adapter, bool set);
-
 int32_t sxe2_drv_udp_tunnel_add(struct sxe2_adapter *adapter,
 			    enum sxe2_udp_tunnel_protocol tunnel_proto,
 			    uint16_t udp_port);
@@ -84,8 +82,6 @@ int32_t sxe2_drv_get_udp_tunnel_port(struct sxe2_adapter *adapter,
 
 int32_t sxe2_drv_vsi_info_get(struct sxe2_adapter *adapter, struct sxe2_vsi *vsi);
 
-int32_t sxe2_drv_vsi_info_get(struct sxe2_adapter *adapter, struct sxe2_vsi *vsi);
-
 int32_t sxe2_drv_mac_link_status_get(struct sxe2_adapter *adapter);
 
 int32_t sxe2_drv_get_mac_stats(struct sxe2_adapter *adapter);
@@ -110,8 +106,6 @@ int32_t sxe2_drv_mapping_reset(struct rte_eth_dev *eth_dev);
 
 int32_t sxe2_drv_mapping_stats_info_clear(struct rte_eth_dev *eth_dev);
 
-int32_t sxe2_drv_rxq_mapping_set(struct rte_eth_dev *eth_dev, uint16_t queue_id, uint8_t pool_idx);
-
 int32_t sxe2_drv_allmulti_config(struct sxe2_adapter *adapter, bool set);
 
 int32_t sxe2_drv_uc_config(struct sxe2_adapter *adapter, struct rte_ether_addr *addr, bool add);
diff --git a/drivers/net/sxe2/sxe2_ethdev.h b/drivers/net/sxe2/sxe2_ethdev.h
index 36f4cc9353..b43030deab 100644
--- a/drivers/net/sxe2/sxe2_ethdev.h
+++ b/drivers/net/sxe2/sxe2_ethdev.h
@@ -387,8 +387,6 @@ void sxe2_dev_pci_seg_unmap(struct sxe2_adapter *adapter, uint32_t res_type);
 
 int32_t sxe2_dev_pci_map_init(struct rte_eth_dev *dev);
 
-void sxe2_dev_pci_seg_unmap(struct sxe2_adapter *adapter, uint32_t res_type);
-
 int32_t sxe2_udp_tunnel_port_del_common(struct sxe2_adapter *ad,
 		enum sxe2_udp_tunnel_protocol tunnel_proto, uint16_t udp_port);
 
-- 
2.52.0

