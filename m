Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D6EC021A6
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 10:04:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4FA6640E0C;
	Mon, 24 Feb 2025 11:04:23 +0100 (CET)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by mails.dpdk.org (Postfix) with ESMTP id 3019740BA2;
 Mon, 24 Feb 2025 11:04:14 +0100 (CET)
X-QQ-mid: bizesmtpsz5t1740391452tzzf013
X-QQ-Originating-IP: fm/ssO1zbptC0foHYtdjy4fOwJytVJWVlHG19IkOQUo=
Received: from DSK-zaiyuwang.trustnetic.com ( [218.72.40.164])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 24 Feb 2025 18:03:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14958975911387470976
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Zaiyu Wang <zaiyuwang@trustnetic.com>,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 1/2] net/ngbe: fix WOL and NCSI capability error
Date: Mon, 24 Feb 2025 17:59:07 +0800
Message-Id: <20250224095910.27384-2-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250224095910.27384-1-zaiyuwang@trustnetic.com>
References: <20250224095910.27384-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: N9V8uIqLa9+gI81i8WYf1IgbAiF3Co79lJRCcMRJ66nOTCr+MjKyyzse
 G20s4v03Z0OOJzPV3GdsCV36tpXBwbaSbDTip85bzdCj8AcrV9X95iS4kNDBr1cI0P5D5qc
 JfcoewJQpKbRln8vKfrnpEPKQomjjQw6YNHupdy4zXJ1xFISiTAyTKVFc+eR9EsDSIfRIsE
 imz3W5H66MQbXeWGfZX+NhF68mJmTtWnzUJ6x7t+j+wIHiYoL7Ni9A45+KsMwSYNG53xx+3
 DN60UVCba56uoG8pZNZCfzrFaUHUYTNpfj2vU68yDJettSihlpDdcafK+IGJS2RCdrk8jty
 HMxAX8VD9mgPaKgvQNALLFOKXAN/6BQzvFQrpeRo1M9MOB3NMOxAUQstfnwrDk+wRtQ3/Y5
 832Z81CJ98LpPABCIOiyYRgyI8mtq4OKWwThwpV4HCfTw4KUqMEmCyuHw0RUeplEVbBHfQc
 7+JMLddWBtpdeH6bga+swcXSq7v/VM5aC0nlYcgoNh898tkfiRMxMgI/YtDw3jm9W7V2q9L
 GV1GDQQ1z7OPTDY+E3aBaAF2pi9HZuOgdJdNG1vkAjyTa2giZDgnSI3aGNfN917v+1kkOwf
 iPEEtsjwZidVNsIBCE1n5fKvdo+Pxrse1AfLc3YF9RTLFefBTy7Lsc8AvK9EtYk3t3yhHUN
 gvfR6lEe7OlhLGuLgk6zWo9n5bGn9hUYPqM8+iCq0IAhIIZ9QvWpsY73acl+NvENugoC61b
 EOgXhuJxc9gglMuajs3EO+6p6dOro6fK8TV7MDabDkZokZKn2+Yx28KxmP7NEw1Om+j2kXu
 PcVTuNB0z5Z0v4in7coIOAjeF84m7C8tutqqFYCZXW1wRHhK/SOsdqhfmb0AXtkbpvih7Dh
 KFbF1y6irsQBvrDNJsaxi7DXruOL1X5ypDb5mezAUwrXhh7nwpAZjy+sjEyLwkqLI2YFPdT
 sOaWNVpC8MSGBGvHY4qY6z1oIgiH2599skAk=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
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

When determining NIC's WOL and NCSI capability via sub-system ID,
flag matching must be exact, not inclusive. Misidentifying WOL/NCSI
capability will skip PHY configuration, causing link-up failure.

Fixes: 5f1ab0d529fc ("net/ngbe: add WOL and NCSI capability")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/ngbe/base/ngbe_hw.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ngbe/base/ngbe_hw.c b/drivers/net/ngbe/base/ngbe_hw.c
index e29a1946e5..6688ae6a31 100644
--- a/drivers/net/ngbe/base/ngbe_hw.c
+++ b/drivers/net/ngbe/base/ngbe_hw.c
@@ -1922,6 +1922,8 @@ void ngbe_read_efuse(struct ngbe_hw *hw)
 void ngbe_map_device_id(struct ngbe_hw *hw)
 {
 	u16 oem = hw->sub_system_id & NGBE_OEM_MASK;
+	u16 ncsi = hw->sub_system_id & NGBE_NCSI_SUP_MASK;
+	u16 wol = hw->sub_system_id & NGBE_WOL_SUP_MASK;
 
 	hw->is_pf = true;
 
@@ -1982,9 +1984,9 @@ void ngbe_map_device_id(struct ngbe_hw *hw)
 			oem == NGBE_LY_YT8521S_SFP)
 		hw->gpio_ctl = true;
 
-	hw->wol_enabled = (hw->sub_system_id & NGBE_WOL_SUP_MASK) ? true : false;
-	hw->ncsi_enabled = (hw->sub_system_id & NGBE_NCSI_SUP_MASK ||
-			    hw->sub_system_id & NGBE_OCP_CARD) ? true : false;
+	hw->wol_enabled = (wol == NGBE_WOL_SUP_MASK) ? true : false;
+	hw->ncsi_enabled = (ncsi == NGBE_NCSI_SUP_MASK ||
+			   oem == NGBE_OCP_CARD) ? true : false;
 }
 
 /**
-- 
2.21.0.windows.1

