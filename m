Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EFEC5CFDB
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 12:22:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE55F402EF;
	Fri, 14 Aug 2026 14:22:19 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 0631140287
 for <dev@dpdk.org>; Fri, 14 Aug 2026 14:22:14 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowACHjjxyCH9qF1pdBQ--.37690S7;
 Fri, 14 Aug 2026 20:22:13 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v1 05/13] net/sxe2: improve representor device initialization
Date: Fri, 14 Aug 2026 20:21:56 +0800
Message-ID: <20260814122204.2666045-6-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260814122204.2666045-1-liujie5@linkdatatechnology.com>
References: <20260814122204.2666045-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACHjjxyCH9qF1pdBQ--.37690S7
X-Coremail-Antispam: 1UD129KBjvJXoWxGFWxZFyxuF1fZry8WFyUZFb_yoWrJr18pF
 4rJa4YvFWrWFnrWwn7Aay8ur13Kr4rt34jkF1av34SkFW29ry8AF4UJ3Way34FkrWUZ3WS
 yay2vr1DGa1vv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
 1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWx
 Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
 x0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
 JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xxMx
 AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
 Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwI
 xGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWx
 JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
 C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUUNeOJUUUUU==
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

This patch enhances the representor device initialization with:

- Add statistics initialization in sxe2_repr_dev_init
  * Call sxe2_stats_init to setup statistics infrastructure
  * Add proper error handling path for stats init failure

- Add representor device naming and NUMA node assignment:
  * Update device name format to use base device name prefix
  * Set numa_node from parent device data for proper NUMA locality
  * Ensures representor devices are allocated on the same NUMA node

- Code style improvements:
  * Align struct member fields in sxe2_adapter for consistency

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_ethdev.h      | 24 ++++++++++++------------
 drivers/net/sxe2/sxe2_ethdev_repr.c | 13 +++++++++++--
 2 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_ethdev.h b/drivers/net/sxe2/sxe2_ethdev.h
index cfcb7fcf00..d0a0f41ceb 100644
--- a/drivers/net/sxe2/sxe2_ethdev.h
+++ b/drivers/net/sxe2/sxe2_ethdev.h
@@ -314,10 +314,10 @@ struct sxe2_fc_state_ctxt {
 };
 
 struct sxe2_adapter {
-	struct sxe2_common_device      *cdev;
-	struct sxe2_dev_info            dev_info;
-	struct rte_pci_device            *pci_dev;
-	struct sxe2_repr_private_data  *repr_priv_data;
+	struct sxe2_common_device     *cdev;
+	struct sxe2_dev_info          dev_info;
+	struct rte_pci_device         *pci_dev;
+	struct sxe2_repr_private_data *repr_priv_data;
 	struct sxe2_pci_map_context   map_ctxt;
 	struct sxe2_irq_context       irq_ctxt;
 	struct sxe2_queue_context     q_ctxt;
@@ -338,16 +338,16 @@ struct sxe2_adapter {
 	bool                          rule_started;
 	bool                          flow_isolated;
 	bool                          flow_isolate_cfg;
-	uint16_t                           dev_port_id;
+	uint16_t                      dev_port_id;
 	bool                          is_dev_repr;
-	uint64_t                           cap_flags;
+	uint64_t                      cap_flags;
 	enum sxe2_dev_type            dev_type;
-	struct rte_ether_addr           mac_addr;
-	uint8_t                              port_idx;
-	uint8_t                              pf_idx;
-	uint32_t                             tx_mode_flags;
-	uint32_t                             rx_mode_flags;
-	uint8_t                              started;
+	struct rte_ether_addr         mac_addr;
+	uint8_t                       port_idx;
+	uint8_t                       pf_idx;
+	uint32_t                      tx_mode_flags;
+	uint32_t                      rx_mode_flags;
+	uint8_t                       started;
 };
 
 #define SXE2_DEV_PRIVATE_TO_ADAPTER(dev) \
diff --git a/drivers/net/sxe2/sxe2_ethdev_repr.c b/drivers/net/sxe2/sxe2_ethdev_repr.c
index f32318b731..b7096f5927 100644
--- a/drivers/net/sxe2/sxe2_ethdev_repr.c
+++ b/drivers/net/sxe2/sxe2_ethdev_repr.c
@@ -483,8 +483,16 @@ int32_t sxe2_repr_dev_init(struct rte_eth_dev *dev,
 		goto l_init_sw_err;
 	}
 
+	ret = sxe2_stats_init(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to initialize stats, ret=[%d]", ret);
+		goto l_init_irq_ctxt_err;
+	}
+
 	goto l_end;
 
+l_init_irq_ctxt_err:
+	sxe2_sw_irq_ctxt_uninit(dev);
 l_init_sw_err:
 	sxe2_eth_uinit(dev);
 l_init_eth_err:
@@ -544,8 +552,8 @@ int32_t sxe2_switchdev_repr_devs_init(struct sxe2_adapter *adapter,
 	}
 
 	for (repr_idx = 0; repr_idx < req_eth_da->nb_representor_ports; ++repr_idx) {
-		snprintf(name, sizeof(name), "sxe2_representor_c%dpf%d%s%u",
-			 adapter->pf_idx, adapter->pf_idx,
+		snprintf(name, sizeof(name), "%s_representor_%s%u",
+			 adapter->cdev->dev->name,
 			 "vf",
 			 req_eth_da->representor_ports[repr_idx]);
 
@@ -554,6 +562,7 @@ int32_t sxe2_switchdev_repr_devs_init(struct sxe2_adapter *adapter,
 			ret = -ENOMEM;
 			goto l_release_port;
 		}
+		eth_dev->data->numa_node = adapter->dev_info.dev_data->numa_node;
 		eth_dev->data->dev_private = rte_zmalloc_socket(name,
 			sizeof(struct sxe2_adapter),
 			RTE_CACHE_LINE_SIZE,
-- 
2.52.0

