Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB55CA5FA1
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 13:06:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4816C427C7;
	Tue, 29 Sep 2026 15:06:28 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTP id 2DB04427AF;
 Tue, 29 Sep 2026 15:06:23 +0200 (CEST)
X-QQ-mid: zesmtpgz9t1790687181t4c6607c0
X-QQ-Originating-IP: 36m7HIU/uYzPd01KUd4jMKghxDIrE1kq0/cdE/dvxiE=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.38])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 29 Sep 2026 21:06:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7797101980223783822
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v6 03/15] net/txgbe: fix e56 PHY configuration error
Date: Tue, 29 Sep 2026 21:04:34 +0800
Message-ID: <8A58F6717B94C04B+20260929130611.4871-4-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260929130611.4871-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260929130611.4871-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MPs12nfZS/hNOX4Iu5JeFCPmnTcMBTyObFaJhUdM75wKG4j+g3oi9fT0
 aU4vjlPGs7eq2cz6ULorFG36vhzavASZnTLuXdCfhdw9oxj/nINTz4jZth1avCpjlc2pKAv
 6+l5vPM62AKyDaJSHkzL/DhQ5k2nwSL68D2yOFipDJXvTHk5cXCiw+LsxUeYqYROsbWry+K
 xtpnQPy1A6EKBdQdYepYZO44thg4KveAG2NiBbuKUBVYAz/5USqgjY7EWJUxOBXRBHhb8/+
 BZ9ufu6JdDi4UB3j0cGp+K7u7iR3G1Zrer0Q0wAio0uJmTVCTzWpus3Hhr5MqGLO8bdayJY
 SZcXTaEhVAeArmEuAK5otq8N+0vozuAHhlSVIq1pOnoMENAI7J0cEpYJfT+eRlaJgrb7k9v
 CY9SwuO6TroKs5zt66y+Q51kexQfWEQUagkKHR59nIAs0EVKMfXCKEqY+qxUhGPhF6/ZiZi
 C1VX/FJjLkbdX2WZelmyvxSYYWvd9brc4w/2X8e6PHLyN8lBWJmxjI9Rjigquhm3qEwM/Tn
 HAucSLc6eq2QWMZ+FXsPxnWvL+UG0KqKfhRtaqfc6XYeew7Y/DcHDqTyO8Ze2qgwYlYzloh
 zELrUKaEPVfNjEAzTmi1/6WBdS2mlYrbOKtp7dmzfX9Trq0HHKJ06YUe/OsNCnIHcrPyYTY
 /7E+GVnQ23oa3iqi0MyRJ9b/eXaguIQmWd2ENQSQpGwS8+efi7fOAA/sATwInc/DstizMSb
 tA8VkE/NSPTUvUf0scI3ltTQ4OIVhd4M+hp15MW8oXI1+1+TANTluHYgTw/pE3In2s6Mc+0
 lBYoNLARryHsrjxXIEpUDWlGwkFGNxT2BDb2JshF3lVYQ6cY7Cz/3/mtAjDY6a/h+O2fLx1
 E6YErE/3WNP4t52iTGjI9H3SwaAYcKvRtA7nr/kd60/zwxccMiKAkcxg72J3P0ME8MEQlyC
 ZZ5oJMdnsO/etQ+8F52VyfTul7qT+qCJFKQq0RG4+Xc5pa7zlOlRMHqiURt88hqSc7H8TY5
 hbb1NvmphksZWk6dt1e3nMoFQA/bfhFlu/Rx73N1EIyiS83aVND/UJyIjVdW2vhgDT/CAx6
 OmVJIJvf0D/u499WYBf944pzjhX0/8NGt6LUshk6t7h
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

