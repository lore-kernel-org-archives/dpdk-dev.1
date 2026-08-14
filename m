Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951A1C5CFC1
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 12:23:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14FBF40671;
	Fri, 14 Aug 2026 14:22:26 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 630B84013F
 for <dev@dpdk.org>; Fri, 14 Aug 2026 14:22:16 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowACHjjxyCH9qF1pdBQ--.37690S13;
 Fri, 14 Aug 2026 20:22:14 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v1 11/13] net/sxe2: clean up duplicate function declarations
Date: Fri, 14 Aug 2026 20:22:02 +0800
Message-ID: <20260814122204.2666045-12-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260814122204.2666045-1-liujie5@linkdatatechnology.com>
References: <20260814122204.2666045-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACHjjxyCH9qF1pdBQ--.37690S13
X-Coremail-Antispam: 1UD129KBjvJXoWxAr4fAFyxGF1kJF4fGw4UArb_yoW5Ww48pF
 48Xw15JFWFqF1kur4UJ3yxua42grW8t3yj9a98W34Fka4DZFZFva45tF1ay3WrC3srXwna
 ywsrWr4DGr1rArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
 1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWx
 Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
 x0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
 JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xxMx
 AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
 Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwI
 xGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWx
 JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcV
 C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbfcTJUUUUU==
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

