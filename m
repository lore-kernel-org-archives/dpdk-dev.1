Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12199606A31D
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Oct 2026 10:42:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 562C84068A;
	Wed, 28 Oct 2026 11:40:48 +0100 (CET)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by mails.dpdk.org (Postfix) with ESMTPS id D9341406BB;
 Wed, 28 Oct 2026 11:40:43 +0100 (CET)
X-QQ-mid: esmtpgz13t1793184039t9afb9007
X-QQ-Originating-IP: bsnPext82kTyouCGjrXVF6FqkpeSGgQ9hpfmXg8MLSk=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.223])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 28 Oct 2026 18:40:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3791947689855664171
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v13 17/17] net/txgbe: fix typo in the fiber support speed field
Date: Wed, 28 Oct 2026 18:34:06 +0800
Message-ID: <BD763D009F2F2BE5+20261028103913.10188-18-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261028103913.10188-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261028103913.10188-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OQhZ3T0tjf0a8WxnBsZ4YccH4ZE9WO+phVd20eCnSDHiL2O/382nQN99
 HnCtflvn2splSg49Wk11k9Dfy8qvY7y0jK1k7OzRdiDF1XOvzetTG0NhMh+PHgHo01dsqJ+
 TgpkijI0oYQZyIDaSo8zYLGUAEMiq3/jZKcmlTi/FRNjg6SOyuITFCvT7PDfIo3NOkrCu+s
 Elo0U4WosvUdFv6npA9Mz8hnmaQ9XP35cMAraUGoaWM4efhnu4CxcibeURxiWcsYQibcKyl
 NVDsDollhiK52HZ1ogvYxHSS+USftMNUcf4GQT8Yb7zBLGZ3eNEZavcS1FrXUmR5WdQnCxy
 KPIoZX76ZH4vs1TMxBFmGFiPmcbCrrdBjV9ECuU09EgEpd2yqO3W2NFnb9VbH2YOSGFGDAm
 a06QeKVyaeXsgA/8HmQjN/373Pl32PTtpy4z9O/IojUsfT8SbNzQCUqP8d9xC4GsKBF3mYg
 9pttegjkDzO3JR7zAb7Jow/g9qgT/v6NWUFu1LGmpJP5qh5BXepXinLd9eaLroX4IunqX93
 7yvEaT2bRJ9/j9+oKihNGIIhoZIFEe7/sQjNFh1AbwtIb/1DjtFaDl37qlko0E3d3OuNOQ6
 f9b+80QMi3j033KWugezge3s383iJ0VMOIEOM1HTbGmEwl+TswM5lwo9DADX0sMAqpPDPt1
 zko0HU3YkTmv4rBg/8QgeIkdR9Y1g4ZHRO2hcbBf4dZh8ipRfTy1mksjn3t2hfvhQWrW0Jf
 7JK6vH63BHy4DyTXrY1IapTFU+khrXdZgj71T0Avd30eTV+cZp10W4YL5g+ggLsviNL4Gj6
 QCwJnSZvvz6E7U2MIqgXgfg7nxUaQEBsP5vQsvl0oQ+QgmWI7m6kREnkeny6ZDXtnL4lwOy
 mHFpRP1i2uIltWT1GUMXE8qcW2G1AfZccav9r0dr+myOaN9YL6tPLIzSKf59JkGnimT6WSn
 Cd1At1APzMkQGv5DvUAwYYb0Cb0YdSfIDa796jp743RMesV8EfdiETVMo/dsShaJIwwfjTu
 uxcIBflV0PXCbdKF5L9oqVuRdyRk3OJC9u/ioEp9t1GDEQ2L5rkNQ2HGXIjFRslxNT6MFHF
 ygbwPeb6MLgh1KTnGcRJxalOJzH2ChJhA==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

struct txgbe_phy_info spells this field fiber_suppport_speed, with
three p. Rename it to fiber_support_speed.

Fixes: 234ce0d1fa9d ("net/txgbe: fix link stability for Amber-Lite backplane mode")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_aml.c   | 4 ++--
 drivers/net/txgbe/base/txgbe_aml40.c | 4 ++--
 drivers/net/txgbe/base/txgbe_phy.c   | 8 ++++----
 drivers/net/txgbe/base/txgbe_type.h  | 2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_aml.c b/drivers/net/txgbe/base/txgbe_aml.c
index 8ee4c1264c..059105b609 100644
--- a/drivers/net/txgbe/base/txgbe_aml.c
+++ b/drivers/net/txgbe/base/txgbe_aml.c
@@ -104,13 +104,13 @@ s32 txgbe_get_link_capabilities_aml(struct txgbe_hw *hw,
 			 TXGBE_LINK_SPEED_25GB_FULL;
 		*autoneg = true;
 	} else if (txgbe_is_dac_cable(hw)) {
-		if (hw->phy.fiber_suppport_speed ==
+		if (hw->phy.fiber_support_speed ==
 		    TXGBE_LINK_SPEED_10GB_FULL) {
 			*autoneg = false;
 		} else {
 			*autoneg = true;
 		}
-		*speed = hw->phy.fiber_suppport_speed;
+		*speed = hw->phy.fiber_support_speed;
 	} else if (hw->phy.sfp_type == txgbe_sfp_type_25g_sr_core0 ||
 		hw->phy.sfp_type == txgbe_sfp_type_25g_sr_core1 ||
 		hw->phy.sfp_type == txgbe_sfp_type_25g_lr_core0 ||
diff --git a/drivers/net/txgbe/base/txgbe_aml40.c b/drivers/net/txgbe/base/txgbe_aml40.c
index a415c8f4a2..747d29b170 100644
--- a/drivers/net/txgbe/base/txgbe_aml40.c
+++ b/drivers/net/txgbe/base/txgbe_aml40.c
@@ -110,13 +110,13 @@ s32 txgbe_get_link_capabilities_aml40(struct txgbe_hw *hw,
 
 	/* Fiber or DAC cable */
 	if (txgbe_is_dac_cable(hw)) {
-		if (hw->phy.fiber_suppport_speed ==
+		if (hw->phy.fiber_support_speed ==
 		    TXGBE_LINK_SPEED_10GB_FULL) {
 			*autoneg = false;
 		} else {
 			*autoneg = hw->devarg.auto_neg;
 		}
-		*speed = hw->phy.fiber_suppport_speed;
+		*speed = hw->phy.fiber_support_speed;
 	} else {
 		/* Unknown module: report 40G so setup_mac_link() does not
 		 * fail with TXGBE_ERR_LINK_SETUP.
diff --git a/drivers/net/txgbe/base/txgbe_phy.c b/drivers/net/txgbe/base/txgbe_phy.c
index 896fe7eecf..db4edbf411 100644
--- a/drivers/net/txgbe/base/txgbe_phy.c
+++ b/drivers/net/txgbe/base/txgbe_phy.c
@@ -913,11 +913,11 @@ s32 txgbe_identify_sfp_module(struct txgbe_hw *hw)
 		if (comp_codes_25g == TXGBE_SFF_25GBASECR_91FEC ||
 		    comp_codes_25g == TXGBE_SFF_25GBASECR_74FEC ||
 		    comp_codes_25g == TXGBE_SFF_25GBASECR_NOFEC) {
-			hw->phy.fiber_suppport_speed =
+			hw->phy.fiber_support_speed =
 				TXGBE_LINK_SPEED_25GB_FULL |
 				TXGBE_LINK_SPEED_10GB_FULL;
 		} else {
-			hw->phy.fiber_suppport_speed =
+			hw->phy.fiber_support_speed =
 				TXGBE_LINK_SPEED_10GB_FULL;
 		}
 	} else if (comp_codes_25g == TXGBE_SFF_25GAUI_C2M_AOC_BER_5 ||
@@ -938,7 +938,7 @@ s32 txgbe_identify_sfp_module(struct txgbe_hw *hw)
 			hw->phy.sfp_type = (hw->bus.lan_id == 0
 				? txgbe_sfp_type_da_act_lmt_core0
 				: txgbe_sfp_type_da_act_lmt_core1);
-			hw->phy.fiber_suppport_speed =
+			hw->phy.fiber_support_speed =
 				TXGBE_LINK_SPEED_10GB_FULL;
 		} else {
 			hw->phy.sfp_type = txgbe_sfp_type_unknown;
@@ -1142,7 +1142,7 @@ s32 txgbe_identify_qsfp_module(struct txgbe_hw *hw)
 				hw->phy.sfp_type = txgbe_qsfp_type_40g_cu_core0;
 			else
 				hw->phy.sfp_type = txgbe_qsfp_type_40g_cu_core1;
-			hw->phy.fiber_suppport_speed =
+			hw->phy.fiber_support_speed =
 						TXGBE_LINK_SPEED_40GB_FULL |
 						TXGBE_LINK_SPEED_10GB_FULL;
 		}
diff --git a/drivers/net/txgbe/base/txgbe_type.h b/drivers/net/txgbe/base/txgbe_type.h
index b030275141..492fb98a64 100644
--- a/drivers/net/txgbe/base/txgbe_type.h
+++ b/drivers/net/txgbe/base/txgbe_type.h
@@ -724,7 +724,7 @@ struct txgbe_phy_info {
 	u32 addr;
 	u32 id;
 	enum txgbe_sfp_type sfp_type;
-	u32 fiber_suppport_speed;
+	u32 fiber_support_speed;
 	bool sfp_setup_needed;
 	u32 revision;
 	u32 media_type;
-- 
2.55.0.windows.2


