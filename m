Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F236606A31B
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 12:26:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE031402B0;
	Mon, 26 Oct 2026 13:26:54 +0100 (CET)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by mails.dpdk.org (Postfix) with ESMTPS id 4236240275;
 Mon, 26 Oct 2026 13:26:51 +0100 (CET)
X-QQ-mid: esmtpgz15t1793017606t67eb611b
X-QQ-Originating-IP: A0Q5mO7odRT+E1RxHj3htbUcAV3dmYKxKCeqDTjs48M=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.25])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 26 Oct 2026 20:26:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12247619943470700277
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v11 01/17] net/txgbe: fix failure to configure 10G on
 dual-speed DAC
Date: Mon, 26 Oct 2026 20:21:47 +0800
Message-ID: <8A823E75AB0569D9+20261026122638.9198-2-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261026122638.9198-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261026122638.9198-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NOIkHYnr7VzdPGpN2ZBbUrnyy7QFRIMVuQ37uNJluHr/LHEV1sDVdWHg
 pKDwlCN9fe4X4HT7SGsyPYX5+Ypp//BwV1uoT6jCuHqSI4ijvTX/I3G6FQR2rN8S8mw3rH5
 BPSCoBGsc5wivix6D2ltbUWpeL32U3jtPKArutEUoXzn2r8R/nS/A/+LGsUVYaGDnE6G8Ax
 tLbVh8ZE9iWfe4ydtZJCh+VZWA97qtZ/M0lux560cCLviNIxKxLzqpCnaZ+5JjERVcUlORS
 lMZtKBBiBkLoGELf4Xn3sr6+0C3AN2gmZvBzofD+9rENNDdsTNm1mVqd+qOOjQ/zHS6TltQ
 NZU8vEZhrLML4qxOX7PUd92Qf/bcNO0kWuLh0Ic0/sCaQqtkcU8muoXyxbHyce4C+WL8YAi
 a3Qu41rS1N1oy7SsQ7a0VVzUT1wv29da5dgBYRLYQ/MR7oDoOMIvEwMmINS6S38D9bKD7A3
 RC8t5ih0T27TGaiPSfSRLdHD/GJI+OULVDIdsedeGagRTCzl0eXHggfzfpr0CXJk8Vt4g0H
 g2vTeg9wbs4bgzKlvMicvpmdk0rNfaNlEqJjeK8XtGF2+5iE+UokHe2CUNPH7cQJh+tIMIc
 ocj48TscIQd7iLx6ELSz9uSa3kAtTtKEaOUsfPUVCid7J7egaLXSJB4qpjMBenKLOPdKdTk
 4ImgkWYuF+olrjkcLpYduf8dUq1PgTC4L3mR/d52/QIe7HmPQjdYvBHhOMytORQ4QsO52y8
 hUge2QXNYTnaYRLpSMN5R2+vDrQOGbsPpNCRGIKbU0Gc0Upu3KkQhkLf0wdqIm0Z+Y3lknq
 7TSPblxSIVFeWx+/7m6Xf+GD65O1dfE0PrXJ2RIjeAaFaDTNWOQz1YR4IDl7axwSoZc7H+Y
 03T3mDJyWL+fy0JYTAu1Wd0MpuN90d7jN+0J7dUoXk5bri4EZsfDn5D9PBgbCj4AqAsArBy
 tmyEi1LeH+uZ7n3rpw5071OQ1KKqzLqS7pAnOXODfmg+NOKZ+B3fjPS/Njso+rg5oHS927R
 6XI0oQQc6xk8kfHDpnTBJQiWvis8jstudZ4J2tKGqg2aq7Q32gv01aosP2yHUvMUG0MdnvV
 Q==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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

