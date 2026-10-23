Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AEA606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 11:07:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C5294067C;
	Fri, 23 Oct 2026 13:07:49 +0200 (CEST)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by mails.dpdk.org (Postfix) with ESMTP id 4F3F540647;
 Fri, 23 Oct 2026 13:07:46 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1792753661t2d70f9d2
X-QQ-Originating-IP: 4uWFIPukW+eooigBh4UNj2Ex0e8zuw3MaeZF++o7qcw=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.205.193.71])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 23 Oct 2026 19:07:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3864840596753759247
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v10 01/17] net/txgbe: fix failure to configure 10G on
 dual-speed DAC
Date: Fri, 23 Oct 2026 19:03:39 +0800
Message-ID: <D5CE24579AF98997+20261023110728.3975-2-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261023110728.3975-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261023110728.3975-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OAS5tGHYFRbc+RmZnFQhFlfZloAporuMFwOmFRBUZ0F9rGoar/0C/A7T
 CKCSjvwgYcZlLhrt4Mw0OjQEeD0+1bnAqVA2j3o1SRgRs2RMf2/s0ugES0k86ElJLDXKwuf
 wA1/lZa3k6oni1txZp+zmJ0Hrhn3adKerMmKpYNSagKCH2YMsDlce+lkR0FW+Wa3YTqI9eK
 4ytAUsIGJlSmXHvOCvjEQvCezH/YInGoI3zCJkHxe+c1Iy78eBdzbVQF70SpQRYAMS0NC1x
 5RuCRQV0hknBrB8ZmPEjrjIgnLbc17kkfyp+F57yVQswmINAdChAXc29zGtf69Yr4cVPwVK
 jNm0/mMq962iE9kaEoLEFJrVaS8tFONRSNvJyiUTxzMlovmVh4YbpiKbrn4tUUrasaztnCS
 NaRATanTtVTIUIEXeLdApZmRZbWDaZBlIbPwG2zlTAh8Git89P9bq3ph1UyWhOprPico/YY
 jHVmLLIWW2Jbc5ZoTPRG/NDcdUkfaFufHJ07tj5CcXTae9ADLXXNeBSs5zKeFmgzB0QLLca
 JwLlLIU4qttTW8GC013W4jf7MOBx67sNjU8ZJkoDIc7Y3TNwknAb4g0QfvvrEaaiMQuSHOe
 X1QrsbgLIsz++zhozLxAIC5lfd3bW5jaB1iZvi/+fe5S0jG4x9G92UpHVKGtxeWem+pcP/E
 vK2BHP4Fn3sL3Vv/x5HphkdpAjkWcYa1G58LYut5Yilwd3hOJTYnJOHDkfyCdoooklsx54S
 rTtXe/pgmIf60n+F6RGnLJd4hRd2ANePb1QQFtHuosWwN3jmMhV1p8Grc3RLxVMOaaeBvTa
 Ks2toShFjJbPNOYQOf9kDi4SEZVgXhMXTK2i05Qb8AyvneaxvwBYH6G5lJSwzU8q1/Mhlf6
 huPGMb3+HvN19ONrOcqRaWcw2vyhObvNWhbTZ+dkSNrh0vlLmi2lCSpoD8IbhYCmv46cmu7
 7U0gHpI/ZAWi9IW55dYyDdvag3euaYYzGLycoSXYUeSLYPiZi/uIAgxOdcv/ZbKTg1AwUQD
 dbA65HH6it4u3AdjtJqIh8RlGfxLZdsFz9hyIYAiclzMGp7Uh6
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
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

Setting "port config speed 10000" on a 10G/40G dual-speed DAC cable
fails with LINK_SETUP_ERR, and the AN base page always advertises
only 40G.

Two checks independently blocked 10G:

1. allowed_speeds in dev_start was restricted to 40G, so the user
   request was rejected before reaching setup_link.
2. get_link_capabilities_aml40() returned only 40G for all DAC
   cables, so the link_capabilities mask in setup_phy_link_aml40()
   stripped any 10G bit from the caller speed.

Remove both restrictions so 10G flows through from user
configuration to the AN base page advertisement. On DAC cables the
capability is read from hw->phy.fiber_suppport_speed, which reflects
the actual SFP module.

Fixes: fb6eb170dfa2 ("net/txgbe: add basic link configuration for Amber-Lite")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_aml40.c | 15 +++++++++++----
 drivers/net/txgbe/txgbe_ethdev.c     |  2 +-
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_aml40.c b/drivers/net/txgbe/base/txgbe_aml40.c
index 1098efe5e6..7c72b53f64 100644
--- a/drivers/net/txgbe/base/txgbe_aml40.c
+++ b/drivers/net/txgbe/base/txgbe_aml40.c
@@ -98,11 +98,12 @@ s32 txgbe_get_link_capabilities_aml40(struct txgbe_hw *hw,
 {
 	if (hw->phy.sfp_type == txgbe_qsfp_type_40g_cu_core0 ||
 	    hw->phy.sfp_type == txgbe_qsfp_type_40g_cu_core1) {
-		*speed = TXGBE_LINK_SPEED_40GB_FULL;
-		*autoneg = true;
+		*speed = hw->phy.fiber_suppport_speed;
+		*autoneg = hw->devarg.auto_neg;
 	} else if (txgbe_is_backplane(hw)) {
-		*speed = TXGBE_LINK_SPEED_40GB_FULL;
-		*autoneg = true;
+		*speed = TXGBE_LINK_SPEED_40GB_FULL |
+			 TXGBE_LINK_SPEED_10GB_FULL;
+		*autoneg = hw->devarg.auto_neg;
 	} else {
 		/*
 		 * Temporary workaround: set speed to 40G even if sfp not present
@@ -176,6 +177,12 @@ s32 txgbe_setup_phy_link_aml40(struct txgbe_hw *hw,
 		return status;
 	}
 
+	/* setup the highest link when no autoneg */
+	if (speed & TXGBE_LINK_SPEED_40GB_FULL)
+		speed = TXGBE_LINK_SPEED_40GB_FULL;
+	else if (speed & TXGBE_LINK_SPEED_10GB_FULL)
+		speed = TXGBE_LINK_SPEED_10GB_FULL;
+
 	if (txgbe_is_backplane(hw) || txgbe_is_dac_cable(hw) ||
 	    hw->phy.ffe_set) {
 		rte_spinlock_lock(&hw->phy_lock);
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 0734a1c63c..d4c635dc2f 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -1848,7 +1848,7 @@ txgbe_dev_start(struct rte_eth_dev *dev)
 		goto error;
 
 	if (hw->mac.type == txgbe_mac_aml40)
-		allowed_speeds = RTE_ETH_LINK_SPEED_40G;
+		allowed_speeds = RTE_ETH_LINK_SPEED_10G | RTE_ETH_LINK_SPEED_40G;
 	else if (hw->mac.type == txgbe_mac_aml)
 		allowed_speeds = RTE_ETH_LINK_SPEED_10G | RTE_ETH_LINK_SPEED_25G;
 	else
-- 
2.55.0.windows.2

