Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAF8606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 11:09:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 543B840A77;
	Fri, 23 Oct 2026 13:08:44 +0200 (CEST)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTP id 7A2F340B9C
 for <dev@dpdk.org>; Fri, 23 Oct 2026 13:08:38 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1792753715t02dd7d47
X-QQ-Originating-IP: 4ixkZkxajciJMR1GXH4uuuZiAY1VN6t68Xt5vK6pNk0=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.205.193.71])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 23 Oct 2026 19:08:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14962215170824186352
EX-QQ-RecipientCnt: 3
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v10 17/17] net/txgbe: fix typo in the fiber_support_speed field
Date: Fri, 23 Oct 2026 19:03:55 +0800
Message-ID: <EEF8C528798480C7+20261023110728.3975-18-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261023110728.3975-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261023110728.3975-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N9i10iaAV/LhMT7gZ0ULt2fsxe0yEfWvu7dJYorgXYbGmrVviiphybZG
 7yMBDzTf81cyTkLQ7rvcBgKBw/R/yhUO9n6uxjF25Wd+WU0sBN0njC3w0B+jWzIbokaBL0w
 BvKWp0l+gv652J1AeqiYnDvBbOB3uoN3wBYL8D2HZkVcYkxI0m8JdYVGD91XLZ1JPkaS335
 LtnbxA8TBXJIh5FmocvhnTWjGSUQ3Lr4+Is1xv0Tqv8j8yJtGr+PPeo1qHPxcHpXQAyzNE2
 NKKNnWxG0Kxi/EhW8z5eB4FIdTwrcfNeX5WOjcKymJTqtWBP7Pt6OWdKsUkXgO+eYnmPBXl
 x8EP9LImyoTymMNEEgJFqrQiboOys58/uKhDH6n3Ub+3prFDtYjCB2A7dhb13PwMCq4ZY+k
 CPP5DcCoKFr81cgePRE3k6svEFbyWRguo7x4hBvYVAVSCiNHHfr8ERHnf6u8M9F4BRrEae/
 toV57hTwi+23f7N9ZsCHk2ldRHV9WU2IxJrUK7lPX4q+2u5n1fdyIOVoh1HgOXLPsk/EdXj
 akDTw9/NmRD24qC4JhQ3cvXOBJvMJ4dWZo+yD4RkB852+ov/M1jksJxUNpiAp8hgocY5+SA
 SK7dXlW1PzPikR6YNmQfSB8gVUzDA1omgZ3nl3WkPNE692jXcU8eI3kBIosdvJga8DRlj88
 l2to1gnkg1WV32uwCt02UT4iLDmv8wJjZ4ft0ZoA2uIFPgCG79G4yaxllEWxn0G0j6NzJpz
 Ni5Q/KPyyo8nQhfQ3z+bgKsc3MQ3gOw6KnWnU1/CopSv9eZEo8rGt3VmWLBsKaERwYMwPbt
 SbwsSQc415o8fmQsKdS7vY8g9EYK+IMssT6u4hBTJ13BZIKrsqVwD42V6724rRgNNTKjU1a
 YwTzbq4P9Lj3XFugTrGSmB0ZlPeyDofikfxvv2q844r3wfUPePMeqMRLmt7ohCu66dNHtvE
 mH2cgHcWEsC/R/nkLp3Gz1V7qNhcBn5jpFg0KP4kWnVlGC9R04NBZyR+T9dY1Ydl/ytNYoD
 brMVCnHM/gsH/bLMFwlD+SSal3f7PkzmSy1kSPaTpFhd+sCCwV341db6GRhMJEEIiXq/Ni6
 sQprvggD1j1Fq1hXceyMJaNAV5Jbu1ylA==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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
index a1ce78623b..28696cefce 100644
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

