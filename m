Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FF5CA9ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 11:06:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 291EF4067B;
	Mon, 12 Oct 2026 13:05:45 +0200 (CEST)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
 by mails.dpdk.org (Postfix) with ESMTP id 5D84F40041;
 Mon, 12 Oct 2026 13:05:41 +0200 (CEST)
X-QQ-mid: zesmtpsz4t1791803138t535f90a9
X-QQ-Originating-IP: ADpqEvkmtLLn7p7Oo2VjoDCKBgdSqQAovCYYbfTwQuk=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.198.217.6])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 12 Oct 2026 19:05:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7327526529715304653
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v8 05/16] net/txgbe: do not force reconfig on link retry
Date: Mon, 12 Oct 2026 18:56:22 +0800
Message-ID: <FA5CD359158FA759+20261012110518.1911-6-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261012110518.1911-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261012110518.1911-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MWLCkAjnYYm5tAwUUWC8Oa7BE3NHu7EgKQfdCODYbfAtqO3EYBaANPPP
 6uRFDQW/umWKjOyrJ0unYqRNDZontNQfcYzaK/bsKWFfLomv9+H2haYLAndyP2EPB3LBg4v
 ZsChdsd1auhjpW/Sm+/NPDwpthsvMQhZRoOInnh1oGVVjKZTXVwWwBSitqQR2s3rLYOfLH3
 Q2WKA19znnIa4H/Mn7+vb+/EdkjrGYFqF/KTE1moQ7N+oNjjS1Ot2L4m9QJhpr6RSJfoA3B
 sg5ie1xT+459cCogTpPoHkUoEmCtURgzXB6NNaAJs6rrmJTSu3y+CIzl27UTz8VGCBgg42z
 Xckts0rHGzSou9pPKBhMl3Xj53PA2VXaUNqPls06xHwab+xD59TcKLia0L6eYexKuq0Lz0h
 PLPdjVbzevYc5gj73DGnXHhHZ2jZ1g/5sa69WJ4HfuZu707TboKUX8lbmsvQViEVTe2qpAi
 AbCyR5ChflSVzNwy+4EumY0+RT3mwsZCIU9LGuedXaiYLlisVmFjotIumJsGbF14kImLk0X
 b0h4JnmYfMcADy9T7DQc2MerS1R2z1xL1n7jjx2Rm1V0uYEuyFRZ4X7bRzlSZN2i3GiWuj1
 3xUIQAd/bPQ9WwjWfj4Eh/tokfs+sbXnbw01aUzdnTSwIGsezioMA5tFE4ahNNpSD415S9E
 oyAGc1lA2FI9Yr5+BlXoRNQi76gKIfWKbetsa5msH8+rk7xpACGGHcM8JHcJlNnNn3nWkxC
 LBN+ERokrTG2hX/LW5MoWXp8Q7p8mYpvuOgzPeGLg5h1Ez8lEPRlYNbpFs0Zl1cspg672aw
 8xZkU22s2Nqj65NNDkaU2PkwNeXnyP5MHLyE8/ecKexfFthsV2kxgiyvJUG2xHqs4k+BhIH
 QAN5kjYiWj29bMNxfmpelbrdxiTW/EdYINKt9Lx7f4sq2x8NNVFa3rAfVUA9NlSKJFd0ZVJ
 2E3PA8z2AeM4RveLvJIRaM53KjcGZNmCy8cKeITq6LkU25iuZlfrniZYScekMfefjHxh/6w
 lfbIsCnPDE+PrZ2UfpUPx+Ig5AnQtc8gfwTAAjdzMUsrjtPx77N0G5E4FaTNB0llOqNeftD
 A==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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

The link alarm retry calls mac.setup_link() with
autoneg_wait_to_complete = false. On the AN73/xpcs path, this skips
reconfiguration once the link is up and AN is complete. Passing true
from the retry path instead resets an established AN73 link, which
then drops and may not recover after DAC hot-plug.

The setup flag is also passed to txgbe_e56_set_phy_link_mode() as its
need_restart argument. Passing false unchanged would make a retry a
no-op while the link is down or AN is incomplete if the PHY is already
in 10G mode. Derive need_restart from the current link and AN state so
retries recover an incomplete setup without reconfiguring an
established link.

Fixes: 6104fd11086e ("net/txgbe: fix link stability for 25G NIC")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_aml.c   | 5 ++++-
 drivers/net/txgbe/base/txgbe_aml40.c | 5 ++++-
 drivers/net/txgbe/txgbe_ethdev.c     | 2 +-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_aml.c b/drivers/net/txgbe/base/txgbe_aml.c
index ac80d85f08..7a0839a7d1 100644
--- a/drivers/net/txgbe/base/txgbe_aml.c
+++ b/drivers/net/txgbe/base/txgbe_aml.c
@@ -213,6 +213,7 @@ s32 txgbe_setup_phy_link_aml(struct txgbe_hw *hw,
 	s32 ret_status = 0;
 	u32 link_speed = TXGBE_LINK_SPEED_UNKNOWN;
 	bool link_up = false;
+	bool need_restart;
 	int i;
 	u32 link_capabilities = TXGBE_LINK_SPEED_UNKNOWN;
 	u32 value;
@@ -246,8 +247,10 @@ s32 txgbe_setup_phy_link_aml(struct txgbe_hw *hw,
 		txgbe_e56_check_phy_link(hw, &link_speed, &link_up);
 		if (link_up && hw->an_done && !autoneg_wait_to_complete)
 			return status;
+
+		need_restart = autoneg_wait_to_complete || !link_up || !hw->an_done;
 		rte_spinlock_lock(&hw->phy_lock);
-		txgbe_e56_set_phy_link_mode(hw, speed, autoneg_wait_to_complete);
+		txgbe_e56_set_phy_link_mode(hw, speed, need_restart);
 		rte_spinlock_unlock(&hw->phy_lock);
 		return 0;
 	}
diff --git a/drivers/net/txgbe/base/txgbe_aml40.c b/drivers/net/txgbe/base/txgbe_aml40.c
index 5fa7c6a243..892dddd373 100644
--- a/drivers/net/txgbe/base/txgbe_aml40.c
+++ b/drivers/net/txgbe/base/txgbe_aml40.c
@@ -148,6 +148,7 @@ s32 txgbe_setup_phy_link_aml40(struct txgbe_hw *hw,
 	s32 ret_status = 0;
 	u32 link_speed = TXGBE_LINK_SPEED_UNKNOWN;
 	bool link_up = false;
+	bool need_restart;
 	int i;
 	u32 link_capabilities = TXGBE_LINK_SPEED_UNKNOWN;
 	u32 value;
@@ -171,8 +172,10 @@ s32 txgbe_setup_phy_link_aml40(struct txgbe_hw *hw,
 		txgbe_e56_check_phy_link(hw, &link_speed, &link_up);
 		if (link_up && hw->an_done && !autoneg_wait_to_complete)
 			return status;
+
+		need_restart = autoneg_wait_to_complete || !link_up || !hw->an_done;
 		rte_spinlock_lock(&hw->phy_lock);
-		txgbe_e56_set_phy_link_mode(hw, speed, autoneg_wait_to_complete);
+		txgbe_e56_set_phy_link_mode(hw, speed, need_restart);
 		rte_spinlock_unlock(&hw->phy_lock);
 		return status;
 	}
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 2f59b0794f..a5ef0b3e54 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -3237,7 +3237,7 @@ txgbe_dev_setup_link_alarm_handler_aml(void *param)
 		return;
 	}
 
-	hw->mac.setup_link(hw, speed, true);
+	hw->mac.setup_link(hw, speed, false);
 
 	u32 link_speed = TXGBE_LINK_SPEED_UNKNOWN;
 	bool link_up = false;
-- 
2.55.0.windows.2

