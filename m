Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B43CD37B2
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 May 2026 11:29:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CDFC240658;
	Sat,  9 May 2026 13:28:58 +0200 (CEST)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
 by mails.dpdk.org (Postfix) with ESMTP id 48D04402E8;
 Sat,  9 May 2026 13:28:56 +0200 (CEST)
X-QQ-mid: zesmtpgz1t1778326133t8f6994bf
X-QQ-Originating-IP: mhq1Znyio1JFU6y3iL2O+kBlQ4EJO194hSCa60gdfM0=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.157])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Sat, 09 May 2026 19:28:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16998547991422203135
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v3 02/20] net/ngbe: remove duplicate xstats counters
Date: Sat,  9 May 2026 19:28:04 +0800
Message-Id: <20260509112823.7728-3-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260509112823.7728-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260509112823.7728-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: ONMinSPvVgZROAHN1YknHSEpGAnSf/FW9/U3zQX9MnzibpT3aKvoIato
 IYOrKr17JfHA3JOdwXwIVsXiw2Wnb2G3ZkykzPEiE8XXSst1xmJ1HlRVrh182uYTWTNQnbR
 Duc+dxWWb+lTSuyhsMOkkq9LOo/qQeLLgb9vMkYPgrbM7ZIkcMhIf77iUM/Uq2hRi0G7zAV
 2zMujyLqzTbsIab2IJUNexpnoP9EHUhkDDxh2tnqMxnmY6yu7NJb/8ir9aiy/BlcSc7gD1E
 PRWqDeEigbuI9/MVmAhkMqeXuT4+/nE/23aY5ky+k+ojkWLV5lG0TRR/md5XWEsGhHPv79d
 QmqXZA9q5O3eR69UTNQTto3F+K6rhOG1oX3NnvFm0ibCw2J5Gg/Ku2CtscbssPM/OAD2wb0
 YmQkTL2ovet5k/3euhLzWbFZnUIQvfF4KVlRneowMcrvU0lVevCreZGnpKTVa1K2fTg30s2
 sF7o65zSNfSDdhJQWNiVmwij9CdqyUgePKXZRy3oXOv46xI7Ok/RXmiQD2rqG76Y4oqHD87
 eaeth+cAyzmOX0lCAsDnkKEmeDRQWB2K5HXanh9G6XhmlYujV/8IvJ9SO0Vow03VX50cL5U
 kdhsV8xnZGrBVoNRWYxIHgRX2/rYajd7Z90YO8ai+8q+nz/+INbYzrlt+7u7c3B5JgTa4tt
 iULom0Gbc5T9hN61GhjMwTXv/Y0eUJNdTqNqVcFORRm340IzqlKX5cDaEH76qlZKgFmv7um
 LQk6oHg/dL7VdXm397z6DvzyfezJUstpeM4yGoKYpdh5bXzAVWuKeHpn8tHwftQn6qSmj5A
 d8Yw6ijpTdsCm+r/EwhpJKfTOmocU+qRSeVmTbmgXjwZkFmC5rwObmRct3nneEaTci3+7p4
 RovBpCkEs1PIEkVYT4K056CBefaXcKY9AubWcyiSPrjeisekUN3BrrsgxZtqBC+vgc3HTHF
 iJFqQxUffWSRPrxr7LKjEljxxg23gjd7U6zONAwXHWDWPrUFgExwUafSWVBx/liMIo0ZYa9
 YxSPIX+Zkxw8EbPuXBHHt10BeNumFpE75ByJ8A+IDB+k2PMPaXdEU+jOpdBS0F24w5HTRyl
 gMZ3WAu/u1m69xJz2xGf6XGZ1NTDVcQAoDtsGhZrwLL
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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

