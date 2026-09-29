Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A94CA5FA1
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 11:22:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B650E427AC;
	Tue, 29 Sep 2026 13:21:54 +0200 (CEST)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id 90F0941140;
 Tue, 29 Sep 2026 13:21:49 +0200 (CEST)
X-QQ-mid: zesmtpgz6t1790680892ta245ea66
X-QQ-Originating-IP: JNP5L8LMEl41y9eYulm0P4+GCX/nSoP+huu4aPmbHeQ=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.38])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 29 Sep 2026 19:21:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14597891964767524143
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v5 01/15] net/txgbe: fix failure to configure 10G on
 dual-speed DAC
Date: Tue, 29 Sep 2026 19:18:01 +0800
Message-ID: <C08CC1B0DBD3B009+20260929112119.4516-2-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260929112119.4516-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260929112119.4516-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OX/+6nY/vs4TwPqQj0o1DWYFy/jMvXOUm5yjqYqug/8wRJosvwUhQ9r1
 nynySeCwccMvCjuUzox1XSip4thUl2MFCmfWwrFfNYgjJlqJnA3KMl0aJZoNHb/Qq+vYppW
 6WN6twEuwCCoS2JfTVt286QM08mGeRO7uBOG9pVHWVd+exfypqd4/q0I3NPVEUJLngn91FW
 rrGQXL+rMMRXXAF6umazWa/QAoZza73jIFPgxKHtrXCwX9z7drMghfljHRZ8HWpJX9XMUxU
 qd+Y9T78xLl2fkLHo8EczWMYIzblLW1aG99pgm1Lr1sRenkl3NMLCs/T55AnI/7woM+d1Ee
 4MzPYLeX2nfJjl8z38UQRQ2nNLLmHj6O8Pq0dhXNeZejS0q5cPLa2CIkP+UQuHd3z0Gdk6f
 Sl7KI27iFQQw0nbl2IVnKTFKhB0gNNwDYsOgVKIPtTOFewuvrPkzBj+6ph/g/ZbF29DdWMk
 YOWQ0334YKmWH9Dyk2azTvoyqDJlLKrqtWe2Oci5DbLAL1shfZSAk0NIr56uVx2PurbPiHj
 ai7KX27gwcjPicNLuGZE3f7oFsb/84KQnjL3bqyPFuAkqlm7fnnVkQPBCwgkIRygd4gyNG7
 j1sYQtqPAb6odsBul6Cxsd0Yl3VKjFNPy8KN5eLuMSDedYWHxpBkFoSW6CILqZt1jmHTc3M
 3Tk2lOYlG34vOWXxReX7m4DQOOLRQDj0fxsngyUxUihkp/24NcXkt+7kfyHIHPycQLo9U6X
 5eoIf3Yw9BV0lht4tuB5FeUwPvRgYsxWaabibL4uzbUCVBJwQNV2lfP/4Q087HeWm2ppnf1
 QPmqfYx8dv5yx7ZwVDUkr+9h/P7kpW9QPajLGRmmJlkJCZRvw6PbKBbxRAoWO0Otjn+ysMg
 sY1rbLCihAvHZQ8cVFzxtE/UqM8PgJ81Y4vBD1Gdo6GRw8SEyUvE4RH9A79dWNw/d+4pTND
 0kuyhNprANdPEI8ujzjrVqwrJWOj/tLWdfRn45OyfiQzcAgcH7brr/S87/BBZ3ARM2octLh
 TenfSdd26Vc+BsPha9F8TPY8SrJ3gpDo/hmdTbFQ==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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

