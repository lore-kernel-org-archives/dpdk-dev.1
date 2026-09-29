Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E130ECA5FAC
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 13:07:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 22F2942D27;
	Tue, 29 Sep 2026 15:06:32 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTP id 1BF22427B5;
 Tue, 29 Sep 2026 15:06:28 +0200 (CEST)
X-QQ-mid: zesmtpgz9t1790687186t724134ae
X-QQ-Originating-IP: A4JzTABgdZqlEICFcf2+qAJvk3W4qBsUEMiAtPTZIqs=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.38])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 29 Sep 2026 21:06:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9704685281509654492
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v6 05/15] net/txgbe: do not force reconfig on link retry
Date: Tue, 29 Sep 2026 21:04:36 +0800
Message-ID: <742FEFBEC6DF963F+20260929130611.4871-6-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260929130611.4871-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260929130611.4871-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OHRR8J/xMhi9NNIIqoUA3nxNXvV7/UiRNHeBJrofC45wieGD7tXA8Ef7
 8R+zVKJNTo3RCJGQNmuy9IbVW0LsSY4u/dAWvBeTzGKeS+bKMRZDkX42uYHoppJpCaPqoBz
 wE/dqjP8YxMRA6dRewby7GH0+SN6s2xi95wsMkuLA4bDhWAYmwmuV3wQRCFRpHOJPJ3eKnl
 W8yyTFFFbjNBjB6AwSLHwAtJXHuZ8QoupxGtupXhDRabYy45ei5XBGdcMUMWBXJV+ynyLgj
 zACMogsKwmpwunyaP9akU8zXB3ChPNY3X//SlnrBxKX1suhMq3L/gj5GghRcUJLPnQfd0Ba
 1+OXrRl4hTBZ4qC0yaAAitrbmdfjSKG6o6sXNtGJlNLAa4tWPpSKhh2OmblXmIFCI/I1fek
 yQ3nFaillPP6t7gEjxb57rqSgBTQpwA36uo+7gP/GYwImLuxAaezmheVuX7ui14rxN34Kf9
 IaDNuYwcjtTS/IEQuMCGV+5L78xXe6WoZhbwMTuS8h9LB/cW5BNjsfIRMfXqk/U1Yrh50eR
 91ODrcQTRATyxS5cRziaDlv/dJL20WS1TT994yu5tyaQ6o4XPIBfV6NXTgOhB1UWpB/WjYw
 dwSy8TjVbPWTZHrIkEzc3TDtt8N4P/oTRYYtKW/qIJ0XnqGjO5XOBXZdGhVLemjVpP6u7cO
 FPg0YRIw/Lu3483aLCrQ/8KjXSGiONLfydQ0Oe7T8Md09phqJha6IsZIDna0EYtUc8KzOXD
 0QjjOjIJ0Qyr5A52MMrNC5a8JNVyGuzpGhwWq/N9UiMfJkJ9jXG568PjQhZ5dwRgI8amFeB
 pdnBMQoyAeezpiUg67oJ5uY4xXAb/DE6zEprhduKC6MEJNRD1hEe/ZhjHWj2CkktzjjE3+r
 kjpgMUguGPI5Tipi97bFbUshLwmC2xYjSn4jcg3d4K3NZ8XnCfHCMLg06im2Ce46Ztq9hIE
 NgJnP8SWWmqLzBStsBYo6QCImjmKFr+eGGIoQwXq8qHw0MJXHNkdpD26V+kAHKLViJ3a+YF
 s9jwFYkPiH/WnR1nqoL62zJ5TlEupFHYh9l1pA6hlUJo/vm6gabrMeYPU34ud27wMF6WnbU
 ZJQOPhlRtqmEbaU3PyEpV+oRfp9uZW/RH8ymeQpSvBU+nVb8LMlkotVIMPGs/BO8A==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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

