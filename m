Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BA9C79F9E
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 12:41:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52B1740E2A;
	Tue,  8 Sep 2026 14:41:03 +0200 (CEST)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by mails.dpdk.org (Postfix) with ESMTP id 4930140374;
 Tue,  8 Sep 2026 14:41:01 +0200 (CEST)
X-QQ-mid: esmtpgz10t1788871258t0234207a
X-QQ-Originating-IP: GPnz9bXqlV8m7ymIS9FxJV3D0S03p429te8Kce5R8wQ=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.66.61])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 08 Sep 2026 20:40:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1997862568339445502
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v2 01/15] net/txgbe: fix failure to configure 10G on
 dual-speed DAC
Date: Tue,  8 Sep 2026 20:38:46 +0800
Message-ID: <15CE4E7715749988+20260908124047.2284-2-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260908124047.2284-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260908124047.2284-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N3IC8um5pMyY9HWfcgQx8pfb4bw+mZfZn2vDAs1nHUL1fQOTjo4Gt+IJ
 pjgP18zfKEZTnl6Z8QUDw/B9EEcS1DmkV+AAs+Gw6ee1ZzVCO/M0ymodrLQ3sN22/s6S14W
 tDGses+fqKWvlw7DkJgSNsSJmwQ+2pCqqPEfkjzu1N1Lkf+5H7hV0rMGtkZDKVx1YlbTmJw
 jEpU3hFzhoJ9fzAmJ+4s5Kxhch48VGtocWUltiJiYnB+8wx9eOK8zlgfKbT0wy332d9OFW8
 8HTTyeYD7AAcINIWI+mtQ2QSdxjfzePYTj4e1Ait9LZ/IX+sVYOxH84S+FEgpsOlpaDO9wU
 k+4/41zIFAWRKgKClzX1OfEuBiK35p5zPlbOY/XkuU8Gv2qY8UYOluGmef0+p2QQLGraCeq
 iWiMVMUVUTq11y79XxY3VQ14htPv8j/AhvtwXyqX4MxS1VlYoPSvNpWo869cN2dh00YPnrG
 6yQ1bosmRwPxqXm4fDTA7WPPO87xpSuElPPUfEDbrkOz7njVcEx00qpimszXpkzWpqsdmNL
 pwxXjKXJuE0o8blIBuf6gm86iGaEGSbndQ2zDEbQlV9k7dcfUE0i75unOwhSXY7eXnOgt7b
 7QY+OBC0BBwNLmU44+Jpc01aJ6v9/tfTV2oVLrLIRMSCrWRpybVnDO8CVjsug9ydDRJOYkh
 bylvi1V6LTLPDq17zNez9VUjHb5f3klWTPDuEs5D/7IK4P17NXSMf/i7BGHi9UoGud0eJ0A
 b6Q7BDMgnA4J22EPOQjcxwPbwz3jkotRaQO5WMi6vy1YZepX5IJ+sbehk6Go50StnpPr2K/
 qySKMTnAQVnksyPxofTXyIpVJHkIQIL31MhD0TzVN2heJ1OTjxmM6ESi6s/J7eUhVUw1e1g
 zS5GQMLWBWrFDjN7wz60M2HB0nZehxks3eu4m0CzkNtGl3KATHHvJVIbQyESAZi0vpeGPdA
 G2fKcfBQRuYNkuThIh/XAhRju7MMjdbe8Oy5APrkIjb0AYw68yULxXNtthPNyEjjizsu5lp
 oM3bfEZwGi4L4GlrFCDtEDGVyzNetpM/h2onaGqw==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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

Setting "port config speed 10000" on a 10G/40G dual-speed DAC cable
fails with LINK_SETUP_ERR, and the AN base page always advertises
only 40G.

Three checks independently blocked 10G:

1. allowed_speeds in dev_start was restricted to 40G, so the user
   request was rejected before reaching setup_link.
2. get_link_capabilities_aml40() returned only 40G for all DAC
   cables, so the link_capabilities mask in setup_phy_link_aml40()
   stripped any 10G bit from the caller speed.
3. setup_phy_link_aml40() on the AN path passed a hardcoded 40 to
   txgbe_e56_set_phy_link_mode(), ignoring the caller speed.

Remove each of these restrictions so 10G flows through from user
configuration to the AN base page advertisement. On DAC cables the
capability is read from hw->phy.fiber_suppport_speed, which reflects
the actual SFP module.

Fixes: fb6eb170dfa2 ("net/txgbe: add basic link configuration for Amber-Lite")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_aml40.c | 17 ++++++++++++-----
 drivers/net/txgbe/txgbe_ethdev.c     |  2 +-
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_aml40.c b/drivers/net/txgbe/base/txgbe_aml40.c
index 1098efe5e6..7476759d4d 100644
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
@@ -171,11 +172,17 @@ s32 txgbe_setup_phy_link_aml40(struct txgbe_hw *hw,
 		if (link_up && hw->an_done && !autoneg_wait_to_complete)
 			return status;
 		rte_spinlock_lock(&hw->phy_lock);
-		txgbe_e56_set_phy_link_mode(hw, 40, autoneg_wait_to_complete);
+		txgbe_e56_set_phy_link_mode(hw, speed, autoneg_wait_to_complete);
 		rte_spinlock_unlock(&hw->phy_lock);
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
index 4d2746371b..bc2e11e801 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -1896,7 +1896,7 @@ txgbe_dev_start(struct rte_eth_dev *dev)
 		goto error;
 
 	if (hw->mac.type == txgbe_mac_aml40)
-		allowed_speeds = RTE_ETH_LINK_SPEED_40G;
+		allowed_speeds = RTE_ETH_LINK_SPEED_10G | RTE_ETH_LINK_SPEED_40G;
 	else if (hw->mac.type == txgbe_mac_aml)
 		allowed_speeds = RTE_ETH_LINK_SPEED_10G | RTE_ETH_LINK_SPEED_25G;
 	else
-- 
2.55.0.windows.2

