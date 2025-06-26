Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82DDC7EE33
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 08:10:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C590641104;
	Thu, 26 Jun 2025 10:09:53 +0200 (CEST)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id 817E8410E7
 for <dev@dpdk.org>; Thu, 26 Jun 2025 10:09:50 +0200 (CEST)
X-QQ-mid: zesmtpsz9t1750925385t305184fe
X-QQ-Originating-IP: z2N/6eFJ2rZEkawN3p5yf9zCqs44IilDSMHoKpksu9o=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.27.0.255])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 26 Jun 2025 16:09:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7054387398913701496
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v3 13/15] net/txgbe: disable unstable features
Date: Thu, 26 Jun 2025 16:02:18 +0800
Message-Id: <20250626080221.22488-14-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250626080221.22488-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20250626080221.22488-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: N/Ph2bJENH2/ymz+xp1AzUQorKjQXBaz1+2X1aAXYLDna+E0V+EChnXc
 ow0Uv5dfgDV2yJIm1r9Vw/fAP8yFUE8oksBOuuLCs5MvyrdcrlQZrALmSAc4QEOsSL98edI
 zsKVp9+4ndHlhXpnr9Xl16r1rxwfOvlg2VZWOSTHIImtyQG/zlaK5Q7WZ+uGOcTYEiJUiUB
 9sqq/yW+iRmuoXzL5aam3doOHwqfIfNiG7WCS8JS49vDZ+srKfLLbxo4Ksge3rM6JPi3VFl
 +d+uKdBsmjenv+0kTViKvBGRIEbKoir7uCrq80sBIowVjWI4p6SE+76s4xiztsZt/dt8oAz
 vNWdwqvsmipVIQUr10P/bVqS63roe+CCms4/KiXqMtI5TXb0NSkIwH47N49u0bkzcK053zD
 UhMKkqy2hcH2thM2ZBkFtUKukHDJ0oj1gyx8XkAG2MvspshdKOKz6YC6LYRAyYzzGyeyHtd
 0jT2Nz3u2DB+/cs+57Bh11o0NODk5tJ3tMlvNIDj1Hq+x7M7/w7IU7cAJyjflHhx7O9Syzq
 ICga/z7ojdgbXARW8W+nphxLVcqoboKN2DwDBWKAma08yS5DjXmP5WCqcH9Zv/YL+99VWRr
 HA31AqxFJbL1AlXX+e8m/9LWeQyBRMcPKZZNXgShvfefIoj3/s6cm5d9LpTtyd5A7YZElvN
 e1wAssWNK0Qylfv+hU6iZeT/KR1AAPPAVP5CDVXH+NnqGDfDumG4Cga4JJGot2PRll4hGXb
 WnZTbTbY2o5za3wIAg0Vo1rDZhX/HBBN+UiSAK+lNVGxIvZFbsvxo5evTjqG11o5HqCn7OB
 kP7tJCvJon0QtY3z44T9EAlR6/6vGah7yyiHOMYaknR/HaeRzCpv38ETsfVtXry5rT8bUWM
 C94gaGcE0tXuVxw44cEGlQ7ILS/JfBqW9TXkgTgYHThMPoMNwJstfR3gWgwZdup4gnf2iTS
 ADqS6OW5H17t9cGhVTCQzsm91Blq1f/ZYMSCqHvtbTeiCSNgWi15YtinaFLMLKxQGiQEe0G
 vGge7tzWnRFe3LiNaiv+thWjZuOj2s/j2+C1+1N2jgjGOpIfq0o+04+Q9gVms=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
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

Temporarily disabled unstable features on Amber-Lite NICs (e.g.,
flow control). These incomplete features will be gradually completed
in future driver updates.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_hw.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/txgbe/base/txgbe_hw.c b/drivers/net/txgbe/base/txgbe_hw.c
index c36d6a6626..b4d79b4176 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -144,6 +144,10 @@ s32 txgbe_setup_fc(struct txgbe_hw *hw)
 	u32 value = 0;
 	u64 reg_bp = 0;
 
+	/* amlite-to-do */
+	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40)
+		return 0;
+
 	/* Validate the requested mode */
 	if (hw->fc.strict_ieee && hw->fc.requested_mode == txgbe_fc_rx_pause) {
 		DEBUGOUT("txgbe_fc_rx_pause not valid in strict IEEE mode");
@@ -3235,6 +3239,9 @@ void txgbe_set_hard_rate_select_speed(struct txgbe_hw *hw,
 	u32 esdp_reg = rd32(hw, TXGBE_GPIODATA);
 
 	switch (speed) {
+	case TXGBE_LINK_SPEED_25GB_FULL:
+		/* amlite-to-do */
+		break;
 	case TXGBE_LINK_SPEED_10GB_FULL:
 		esdp_reg |= (TXGBE_GPIOBIT_4 | TXGBE_GPIOBIT_5);
 		break;
-- 
2.21.0.windows.1

