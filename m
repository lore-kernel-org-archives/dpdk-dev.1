Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9D5C43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 10:47:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C64840A73;
	Mon,  6 Jul 2026 12:47:40 +0200 (CEST)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by mails.dpdk.org (Postfix) with ESMTP id DD74640691;
 Mon,  6 Jul 2026 12:47:36 +0200 (CEST)
X-QQ-mid: esmtpgz13t1783334854t9696c369
X-QQ-Originating-IP: B136cBHNLDLjsur0jvsWpq9gP6HonnoejGd4VYonEVg=
Received: from DSK-zaiyuwang.trustnetic.com ( [125.121.223.58])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 06 Jul 2026 18:47:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16161646815058786212
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 2/2] net/txgbe: validate lane_num before GENMASK operations
Date: Mon,  6 Jul 2026 18:47:19 +0800
Message-Id: <20260706104723.25968-3-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260706104723.25968-1-zaiyuwang@trustnetic.com>
References: <20260706104723.25968-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MdoRYM9mYryd3n9DDdDQknifftEMAxx0BvvG5Z9K1Rgrt/ap5mjhrl1/
 BMybCV4jR7o8MWYgXMJRvxAIiGeEUDJh3LoGCKMHfrw8N5NekxPgq+oDWgDLsmrHUZBb4ef
 I8g3JewEX/S7LimMDOrpdcuwFVGYRR0WIfFkk3OZV5qg+uV64Pb5vpA6oFrydjqA10FBCVb
 lrCSRqmxxfJRn1vJO5IwjS81vDXtMpSi73eoaEoT1p43RBnrg+ccr8LfpbaI1lXoqDtikO5
 n8Om0qv/DpBg6Y5GQq9iI+rXZkG8f821nzBEcj6WFVWHV/OwP/Em4oJPEiE4LcuRRa0+xOe
 u9airQjCbRHhPFuwfed2qApfBKxrBTIzGd9Qyk8f+YmEXYlERnFh7VpgqX8mkhqXrugEY1v
 E931B42tJsrBBV3wP7ReN6/6c7EW8Q4kGVMLbOBxHB7YC+CiUY8mGc3c3L6gSyndoj8dCxf
 d5f9MXjM2kVXcYQVvz1IwxW0+q/Cx0P9oGz4gClre9iZbtzBDqrHPE0MNDKQzAVLhGXiHsP
 kxBFmkd7c+JmIOVx4d2pAruos8m2oVLF3gIfiAJrpQ5H+3XrVmzTrzrjS0KgVs+ddAsTFFn
 2ECNqyjlSTWJdTfo4ex7zQ24VUArP6KVRP0gUqWDclngA0qFyIh+/pzDZ+pkMnVup4pVpFT
 ZsmvXbVAhs76aSSHBsg+3IBc52KTKCAmKGvMlTcYMvYsQeKJ0aff424rKdngI0pKeE3M8zk
 ulje4sf9ThUkypDdVd7rwjv0aKetgrl/l6kHTKuDPOrGlgyJLjHI+4PXDANP7EHhOV2n+yW
 QDMJiEFw1UP0k+Q/4ZaKoe4jj1cW5RPBCcxsY88p5rosQVU3ZwmIzkNgFxkrIM/R/wvXRyX
 a3OQugy5kxK+TL/ny9UJZ4hfXXT4FfSXPdosz6i7HcxSN0T1dfA0GC+hUsnnsy5negPm0IV
 rn3whj/hqVAid4+uwlwini+Bdj/XyXKprbV7o2J0DZmjtLQ2ILItHg/1rqKJ2TkgUDIx+1h
 HfMGO7+q6rS9ZVEC03EmZEiRpNWvdSlbuiCZdTWQt0KlAVhaxIviaskEbfri8=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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

Coverity reports multiple issues (INTEGER_OVERFLOW and BAD_SHIFT)
in the e56 backplane code. The root cause is that 'lane_num' is
initialized to 0 and only set in the switch statement based on
the link speed. The default case simply logs and breaks, leaving
lane_num as 0 for unsupported speeds.

This leads to unsigned underflow when evaluating 'lane_num - 1'
in GENMASK(lane_num - 1, 0), and undefined behavior when the
resulting mask is used in shift operations.

Fix by returning -EINVAL immediately in the default case of
txgbe_e56_cl72_training(), preventing any invalid speed from
proceeding further. Also add error handling at the call site
txgbe_handle_e56_bkp_an73_flow() to check the return value and
propagate the error.

For txgbe_e56_rxs_osc_init_for_temp_track_range(), no additional
check is added because:
1. It is called from txgbe_e56_cl72_training() after lane_num
   has been validated to one of the legal values (1, 2, 4, or 8).
2. The other caller, txgbe_e56_set_phy_link_mode(), passes a
   fixed speed of 10 (lane_num = 1), which is also valid.

Coverity issue: 504598, 504602, 504613
Fixes: 234ce0d1fa9d ("net/txgbe: fix link stability for Amber-Lite backplane mode")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_e56_bp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/txgbe/base/txgbe_e56_bp.c b/drivers/net/txgbe/base/txgbe_e56_bp.c
index f8b39a0c7e..d376d918df 100644
--- a/drivers/net/txgbe/base/txgbe_e56_bp.c
+++ b/drivers/net/txgbe/base/txgbe_e56_bp.c
@@ -2432,7 +2432,7 @@ static int txgbe_e56_cl72_training(struct txgbe_hw *hw)
 		break;
 	default:
 		BP_LOG("%s %d :Invalid speed\n", __func__, __LINE__);
-		break;
+		return -EINVAL;
 	}
 
 	BP_LOG("2.3 Wait %dG KR phy mode init ....\n", bylinkmode);
@@ -2583,6 +2583,10 @@ int txgbe_handle_e56_bkp_an73_flow(struct txgbe_hw *hw)
 	}
 
 	status = txgbe_e56_cl72_training(hw);
+	if (status) {
+		BP_LOG("CL72 training failed, status = %d\n", status);
+		return status;
+	}
 
 	rdata = rd32_ephy(hw, E56PHY_RXS_IDLE_DETECT_1_ADDR);
 	set_fields_e56(&rdata, E56PHY_RXS_IDLE_DETECT_1_IDLE_TH_ADC_PEAK_MAX, 0x28);
-- 
2.21.0.windows.1

