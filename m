Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BBCC71135
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 08:44:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB87642ED0;
	Fri, 13 Jun 2025 10:42:52 +0200 (CEST)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by mails.dpdk.org (Postfix) with ESMTP id 257CE42EC3;
 Fri, 13 Jun 2025 10:42:48 +0200 (CEST)
X-QQ-mid: esmtpsz18t1749804166t55244157
X-QQ-Originating-IP: 2WuNeJh7K76jhl8X/Sumav3Pk0/e99Ob82b1VVc0SWA=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.60.58])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 13 Jun 2025 16:42:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7477168587411949137
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH v3 16/17] net/ngbe: restrict VLAN strip configuration on VF
Date: Fri, 13 Jun 2025 16:41:58 +0800
Message-Id: <20250613084159.22184-17-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250613084159.22184-1-jiawenwu@trustnetic.com>
References: <00DEAE896AFE0D2D+20250606080117.183198-1-jiawenwu@trustnetic.com>
 <20250613084159.22184-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NQzH8pzEc5hGbGVq1c1IWQ+tIJ9cb3t0nPeRn1VtxMfObHWFvyjub0Mt
 gJ/3od41jzUzocL9MMILtZGXEPav2fjjHjvTCSzUnrNG9oSOtk6bWJss1nmIoINAlJW54WQ
 1V8hCcH8+GNL6tfApxjcNgXH/3Hl6OC1HypFdhhRPWr55//cRL38bCeYCmKlPfXikliBieH
 eT8s2RUVIeboElVCewo3zUJ+tsI7pEt1Ob+whhEzSxU+vGY7YSm2+T6FbiqdnyfJuoT/KfO
 7144pYPju3/3gVh47VtfHm3GvXagbZIrmNbIO+aG4bQJ+7pKTjH8PFOSa5pOrhVJglY0d78
 5xoZFkmHdlxxp7v7EkEqYI1hSINtP37HH95KZ5N6+g2GUKwHkrcRBknxnNGvy9bQYSlffwQ
 54n8Yzx0nMt/+m0CRbTwTyF8F0RXQKZtRNPn5wjlx7C7WLSauugG18sIVida8Hz+dCM4Mss
 hMPlw1KHYNFuRd2jI578cBsXFfLOuKgMCOylLm32P/PWLsLO3QoBsETydql9YDhCRFAEKXG
 +Ia8IS02cv35wcVywb3GE7xq7D9Y59N/MlVBgA9CbS2G/0R52ZZ8A/zKn/d8MRh856u5t38
 fHL+1TIYLPUmpuNQ2u8zprxB9YWNs5nV1EqG4lNBTEbPyivIAYya0d1A9DSE1Tb/SNr9cPx
 MyR4kKkZNmjFTAyajS9I8vxrSRHK+ZuPRyctgtjaI6peyJyR7Kze/o/SW7cb7r1060bp+mz
 FYIRw9Q8DaPSGToh7ne2VZygbJR13NzeSXgMKUQxNQXjT8ybkI2BzLnODLL43ZYewwArhpZ
 UusmKK8blHuwcjEX4hsQumTA9/xl0qBjq4TpMnt3/mgziCUlE/SFF/jLk5pnwhhZWvcWJ1k
 3zeQdJryImXj9IraiOzdozR0q223LYHo8N2pSA0NUkAAyjySQlCIxoBtVQgK7dQPaiNAiuF
 /x+GoquGVKhTHg+Q8YcHAj3ZOtnpfYbHYXs5HIzu5ha9OoTowE/S4u/TOS8fBDtzaA3E+gZ
 sB/0fLlzGhyVf/1mZ/GSykQhVatRD8w06D2P5dG9lHuWewqF+78fCV6DE0a60=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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

