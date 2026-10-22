Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5694606A319
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 11:10:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EBD6D402C8;
	Thu, 22 Oct 2026 13:10:45 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTP id 63B3440663;
 Thu, 22 Oct 2026 13:10:39 +0200 (CEST)
X-QQ-mid: esmtpsz17t1792667436t08617b86
X-QQ-Originating-IP: fH/CQh1R/moCU5e9/FlBN6uUWfW8MIFAIFeCchh0hm8=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.205.193.71])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 22 Oct 2026 19:10:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7688410505324096425
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v9 03/16] net/txgbe: fix e56 PHY configuration error
Date: Thu, 22 Oct 2026 19:03:09 +0800
Message-ID: <110BD1E4690B3858+20261022111017.3605-4-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261022111017.3605-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261022111017.3605-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Mg0VNL65EMx8wZ2c29fdb2T+V2Ci9Wgxr4NyJoFKidH88p6Oh+JAi0l1
 El0+CUo2XldefcXIS3yajjff2osU6fd8hriLkqbm6I4fHHX6CjLChAPatHFG1GYlfRDs0c6
 YnsC3ma4Wno/gHqxo7u5tblkBm001pKf6Jyt9dzmIhnnBU+ZsLnM3h6wKoiTiMDtks4A4pY
 OPL/Qei477uBfJnNppmA879XneOFJgkYOAroQTMjIwBWqt8hW45fXmt03H/dHytWrlUkv0c
 CaTL2e/DAPhJIfpHJFzfpfK8kAYDY9RMbJbDCrOdBeLYJY9Xf1jKJWGpEEhmYFu3uUxRb83
 uDS/XQ4j/b7jdcpNu1ALnzjLI9/lJ9B5oRWvygOC1NrO2ZxWS077e2mlVJDZjrLpABdREeV
 9gbH4oNEhFrzIXhiAVVr8AmxSyLCHraQquvIsVxbHzANpVVy66eSvIfkQ/ywtys6cDK/Fx5
 yDK4hOZRBRsjPkgD12R2271j3WyHmYT0rBJkrm8cN1szVkeRydjWBnw9xhDLxutNJDpOe+s
 QrLgyfLTH4KUw66vR5+LUu0cEYay8enbinD9Y8x8L6U1E0ADIaYkHT6LltmhWf0PPEte8VC
 c/6oAGVYzjKZni93IkBTpaMyuQkwzLPMPlzeDHQaxVq/eD4YBPNwUzWF0Fm8vxidAUc1wZe
 exFzOqWyFj/SNFXIlW7Hq46vAfQzfKPEhLrzV/nSrPC2VPPLLm/+xN55HUtv0+wobXrOfNu
 e0wns48ZuhX1xhh+ASXwFgiT64JsGjuMN+wm5gJ3+cy2iASx1hluuBqMtTj1yKI8qMXb8Dm
 T4Cu9/ZZYEWjQu2z6wtAa2zj0uVXEpUB/bspshWIRWsJ6eDW25ubUejQxF/bnF8ydFPqKAr
 IEctbd59n1cMyC1AVjhLs35PW8ODf03dJ8Xlt3zlS1NojbqFu5hUjs/rLDc3D2vt4wa2gHc
 xq5IRO7XCUwl3QlV28C4uvRKycduBxfotYzu+Wi5JwWYfWlA0iVlulV46J7j+OYrEwfP9NQ
 AjlIuhMz2b+OZsTd9S0SGvowU0dxvMXvi//pzMFpsXM7xpubCn08Qhr9NMnAc=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The e56 PHY RXS ring equalizer/tap configuration is written to the
wrong bit field: set_fields_e56(&rdata, 9, 4, 0x366) targets the
unrelated lower bits, so the configured tap values are never applied
and the equalizer stays at its default setting, which can degrade
the received signal on both the 40G and 10G paths.

Fix the field range to (21, 12), so the equalizer/tap configuration
takes effect.

Fixes: f7cfc21e9f75 ("net/txgbe: fix link stability for 40G NIC")
Fixes: 6104fd11086e ("net/txgbe: fix link stability for 25G NIC")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_e56.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_e56.c b/drivers/net/txgbe/base/txgbe_e56.c
index cbcc05333e..c0e5cc3894 100644
--- a/drivers/net/txgbe/base/txgbe_e56.c
+++ b/drivers/net/txgbe/base/txgbe_e56.c
@@ -423,7 +423,7 @@ u32 txgbe_e56_cfg_40g(struct txgbe_hw *hw)
 
 		addr  = E56PHY_RXS_RINGO_0_ADDR + (E56PHY_RXS_OFFSET * i);
 		rdata = rd32_ephy(hw, addr);
-		set_fields_e56(&rdata, 9, 4, 0x366);
+		set_fields_e56(&rdata, 21, 12, 0x366);
 		wr32_ephy(hw, addr, rdata);
 	}
 
@@ -1251,7 +1251,7 @@ txgbe_e56_cfg_10g(struct txgbe_hw *hw)
 
 	addr = E56PHY_RXS_RINGO_0_ADDR;
 	rdata = rd32_ephy(hw, addr);
-	set_fields_e56(&rdata, 9, 4, 0x366);
+	set_fields_e56(&rdata, 21, 12, 0x366);
 	wr32_ephy(hw, addr, rdata);
 
 	addr = E56PHY_PMD_CFG_3_ADDR;
-- 
2.55.0.windows.2

