Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD221606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 12:29:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37B6040695;
	Mon, 26 Oct 2026 13:27:36 +0100 (CET)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTPS id 8FAA040BA2;
 Mon, 26 Oct 2026 13:27:30 +0100 (CET)
X-QQ-mid: esmtpgz15t1793017645te3971799
X-QQ-Originating-IP: gcKPDIG1LD0/hXl+Q7deymkpHVeRwMULubE8BA60Xds=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.25])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 26 Oct 2026 20:27:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4166407300100462057
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v11 17/17] net/txgbe: fix typo in the fiber support speed field
Date: Mon, 26 Oct 2026 20:22:03 +0800
Message-ID: <D0E1DBB6ACA7E6B0+20261026122638.9198-18-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261026122638.9198-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261026122638.9198-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: ODape9HLJUgbh+Tlaq9A4yYgXpLVKW0Xf8jdP4OX6tjNetBVXs6KHQbf
 A01JHlKxle2MM+G1HRLTemVg0g9H0OqZqM6Gha3kcwetfSoWT2MGXxvzBPMYsEwWUUlp3Ot
 1VsElQgx8/Rqr9Wt/65nxn4BfHvHogfMWfYuLiH/elUQ6/yQsm8ixZd85lhgKEmuz41wTD2
 2u9hltyUhD7rqC56rVsxEOi8LryfKg9LzaLvIIKeB3qK+7kNruz/gG5pLRdh3oF8uJ8XtLk
 JQAblB7EP/mXBXrGjaX9XcKKyAaxIxXiNKX1BvO0E5GGYtKYXeYYHIZ+GwbahAtDT2LJim0
 yKRx/1l6cko6fLB8OV7Ye+W05hS3rkd2++kjvI0ifqVBaj1s7VZbGTVJTtwhDvRoDvUVLtv
 m0skD0BagYtxLWML6JFDRZ/vOpSTQ0QSFobzaEOXJ3mjXcSqDIYqv8+5UdgmD3SPilMEVFm
 /1ifYGddq9WGNWbG+8ifZRuMGyunEbn+pXicLBoDJVieNaTtPcczxAblwTvvIft5bVrc1VC
 hdxPZIh8Yt8c2Neim53XbTJinAJOMIzeRvusiVwLHHyNjpNxjkhCmNcA2v+rzEM7YDghTNa
 26IaQKHBgrpxLU//mQ5JI8HpFR+I/edZJDYwTmgMYYx5Xp0TsjaDOUfynyGPsQuWq3v+NuN
 zqAkd+s2d6UWYi1obU+/+ir8LLefk37lHG/oHdFKKllC1/KJhI4uW/Ruqki91fRjII7mv9M
 EWK0RDncVoMOuhKRXzGGqrtV1p6pe5hgJ9BGU9oO3PpX3qJfLj6bad6WLiDbldkJ0jAgDG0
 zQ+v+17OVWk6ZiU5DixJbKxr9/si3JuW+tlO1Rln2O7tPf81+0Y/0VjbL0PQqlOc2mGTifu
 GovyMnSF41ODMu1vLMn+rijqQQ9cl79M0VLWBhTT6gK1pUexXN7ICJgF2g2mi5qRm0oLgpy
 UajG+61rQA1VRi2ivkFFu14MF1ljQzlYZKjanL/muj3NvaOo9lUr2GJUc5tOkrx4gY/7JH0
 8/B1xsUSCaYlvrZP0PcoyUNcA1GwJevh++zdnJelst0WnuHo7kpSUX0Kj3lvnhC2y7j57n/
 ezNKCiGPG43YDsMYMKwY63/2man9SPX125xtbdKOIo0
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
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

The name came from the out-of-tree base driver, which spells it the
same way.

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
index ae5c7d7f0d..89f281e116 100644
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
index a338880345..10a86e5095 100644
--- a/drivers/net/txgbe/base/txgbe_aml40.c
+++ b/drivers/net/txgbe/base/txgbe_aml40.c
@@ -123,13 +123,13 @@ s32 txgbe_get_link_capabilities_aml40(struct txgbe_hw *hw,
 
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
 	} else if (txgbe_is_40g_fiber_qsfp(hw)) {
 		*speed = TXGBE_LINK_SPEED_40GB_FULL;
 		*autoneg = false;
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

