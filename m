Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B169AC7EE30
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 12:53:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 831D740EE4;
	Wed, 25 Jun 2025 14:52:28 +0200 (CEST)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
 by mails.dpdk.org (Postfix) with ESMTP id 8FC2340EE4
 for <dev@dpdk.org>; Wed, 25 Jun 2025 14:52:26 +0200 (CEST)
X-QQ-mid: esmtpsz21t1750855942td414750e
X-QQ-Originating-IP: GVgNn0RErxSVsGqFcEFQhPEd4JoTrw0Tg65UoCI42K8=
Received: from DSK-zaiyuwang.trustnetic.com ( [60.186.80.242])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 25 Jun 2025 20:52:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9931936634493255126
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v2 13/15] net/txgbe: disable unstable features
Date: Wed, 25 Jun 2025 20:50:45 +0800
Message-Id: <20250625125047.18072-14-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250625125047.18072-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20250625125047.18072-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: NFXE0m7bMC5564XKpjaFxWolUVbm1ZMQ97j/4nNtCrFbmlGb7PTUAmbE
 tOeeorLHFgqppbq8/klc48IzH3gzhZ5B6G6bT1+RqCMLgJfZbBjmksUpryJdzNLVmn+eMvW
 hP9JMD95xHAA355RW2LVi244IWrld4xXsAzYeqrDKmpbeimin1VghuOTPTbcHxd3zCsyIKq
 cLBPztqa9suzRnLMz9Dpb97fhCZYuwv/ZNWdk7XfVVubZVUmsyoZvDvX91ZmpRHEZJ5gi1z
 AY3LihaevtR+UEmPM7gf0hrmLonAiil7Q/BpEv0OyY+MuOHF4xO8bOCTeq+LCvB8fA/9F3z
 fPj6TpUUA6mwROTuSJSwcDBBqEW3f1MZs3QxSeuC4biJ7iqV+mMnMztkKOnOkByDTJsczli
 DZPXZU0nWQ2193dvrJkTheBYgFts6Nj2/nvWfNospgbk93SSvpWiRwCjtFGQtxNmq+1bwbJ
 4qrq4MTkniWAw4RohE3Zy57vajZKJ3F69D9RykqDrc1yY3GA2DH6LWH1XvmzzfmG0+dOVct
 NcCalpCEykBguwC+ADYG/R7WK0BNvqPknpNICZCOqsgrXHL4ASP9GSePq8glQxXaMeTVE6o
 paBx/ZvJ62FRJ6S4Ez9XW0518TsJSg4gcIixNp26oAwWlCxz4Qv3C9p5Co9d5PvPBztJe0j
 Aw2wiMLNev2ia9MFzZ9UmY7IB+/qqCBjTuDDuz69XY4IvKCipKrQy6BcQqqqZcAb9QOJTZQ
 wc2kyuio9KYml63Td6ei2mWjrhn0EDc6Kk7VZf+7sNKgdu7Hw10fz9jWmPxkfyo0TdYBlWo
 7oRDJurd2j/M2DzHHvuwjjo+IQ8pZwxpp97VxagnYYXyV7p4J0CzqMtQzf8UHDS4hR3bwU4
 3+gWAvDO7YgIghcbxENkJ5WmUlKx3PlYmbfQmNTGX0Vb+azNsRtmIdTd5UmoN3UzevMwMEH
 SHVgaykO2ca6b5xRyG6mnQoNebCxYVRCFgsG7D60IWWeCLh7L0vqDP4W1uDDJUGbVxlI7R/
 pyZ+QjxM58jvprOFDRnAdMZehaTMuLfa8sB7NaWUBqFksha3FG8zWBOuy6+dr80RdoREdGF
 g==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
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
index fd6594e831..6010a4a569 100644
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

