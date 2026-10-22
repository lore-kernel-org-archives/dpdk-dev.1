Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30918606A319
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 11:10:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D65340658;
	Thu, 22 Oct 2026 13:10:40 +0200 (CEST)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by mails.dpdk.org (Postfix) with ESMTP id 58E2B40264;
 Thu, 22 Oct 2026 13:10:36 +0200 (CEST)
X-QQ-mid: esmtpsz17t1792667430t2df215e9
X-QQ-Originating-IP: h0J/6cKsyF2Htj89fdyuS4pVKS9kdR4X+N5e/v78Mgw=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.205.193.71])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 22 Oct 2026 19:10:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14442279594974848506
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v9 01/16] net/txgbe: fix failure to configure 10G on
 dual-speed DAC
Date: Thu, 22 Oct 2026 19:03:07 +0800
Message-ID: <334DC8DAEC0EE0C7+20261022111017.3605-2-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261022111017.3605-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261022111017.3605-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NyNN0kiL8cx3qJF3EshZYNojk/3sxuPVJXAGHrYs4sTYX3liLrZkPTdX
 GjVUFHfCWFE6Pa728Wyzck3/XsMEkse4GTHO7R5Q99/2yRmuFfHdO72gqO6E002DMdfUHJ1
 e3PgY+U7xCGHB4hitGeyLzE8+ep699SWC37trbWJdAuIRfekAhxDtpOecm1XfRTgKqPAbyX
 nPx6T4OL6uJviOGnAA6i3SRzYaB/SQASlDAJhNQn7zfhGSghhqVsSdCBADftqPoIExTIcse
 2/VtvTeozpZBKCIqrr1ki09eLEnCsrE6zrWSbfC2lm/QV9vDNrnoPUZT2mT8mMa7e7vEpDa
 w8GKwIqigk2ECozwgOFPEMS4HFaDo+Vw9Xmp0s1K8gUO8VKJ9sQ/wW33qkXyrs9efyz92l+
 iIKx8rUJd1sV7ShMAZCFUgjiXKKrvP6zAXeVmvNtSKzYOC9NMA0nspV12aYbV6pM4Kix+ua
 xbX4v6N1Dd7aBQPEIp36SgdoyoUJ41Hl3IS2kbmEa1nIP/LicHNLWK1ecnmLmxAMpGE+Rhi
 RLPyGIUol6yF7D+L69qA1WnRDqVxB+7CstX0Evz1zNwTVw1HnAouz0NZShRFvDiCa40Js8f
 IrLS0Ih7iGjqyxtB1gHeEUQY+dR0GXCDx1X5LmAI+TiX5563BD06sfPh9RvlQ+PDZ5yizGu
 ElenOqWID2XGZul+ZG9TCHSsrd+2rp/HFLFSNaD/C2e7vz9h84k52mGP9/nRmor+S+kpTvi
 ITFPhmRB7oDB0YLQLAMOjS66CbveRWe23+/GJMz1C0jpUM3eR5uXFyrjYzh/U0/Dpsvg6Rz
 XkTp/RqjXX/PnYtgJour7SQVOvDF47wq/Lu5vBU5hCZ9WuQuzJM/gdolo+YTQTRAJU7PG7t
 cBHouEAK9cRCM/wiFX0/nubtgsLdKyLmkmzVQyH7YhxNQQrltGNBlrbxSKfxzuBbMb2rsS0
 WXc17Df5mVpmcwPJPc86GBSHQT9OjATBAxumRd8DJu9sWZgD4i2ErZnQKI8AxgYlSaZllIe
 LWPczWv/TAfM71wbuxGwRXbv6LCdFSlOnjzTooWXPcJ6w4cKpPPMI2FUS2xDZ/3ypA5BjdI
 w==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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

