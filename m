Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4D1CA5FBA
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 10:21:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6CC4427CD;
	Wed, 30 Sep 2026 12:21:00 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTP id 2AF52427CC;
 Wed, 30 Sep 2026 12:20:56 +0200 (CEST)
X-QQ-mid: zesmtpgz3t1790763654tc20bef55
X-QQ-Originating-IP: C3SEUo6OX/Ip5jtN8Trg9/4FVMX4VkqIOJlbQLj7upA=
Received: from DSK-zaiyuwang.trustnetic.com ( [60.186.241.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 30 Sep 2026 18:20:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6474082343220285648
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v7 03/15] net/txgbe: fix e56 PHY configuration error
Date: Wed, 30 Sep 2026 18:17:50 +0800
Message-ID: <47DBBD7E163A736C+20260930102042.2214-4-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260930102042.2214-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260930102042.2214-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OddG9bJrw+wOeUl5arOPBDtkkrwAGFUzxqjR6E9GAjr4H+A5UlV/GG/X
 tdDpnretGzwnCcXWXxqhiy6il3JOYVwv1mIjU61WyBOheFTzbouy/Vm8UDN8SnajUC5vvVe
 GU4WPC20I/NxnG0YxHclZQZnNcAoddJe2cttOQdcGAaq16a67T+nKQ6Uh+oBxVtdrNmvVl6
 HvPaQng6/7t9VIcIFasZEuxNA5HJir+bfbH3sIlcJXveKCSAn02TRxwng2WM6D7W5hl0TS8
 Fv376gsl+gqjSSSWiC221aDlPnW9UCmDceZDFiUPuQMdaFkCaELnFu6KhixTAGJKwd4qftP
 7LG3wt2hhAf31bSSf7WiXsvFL3WbH3KZ/Zb1JOBODpBNsAUxc4tTScGxm5oK8qLoNQco/Jc
 tErBmEP4aQI31dN8UBPpn38JloNcFu5uyuqT7npZYaK2Of8qImtYc+YAye37dZAssPr1PW2
 JJx0+oygC2xDCRYcTPOZgNqZtrplLlwrIRr/ISSSZrzZrUiVQsn+6sibdVwIIpT/BEPNZim
 r66QmNvv2SWNABRbIi1iuMk9kYd4T5td7Kq/IxHV5CbwqzNuiMJpHLm5cfa2kfVmzcbgSGN
 rEkSZGBgcLkceUTL0XJLY0VVjwtwIrOqmh1XbzSYOrmQXqu7YU7jakcDBshMyr1iBqBM5e4
 AMK2S2AHxvme8gJKtmV5ocyzDdtHqXG3eI7fjtlN5WiyvoH9eWB5RUWL0pKjVTmDPLcaGXC
 L/iWGD2SEEVLtar5ETIhXkyWk3WOq5pmuJZczvMgpa8Nff9f6m0shuf489K3M7gR6MyMlsp
 RHuNzP9XMShloB+HOMypSMOpNMzr372dFqigVGcITrMhkaO0hMhsjN1Ygo09+aspK7Xrrhb
 srrUJEvvCDQuk+zBmLCWNLeWYe5fporMObhC+tdHUVVr/7Y3Z2Gj9cBz4lcHoHa6HDQrSIR
 tfp9xp6BnIr+CmRxokQ0qEVzKFJ0xz65MhYGSG2q8YsM5IFv0PtQvj2AMm7AH8Z6A6D+9d8
 WyJBYd9kR1P/q3xqdyURosof+vIfcddF9FFajwqyziP/V2IrdXwuJvQJoF9rvBCDoXe8RIx
 g==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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

