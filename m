Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40547CCD183
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 11:20:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54060427D2;
	Thu, 16 Oct 2025 13:19:59 +0200 (CEST)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTP id 93056427B6
 for <dev@dpdk.org>; Thu, 16 Oct 2025 13:19:55 +0200 (CEST)
X-QQ-mid: esmtpsz17t1760613592ta379a91a
X-QQ-Originating-IP: cegQUZsd6LEKjZuQ5gkV+WYbR6S5mWSJfUYRohAa0fU=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.206.160.146])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 16 Oct 2025 19:19:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3893510425925553412
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v5 14/21] net/txgbe: disable unstable features
Date: Thu, 16 Oct 2025 19:17:28 +0800
Message-Id: <20251016111736.25372-15-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251016111736.25372-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20251016111736.25372-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: OXLYC2j4t+GHvVNfZU3cztZbZl6AxOAF5RZ92IVbo9nfUBhYR+Ds9D3m
 HbJVEBcaaKRwTu78M+J69OQtFwijbSLV6nB9Wrj+SXqHv5aH2pd7MkQdoBYzskzeEl2gepW
 0nrCb4iv1UhDR6AcIszL1RU7CQQRmtf8SISsVcIb+uYboKHeTqlNIqAk9em5RNwaHj4Z5/1
 F9xiZY1qrSHvbhi/agLkDlG9iLIvXxSdzEsLdFrRBS9dnjxYNwX63hrb8YeqeYSJwKE6VxM
 07whGd4/bnMzuywyJXxpLAkzaGYgA205UgHwJNVKGVGKU/VaJJhPHEzfd84t/01DfSK6fUZ
 rvsh2dIc255vMPpWlv+H5rMpcnSbcEnGzunKndNr5JUIU5A5ePPiUyIgxDY0fCpq+h+X7Ce
 vOYr0PtWJ/U1/9aBRabExGjoeJWZtP4NIJB0iOGcXtMj+hNU+a3HFs0olF8hkm9Zz4NEP9A
 +Ra7vs1DczB/2v2Q4Kh2Gcd+zGe7btO9pl+8TDWpB1UQVKNkiX2IzoHKdpB8Nm5iOV8zUBK
 7WMOIj99iVsPTqfIgkGm2jvjCVxnh7pc2Z8CKyUq/nzWPOw//W0PN9Wkxv0nT7JqUf1ADIQ
 wsI7xrIncCtqYyqKp5bJXZYhVTH7+vF3itNpUnBvGqr020nH8mxknNKouviUVZYy5aj2pkP
 wVQcBDXtGeuVRrM1us2LZ53TBML+AiLsl8s7udB576T1+Xn/HM0DTY+US+v/mbwctV8ro3s
 rsQXbJStdvpfXA+Le0g4a5bVYTFHbTThXF6LMM6QHHXCS3kNz6TJuW501qJGpwAzpEs2Ntg
 e+rW0HAHIgwpfnTzHkGMPTJMfO3gSQ0lIaBcamZMFbgHAbFCeHSS3C/JIJOX1qQ74q5Bhgl
 kuvrYOvFMzrjoH54i7KrWTZRCJjrjICmaQeJU91jsWVHW7z/5lWJzGaauptETO4ANbvqlC9
 YnQx23Qg3DN6QU7jsKEJ9HMA2MaM7EBguFoza0664KZNj62kGTTRGWxMnhrc00MWkuFPQnn
 1btG7rouLsTnY7mATgXahb65hA4Jcatsf5LeUd0sbUTlMoArGabP8ps2TKRCQsahP51T8U9
 MkOkE8zgmNpefMHUk9CNnQ=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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
index cbf7aafe7f..d845fd0a69 100644
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
@@ -3242,6 +3246,9 @@ void txgbe_set_hard_rate_select_speed(struct txgbe_hw *hw,
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

