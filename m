Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322B0C5AD49
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 08:03:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A58BC40A77;
	Fri,  6 Jun 2025 10:02:13 +0200 (CEST)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by mails.dpdk.org (Postfix) with ESMTP id AA72B406FF;
 Fri,  6 Jun 2025 10:02:10 +0200 (CEST)
X-QQ-mid: zesmtpsz2t1749196928t1fd3ed83
X-QQ-Originating-IP: 71CV8ZaHxtFqN+L1zfTp/3aXTKM9jrgtPmVPOFySqyM=
Received: from w-MS-7E16.trustnetic.com ( [220.184.249.46])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 06 Jun 2025 16:02:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1474719241013930642
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH 11/12] net/ngbe: restrict VLAN strip configuration on VF
Date: Fri,  6 Jun 2025 16:01:16 +0800
Message-ID: <C15823B48F0E54CF+20250606080117.183198-12-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250606080117.183198-1-jiawenwu@trustnetic.com>
References: <20250606080117.183198-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OKkKo7I1HxIelvWIr6bqARQ8m39rUtwfXO4d13y3osqo5DVeapxmCbFk
 4PBpMaMks4ToA03jKINxBJvoH+e2qDg1siK8wXTqMMXSAuIXXO2jnhK/7nQdCAqBoSi/IrN
 wZqIov5yKjl96gaRGgjjFYPEbcWzvl73cMyUM45eKb1/h4AkpWdeGhDNKiNr4wijOJc0XwG
 5tyIUPMhRK4H9PCCHN3qLfMj91IBnKBdunz7N7FptlflHKvwAThPtVbxtFCuN20OvBJd7oD
 nBESwpZPaMBbOfsKWQn4M0uGGdavjnnc5f/mOKSDfoIIUuFXpo4rR4DvPQBpLna3E5DEzYP
 kt78VIwxmye0IDZ1LIows+4pDFmozuGHAVNSo3MygFL8X17/K3E06EBENTID9gKHQXyIOP0
 aOYuN/5V1P9iAz/1Kj80G8AM4B2+YE1vqWlP9Mk1+2SzEl1HDtk8Or5n0tCuNgyTzeP+qYR
 kvErffhV7H66/+QjhPbxgBnTkNFDtyY9nA6Egq3ZTbqIGKI8g2TcRjxMtaO52RCVJHPGMFT
 MRLcxASetQBLaifahDs5hFxIs62i0MTzAiEd8B7RTkqbHysC8XcyZwy8I1pi+SWsa/6MEml
 tbk+5FLqSxh+08QlpvORAvCkPpkm8RT2v1/BsdaH8/R74iEh/2JH6wZ5GQdzjB+VCVUdYxH
 twXQ4ww3Ne+HrvOpn5zp7nrJjQC7kQ/DBJfMgDCIAYF3d+eH6tMmytadpOUOKDp5KNS1WFZ
 /LaupXvhZjG3rU7d7uvtNULBD55nUnIPskl6Ezkz+4vUuR8shSPNSkBE4oyIjohxMPsrn2M
 NPPE28HyXJGm3R9fq+u0MB82emew4fWBTWxmbookq0jM+s3s6YV28/9a+0pljCBcS6g68N5
 fOoGPtFMyqcs6wdfFOpE5NJvcty2CMl8mLvuPlPek0vxD6uz2eNM9GbwrcHaquk2ZInEuIv
 nvg9cHY4qmnLe2ImOKoFHefEQK9ZR6ueN7cS1d04Ja6G+X7jPlHU3vIBgrrz50ws2f1X5ab
 6UBDVVARcfcw3turYW2AT0Qbg45OZ40BDKfA2uISisVgfbG2+W
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0
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

Fix the same issue as PF in commit baca8ec066dc ("net/ngbe: restrict
configuration of VLAN strip offload").

There is a hardware limitation that Rx ring config register is not
writable when Rx ring is enabled, i.e. the TXGBE_RXCFG_ENA bit is set.
But disabling the ring when there is traffic will cause ring get stuck.
So restrict the configuration of VLAN strip offload only if device is
started.

Fixes: f47dc03c706f ("net/ngbe: add VLAN ops for VF device")
Cc: stable@dpdk.org

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ngbe/ngbe_ethdev_vf.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ngbe/ngbe_ethdev_vf.c b/drivers/net/ngbe/ngbe_ethdev_vf.c
index 5d68f1602d..846bc981f6 100644
--- a/drivers/net/ngbe/ngbe_ethdev_vf.c
+++ b/drivers/net/ngbe/ngbe_ethdev_vf.c
@@ -828,7 +828,7 @@ ngbevf_vlan_filter_set(struct rte_eth_dev *dev, uint16_t vlan_id, int on)
 }
 
 static void
-ngbevf_vlan_strip_queue_set(struct rte_eth_dev *dev, uint16_t queue, int on)
+ngbevf_vlan_strip_q_set(struct rte_eth_dev *dev, uint16_t queue, int on)
 {
 	struct ngbe_hw *hw = ngbe_dev_hw(dev);
 	uint32_t ctrl;
@@ -848,6 +848,19 @@ ngbevf_vlan_strip_queue_set(struct rte_eth_dev *dev, uint16_t queue, int on)
 	ngbe_vlan_hw_strip_bitmap_set(dev, queue, on);
 }
 
+static void
+ngbevf_vlan_strip_queue_set(struct rte_eth_dev *dev, uint16_t queue, int on)
+{
+	struct ngbe_hw *hw = ngbe_dev_hw(dev);
+
+	if (!hw->adapter_stopped) {
+		PMD_DRV_LOG(ERR, "Please stop port first");
+		return;
+	}
+
+	ngbevf_vlan_strip_q_set(dev, queue, on);
+}
+
 static int
 ngbevf_vlan_offload_config(struct rte_eth_dev *dev, int mask)
 {
@@ -860,7 +873,7 @@ ngbevf_vlan_offload_config(struct rte_eth_dev *dev, int mask)
 		for (i = 0; i < dev->data->nb_rx_queues; i++) {
 			rxq = dev->data->rx_queues[i];
 			on = !!(rxq->offloads &	RTE_ETH_RX_OFFLOAD_VLAN_STRIP);
-			ngbevf_vlan_strip_queue_set(dev, i, on);
+			ngbevf_vlan_strip_q_set(dev, i, on);
 		}
 	}
 
@@ -870,6 +883,13 @@ ngbevf_vlan_offload_config(struct rte_eth_dev *dev, int mask)
 static int
 ngbevf_vlan_offload_set(struct rte_eth_dev *dev, int mask)
 {
+	struct ngbe_hw *hw = ngbe_dev_hw(dev);
+
+	if (!hw->adapter_stopped && (mask & RTE_ETH_VLAN_STRIP_MASK)) {
+		PMD_DRV_LOG(ERR, "Please stop port first");
+		return -EPERM;
+	}
+
 	ngbe_config_vlan_strip_on_all_queues(dev, mask);
 
 	ngbevf_vlan_offload_config(dev, mask);
-- 
2.48.1

