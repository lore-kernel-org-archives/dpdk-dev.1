Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B5ACD98F0
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 11:34:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44D8E40A7A;
	Wed, 17 Jun 2026 13:33:53 +0200 (CEST)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by mails.dpdk.org (Postfix) with ESMTP id C546340A73
 for <dev@dpdk.org>; Wed, 17 Jun 2026 13:33:51 +0200 (CEST)
X-QQ-mid: esmtpsz20t1781696027td0232d48
X-QQ-Originating-IP: jL61EJkJILMsgP9ngj46n04xFdJ7aDm2LHsjkMNeJeU=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 17 Jun 2026 19:33:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 526055705831516892
EX-QQ-RecipientCnt: 3
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v2 4/4] net/txgbe: add VF support for Amber-Lite 40G NIC
Date: Wed, 17 Jun 2026 19:33:34 +0800
Message-Id: <20260617113335.15648-5-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260617113335.15648-1-zaiyuwang@trustnetic.com>
References: <20260617105959.10764-1-zaiyuwang@trustnetic.com>
 <20260617113335.15648-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MVocNrGTvdgh7LPKh2UmtS+oQOYS0wO6XAtO9wyKzCGBY9IT5Ue7PARR
 9e/CKGOrJoR7nuDk/Uh/MwdyWxUzSB05uec9t1u+CCL52e1Y0jRq095u1i6qdncUt3HTAvI
 1pGVOAk+eLwDD3zM7Vhek02fn/+hfTFjXswq9AvIlRVFLprCQ82d67qlAkYGqwxzb2yOK5x
 7pH3mB6rYIZuw+Nk49IBFxNPF6Al9Ue1fX4vRwyxNSJ2mfAnfiTJ0DFIs8zJtysHMxFS/eB
 Vck4FVmJQCBoQAm6rpglQOTsUQZWYD8FK/ocxAM/gPA3xgfCuze4d14kYlrOjU+2pyNwNGO
 hNFbPWZcDkdLD8f+9MjIvfkmVM+BNyd975OD5t8DVkIS9eBHKvYZsgj32sTcQDCvFrUnJBN
 OoSb7ByZEC3j+Pqidkr8KlryxHLqqCF8pD6B7kw3UcXSa5nhlP0YQqomUfQpFf2J9QTSq67
 RUaueG/VqzK5LL+uDdcRpdqhUIhsfaVO7ZwdidfIeo1BsE8fx4GlGFjfg5gWYgIcBOaMZc6
 hdFPjbKY8UoEXWUx7ivvTgk+5GXlV/GZ9VLJutxWZhfCP0AhpHSUlHxqH3lMkH+UbI9q/9W
 RfMvobbvyr1kuVqOlxg3sn7k4gMWPUhgahXktNQw2OYjljd9JhzNWCXzJ9b80SB0ayXv8eC
 L4I/+UUCY7t63gP+PAuaZM0C7a+MLqQgHAWKSqdQqOrLp7wj8YvlzMneTPs++UaWH311MVp
 uj6+eGQUi1SJkEEDgg9R0ynKm8TSEhWgeyRzkkwWAfzhlx6bHyWfA3Ih+nGBr41V27l775b
 1o7Jf/HHQ4ArCb0Ixl6OdSIlOOnpbD6QjAtlIcGjepkKEcdecan7BCwKCh/gXFKAcyYi5Rf
 U3yFueVT4O/Lydo8NwC9TIdb05qa/qyahq0J2AdCe4sLkxxgw2tfxyeRvrvHj21ZTXUqhIT
 hqVjI8x9QvlAtAfjrwk7dQ4znxZruhMEuX0hC1m5ezV5E1GTvng+X/kZdAvYl+y+UVC5C2Z
 FHM0U8me3Umx/djVVHmMxxLcy82/C62+pW2iAOdyO4+1RP//fxCqUGzsUWKueOSYsBv72xM
 2HOHwoZNdl1QWmkFNY7QpaY16dhZS22qQ==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_devids.h | 2 ++
 drivers/net/txgbe/base/txgbe_hw.c     | 7 +++++++
 drivers/net/txgbe/base/txgbe_regs.h   | 7 +++++--
 drivers/net/txgbe/base/txgbe_type.h   | 1 +
 drivers/net/txgbe/base/txgbe_vf.c     | 7 ++++---
 drivers/net/txgbe/txgbe_ethdev.c      | 1 +
 drivers/net/txgbe/txgbe_ethdev_vf.c   | 2 ++
 7 files changed, 22 insertions(+), 5 deletions(-)

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
index 1a8a20f104..4412006f1f 100644
--- a/drivers/net/txgbe/base/txgbe_vf.c
+++ b/drivers/net/txgbe/base/txgbe_vf.c
@@ -134,7 +134,9 @@ s32 txgbe_reset_hw_vf(struct txgbe_hw *hw)
 	}
 
 	/* amlite: bme */
-	if (hw->mac.type == txgbe_mac_aml_vf)
+	if (hw->mac.type == txgbe_mac_aml_vf ||
+	    hw->mac.type == txgbe_mac_aml40_vf)
+
 		wr32(hw, TXGBE_BME_AML, 0x1);
 
 	if (!timeout)
@@ -493,8 +495,7 @@ s32 txgbe_check_mac_link_vf(struct txgbe_hw *hw, u32 *speed,
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
index 7ec1e009ed..655ccc622f 100644
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

