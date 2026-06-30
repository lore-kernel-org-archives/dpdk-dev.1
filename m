Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E872C43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 11:16:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A46F4066A;
	Tue, 30 Jun 2026 13:16:49 +0200 (CEST)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by mails.dpdk.org (Postfix) with ESMTP id 615194065E
 for <dev@dpdk.org>; Tue, 30 Jun 2026 13:16:45 +0200 (CEST)
X-QQ-mid: zesmtpsz7t1782818199t24ac577a
X-QQ-Originating-IP: cAMQD4ZMNtFCXjqOpHiMGFWuZsoJrkn83wc3kQBFdVQ=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.190.76])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 30 Jun 2026 19:16:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14987545652333611515
EX-QQ-RecipientCnt: 3
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v4 4/4] net/txgbe: add VF support for Amber-Lite 40G NIC
Date: Tue, 30 Jun 2026 19:16:04 +0800
Message-Id: <20260630111608.22196-5-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260630111608.22196-1-zaiyuwang@trustnetic.com>
References: <20260617105959.10764-1-zaiyuwang@trustnetic.om>
 <20260630111608.22196-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MnKFQI2idf+win8X4YthMYdFGVFqqW7g4yJ1AImj8VHY0Nt4V9rx3odm
 rkEX/61Of1NVXlNRxMZvPv5FLnnoB9AYBKXw0b7ig5zawj2hrX+YkvRxd2dYPp6hVuZFEk5
 9dytedvdV0pHciPtiIs/NieOFX9EV0LB7nf5q8PVy532juBLWQYNnI7Y/oswUOigcLwK19B
 PE2XGLLIuJnLZ6mt1kTlEAV2Ub+FAlfhN/CUZHi0RiP0gnUWFcvPSnBUhP/0hWdvyNDxjhG
 JsxlnfEaC1htJ5Q8ATgFUBHaL4/bfUC77xETq/HdRlCRc5X/6YuU8sCkXQESb1dWW3jljO/
 q7dinQRdvOvpmwAG7VqK1BPJ7kuH+efS/ZhAAS7QEpl4+ekS9eWvgoIXhqi5Vo//pQqd33B
 N9Me2RKTUNZyt/n7iscG0ZM5CBcoNJotcC6p0IoD57/EcXOGSDp0NqsgccvjjIMMXomBheN
 llCjzTEuJ+jCP8wX9Sr2peyd9f8q8rmuC+IlJtklVK+lGe3co1Tg+WBndD/COJgcYlpUKHh
 ITiBTvv9kINRr9e3vsMo0H/HdPel1Ahre7QQfBFG1XOESpdhhVdsDxTmiZwOW4B0Dkg1R5l
 ri/pm8FEIebtHP/iF0EURE/4kTVM8bXP6r0VQwzdvC00FKVRM19dZkGGuUzGEM5FAC64sdK
 0wMFfscoJ8ByuF5pN1R04Q7nD+0jmFhjB7UFQq4Ac5LVwuJQ9AWan6dTvir4rVVEN5me7R0
 YUPc1sWSRg0WORCm1HtpXbfE+PRP65Uuus0gDHeogH/ufxnoW3+mEEQBvyi3P2NUHw5TsTD
 YiQcDc5z0lFAqkvUtDMedh1HAbPpeWm9Lq/+JjDbCvX303UoW/sj5xq0UlsysjowA2X3J4/
 ToQGUe1WHWAlNA0uXB5ldjJsfv/lin4wqPLxY1Ltua/it21M6QBSExfozQzuXxCyVRAWona
 u1NjsD/ztg/PAQiiiPKAzsnwYzErB8gYRsD1+8v/Q79QNehDvwmpuzkb3HYZCDZW3urIiCz
 Ktnlowww35kk4FQ5rCfVFVez60YN7uhjbTJRMfVy6MHEQSLQO096PrBoXkke1kWC5ANNnRP
 4915ggpNX4JTkiROK1UVK9jWCQeY78guA==
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
 doc/guides/rel_notes/release_26_07.rst | 2 ++
 drivers/net/txgbe/base/txgbe_devids.h  | 2 ++
 drivers/net/txgbe/base/txgbe_hw.c      | 7 +++++++
 drivers/net/txgbe/base/txgbe_regs.h    | 7 +++++--
 drivers/net/txgbe/base/txgbe_type.h    | 1 +
 drivers/net/txgbe/base/txgbe_vf.c      | 6 +++---
 drivers/net/txgbe/txgbe_ethdev.c       | 1 +
 drivers/net/txgbe/txgbe_ethdev_vf.c    | 2 ++
 8 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 46935ba872..95b536a5ef 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -195,6 +195,8 @@ New Features
     down. When the PF comes back, the VF triggers an
     ``RTE_ETH_EVENT_INTR_RESET`` event so the application can reset the VF
     and resume normal packet Rx/Tx.
+  * Added VF support for the Amber-Lite 40G NIC variant, with new device
+    IDs ``0x503f`` and ``0x513f``.
 
 
 Removed Items
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
index c73a9ebcb4..3ac4c28fd3 100644
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
index c99734cced..7c39e9f2e8 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -5229,6 +5229,7 @@ txgbe_rss_update(enum txgbe_mac_type mac_type)
 	case txgbe_mac_aml:
 	case txgbe_mac_aml40:
 	case txgbe_mac_aml_vf:
+	case txgbe_mac_aml40_vf:
 		return 1;
 	default:
 		return 0;
diff --git a/drivers/net/txgbe/txgbe_ethdev_vf.c b/drivers/net/txgbe/txgbe_ethdev_vf.c
index c57ac57141..341f62bc75 100644
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

