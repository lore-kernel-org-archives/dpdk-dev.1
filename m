Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28344CD98E4
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 11:00:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CAB04064F;
	Wed, 17 Jun 2026 13:00:34 +0200 (CEST)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id 919A1406BC
 for <dev@dpdk.org>; Wed, 17 Jun 2026 13:00:31 +0200 (CEST)
X-QQ-mid: esmtpsz21t1781694025t77589f1b
X-QQ-Originating-IP: XisSjq3FpBT/u1OceoouOdnA/Nrv/eyUPX1C1Kwo2oQ=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 17 Jun 2026 19:00:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2318823260505516711
EX-QQ-RecipientCnt: 3
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 4/4] net/txgbe: add VF support for Amber-Lite 40G NIC
Date: Wed, 17 Jun 2026 18:59:59 +0800
Message-Id: <20260617105959.10764-5-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260617105959.10764-1-zaiyuwang@trustnetic.com>
References: <20260617105959.10764-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NyPaQtJYQgeoFSgwC6wsAUXMcPoxv+uEEBuR00/e1CLA9OJg5Tu/SR+H
 gKnW8kfVEAcN1ud8KSdzhDqHz2Ca6qI4f0szjHoXLK044IAu6O42pF/6b6eS5B/0JKs0JSf
 ocaI4hyAjKl12O+RIW5EmlZvanaOIc41j/jD3HSZqw4OdhpQxU5PpReSOcNVSlkG7a15x46
 ebQgROi0izcizpd8RZhZBHtL2GXSUyzOO9YAr56LkPFyTfOHmjv7BmtvErXT8d3Z0FhQLUC
 eenTmcM1yaDOrSvcwywKY4rnf+f6D+tf1PbcqNQZVNyTd1tNvcFP5hgMTPO2Lg0ptd5FSYw
 q8H18HtFkYAspSV/RO2roby1webS1B8fyEQ0QYepk3BStYQPnoRRbSH5UHYypCegxa70jtw
 7AHjYs8Zw2qrLbR9XI9mk4XzWFPpLARFjPnXScl8shLu8bp25hW6ReXx6gmdgCdCm79TVPF
 Wb6RqBaSWcmPMwdbJLuq5iO+5QC8dWMdrw9dbkizFRg881vclpZ8yomFw8f9sZUIwRaxFsC
 KXrEvog3b2Whn0OdSR6G6MvL2nOKRYKShjBad3WxsfNafKSuHFpzDv8ynGWklmU7a4riXt4
 /J96OxA+U43OZl3lqdVLOrNC+rquEI5U7/p1K8sq0xWUQld+sdJzdoD9tdfcaDlwaQee/8H
 owH86gMcDwDbtu9xhPGpD2CIAD69rdKIWax0O+5iWdhSlSqmy1XH2oLCIFZvLISYuyBsY88
 BHrxNe7rn8P0KqVbdFZSEyuJYiw5OcwC3wvxVedvhqPRYIweUdTZkwtOFqiUeZ7o+zdez5/
 9FQPj1Z3DrxOZc6OzkuW495mkcXuwRSSnWzFJv0UWEIz3FgtYWkTvq7hKjsjOFxIu8fXy5i
 mTtXJc42yF/M90pg5iL79DKnrSrrin5CoOI0+SlJ/hT3FlVKRi/ERzPYRBiVYyGiswSvirZ
 Ygpt28v7LM6dzIW5E6dEy1k+SP6wC1uGHdRbu8MxiOvUyIexj2/UA72BkTG6CW8CiZ1fvX3
 D3Vsu1l4Knkra5Bc41YoUrBGSkQzz3bG7UK/XsilNOPal/01sw
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
index c84656e206..2650b8b7f1 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -2552,6 +2552,7 @@ s32 txgbe_init_shared_code(struct txgbe_hw *hw)
 		break;
 	case txgbe_mac_sp_vf:
 	case txgbe_mac_aml_vf:
+	case txgbe_mac_aml40_vf:
 		status = txgbe_init_ops_vf(hw);
 		break;
 	default:
@@ -2582,6 +2583,7 @@ bool txgbe_is_vf(struct txgbe_hw *hw)
 	switch (hw->mac.type) {
 	case txgbe_mac_sp_vf:
 	case txgbe_mac_aml_vf:
+	case txgbe_mac_aml40_vf:
 		return true;
 	default:
 		return false;
@@ -2629,6 +2631,11 @@ s32 txgbe_set_mac_type(struct txgbe_hw *hw)
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
index 3c4c696c00..bf46a80862 100644
--- a/drivers/net/txgbe/base/txgbe_regs.h
+++ b/drivers/net/txgbe/base/txgbe_regs.h
@@ -1829,12 +1829,14 @@ txgbe_map_reg(struct txgbe_hw *hw, u32 reg)
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
@@ -2017,6 +2019,7 @@ static inline void txgbe_flush(struct txgbe_hw *hw)
 		break;
 	case txgbe_mac_sp_vf:
 	case txgbe_mac_aml_vf:
+	case txgbe_mac_aml40_vf:
 		rd32(hw, TXGBE_VFSTATUS);
 		break;
 	default:
diff --git a/drivers/net/txgbe/base/txgbe_type.h b/drivers/net/txgbe/base/txgbe_type.h
index d9d08b79a2..4b5ff7da17 100644
--- a/drivers/net/txgbe/base/txgbe_type.h
+++ b/drivers/net/txgbe/base/txgbe_type.h
@@ -174,6 +174,7 @@ enum txgbe_mac_type {
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
index 6e7ac1320f..16a548e6d0 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -5602,6 +5602,7 @@ txgbe_rss_update(enum txgbe_mac_type mac_type)
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

