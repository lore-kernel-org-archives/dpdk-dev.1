Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6877E606A33F
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 11:44:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EFD0840DDC;
	Tue, 27 Oct 2026 12:43:05 +0100 (CET)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTPS id A825540A87;
 Tue, 27 Oct 2026 12:43:02 +0100 (CET)
X-QQ-mid: esmtpsz17t1793101379ta80c537d
X-QQ-Originating-IP: 3By5HmqH636UMTEy9FWdy0hiTChF1yT91FAqbs3YdfU=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.25])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 27 Oct 2026 19:42:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4275244788979904637
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v12 17/17] net/txgbe: fix typo in the fiber support speed field
Date: Tue, 27 Oct 2026 19:38:33 +0800
Message-ID: <3584C072589B9465+20261027114218.9724-18-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261027114218.9724-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261027114218.9724-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MlsYLnHA0UVjuRdd+TCSH4tcLh/AQAENlkrn+FVlsElpAbUKdtQ9V96p
 SFV3DHLvUbdXTPSpi1GcGwcyuqDKuJmVuqpqVKUtBMM72ExBDJGovK2aRdWdeqZWpg93BhN
 kq9orfqMG+HEl7Z0tpeC8v/BLK45fRBtWWIKu5SEw3BpsXzvY6yvScr51dlUgn8M6P4qDxt
 qcsQcgFtxcXtbDmai9Zk68+GchW3aQP6kQ97jcsiYhFy+wfW3MuF9tMqdWYsyqZIXFUheW3
 KfPHSC5wZvG1iEembI9XHxVd85qtDaJf161nwOcfsPBg4Qwcn9foA1RVrJTNnfjaI/Yhbwp
 KDpPpH2mWvEkOYo8eKJ2qwgAnFqGIQfQaAHVq+HnghuNJzxUcCPRzUcl/KrQG1C0Q60K3M4
 VtuP4HdKbgISE8179okTa/6dvplBAwdeIQ6a5nxLEIjpkH7h3xzdZkAPVA9SVq9EUZ/cy1W
 PdLQc9SwASW733AA1qdZGUQwVPfcyvoVkMxFShdQzTnXapiqOwLlhWfMgVG4vFdoBNy0UZG
 TpuemU189FWSrMloX33sVJGS5qvoJO6ssXpXnRrUiDzEyAg1QYi4GnXLDVWSihIBxD+mo+O
 wTdKsxNtryCzenb9wTMUA86q7gGzCKcpRO/EvuQ3B3eUbjPzwMdBXDiliEU5D2x1tkD1+te
 8Cw8etXCCSvyS8TBmXO7uRPj1Xd5v9fw3rJRYMRwIOPiqyX5W2Zz1ah/BKiMQNSrsjKmbXu
 TKSe6/N/S25TYS0nMgmcAGEDcPO0AsWihvkaD370rJ1x92TlDDXj36CA6rs5sP+3JCogK41
 7ZyWQzW4452XYK6S8gRMzs2SOm+KZ4TNPH0IVKrI2TMncy0WyuTPwmCAdWFv7k/z71LF2DQ
 y9CkRGkLnW2wjaCJjN6faPisgc6TX5qiPRFSZkZ/7tS4g+EXkqT9pqRARv/M9ARyD01cr6f
 VjBddgkECRv+ueVxgbsqwPmvbG7b8bpoO5EOHgumebX8uV2mYiCVYGGvYCeAB8LXurLlklw
 cjQ4ylmVPYcPBqe6MMot+L0PaY48kXe7K0fPCbdSe05pTn5BwkjeGDZ08sJN2MCs0sYfTIv
 k057RxjXoGyy/qr8QJe3uRU5w8ugIB3eQ==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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

