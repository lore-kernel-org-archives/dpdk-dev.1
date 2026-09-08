Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A4FC79F9E
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 12:41:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B89040E68;
	Tue,  8 Sep 2026 14:41:15 +0200 (CEST)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTP id 81C7640E32;
 Tue,  8 Sep 2026 14:41:11 +0200 (CEST)
X-QQ-mid: esmtpgz10t1788871266tac8b4702
X-QQ-Originating-IP: UsNAKCTewLkej3ndDoSZP3BuRbxsH6SLUORVC5B8O1g=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.66.61])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 08 Sep 2026 20:41:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2938906839078843185
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v2 04/15] net/txgbe: do not force reconfig on link retry
Date: Tue,  8 Sep 2026 20:38:49 +0800
Message-ID: <85723930409F97D1+20260908124047.2284-5-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260908124047.2284-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260908124047.2284-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OKKHiI6c9SH3/XxCF/CZ6Z+TeqsXT+ifispkKmIH4I5hjto/qJAJKPm3
 RgUihrrON/dJ6a0d5poswd20YFwO/Uea+kjkKD9VBfJs6Gc2r/uQ06fW13zrELPEGFZ/eaM
 UacJg+Q4k13xlMq0kfunixzsG9ZvjSEHhVLM7uZ+CvbtJ/B3WmwfmgQdMVrvtaqWvKWIYEW
 othMaYVdDm0OF81wD9+R3h+s8vKq0RUGcRN7yzkuuJKR/xMufsuN5jFy3D8iLxC/ccC+0JF
 Aj4JkGYMeQRkTVZCPYyDKBbGmSWHQSaT0YSww07oiMm7WeD6pwbqGY0CLkZknZ8I3XQJwD3
 asXcW8S1JVAuznDpl6TftGlywvaVcBw75peG4vpOy/sIXY4hZBJ1H88Z0xVyYr6rfbEilGI
 AsxlCITexhkdQOb+CUyLIg3rBArY0djrVO0UksUeJrxKaEUDbmhH5qmHP2uai7ANd61D2Yp
 8D6Rav8USeLmBdEdZBWT27FZwVQVhqaZBi2gs1vxwyRSuK4TC4DMbLUJ5TJ/ayN9DkDpez4
 /InKYGRcMQvbSYHIJkinO+ig3A/s6A3AN8zTjDfxn+PTyT2caamvQYPUSw7s/bKFLYP7iQD
 GrslZmIya1qoEo4IwWW6ehI4ijzsNwfUBPN856A/2FBcqvIUq0XY3YpL3yScqVgaNWIg/Vo
 l1eFP/dqY/z+GD4rcZedK6SYdKBxm115tEs9q1Nxs8Hp47V5ImjDI8Iyh4103sNBTe84BAc
 W/oNaWuZgSInDgIjjZCRXNVSRAvz7i2aRGAYeupFqlq5b22UiCxkkaeB5AHpkUseIeNMgXQ
 rnzSdpIZzV8d95HfqtkuETIbFhk/MBqLxfMhJZBgI6v4FNgWIjvokAPEsQDrbGK4ZMyVu1c
 4zV+Y7FMO0jBSVzLb5hv4e95nGSZWcxGGquR3orUffpVMzgrMKSU0LGt/cJbifE4nush2lM
 3tY38U6pWISGeuLpetDZQZaTC3v+O4Wlv6aoZ/j0dXQTJe97HXncGSaxyGp3bVvZI3i2A92
 smVr6Y1u4M/lixmjL9OCbD/HTcn4Y42IJUP3/MycAnqV6Y22zTGzSkAVemBB0IiYJdqvdsB
 /py3N4ygMHr/gxfFGmVx/4=
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
index bc2e11e801..9e4eca40cf 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -3286,7 +3286,7 @@ txgbe_dev_setup_link_alarm_handler_aml(void *param)
 		return;
 	}
 
-	hw->mac.setup_link(hw, speed, true);
+	hw->mac.setup_link(hw, speed, false);
 
 	u32 link_speed = TXGBE_LINK_SPEED_UNKNOWN;
 	bool link_up = false;
-- 
2.55.0.windows.2

