Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BD8CCA470
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 10:02:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D922340E37;
	Tue, 30 Sep 2025 12:01:05 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTP id BEB1B40DDD
 for <dev@dpdk.org>; Tue, 30 Sep 2025 12:01:01 +0200 (CEST)
X-QQ-mid: esmtpgz13t1759226457te634bb54
X-QQ-Originating-IP: bdr1u/el9YPtD4u0sjO44T0pGfNkYO8OAzsCa/kspT0=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.220.225.164])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 30 Sep 2025 18:00:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16320697659879495577
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v4 16/20] net/txgbe: add support for TX queue rate limiting
Date: Tue, 30 Sep 2025 17:59:48 +0800
Message-Id: <20250930095953.18508-17-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250930095953.18508-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20250930095953.18508-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: Nc7l3rjNm00Az1B8X9lnZ3Lrm8KSyv0wdQYgfOplW7xgxq4nyEVt1Kks
 O4uA9nS17OqL1zgsfz5cgXP617/6TC7kKowpIu8YtyYzm15JbSX1HPepWQgvBV30KWRMgqP
 oVc+9yxbP/WYJ1Ply6CY/r2rhj3fE5NghgKLCQMiqYCybvHNiwKPdHp9m94eTYqbBkR2gzP
 wjLW10o40ChbesztpqZCgCcPqYyOQd5Hg71rFpQEVq76KbPlDCXXIp30dU/26YrUvEZfuly
 Dg7MyCIglZxFgByzmJ75maKQe/wY42OQWtEZSrHeAM+uglB0cO4EVhy+5+K2qbzHfdceDbV
 XruWKodt9eBnASRa35tBBu5q4v4ATvTyeYWrLyHiP+62ExLG0Hxbc/WuQzoD3yqE6dCskar
 28x+PFFG4WPjTheTCcDDGmxHMctVv5nCIywn92TLKn8K2nOss2kKlWzrp2xVtaJk4AS8eeB
 rwelSqfnlHfRk5do4Q5j6hKhpG0CCd+cNo+vW7z4aygaD+Z/PkZ1EaVlI90zslHc4ikB8U3
 ZgjRM4dRf0lFmQq0sw9BgTp2+U+sJfW3fqlwMv255rJQh2+x8Bwk8PV1nIfc5o/60yHu/+X
 D31Y8I5j4oc9aRu1O57uxeSbaHqc4QQ6rCijF8fCJD8HedSoQtlAtqq4VGcpRZx1IfoqhGT
 nTFD44Zjb8GHbFShWOR43kAGRupoQeiOxMq0brFQ+QwkuG1R/qO2F3GBmabWlGGCHPq00nO
 b9n4vYtiLK0BeS/RKMNb38rjQED0vK+Co6i3YzFsIIttBQhkwN3wXwUkVuS4tsx0YmBCLt5
 Y5ARN7Vgzbweyznqir1LewgCyCB9fThe3PbJeAExcLfXkj2gdtYmqXR1ZAL9Oah0Cjufaex
 EKzCLKkiryO1JvdgXr35w3RRS6YmiXgU0tr/SvOI2htgCQzv6Q73hfD6AtJGLtl6f84iNBS
 oArGF4JA7nwXTXKgYMI4fuKCJTfdloCcmLECoz9UzF9GT9jyNzir2PnabCAyOddQtyZy/xe
 4pC+Msyv7eU46KJLKXLxDuQsim8HsWDE2hm2+RMHv0UJ5rxpdrNAnr0qtpGlg=
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

Add TX queue rate limiting functionality for Amber-Lite NICs.
Due to hardware design differences, the TX queue rate limiting
configuration for Amber-Lite NICs requires updates compared to
Sapphire NICs.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_osdep.h |  2 +
 drivers/net/txgbe/base/txgbe_regs.h  | 12 +++++
 drivers/net/txgbe/txgbe_ethdev.c     | 69 +++++++++++++++++++++++-----
 3 files changed, 72 insertions(+), 11 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_osdep.h b/drivers/net/txgbe/base/txgbe_osdep.h
index a1477653e2..f4282b3241 100644
--- a/drivers/net/txgbe/base/txgbe_osdep.h
+++ b/drivers/net/txgbe/base/txgbe_osdep.h
@@ -164,6 +164,8 @@ static inline u64 REVERT_BIT_MASK64(u64 mask)
 
 #define IOMEM
 
+#define BIT(nr)         (1UL << (nr))
+
 #define prefetch(x) rte_prefetch0(x)
 
 #define ARRAY_SIZE(x) ((int32_t)RTE_DIM(x))
diff --git a/drivers/net/txgbe/base/txgbe_regs.h b/drivers/net/txgbe/base/txgbe_regs.h
index 2e0ac9c742..f2e4994863 100644
--- a/drivers/net/txgbe/base/txgbe_regs.h
+++ b/drivers/net/txgbe/base/txgbe_regs.h
@@ -1656,6 +1656,18 @@ enum txgbe_5tuple_protocol {
 #define   TXGBE_ARBTXRATE_MIN(v)        LS(v, 0, 0x3FFF)
 #define   TXGBE_ARBTXRATE_MAX(v)        LS(v, 16, 0x3FFF)
 
+#define TXGBE_TDM_RL_QUEUE_IDX          0x018210
+#define TXGBE_TDM_RL_QUEUE_CFG          0x018214
+#define   TXGBE_TDM_FACTOR_INT_MASK     MS(16, 0xFFFF)
+#define   TXGBE_TDM_FACTOR_FRA_MASK     MS(0, 0xFFFC)
+#define   TXGBE_TDM_FACTOR_INT_SHIFT    16
+#define   TXGBE_TDM_FACTOR_FRA_SHIFT    2
+
+#define TXGBE_TDM_RL_VM_IDX             0x018218
+#define TXGBE_TDM_RL_VM_CFG             0x01821C
+#define TXGBE_TDM_RL_CFG                0x018400
+#define TXGBE_TDM_RL_EN                 MS(0, 0x1)
+
 /* qos */
 #define TXGBE_ARBTXCTL                  0x018200
 #define   TXGBE_ARBTXCTL_RRM            MS(1, 0x1)
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index e6694f7fc2..c7c3668066 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -4245,33 +4245,80 @@ txgbe_configure_msix(struct rte_eth_dev *dev)
 			| TXGBE_ITR_WRDSA);
 }
 
+static u16 txgbe_frac_to_bi(u16 frac, u16 denom, int max_bits)
+{
+	u16 value = 0;
+
+	while (frac > 0 && max_bits > 0) {
+		max_bits -= 1;
+		frac *= 2;
+		if (frac >= denom) {
+			value |= BIT(max_bits);
+			frac -= denom;
+		}
+	}
+
+	return value;
+}
+
 int
 txgbe_set_queue_rate_limit(struct rte_eth_dev *dev,
 			   uint16_t queue_idx, uint32_t tx_rate)
 {
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 	uint32_t bcnrc_val;
+	int factor_int, factor_fra;
+	uint32_t link_speed;
 
 	if (queue_idx >= hw->mac.max_tx_queues)
 		return -EINVAL;
 
-	if (tx_rate != 0) {
-		bcnrc_val = TXGBE_ARBTXRATE_MAX(tx_rate);
-		bcnrc_val |= TXGBE_ARBTXRATE_MIN(tx_rate / 2);
-	} else {
-		bcnrc_val = 0;
-	}
-
 	/*
 	 * Set global transmit compensation time to the MMW_SIZE in ARBTXMMW
 	 * register. MMW_SIZE=0x014 if 9728-byte jumbo is supported.
 	 */
 	wr32(hw, TXGBE_ARBTXMMW, 0x14);
 
-	/* Set ARBTXRATE of queue X */
-	wr32(hw, TXGBE_ARBPOOLIDX, queue_idx);
-	wr32(hw, TXGBE_ARBTXRATE, bcnrc_val);
-	txgbe_flush(hw);
+	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40) {
+		if (tx_rate) {
+			u16 frac;
+
+			link_speed = dev->data->dev_link.link_speed;
+			tx_rate  = tx_rate * 105 / 100;
+			/* Calculate the rate factor values to set */
+			factor_int = link_speed / tx_rate;
+			frac = (link_speed % tx_rate) * 10000 / tx_rate;
+			factor_fra = txgbe_frac_to_bi(frac, 10000, 14);
+			if (tx_rate > link_speed) {
+				factor_int = 1;
+				factor_fra = 0;
+			}
+
+			wr32(hw, TXGBE_TDM_RL_QUEUE_IDX, queue_idx);
+			wr32m(hw, TXGBE_TDM_RL_QUEUE_CFG,
+			      TXGBE_TDM_FACTOR_INT_MASK, factor_int << TXGBE_TDM_FACTOR_INT_SHIFT);
+			wr32m(hw, TXGBE_TDM_RL_QUEUE_CFG,
+			      TXGBE_TDM_FACTOR_FRA_MASK, factor_fra << TXGBE_TDM_FACTOR_FRA_SHIFT);
+			wr32m(hw, TXGBE_TDM_RL_QUEUE_CFG,
+			      TXGBE_TDM_RL_EN, TXGBE_TDM_RL_EN);
+		} else {
+			wr32(hw, TXGBE_TDM_RL_QUEUE_IDX, queue_idx);
+			wr32m(hw, TXGBE_TDM_RL_QUEUE_CFG,
+			      TXGBE_TDM_RL_EN, 0);
+		}
+	} else {
+		if (tx_rate != 0) {
+			bcnrc_val = TXGBE_ARBTXRATE_MAX(tx_rate);
+			bcnrc_val |= TXGBE_ARBTXRATE_MIN(tx_rate / 2);
+		} else {
+			bcnrc_val = 0;
+		}
+
+		/* Set ARBTXRATE of queue X */
+		wr32(hw, TXGBE_ARBPOOLIDX, queue_idx);
+		wr32(hw, TXGBE_ARBTXRATE, bcnrc_val);
+		txgbe_flush(hw);
+	}
 
 	return 0;
 }
-- 
2.21.0.windows.1

