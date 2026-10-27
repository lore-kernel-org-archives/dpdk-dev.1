Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFA9606A328
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 11:42:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5667A40656;
	Tue, 27 Oct 2026 12:42:31 +0100 (CET)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by mails.dpdk.org (Postfix) with ESMTPS id 112A5400D7;
 Tue, 27 Oct 2026 12:42:27 +0100 (CET)
X-QQ-mid: esmtpsz17t1793101344tb8a94569
X-QQ-Originating-IP: ekVd4oiY/XiDICJU7/MnGnOp8yZZas8lmxdo/oxYs6E=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.25])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 27 Oct 2026 19:42:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5297938337813337240
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v12 03/17] net/txgbe: fix E56 PHY configuration error
Date: Tue, 27 Oct 2026 19:38:19 +0800
Message-ID: <23EB43A272B392B1+20261027114218.9724-4-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261027114218.9724-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261027114218.9724-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MLetzUOBDtQsA4pZzheJuFiyU6Ni/FtMxgqN/jBl2ditds/7cHFMNuJ/
 EszjZ3U54SXd+lFyQ+E9lqw80ntM1qP4l5oWgOzRTNI+WdKSOy3otMwqESX9WyESbPg0gkk
 MWRPjNHUjOYhMDbNKUMDwE1TF+RDOGxSGwnFDc5mA0rrU5d95+xSLT3nT7+nbtD57jtaN72
 7wTuOcDDAEkT7+DuulonbwI1vo8rb3J+7Utv4ulBR4YXLET/yssZMW00sWgu2PNdg0ykKvY
 HxSxJWqrNqTk1S4l3RGmQaIpIw2P5HaOuSOP3HeXRqSSjjFm6BKHnvKVLKwZ2ycmi6Fbace
 7zNoIhoJra9rt5XaSI/R5TUW61+W6pGnGF4BgJC9k2FZguCahCipBnGa3wElSElJLEP74Rg
 fTVGJMLb9H9wMdFwsSONQ6c+QcOC7vzHc1ARQYf/2mspgCFSsZ70MQJ9IhkH/fZr+5YZU6b
 9ZMHvl85iCP7n9m3m4Gp0wB6+eAx1iyeWnBcVqO3VXUiaCrttZhhrQRfw5tDE0pOcn9o83g
 XzhA5etcgZuYhp/xJhD0EfIyKVJiEZ/EducxpyhcJEwfJ6jeyZXEcVtTm+JOUw1TH2y5h3Y
 F54+2AZGuuytr7xI80Twyi15PZ/GUtgEMJnaZaPmPzf6dv4tZSLGoUuxCz68UGOHy9OMMm/
 CPjVNmh7zIjItsyfjNi1j/4omChdFyPnWkWFp7vGN5aUt2zr9m8tnHK31r55v4HQnGLW7PV
 aFCPtUKkCMXZIGA7JggjciaB7CV6kPOSqf5AlzxMQz5kQqUPvBRdoovHA88pgotSaIkrWLK
 DCwDhh0XvwGk7QZVNBkX++C2xe4E+ErQsMlUNrECuJx9VEJZMQvo2/2sSmPbjV8yceaLrLM
 CPJGEEZ5WvACf5WN6ZftoJXlDUWbOvYqVZhJbKxwoLIA/sBMfBAN4KjxMqXudQWvT4Vhcut
 KTJ1sOKFdll52zB/gkZCa9oXfR5EWGgxfsgiTEfl5Z4NlU236dDQBB9N0JjfZ3r3/wWBNEG
 NZo9L7wV10yXImsW6cYoq7n9XebqGogxGa6DjwksKcnlrH2VI45IV3W0KL12FXrFNTBF284
 EtnAJEPXWds+8x6YOAJX1k=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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

The E56 PHY RXS ring equalizer/tap configuration is written to the
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

