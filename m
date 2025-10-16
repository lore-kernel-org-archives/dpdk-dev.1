Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54B0CCD194
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 11:19:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4DB74275B;
	Thu, 16 Oct 2025 13:19:25 +0200 (CEST)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 by mails.dpdk.org (Postfix) with ESMTP id 3DE2240A71
 for <dev@dpdk.org>; Thu, 16 Oct 2025 13:19:22 +0200 (CEST)
X-QQ-mid: esmtpsz17t1760613556ta99f8546
X-QQ-Originating-IP: E7PinH8hUagaQwnYyu7RhljyXivGo6jGvawR+pJldII=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.206.160.146])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 16 Oct 2025 19:19:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7875443516415603971
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v5 01/21] net/txgbe: add basic information for Amber-Lite
 25G/40G NICs
Date: Thu, 16 Oct 2025 19:17:15 +0800
Message-Id: <20251016111736.25372-2-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251016111736.25372-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20251016111736.25372-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: McwPjg3OAJPjh5aTuq0KSbZ5zps5JYmWZ0xg0BqE4FiwLK7YIhNyk5HV
 UzPIvtD/p9C29phEe78pPlfBjqGVFi6NzWzoNM+mEDqgkiMA3KMODy4aNZTtthzwC+cidsJ
 yjbzGUs50hD7EIjvze5Wq43b9INmvVy7wJXe7ruUvScgfk++XfBnIq5sJZM1HOPlR1wpa+T
 s40Q5HcJInQm+0w3aI7us7/xQAxQltOz1nOPjKYYJqeKl9bA4MBnSVX+FJJwgwWLdK5vSQK
 1SRqjwd/AZtYJ44GTseUeYUUvuiiU/Rm71Cgz2XEHqM/etwVlzW640LmwGjY8mDfgt3cWb1
 GoXE2SDl25R6+UQTNf/MZFHpnOEQJ+C2qaogFOZa9w8cz7+rJBFQcMBYUcRC7Fi5M+4zRZS
 CtfYKi5G6RENj6gqiml7lprRvkSsBL9M9MMrn+GcwQ9+5RFSR01MAMiAnfe2/m6KIGXpUJE
 QVroQMI7TA6GvvQwj+PEieTVaRupjDE9OQQPHvTtDDz9ZU1kdnbo80uKKO7sT8CP/T/ydXd
 WWYsLX6s72SjwnBrJ4j5M3VDk9P1AFHC68LjyWXyj0EdtbEhlhZ0Ch9HRQ1eh37OEf13Ox/
 ZxHNifT6eCEJ1uTmnhaGCmQYVE8/0G8OeloQ+r4CH2SkT5sCIzyV9tbzk+D5NyPQaeD3NtC
 zu1svlborvCQzkCjpYhRvd4OZF2vRBP1tz+shqVFmM3NU/X+9we/QMp1o48ZELBnkswTVj0
 AcIKvZRTB313U8Klgn41zeyDdV3/UYZrhEVJZgHN87Kk1lTfJnhO5UA+o4DVywBgUardDKr
 7vdue+OciNntcddMMKdmal1y8lD3Au1d9uo57hHSFCkzj26qQX0XrnCyi9qPnaXH0BCzwas
 ozaENG3uleYuutWx6UOX2/hVH15JbYaP5aRCBnK16eVetXR5Grr7z5Fa5lx15d+MSp4WbRA
 r8OuvchC6K0FLjgu/rm8Mo7uu3nHhtPHZiKI3p9rE7/7zIHFAFcLdp11wra/v34BgcnNWdc
 Zf7dTQDJmSIfnKObt6AzhSSNcT6s1ZoDBN0AhDSOrHdFDsy+0RGrjsnCLiibA+io1g/XMp7
 8p6juGRBGxcoQJYqL2chBw=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
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

Add device IDs, speed and other basic information for Wangxun's
new Amber-Lite NICs: aml (10G/25G) and aml40 (40G).

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_devids.h |  9 +++++++
 drivers/net/txgbe/base/txgbe_hw.c     | 17 +++++++++++++
 drivers/net/txgbe/base/txgbe_regs.h   |  4 ++-
 drivers/net/txgbe/base/txgbe_type.h   |  3 +++
 drivers/net/txgbe/txgbe_ethdev.c      | 35 ++++++++++++++++++++-------
 5 files changed, 58 insertions(+), 10 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_devids.h b/drivers/net/txgbe/base/txgbe_devids.h
index a3f26eabf6..b7133c7d54 100644
--- a/drivers/net/txgbe/base/txgbe_devids.h
+++ b/drivers/net/txgbe/base/txgbe_devids.h
@@ -19,6 +19,15 @@
 #define TXGBE_DEV_ID_WX1820			0x2001
 #define TXGBE_DEV_ID_SP1000_VF                  0x1000
 #define TXGBE_DEV_ID_WX1820_VF                  0x2000
+#define TXGBE_DEV_ID_AML			0x5000
+#define TXGBE_DEV_ID_AML5025			0x5025
+#define TXGBE_DEV_ID_AML5125			0x5125
+#define TXGBE_DEV_ID_AML5040			0x5040
+#define TXGBE_DEV_ID_AML5140			0x5140
+
+#define TXGBE_DEV_ID_AML_VF			0x5001
+#define TXGBE_DEV_ID_AML5024_VF			0x5024
+#define TXGBE_DEV_ID_AML5124_VF			0x5124
 
 /*
  * Subsystem IDs
diff --git a/drivers/net/txgbe/base/txgbe_hw.c b/drivers/net/txgbe/base/txgbe_hw.c
index 42cd0e0e2c..76f8ecf62e 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -2476,6 +2476,8 @@ s32 txgbe_init_shared_code(struct txgbe_hw *hw)
 	txgbe_init_ops_dummy(hw);
 	switch (hw->mac.type) {
 	case txgbe_mac_raptor:
+	case txgbe_mac_aml:
+	case txgbe_mac_aml40:
 		status = txgbe_init_ops_pf(hw);
 		break;
 	case txgbe_mac_raptor_vf:
@@ -2523,11 +2525,26 @@ s32 txgbe_set_mac_type(struct txgbe_hw *hw)
 	case TXGBE_DEV_ID_WX1820:
 		hw->mac.type = txgbe_mac_raptor;
 		break;
+	case TXGBE_DEV_ID_AML:
+	case TXGBE_DEV_ID_AML5025:
+	case TXGBE_DEV_ID_AML5125:
+		hw->mac.type = txgbe_mac_aml;
+		break;
+	case TXGBE_DEV_ID_AML5040:
+	case TXGBE_DEV_ID_AML5140:
+		hw->mac.type = txgbe_mac_aml40;
+		break;
 	case TXGBE_DEV_ID_SP1000_VF:
 	case TXGBE_DEV_ID_WX1820_VF:
 		hw->phy.media_type = txgbe_media_type_virtual;
 		hw->mac.type = txgbe_mac_raptor_vf;
 		break;
+	case TXGBE_DEV_ID_AML_VF:
+	case TXGBE_DEV_ID_AML5024_VF:
+	case TXGBE_DEV_ID_AML5124_VF:
+		hw->phy.media_type = txgbe_media_type_virtual;
+		hw->mac.type = txgbe_mac_aml_vf;
+		break;
 	default:
 		err = TXGBE_ERR_DEVICE_NOT_SUPPORTED;
 		DEBUGOUT("Unsupported device id: %x", hw->device_id);
diff --git a/drivers/net/txgbe/base/txgbe_regs.h b/drivers/net/txgbe/base/txgbe_regs.h
index 346c23b5da..8da976dcc4 100644
--- a/drivers/net/txgbe/base/txgbe_regs.h
+++ b/drivers/net/txgbe/base/txgbe_regs.h
@@ -97,7 +97,9 @@
 #define     TXGBE_LINK_SPEED_2_5GB_FULL   0x0400
 #define     TXGBE_LINK_SPEED_5GB_FULL     0x0800
 #define     TXGBE_LINK_SPEED_10GB_FULL    0x0080
-#define     TXGBE_LINK_SPEED_40GB_FULL    0x0100
+#define     TXGBE_LINK_SPEED_25GB_FULL    0x0100
+#define     TXGBE_LINK_SPEED_40GB_FULL    0x0040
+#define     TXGBE_LINK_SPEED_50GB_FULL    0x0200
 #define   TXGBE_AUTOC_AUTONEG             MS64(63, 0x1)
 
 
diff --git a/drivers/net/txgbe/base/txgbe_type.h b/drivers/net/txgbe/base/txgbe_type.h
index 65527a22e7..731a7b4373 100644
--- a/drivers/net/txgbe/base/txgbe_type.h
+++ b/drivers/net/txgbe/base/txgbe_type.h
@@ -140,7 +140,10 @@ enum txgbe_eeprom_type {
 enum txgbe_mac_type {
 	txgbe_mac_unknown = 0,
 	txgbe_mac_raptor,
+	txgbe_mac_aml,
+	txgbe_mac_aml40,
 	txgbe_mac_raptor_vf,
+	txgbe_mac_aml_vf,
 	txgbe_num_macs
 };
 
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 580579094b..d49030357d 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -145,6 +145,11 @@ static void txgbe_l2_tunnel_conf(struct rte_eth_dev *dev);
 static const struct rte_pci_id pci_id_txgbe_map[] = {
 	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_WANGXUN, TXGBE_DEV_ID_SP1000) },
 	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_WANGXUN, TXGBE_DEV_ID_WX1820) },
+	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_WANGXUN, TXGBE_DEV_ID_AML) },
+	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_WANGXUN, TXGBE_DEV_ID_AML5025) },
+	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_WANGXUN, TXGBE_DEV_ID_AML5125) },
+	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_WANGXUN, TXGBE_DEV_ID_AML5040) },
+	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_WANGXUN, TXGBE_DEV_ID_AML5140) },
 	{ .vendor_id = 0, /* sentinel */ },
 };
 
@@ -1829,8 +1834,13 @@ txgbe_dev_start(struct rte_eth_dev *dev)
 	if (err)
 		goto error;
 
-	allowed_speeds = RTE_ETH_LINK_SPEED_100M | RTE_ETH_LINK_SPEED_1G |
-			RTE_ETH_LINK_SPEED_10G;
+	if (hw->mac.type == txgbe_mac_aml40)
+		allowed_speeds = RTE_ETH_LINK_SPEED_40G;
+	else if (hw->mac.type == txgbe_mac_aml)
+		allowed_speeds = RTE_ETH_LINK_SPEED_10G | RTE_ETH_LINK_SPEED_25G;
+	else
+		allowed_speeds = RTE_ETH_LINK_SPEED_100M | RTE_ETH_LINK_SPEED_1G |
+				 RTE_ETH_LINK_SPEED_10G;
 
 	link_speeds = &dev->data->dev_conf.link_speeds;
 	if (((*link_speeds) >> 1) & ~(allowed_speeds >> 1)) {
@@ -1840,17 +1850,24 @@ txgbe_dev_start(struct rte_eth_dev *dev)
 
 	speed = 0x0;
 	if (*link_speeds == RTE_ETH_LINK_SPEED_AUTONEG) {
-		speed = (TXGBE_LINK_SPEED_100M_FULL |
-			 TXGBE_LINK_SPEED_1GB_FULL |
-			 TXGBE_LINK_SPEED_10GB_FULL);
+		if (hw->mac.type == txgbe_mac_aml40) {
+			speed = TXGBE_LINK_SPEED_40GB_FULL;
+		} else  if (hw->mac.type == txgbe_mac_aml) {
+			speed = (TXGBE_LINK_SPEED_10GB_FULL |
+				 TXGBE_LINK_SPEED_25GB_FULL);
+		} else {
+			speed = (TXGBE_LINK_SPEED_100M_FULL |
+				 TXGBE_LINK_SPEED_1GB_FULL |
+				 TXGBE_LINK_SPEED_10GB_FULL);
+		}
 		hw->autoneg = true;
 	} else {
+		if (*link_speeds & RTE_ETH_LINK_SPEED_40G)
+			speed |= TXGBE_LINK_SPEED_40GB_FULL;
+		if (*link_speeds & RTE_ETH_LINK_SPEED_25G)
+			speed |= TXGBE_LINK_SPEED_25GB_FULL;
 		if (*link_speeds & RTE_ETH_LINK_SPEED_10G)
 			speed |= TXGBE_LINK_SPEED_10GB_FULL;
-		if (*link_speeds & RTE_ETH_LINK_SPEED_5G)
-			speed |= TXGBE_LINK_SPEED_5GB_FULL;
-		if (*link_speeds & RTE_ETH_LINK_SPEED_2_5G)
-			speed |= TXGBE_LINK_SPEED_2_5GB_FULL;
 		if (*link_speeds & RTE_ETH_LINK_SPEED_1G)
 			speed |= TXGBE_LINK_SPEED_1GB_FULL;
 		if (*link_speeds & RTE_ETH_LINK_SPEED_100M)
-- 
2.21.0.windows.1

