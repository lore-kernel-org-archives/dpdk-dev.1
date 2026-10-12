Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D96BCA9ED0
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 11:07:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D81040A87;
	Mon, 12 Oct 2026 13:06:13 +0200 (CEST)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTP id 183EA40B8F;
 Mon, 12 Oct 2026 13:06:10 +0200 (CEST)
X-QQ-mid: zesmtpsz4t1791803168t64c7498d
X-QQ-Originating-IP: uHaSGiib49B8sKiCKM7JW3t9nNWpez029fIIRXLXBpI=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.198.217.6])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 12 Oct 2026 19:06:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7046212818357025903
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v8 16/16] net/txgbe: respect manual link-down on Amber-Lite
Date: Mon, 12 Oct 2026 18:56:33 +0800
Message-ID: <0454C4EC1B028238+20261012110518.1911-17-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261012110518.1911-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261012110518.1911-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NG7xP+P+sy64zbhJ9czDZoLk+mKUKpiEbYbBcgaxNXkubIBFFeB0VElF
 1gpIl0HwR0zDuLxv/fcZ4eqgROpd3qczCDg8jNj1zGXl+l5zfIndzuhg1AeycsgvEmWWzDW
 /wgk3eSdwPJkn5Q7KR/315xfr5U9soCorMxFeNj9rJZAI+qvaUOyyfh9ZkUBLvOa6kQ2t/x
 r4hBVgK6z0c1XDCqwELSYfmr5yi2q7ltIcU+kUW8wXqWF1kRq/VMe+07xDYzlu7Zyhb7GBs
 RiB2L82/kaa7uURiTyLZwEBz6hFrPZtbdcDC61g8cNZ8eNaN8+Vv7YAhRKfD4hiALmQ+aY+
 v0rDX7j93mw9hK3wltNPBdNWAD4JfmUCmLA8MZWtInx/RmjsHpFXR2VCqXZskzKGzZ3zrzq
 jP8bV4geOSUzuebJp8yc1OAOIwYC2RXAZ2uiGq6DV0xOFcjGsj7BqiH9+T80zsbEt+hBnlu
 fOF33jGovrPvG8S9XWGv8K5Y+B/G0y+ZYp0xGHVpeKP3exKDUVsKG7t//3pWLaD5n2dcGOF
 jRF36WloGbUasrdECw+g46yij0Lo9e2NLsg55my8uDrUHgfTx+6bmFWx6sF3TrMdDurfTdG
 jsL8JTNEXeOGuYGtXjFqovibYNWT/Nv91sUwMxXLPmNp7lAYyXqCG/S8kXeBZCTg6T7a5eq
 2tHRKlavTINdyraW5/pNdEXIqXCvivBR9b6BqkTwiLYyFtEAWi6N0UD1BG0xSop04C2d/v0
 vWDVibPUOUbeDFnN1dxGq0MObs5kDNZBEfeLr+aS0qDQg4/9iClUFsEBlnH7vRyO6HQnZVd
 luxl34KDQBAEZVRV8kPhEm4SWws3i7mjSfgkeN1+05LYFWFWgQjx7IoG/ZXhXn1e1ylyGf0
 hDdOxAK56CGuN4Ukq2+7pv3WeH9R0xcP4ItDG/H9v8x+0Wn2D9cCZu3rSYSvOnBzTFGvJhn
 HP3kbgjvwv0MVm15XmoKqA6vkiLKL0FpNaeUInxml1UB7O9ukGXqHjbq3kbq6EHbMcciVYh
 u0qqvRTcPI0l1vQzKAQGa8ByYnYMBQkvA/LTW4M406vZzAz+8a7r3pepBqQZo+lSiIbOOTj
 XX7wpjbHZT4TBoFIswWJ9Y=
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

txgbe_dev_set_link_down() clears hw->dev_start, but the Amber-Lite
AN73 watchdog treats a down link as a recovery condition and can start
negotiation again. The setup-link alarm handler can likewise configure
the PHY after a link update or a previous setup retry.

As a result, a port brought down through rte_eth_dev_set_link_down()
can link up again without a matching rte_eth_dev_set_link_up() call.

Use hw->dev_start as the administrative link gate. Keep the AN73
watchdog armed so that monitoring resumes after link-up, but skip link
recovery while the port is administratively down. Also make the
setup-link alarm handler return before it configures the PHY in that
state.

This keeps the link down until rte_eth_dev_set_link_up() explicitly
re-enables it. The link-up path then restores the required PHY
configuration.

Fixes: 234ce0d1fa9d ("net/txgbe: fix link stability for Amber-Lite backplane mode")
Fixes: 6104fd11086e ("net/txgbe: fix link stability for 25G NIC")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/txgbe_ethdev.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index f87fca5b19..e733514826 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -3033,8 +3033,8 @@ void txgbe_dev_e56_check_bp_event(void *param)
 	if (!hw->devarg.auto_neg)
 		return;
 
-	/* only continue if link is down */
-	if (dev->data->dev_link.link_status)
+	/* Continue only for an administratively up port with link down. */
+	if (!hw->dev_start || dev->data->dev_link.link_status)
 		goto out;
 
 	value = rd32_epcs(hw, VR_AN_INTR);
@@ -3362,6 +3362,9 @@ txgbe_dev_setup_link_alarm_handler_aml(void *param)
 	if (!hw)
 		return;
 
+	if (!hw->dev_start)
+		return;
+
 	struct rte_eth_dev *dev = (struct rte_eth_dev *)hw->dev_back;
 	struct txgbe_interrupt *intr = TXGBE_DEV_INTR(dev);
 	u32 speed;
-- 
2.55.0.windows.2

