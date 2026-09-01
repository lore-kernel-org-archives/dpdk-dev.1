Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F2EC61DFD
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 03:06:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C03F4068A;
	Tue,  1 Sep 2026 05:06:33 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id 553914068A
 for <dev@dpdk.org>; Tue,  1 Sep 2026 05:06:31 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowABHsDoxQZZqRvUhBw--.57985S2;
 Tue, 01 Sep 2026 11:06:26 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v8 12/49] net/sxe2: clean up duplicate function declarations
Date: Tue,  1 Sep 2026 11:06:24 +0800
Message-ID: <20260901030624.3684064-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260831024549.3231744-1-liujie5@linkdatatechnology.com>
References: <20260831024549.3231744-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowABHsDoxQZZqRvUhBw--.57985S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAFW7AF1UAr48XrWfAry7ZFb_yoW5tF13pF
 48Xry5AFWYqF18ur4UJa1fuFyagrW8tryj9FZ8W34FkayDZFZFvFy5tF1Fy3WrC34DGwna
 yanrXa1DG3yrXrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkS14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
 4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24l
 42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
 WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAK
 I48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F
 4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY
 6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU8KsjUUUUU
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

Remove duplicate function declarations from the sxe2 driver headers:
- sxe2_drv_promisc_config, sxe2_drv_vsi_info_get and
  sxe2_drv_rxq_mapping_set in sxe2_cmd_chnl.h
- sxe2_dev_pci_seg_unmap in sxe2_ethdev.h
- sxe2_rx_pkts_scattered in sxe2_txrx_poll.h

Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_cmd_chnl.h  | 6 ------
 drivers/net/sxe2/sxe2_ethdev.h    | 2 --
 drivers/net/sxe2/sxe2_txrx_poll.h | 2 --
 3 files changed, 10 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.h b/drivers/net/sxe2/sxe2_cmd_chnl.h
index d63caad526..294ac15db4 100644
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
index 158198d74b..1409be74d3 100644
--- a/drivers/net/sxe2/sxe2_ethdev.h
+++ b/drivers/net/sxe2/sxe2_ethdev.h
@@ -385,8 +385,6 @@ void sxe2_dev_pci_seg_unmap(struct sxe2_adapter *adapter, uint32_t res_type);
 
 int32_t sxe2_dev_pci_map_init(struct rte_eth_dev *dev);
 
-void sxe2_dev_pci_seg_unmap(struct sxe2_adapter *adapter, uint32_t res_type);
-
 int32_t sxe2_udp_tunnel_port_del_common(struct sxe2_adapter *ad,
 		enum sxe2_udp_tunnel_protocol tunnel_proto, uint16_t udp_port);
 
diff --git a/drivers/net/sxe2/sxe2_txrx_poll.h b/drivers/net/sxe2/sxe2_txrx_poll.h
index 708e3839d7..bfa099c097 100644
--- a/drivers/net/sxe2/sxe2_txrx_poll.h
+++ b/drivers/net/sxe2/sxe2_txrx_poll.h
@@ -13,8 +13,6 @@ uint16_t sxe2_tx_pkts_simple(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t
 
 uint16_t sxe2_rx_pkts_scattered(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts);
 
-uint16_t sxe2_rx_pkts_scattered(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts);
-
 uint16_t sxe2_rx_pkts_scattered_split(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts);
 
 #endif /* SXE2_TXRX_POLL_H */
-- 
2.52.0

