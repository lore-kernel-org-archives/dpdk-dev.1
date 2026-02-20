Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DA9C54EFC
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 05:50:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC48240B9D;
	Fri, 20 Feb 2026 06:49:02 +0100 (CET)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by mails.dpdk.org (Postfix) with ESMTP id F0F144067D
 for <dev@dpdk.org>; Fri, 20 Feb 2026 06:48:56 +0100 (CET)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-8cb4081e82aso214286685a.1
 for <dev@dpdk.org>; Thu, 19 Feb 2026 21:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771566536;
 x=1772171336; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ke+ohBKXgkoOAnOurtzd9/iE9Vi0nbDHRtTjMLjuu5s=;
 b=SrFyABjDr46nuFPWax1lIGCQA1BC2cLpPQcU1phxF0iV+E6cpX4KDTqqOmIfC8D97v
 4QI01yqobYfmWDzdpjV/CP/mD8mFSvhz4UNdlh6DtLO1OHFjyvSAAyLHdKutcpfT2dSC
 gOIP/g1mART7xBXF2fitOdGsWkt6HCTZ4QLyafO7F0DWfO/s9vlb7D06xYWFTLyZg1D5
 LAPvsmI8HNuXAuTqe66LuNcJ01SRJljQ3mGUC8oWqwdUILnLXVySyn/e0n6SaLamJH2H
 9VrvlSakKg3wi0SiZoF9MYKNNsVq8momJoVtKnRWbEkkLJv8kIuFTfl5WczmUHle1ofU
 viGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771566536; x=1772171336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ke+ohBKXgkoOAnOurtzd9/iE9Vi0nbDHRtTjMLjuu5s=;
 b=I84mfYcMsfoQJoefbABT4nem6EBLuMgTIT9bv8zUL8qCfmMt4nVDppnGZMPlcPfISl
 3K7dtBZyOgiMa6CI7zF1Y4noP/IvuSKgElb076bOGMqQVKR9tf+eLXsld1CdCdpLRxh+
 l9dQte0fuixD4k8J+hAeVGTbg0akzHuilIwb/b4sIWx5txHF3Km5m4A++mdcfewBdwMY
 Dxuq8H/SAXujjg7xeMVBRPchLdWarqqtahcZhDRLbegZyfNNQgIWP1oPn7NMtD5IzoKf
 araxqAovl10E7/lKH21n8LVUi2FWUiwfvXqMYC0wxcvMwx5xfU8EbUh0Ui6a7H8dZX43
 jCPQ==
X-Gm-Message-State: AOJu0YxSiCTrydG59bw3vI+58ayuFFfaG4ZvsstHRCCdYcOyigRXk2CT
 0D8zBDdVOCnf2EedWfP0WrVoqzb2EF3UXivNzJi8dDf+s3t0zNizeM8Iz0qGrWD1Nc0NO60+RfL
 gozdA
X-Gm-Gg: AZuq6aLe6PYyXeMncL+a6sYtOnaTzBd5EArXxunpCGanTwXLdXP1aCn7xFFCrRvlPre
 mzN9EG1KR/ZyhdhjyeLwQJgJqi+JDM1+9dqC29hBqDRgiQrJ2jv0rHl6B6IUfPQjQkzv120MzRW
 AxpWjctXEipFUpwYM8PbITrBB1REKVPAoqxtrroOX4paXn1rrJbklTSfAPxpSt6hjodyjgKP8JF
 6KewnkQnFWwg0TFNCKFqDMk8I3i8kBzItHjT63ve/G/9ctbMAxB6/esgufAOIdHaRwxs645fEuo
 hRaD6JtinwYqQSrOoAt65pAJ5od15XXkK3c6qqKlye7hD2tPt9ERXdG/kOt3ntSWjVacZGSCh0c
 SxsXSAh6KzupXzy8Jo+X5Gt0HIf8Q4/LPMKVCPuyR524O1CrROfcqMpPLC9277xIAR7/bXTgFrW
 kVIdpjcjYIFxal4ui8nQySf538vYq+BW2r5fx9G5QWOWL00vZ2rPjz6tXLRIyyoA==
X-Received: by 2002:a05:620a:3707:b0:8cb:44d7:39aa with SMTP id
 af79cd13be357-8cb4c011f20mr2580028685a.74.1771566536371; 
 Thu, 19 Feb 2026 21:48:56 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8971cdad6c1sm229078096d6.39.2026.02.19.21.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 21:48:55 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v17 17/23] net/pcap: avoid use of volatile
Date: Thu, 19 Feb 2026 21:45:52 -0800
Message-ID: <20260220054834.1632201-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220054834.1632201-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260220054834.1632201-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Using volatile for statistics is not necessary since only one
thread is allowed to operate on a queue at a time.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 508163c4c4..74812c6842 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -54,10 +54,10 @@ static uint64_t timestamp_rx_dynflag;
 static int timestamp_dynfield_offset = -1;
 
 struct queue_stat {
-	volatile unsigned long pkts;
-	volatile unsigned long bytes;
-	volatile unsigned long err_pkts;
-	volatile unsigned long rx_nombuf;
+	uint64_t pkts;
+	uint64_t bytes;
+	uint64_t err_pkts;
+	uint64_t rx_nombuf;
 };
 
 struct queue_missed_stat {
@@ -930,11 +930,11 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 	      struct eth_queue_stats *qstats)
 {
 	unsigned int i;
-	unsigned long rx_packets_total = 0, rx_bytes_total = 0;
-	unsigned long rx_missed_total = 0;
-	unsigned long rx_nombuf_total = 0, rx_err_total = 0;
-	unsigned long tx_packets_total = 0, tx_bytes_total = 0;
-	unsigned long tx_packets_err_total = 0;
+	uint64_t rx_packets_total = 0, rx_bytes_total = 0;
+	uint64_t rx_missed_total = 0;
+	uint64_t rx_nombuf_total = 0, rx_err_total = 0;
+	uint64_t tx_packets_total = 0, tx_bytes_total = 0;
+	uint64_t tx_packets_err_total = 0;
 	const struct pmd_internals *internal = dev->data->dev_private;
 
 	for (i = 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS &&
-- 
2.51.0

