Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B89CCD98F2
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 11:38:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 930CE4066E;
	Tue, 23 Jun 2026 13:38:34 +0200 (CEST)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by mails.dpdk.org (Postfix) with ESMTP id 2D705402EB
 for <dev@dpdk.org>; Tue, 23 Jun 2026 13:38:30 +0200 (CEST)
X-QQ-mid: zesmtpsz6t1782214706t3f09fbb5
X-QQ-Originating-IP: OD2bF9hCGv4+VhKUagryFDHGHlo26F7Vddo2x2FTDiM=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.248.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 23 Jun 2026 19:38:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14467152570171516276
EX-QQ-RecipientCnt: 3
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v3 4/4] net/txgbe: add VF support for Amber-Lite 40G NIC
Date: Tue, 23 Jun 2026 19:38:04 +0800
Message-Id: <20260623113805.16464-5-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260623113805.16464-1-zaiyuwang@trustnetic.com>
References: <20260617105959.10764-1-zaiyuwang@trustnetic.com>
 <20260623113805.16464-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MCw/P4/HZHFaOIRwYcfJWanAEkfvJxj3Udi8lBu0f8uv/OTyPEzxBb5z
 0BNkgC23Qntw4EjGEbSfu8T1/9GWIbXIrD2U4pox9xoMZa+FUJCKeOGDBsfIyNnIvH6/FYk
 q4FEzBrdiVAIKsLuW8nKSP6eqSIh8jh4KGRqCqideeopyrYkwuqWkuSkfOcP0EyV2rbaWcs
 ZSSr3Ork+yL4qYA6/drbOgrOaxjh/bhUmfsuDV0zN6vJ6MkQyCBHgIkRhNeGCl6ssy/z8Mf
 yMI9Y7gH/5KWmQOR7dWQE2LgeOBmRkabwX97/Hus+GsxahIqkvQ6TlaP7UPPXIteyhH5D/N
 WAca/dm00BCO3Cyp2RI5zBxo4XWDnKxSIVYSGwLtyvZuoYUMqQpu6FPSivnWlcwFkdkcTYi
 jwafUeBv7LmxhxeWRBbfNIYwBKxZ29adgzaQjnMF7NKBix6I427dbb56HlgmAo2+UwvSgT6
 hfCUlUE6jGqs18ynIN54c5rfYlV7MokL6jf+TGdY4PE/1yYbRL535KKhWNnriyZmHhVCtH8
 8GKZK+ezyAX7u9QdC1HNMMppHob3zcsUMF6MPkXYQzrswyhkJf3fl+ioEEYZRuVt/IvMHr0
 7KgbMEijVr3pGQO9WXKznMRMIB1ies4WdCWzXTW710vKoixx+bcUzDW68jem19daA1m5Q1a
 XKizOneGJuSqTLS2ri53SGibQbE3cEl2Jv4pqjpAy3R8AoKlFgXcYe+/duFf2/Qh2USSXSF
 X444BjJFK65V0qz6i2lqLEBEFcJVrflkIc4ry+yr5RmdUOtG6h6HNOksk8SHuZHEXwnOAgK
 xgHYc+kmeKe1jxnWjwzZbwi0tw5dvteggQKNmAiGk/DWX22bM2YpoAqZZFBEB6LtH+lGm/c
 jYjzfqlPfZos8Krq/jiABFDvJeHrLRmRxUOLtVOSC8eGWR1ECXxn0N9E79vXzd5UghNZbgV
 2MdFuEK02pQoaxHSnDTe1RISBPFcw0GXSnwFocpq8C4s7nq11vl+Vo+uutbysKt+WYD52GA
 UzdP2Uqx1qoNLFLB3ZhCqTcXkFKd0abJWjxBii0a1hGaNBaXQ6oxP7K2TqZqIqkEcV+U9dn
 usjIqaW5aQETwXxkmUHFEQ6xInI/tgYiRIwKRZx3C/H
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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

VF support for the 40G NIC was previously omitted; only the 25G VF was
added. Now add 40G VF support based on the existing 25G VF implementation,
with no major changes but only device ID adaptation.

Also, drop the redundant mac type check in txgbe_check_mac_link_vf(),
as the function now handles all VF types uniformly.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_devids.h | 2 ++
 drivers/net/txgbe/base/txgbe_hw.c     | 7 +++++++
 drivers/net/txgbe/base/txgbe_regs.h   | 7 +++++--
 drivers/net/txgbe/base/txgbe_type.h   | 1 +
 drivers/net/txgbe/base/txgbe_vf.c     | 6 +++---
 drivers/net/txgbe/txgbe_ethdev.c      | 1 +
 drivers/net/txgbe/txgbe_ethdev_vf.c   | 2 ++
 7 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_devids.h b/drivers/net/txgbe/base/txgbe_devids.h
index b7133c7d54..f5454ffbb1 100644
--- a/drivers/net/txgbe/base/txgbe_devids.h
+++ b/drivers/net/txgbe/base/txgbe_devids.h
@@ -28,6 +28,8 @@
 #define TXGBE_DEV_ID_AML_VF			0x5001
 #define TXGBE_DEV_ID_AML5024_VF			0x5024
 #define TXGBE_DEV_ID_AML5124_VF			0x5124
+#define TXGBE_DEV_ID_AML503F_VF			0x503f
+#define TXGBE_DEV_ID_AML513F_VF			0x513f
 
 /*
  * Subsystem IDs
diff --git a/drivers/net/txgbe/base/txgbe_hw.c b/drivers/net/txgbe/base/txgbe_hw.c
index 0f3db3a1ad..21465d68ff 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -2543,6 +2543,7 @@ s32 txgbe_init_shared_code(struct txgbe_hw *hw)
 		break;
 	case txgbe_mac_sp_vf:
 	case txgbe_mac_aml_vf:
+	case txgbe_mac_aml40_vf:
 		status = txgbe_init_ops_vf(hw);
 		break;
 	default:
@@ -2573,6 +2574,7 @@ bool txgbe_is_vf(struct txgbe_hw *hw)
 	switch (hw->mac.type) {
 	case txgbe_mac_sp_vf:
 	case txgbe_mac_aml_vf:
+	case txgbe_mac_aml40_vf:
 		return true;
 	default:
 		return false;
@@ -2620,6 +2622,11 @@ s32 txgbe_set_mac_type(struct txgbe_hw *hw)
 		hw->phy.media_type = txgbe_media_type_virtual;
 		hw->mac.type = txgbe_mac_aml_vf;
 		break;
+	case TXGBE_DEV_ID_AML503F_VF:
+	case TXGBE_DEV_ID_AML513F_VF:
+		hw->phy.media_type = txgbe_media_type_virtual;
+		hw->mac.type = txgbe_mac_aml40_vf;
+		break;
 	default:
 		err = TXGBE_ERR_DEVICE_NOT_SUPPORTED;
 		DEBUGOUT("Unsupported device id: %x", hw->device_id);
diff --git a/drivers/net/txgbe/base/txgbe_regs.h b/drivers/net/txgbe/base/txgbe_regs.h
index 95c585a025..5eb92c54b6 100644
--- a/drivers/net/txgbe/base/txgbe_regs.h
+++ b/drivers/net/txgbe/base/txgbe_regs.h
@@ -1824,12 +1824,14 @@ txgbe_map_reg(struct txgbe_hw *hw, u32 reg)
 	switch (reg) {
 	case TXGBE_REG_RSSTBL:
 		if (hw->mac.type == txgbe_mac_sp_vf ||
-		    hw->mac.type == txgbe_mac_aml_vf)
+		    hw->mac.type == txgbe_mac_aml_vf ||
+		    hw->mac.type == txgbe_mac_aml40_vf)
 			reg = TXGBE_VFRSSTBL(0);
 		break;
 	case TXGBE_REG_RSSKEY:
 		if (hw->mac.type == txgbe_mac_sp_vf ||
-		    hw->mac.type == txgbe_mac_aml_vf)
+		    hw->mac.type == txgbe_mac_aml_vf ||
+		    hw->mac.type == txgbe_mac_aml40_vf)
 			reg = TXGBE_VFRSSKEY(0);
 		break;
 	default:
@@ -2012,6 +2014,7 @@ static inline void txgbe_flush(struct txgbe_hw *hw)
 		break;
 	case txgbe_mac_sp_vf:
 	case txgbe_mac_aml_vf:
+	case txgbe_mac_aml40_vf:
 		rd32(hw, TXGBE_VFSTATUS);
 		break;
 	default:
diff --git a/drivers/net/txgbe/base/txgbe_type.h b/drivers/net/txgbe/base/txgbe_type.h
index 956080c702..132d5c4eff 100644
--- a/drivers/net/txgbe/base/txgbe_type.h
+++ b/drivers/net/txgbe/base/txgbe_type.h
@@ -171,6 +171,7 @@ enum txgbe_mac_type {
 	txgbe_mac_aml40,
 	txgbe_mac_sp_vf,
 	txgbe_mac_aml_vf,
+	txgbe_mac_aml40_vf,
 	txgbe_num_macs
 };
 
diff --git a/drivers/net/txgbe/base/txgbe_vf.c b/drivers/net/txgbe/base/txgbe_vf.c
index 1a8a20f104..47d9bd16ee 100644
--- a/drivers/net/txgbe/base/txgbe_vf.c
+++ b/drivers/net/txgbe/base/txgbe_vf.c
@@ -134,7 +134,8 @@ s32 txgbe_reset_hw_vf(struct txgbe_hw *hw)
 	}
 
 	/* amlite: bme */
-	if (hw->mac.type == txgbe_mac_aml_vf)
+	if (hw->mac.type == txgbe_mac_aml_vf ||
+	    hw->mac.type == txgbe_mac_aml40_vf)
 		wr32(hw, TXGBE_BME_AML, 0x1);
 
 	if (!timeout)
@@ -493,8 +494,7 @@ s32 txgbe_check_mac_link_vf(struct txgbe_hw *hw, u32 *speed,
 	/* for SFP+ modules and DA cables it can take up to 500usecs
 	 * before the link status is correct
 	 */
-	if ((mac->type == txgbe_mac_sp_vf ||
-	     mac->type == txgbe_mac_aml_vf) && wait_to_complete) {
+	if (wait_to_complete) {
 		if (po32m(hw, TXGBE_VFSTATUS, TXGBE_VFSTATUS_UP,
 			0, NULL, 5, 100))
 			goto out;
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 003a24141c..63b967d71a 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -5228,6 +5228,7 @@ txgbe_rss_update(enum txgbe_mac_type mac_type)
 	case txgbe_mac_aml:
 	case txgbe_mac_aml40:
 	case txgbe_mac_aml_vf:
+	case txgbe_mac_aml40_vf:
 		return 1;
 	default:
 		return 0;
diff --git a/drivers/net/txgbe/txgbe_ethdev_vf.c b/drivers/net/txgbe/txgbe_ethdev_vf.c
index e3832c0173..14cc49ece1 100644
--- a/drivers/net/txgbe/txgbe_ethdev_vf.c
+++ b/drivers/net/txgbe/txgbe_ethdev_vf.c
@@ -77,6 +77,8 @@ static const struct rte_pci_id pci_id_txgbevf_map[] = {
 	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_WANGXUN, TXGBE_DEV_ID_AML_VF) },
 	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_WANGXUN, TXGBE_DEV_ID_AML5024_VF) },
 	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_WANGXUN, TXGBE_DEV_ID_AML5124_VF) },
+	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_WANGXUN, TXGBE_DEV_ID_AML503F_VF) },
+	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_WANGXUN, TXGBE_DEV_ID_AML513F_VF) },
 	{ .vendor_id = 0, /* sentinel */ },
 };
 
-- 
2.21.0.windows.1

