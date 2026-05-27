Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426FECD5BD5
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 13:03:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BDE240653;
	Wed, 27 May 2026 15:03:22 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTP id BB1B74026C;
 Wed, 27 May 2026 15:03:19 +0200 (CEST)
X-QQ-mid: esmtpsz19t1779886994t10ace56a
X-QQ-Originating-IP: frdolibg7UoytEtFx5WJPCgs72wwl7CZxEMdWiym/Zg=
Received: from DSK-zaiyuwang.trustnetic.com ( [122.231.28.113])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 27 May 2026 21:03:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8780955341107625170
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v5 02/21] net/ngbe: remove duplicate xstats counters
Date: Wed, 27 May 2026 21:02:02 +0800
Message-Id: <20260527130222.24348-3-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260527130222.24348-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260527130222.24348-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: ODape9HLJUgbcBUJeVu8f556EkD5Kh4nfhpMoKhhRonxPsEsZ74K5zqy
 zLcygPMrbYEBvX4HNSfHvIS/OeHbuthQJyBPDS1KcdbuVeHqCohu3P+kFXYdNfh9O3fn9eb
 VBU9RAXwhIuSyuykAdrbwdJkpHxhSmngFB5+1Junx12Inl35GRzSmjrwLg2Qmyp2S/tnIgd
 3m403DeB47whHq5mlgXVWrBxTgOCGMORzhvvmVdHaa6tBHg26w6s40y9Rs4tooYI49AZOLU
 gS81K3NEpUzA7NMih58kw6detmQKY7TCqNkpxv1P28on6FbJPxfvcK/1I8QNbWK8f36v5Zf
 IJAfr4sAGtT8QLBzA3M5hgaw/7RaLL0uH3Zo1TQ20cV8RFmiClBK5FN/5Kv29Lfb2gHI8vJ
 qxzdhRSUfCle1WcyOYu87QxacIICL2Kr/PFK8gO0g9IpYWxBsmGiydjKDvg3J4zbrXxzSUA
 /jz0d6ZHaN9XLobM05xUe8ifqpdYiYA6Z4uWMU5bx+3Wmm2Ksqjr1Ed8Pz5/vKKWXZdL7DK
 ntS9mvjr/Zugc+FNSTFxcULm5HMOdKawkhRk4LbpzuGpcZVTssCjiUpe1xaun+SRzAs5gPZ
 HCzrSsOT/+cN/6a++rr0w1VmpuMU019wxIjaUHJhxDHV2dH4BCj0xbbwGUaSpHOiWjhyuz2
 s3tB4Ou7AMbvfbkBsnyTCkNznmDYeiq9g6J/EhlQgTZxA50CToQuPAVfP1FltT6crGZQiy4
 S2WBfBHWBy7oieClyNfBpvB0NBf3CtCQGP8MAKkztypj7ItgzuNAaKzd1HVHDrefq9vP9Wn
 q6LQ2lLA09sO7C8Ho8gDGmzD9XgCwhVN2FvUYZqqIn6BGJ7fwWjOiA0xisUeg6GJTWue21D
 y4Nz6q2psv3Gr4dfEkW+uxbHmgIqHzb8I/9TPpmC/lJTSp4piZxhXLjOfJ9HxdMNmtgWHwW
 8nXUAvZ8suMVX2lLgT8Bo1DxUuNGHMAEoQRysx+/mgAbnkyG3i5aczUaGGodC6Qsr9HfpgN
 RxIu2OQjQ14yRytcj67WiaiMhibuSqkjgreLyRPWoJKWSLgar+17eev9r1w28BbatnW46oI
 shy//Zbm7hGxrvwlMY6Li/kWtqGjIny/fDzYJeKWzFdhir1f4rRS08=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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
index 8b9d6371fb..6df53f3266 100644
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

