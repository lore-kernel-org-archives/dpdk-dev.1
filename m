Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7249CCA5FBA
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 10:21:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26C5742D7F;
	Wed, 30 Sep 2026 12:21:04 +0200 (CEST)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 by mails.dpdk.org (Postfix) with ESMTP id 19550427D0;
 Wed, 30 Sep 2026 12:21:00 +0200 (CEST)
X-QQ-mid: zesmtpgz3t1790763658t66c2ce53
X-QQ-Originating-IP: 4aWhd+XoN3X1AlaInwcLxV5PhxIRSXQcCbCJCWcgWOw=
Received: from DSK-zaiyuwang.trustnetic.com ( [60.186.241.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 30 Sep 2026 18:20:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 215085929778540339
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v7 05/15] net/txgbe: do not force reconfig on link retry
Date: Wed, 30 Sep 2026 18:17:52 +0800
Message-ID: <AAF1FE3463D77A4C+20260930102042.2214-6-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260930102042.2214-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260930102042.2214-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MubuIQO4SJVS6u6C5VaTF3w9dJ8fHxylR5iO8lzW4bhpKH3u0CVE93qS
 5CBI30ZAHTeOzXKhIcis4solGrKNtbeBoSjVyNEnGEXAW7RbQwq3h6zR1J+8v/1pFyGYqne
 6GZhIsOHL4ZFui+n2pUKv7ATjqhfDgYBLtAGtT3Qw8ldxrBG/+lqaK6f+fNdTKGgSN5c7Om
 A0oY6Vu6d3QlJ7dN6tcnN12JlCRSQPJVDdeYdMsQlxmNYmI4bCoMRUBv1LhdLIh7MuIXKZc
 uJAd7eukzfdbHvgCcs6vdspI4T7IdN5Eqbz/R4ZcuwYpjBwX6ZdA7XaBt3of9Bes4coSTtc
 LeBd7cEYNqOZu9o532vuIlbI5nAC3uX8eJwZ4eX7IbaZhIwOcBnM0Jn+k7F2ecMgEqESGZe
 jOiS8x9jhTA9RfYPA+h1zri/HhUlFfgQHuTxS7IPoDp4naV0F3ar07IBPyo8fluBFnJyWsO
 YN5MbvTmpulTW1pAHEvsJTwT7efCoE9Mv9fphYwpNRjySCzUFtLqu+yE8V0FLs3ePVrZBBt
 VM7p2i8WvcS2v+UNTyKfDMKeNh/beEReN5+M4ViuYVBsd7wpUqeUQiBif44/Rnw7G+Fr6Oi
 Fz25c0lsVZ0qaa0NS5aSIzIks9EAwNIeYQKztwoJht8XZSOWkKyqjpIiB8IE9nnb1II+k0p
 pQbf2T0EevAwJ56q2V/2KHqGNh8CZrcXuYUtHPmd9H71LaiDnRFPOtebadRTnhJEQHPDDfk
 FSJagYHjyUy9VCYY1BXSAtqqWRrb3+QI3I+/ULYMageIV959AT0kWXZPrb7x4lfGTLIdD++
 1X5///VTiOJNuoga2gmbZda7sGHTGjdSbgHpMCMe6ZWgzP1PU2n+ydflA74m9fnJ63/0/nv
 7NpxbBnX6fh51jt21QwCB1Tt+rg4dVQZ66ZyJMMzR6OQub+H5r0ZGvQwDO/3fBX+FY3faFs
 UZRS6TkF3sL78id+YDF0M7f9TmCEUPHno+yovxhjKNDHWRAat+q3AoTE4/hI0bHeUNYc7E4
 7SnZiISHmiLHNeJJt91blkHcBkpdPKYFz9PpVCvKF9UYHJI3gtXPACbNBAoFBLzbfSjLf0Q
 ZhyXlLMTAvQCymlprQPzWU=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
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
autoneg_wait_to_complete = true. On the AN73/xpcs path, setup_link
skips reconfiguration when the link is already up and AN is done
only if the flag is false. With true, a retry that arrives after the
link is up still runs set_phy_link_mode() and resets the established
AN73 link, which then drops and never recovers (e.g. after DAC
hot-plug).

Pass false from the retry path instead.

Fixes: 6104fd11086e ("net/txgbe: fix link stability for 25G NIC")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/txgbe_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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

