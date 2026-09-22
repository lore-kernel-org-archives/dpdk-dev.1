Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B39C982FF
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 12:55:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 152F542E53;
	Tue, 22 Sep 2026 14:54:43 +0200 (CEST)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id 704A142E53;
 Tue, 22 Sep 2026 14:54:36 +0200 (CEST)
X-QQ-mid: esmtpsz17t1790081671te006aba1
X-QQ-Originating-IP: BRp+Y4WtquIPJ9Zijq3ouA57x5IFxWsxuk3QD4wIjc0=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.205.193.132])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 22 Sep 2026 20:54:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16167748069125121500
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v4 04/16] net/txgbe: fix incorrect link state in 10G forced
 mode
Date: Tue, 22 Sep 2026 20:37:37 +0800
Message-ID: <9BAD54888E221146+20260922125414.3638-5-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260922125414.3638-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260922125414.3638-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NU60Kbs86PFj8gVUN8O7R98ejKkeRSu64hg00HlYbanaFcgbCK01X8cK
 KVMH8UDDO6bfC1N5NUNcs+6Xljbe6IpB6k0KRxk8dyWCRLYf+qC+9ipubqOQx4bC1Hc5MqL
 lF+sFntYOZ+e62mNoaQG7pkRlLFSbmiHV+UVcmMuwG4pgUMSWmsE/2l0pd6EEKFm6M1Clta
 Tr5ch63MgndBharoVuhYqm00bz1TOM0KbV64oU0URHNVxCQ6PecuF5s7FJSg9yvkPb2PNeo
 /Vp6Lc7Uv/HXeO6HYP5o32TOIt4q/+gxH3svgMClAls7Tl2MSuF6AGn5hm0jTtkyT4tg9IW
 v/hQqfACS7APqikSPUisRmuTVfJzTikELnS2ukS1fPzT8AmQzTd5MAEZ+rot8FPRxy3+l95
 iVxJqd1yPjmbj3/r+kLuf7SKhleMzJ4yfDfAI7kYpjQPurCJrzbSpAVHK/NOaKe+yKTSHkU
 z8RMmrVQYQrongdkYsNUSMKezKTYa4PhhOrDUBf8YFgtC4MeZdLDRJkLoK3wkNmiBtdK7xa
 trbriuIMGCXRY0U/N8fnuTeoN0zjVWgt2NowZDsXv2Zz34cnoTwQRwMGqT0AdoaGkyg7yEt
 ft2Wfe5fjpDkEmz5oQS5AMktbkX0RvvZycHNHghUqu0PwjdRGmIOAyZsT1iOggzFS+IIEn9
 aTdnsXUPkCXJwkXD7tsZa9F3indFErTi3LaArA0zFUIuGCRP8UTuueP/ynvC/1Tho68U6s9
 s9aOtjlaltyz8GJYAWqDt/LDkJ4OfCMfe1/luO8JUj9W5PTt3HMXSZAGW1LwmyNQdVNqyAT
 K+AnW3wPglHyL222wkh1BVBrZOiqQuanAF/i+dLqnj1DzP3de+xswLxeF2qgZOyLCU3DrZP
 +nRUxEY0XgN+ok42eY+RkeDVH88p4p3PNnREneeNYedIiR0Meflvzw87GdHhQdXEj5/ozdF
 VT7NbOSNHzhhiqIvKk9KjOxQhdzunRT95RhomDj3sOX/5o6SJfsN1eEtCImf2MKfNj+/UtX
 ll9nkFJUniHTwR5z9oEjr57Fve5L5HjCS+ucc287w97/4RZyWg8XPBUfbU3q67z8oNcV/W2
 g==
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

When an AML40 port is configured in 10G forced mode (auto_neg=0),
the hardware can link up but the driver keeps reporting link down
after a peer link failure: link_valid is cleared on timeout but
never restored when the peer recovers, so the link stays down until
the port is restarted.

Restore hw->link_valid = true in the success path of
txgbe_setup_phy_link_aml40(), symmetric to the 40G path. Handle
TXGBE_ERR_PHY_INIT_NOT_DONE before the timeout split and leave
link_valid untouched, matching the 25G path in
txgbe_setup_phy_link_aml(); the alarm retry then attempts the
setup again.

Fixes: f7cfc21e9f75 ("net/txgbe: fix link stability for 40G NIC")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_aml40.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/txgbe/base/txgbe_aml40.c b/drivers/net/txgbe/base/txgbe_aml40.c
index 7476759d4d..5fa7c6a243 100644
--- a/drivers/net/txgbe/base/txgbe_aml40.c
+++ b/drivers/net/txgbe/base/txgbe_aml40.c
@@ -202,9 +202,18 @@ s32 txgbe_setup_phy_link_aml40(struct txgbe_hw *hw,
 
 	rte_spinlock_lock(&hw->phy_lock);
 	ret_status = txgbe_set_link_to_amlite(hw, speed);
+	rte_spinlock_unlock(&hw->phy_lock);
+
+	/* The PHY did not come out of reset; leave link_valid alone and
+	 * let the retry in the alarm handler attempt the setup again.
+	 */
+	if (ret_status == TXGBE_ERR_PHY_INIT_NOT_DONE)
+		goto out;
+
 	if (ret_status == TXGBE_ERR_TIMEOUT)
 		hw->link_valid = false;
-	rte_spinlock_unlock(&hw->phy_lock);
+	else
+		hw->link_valid = true;
 
 	for (i = 0; i < 4; i++) {
 		txgbe_e56_check_phy_link(hw, &link_speed, &link_up);
-- 
2.55.0.windows.2

