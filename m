Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2619AC79F82
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 13:28:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F04C340E68;
	Tue,  8 Sep 2026 15:27:58 +0200 (CEST)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTP id 9547C40E40;
 Tue,  8 Sep 2026 15:27:54 +0200 (CEST)
X-QQ-mid: zesmtpsz3t1788874070tae93f7ff
X-QQ-Originating-IP: joIJAHkNAY1E32uYq1r2QG4w5uKXz1W5OME0FKOgqtU=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.66.61])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 08 Sep 2026 21:27:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9263145364693650951
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v3 02/15] net/txgbe: fix e56 PHY configuration error
Date: Tue,  8 Sep 2026 21:25:47 +0800
Message-ID: <543A6CDBA3EDC1AD+20260908132742.2661-3-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260908132742.2661-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260908132742.2661-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MYUpfHtk16q4lz2o6VJtxpohfT3d7QF4DKigx3O6FsMnxZ0FeK2cHfF5
 htUqnSSGozzETKYc298tAze8EQUn0I7Otd9qBe2dnsTXImPeD/vBqTn6+n/toqcQ3Qd4HuC
 wNPZUz9TL3wIXONZF9k2VJFED3HuMzlc7Y6wFXMMdHOC9iQzfcKj7qIkybLsChaniXicvV3
 7owhnMMT2bD9zFuaw2EQGnZIQMnerLQjNC/lDtcCUBRJPRYcSYDmn5dk3ZQBwTwqDPEV3lF
 ItY06edC0oy28wvA8237LB3vk/IIpSfcmvFB1RaAyPaAfomWDdNTgcbxvoMjTLxIYyKo32b
 ZhOQfpTDnYReqKuzwbGH4UmoSovGi+HH2F3xTEiX6dvWfYaI0UgrTTESaHbTmcNgy+vum22
 pfPjcxWAte80vCWZ4t2/FIJMJoe+rhnfPlZWL+q4Gh4ia/1ZbOwiRwQknoKYGUXGG9Zdrq6
 Wx1SOmEUnKFC7O1ItV9GwA+cEfRk8YnRFJWb/QcafVxu197J3RrTMkOcRubmdzzVR0DFNP+
 bIoccGvBk3Ad8lMZ1iUZp4o1K9zKd1m09kroO6aFIsDgNwf12fVAKyjpaJZ5fD6cy4eCv/L
 xxPowFHuK8x3ql+aiDD8wKcR4pBEsd2cYnleX9DdjCw7wnlu50gm1XEZ2lcQ3fTKm67JFfJ
 X1ufWhZv01OLWA2UN1bjaSvRX+BnR/+On8Gq+qLFEfCO+wQDrCTbY95mk/jsJ8X16y9bJPd
 8BDJg8wbTosYJ5gzjbDssdZTmGoUk2ReJ1G6kOFSL0tT+u2swo69+iB1tqMRiuWpP/haxtn
 /aWwxrhHpFzuv39lEEVQTeKWe2g71qQzPDZNyvW4f/PnWHEhi/1EoFPiZ6lWsad6+gm1wEQ
 oMGTpM9FOk1geyo9yow38wJK95X0eCoRQkGG9GwDLnDBQve5XhfMkHp2vVqAuE4dw5V/wxm
 DFiG3nOy/2jrGeq+lWHu17a2brAhSwbCIgtuwui4ulOJpgfFl/I6ZRWbeSFCBw1ylhpcdX9
 3qJE2493ns6IWTk8LCSeWcqkts1pj7Snt+G84gQkJq/2FNkBJhn+SsVghOs2/LIkX4CKPpY
 3FsWzZYunnMwjUd9lCtl3xnVbG32mGC65p4IpcqW+R9fpTAXkBKvbdqhF1sjaZVjw==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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

The e56 PHY RXS ring equalizer/tap configuration is written to the
wrong bit field: set_fields_e56(&rdata, 9, 4, 0x366) targets the
unrelated lower bits, so the configured tap values are never applied
and the equalizer stays at its default setting, which can degrade
the received signal on both the 40G and 10G paths.

Fix the field range to (21, 12), so the equalizer/tap configuration
takes effect.

Fixes: f7cfc21e9f75 ("net/txgbe: fix link stability for 40G NIC")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_e56.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/txgbe/base/txgbe_e56.c b/drivers/net/txgbe/base/txgbe_e56.c
index cbcc05333e..2711863f2c 100644
--- a/drivers/net/txgbe/base/txgbe_e56.c
+++ b/drivers/net/txgbe/base/txgbe_e56.c
@@ -423,7 +423,7 @@ u32 txgbe_e56_cfg_40g(struct txgbe_hw *hw)
 
 		addr  = E56PHY_RXS_RINGO_0_ADDR + (E56PHY_RXS_OFFSET * i);
 		rdata = rd32_ephy(hw, addr);
-		set_fields_e56(&rdata, 9, 4, 0x366);
+		set_fields_e56(&rdata, 21, 12, 0x366);
 		wr32_ephy(hw, addr, rdata);
 	}
 
-- 
2.55.0.windows.2

