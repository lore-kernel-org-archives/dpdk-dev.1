Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2962DCDB46F
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 11:11:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65E774060F;
	Mon, 22 Jun 2026 13:11:40 +0200 (CEST)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by mails.dpdk.org (Postfix) with ESMTP id 511E04060F;
 Mon, 22 Jun 2026 13:11:38 +0200 (CEST)
X-QQ-mid: esmtpsz18t1782126694t4602c16e
X-QQ-Originating-IP: 2Wufhm8bySx4KAkmHiRqfbTMNrLHf6JO8m37u/LZBz8=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.248.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 22 Jun 2026 19:11:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8577093679764628731
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v9 02/21] net/ngbe: remove duplicate xstats counters
Date: Mon, 22 Jun 2026 19:10:50 +0800
Message-Id: <20260622111111.21024-3-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260622111111.21024-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260622111111.21024-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NPdR9eBl+Ml9j/T7JO4RhY7GEOSkzvxMa7jCy8kdJvYJUaLaZzs41l0+
 +Jybzs0CaESCHsaVv1vXmxPXnD0E5GOzxnbVEB3gwOZdw6xdqLovJgnl61pSMbGDbMGts2R
 D9nnoh13HGYUtv3BSfeqk4s6h95Dzwwrsyw8MnpFzP73YR59ED5NW0nssJHoBj4cu8wWkxL
 3gFBZDUCrQHtMce2PmdiqY7b15lgBqMNiFilMttKG5KzFGSeaMr868LvgyWxGFfDcpLlhTo
 SfqvctcdP85tO35KqTpRuLigyQf/HTAy0g7pzrBJd0+Sg4yUT/LlgBK4//+xRt4MqMy054w
 vIBkmMqeNTwI+CiL3hCmFSQuB9yyO9+a9QSVJNjfu3tMq9U59lbQx5eKldJgWwPT+sVh1Mx
 7Hk1PRjkp4PRsueLQ/iHVGEoynuxguuX2i1DaDhtAwupZLwCFXv6BVg/UcBn6FmCmVCB5Gj
 U5lxyHA2Nu5TcQ36+qgkRwk6MYWVgqBuqPqBL1YTuO/vJcRBPavJ/376ZVjvhRKnTMAaCRt
 yV2s9tzoeXJqykiG9m2Smz5peHkYtnLd9+mkQzvA/bIJGazQn69hVMN7CrqU6FkEYgfly21
 T0wuIyT2gqWyqwfuz2a3fVZqLCoHvjENey0QCTxgz4QveH8Rnhu7C8dwGk7Ngx2XsZaZMS1
 oO4qHlJaKg1h+zO+bkZTbR69bxnSXQAf5ds/dMLROz5oGSuCDYrEUXV9qR5Zl0fD3XFxd28
 159+CGtcrTlqdOsi4uac4oAkdqy79rz80lr/SyYa32vty9JY9EbTx6HRDhR8F8zJdn6z85D
 FDPrFfmrN2SHXT/5RWEQ/+FC4aYlt8dzLL+d2FdYenT6nBXdybz1Wo/KOvCHHU1gM2/cJhy
 LSpjfarszMCcB5tb2egTaXvqbFsduxumCgCDZ2yuKXo1TRugJr34IyzP2ASNceI/P3RE6A1
 vYcKUaGzcPN66AZ70Hes8en/QvLcOFDjwMoT4MBcOIs+U0WJ7rSSPhvwnvdmL3mVubC1voD
 rP4ymNDaN9mlqx+myMO7haFJKO7S278WG6z2Wk2TgZ5wGTT+IFPYr/lRA+9vF+NhAnazQX7
 PgPF2uufd/JLzOLPpyw35a0UHIfYol5wfkcL97w4vgHSlQ1giBUiOv7huAWneVsaAoXBZXz
 vZuzWwcVaoS82JNO1WxXoQ3gFVIrJMY5hUlClaAFhZrmVFo=
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

Remove four redundant counters (tx_xon_packets, rx_xon_packets,
tx_xoff_packets and rx_xoff_packets) from xstats, as they were duplicates
of tx_flow_control_xon_packets and others. Both sets were reading the same
registers but being output twice under different names. After removing
these entries, the flow control counters in DPDK now align with those in
our Linux kernel driver.

Fixes: 8b433d04adc9 ("net/ngbe: support device xstats")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/ngbe/ngbe_ethdev.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ngbe/ngbe_ethdev.c b/drivers/net/ngbe/ngbe_ethdev.c
index f7b4a8b159..09bcd791ed 100644
--- a/drivers/net/ngbe/ngbe_ethdev.c
+++ b/drivers/net/ngbe/ngbe_ethdev.c
@@ -227,11 +227,6 @@ static const struct rte_ngbe_xstats_name_off rte_ngbe_stats_strings[] = {
 	HW_XSTAT(tx_size_1024_to_max_packets),
 
 	/* Flow Control */
-	HW_XSTAT(tx_xon_packets),
-	HW_XSTAT(rx_xon_packets),
-	HW_XSTAT(tx_xoff_packets),
-	HW_XSTAT(rx_xoff_packets),
-
 	HW_XSTAT_NAME(tx_xon_packets, "tx_flow_control_xon_packets"),
 	HW_XSTAT_NAME(rx_xon_packets, "rx_flow_control_xon_packets"),
 	HW_XSTAT_NAME(tx_xoff_packets, "tx_flow_control_xoff_packets"),
-- 
2.21.0.windows.1

