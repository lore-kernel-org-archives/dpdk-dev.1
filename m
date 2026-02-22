Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D15DC636A1
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Feb 2026 17:32:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09B1E40608;
	Sun, 22 Feb 2026 18:32:32 +0100 (CET)
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com
 [209.85.160.50]) by mails.dpdk.org (Postfix) with ESMTP id 37899402E8
 for <dev@dpdk.org>; Sun, 22 Feb 2026 18:32:30 +0100 (CET)
Received: by mail-oa1-f50.google.com with SMTP id
 586e51a60fabf-40f095f1036so2602376fac.1
 for <dev@dpdk.org>; Sun, 22 Feb 2026 09:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771781549;
 x=1772386349; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hMtxLXB9JsYm0atfgC4fdGhdHpKszUlC34DEGDXB0K0=;
 b=k+CIqAf1F9bmmSkgjzV97NdSuXK5isngNGTsZ1aIhxeGVZGbhS45526rbThR+ItamW
 /JFLeKxqK+62UaP87Rrc9eT6TmH4j+1wezweXnWkpniLImAYOXQbAN6lDi8Hc1lOycyh
 8dSKt5u5heAH8wcFwjKaQMk7FXI17nQWgg9qVlmn79qyDIQ/SXvEAPygDtB6mkqPx+a4
 5/mgtI9LZeuFvVZy4hGUzHQSHZYt0Hmb7q/XZUStH0OgJimj+BINFiwJtu5cVQMQb4Iw
 YQvxNxssWQ2IyekY5pB8xpfogJS+tjZNBcWsiYrlPrTRSDjAxcog5gnMn4UOyMgoc531
 HOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771781549; x=1772386349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hMtxLXB9JsYm0atfgC4fdGhdHpKszUlC34DEGDXB0K0=;
 b=Fdd4e1/GyMqWvGpW5FQA4aFaJYY61QG4ia4xO63VhzTs/MEpLMg/HF2qmohKewJd2z
 NYmE0JhOEUrWHn8PPiuIfdJfaUxRJaIas59B86grMLcnAx7pzmiuMntR+gLn2ONhY1hS
 +A3dl4YpdGjC0RR5DjVxuMJ+gpubkhn3l+UgVVeS7gGj65SOrims4J/o4CCZbnxs4fS4
 2TDtDQiBKloIZyqgNLZPp+G4awB6c7cKA3u+GFAwYmMCTdop6uw48TEWu3kVlLKchmc9
 sPx4wdP4tV4DkGZ7XdTfoXhWvUmkvO/iLKGL82JXLpKlvobsvESDpszBbQgCyjNVH6+V
 gdkg==
X-Gm-Message-State: AOJu0Yz+dW0wcKQSn1g2Bf5FRR12dNWDKni/aYHX2RP+IDNWrJ17mZ/2
 Qtti4cll3aNija86of3Mltav30RZ+sWoiZ92SBHlZADu9NRnSI4P0lbk4ADNhLsj/StUXYtRyVY
 UppAr
X-Gm-Gg: AZuq6aLbxN27nEc006xBLU/SE2qYePjK0X7K0HsBgJ4PBbDcStjX4jb5bgNyfF3Sb38
 cvwncu59f8fBgESB1/LUYcT+s7+NnbSnFJ/SINEJ+d0GiQQ0tgnMBVU/xMZoVI6wI0z2LZIiO55
 MgzyYiDHZmdV+pvMHDG73unOdxZ/+ptMgwgw/Tj7Y5UyLQjQ6Zmjyld0Aja9GI8vC9ki/WQIIQc
 9lhE4x5TVY0Zy9F0+moFxehMbBSnLshyvnru9QksuV3C/hbG7d9v6+q3ifHAAK6V1bYfKZ9wHoq
 WmhPDdog7k/aYrbFloBsnfHfsakOpoqWm1xZJDKESJCRHWHn7O+T/KebAMW+Zm5TWKPuvvusQwu
 HJHosErdkkFD6jxVVz+OzkI2gwYq0YEaOY2CAabbd39v2n2PXYPqjm4GqMASdRiq+Z2uJ+MetdY
 SBzebSui0WgP4/1T+S6161he1Q1kZ7RI4Yu/PsWYqcmvn+t7viuwP4oVxlo2uS5g==
X-Received: by 2002:a05:6870:16e1:b0:409:6862:aba5 with SMTP id
 586e51a60fabf-4157b1033f0mr3505472fac.25.1771781549327; 
 Sun, 22 Feb 2026 09:32:29 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157d2d7922sm5608972fac.12.2026.02.22.09.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 09:32:29 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v5 01/19] net/tap: fix handling of queue stats
Date: Sun, 22 Feb 2026 09:30:36 -0800
Message-ID: <20260222173225.522754-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260222173225.522754-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260222173225.522754-1-stephen@networkplumber.org>
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

Drivers are supposed to account for packets in all queues.
If RTE_ETHDEV_QUEUE_STAT_CNTRS is configured to a small value,
the TAP PMD would skip counting some queues in the accumulated totals.

Also, use memset to clear stats since that is more future proof
if new stats are added.

Fixes: f46900d03823 ("net/tap: fix flow and port commands")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/tap/rte_eth_tap.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index 7a8a98cddb..8b233a3143 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -956,17 +956,15 @@ static int
 tap_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *tap_stats,
 	      struct eth_queue_stats *qstats)
 {
-	unsigned int i, imax;
-	unsigned long rx_total = 0, tx_total = 0, tx_err_total = 0;
-	unsigned long rx_bytes_total = 0, tx_bytes_total = 0;
-	unsigned long rx_nombuf = 0, ierrors = 0;
+	unsigned int i;
+	uint64_t rx_total = 0, tx_total = 0, tx_err_total = 0;
+	uint64_t rx_bytes_total = 0, tx_bytes_total = 0;
+	uint64_t rx_nombuf = 0, ierrors = 0;
 	const struct pmd_internals *pmd = dev->data->dev_private;
 
 	/* rx queue statistics */
-	imax = (dev->data->nb_rx_queues < RTE_ETHDEV_QUEUE_STAT_CNTRS) ?
-		dev->data->nb_rx_queues : RTE_ETHDEV_QUEUE_STAT_CNTRS;
-	for (i = 0; i < imax; i++) {
-		if (qstats != NULL) {
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
 			qstats->q_ipackets[i] = pmd->rxq[i].stats.ipackets;
 			qstats->q_ibytes[i] = pmd->rxq[i].stats.ibytes;
 		}
@@ -977,11 +975,8 @@ tap_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *tap_stats,
 	}
 
 	/* tx queue statistics */
-	imax = (dev->data->nb_tx_queues < RTE_ETHDEV_QUEUE_STAT_CNTRS) ?
-		dev->data->nb_tx_queues : RTE_ETHDEV_QUEUE_STAT_CNTRS;
-
-	for (i = 0; i < imax; i++) {
-		if (qstats != NULL) {
+	for (i = 0; i < dev->data->nb_tx_queues; i++) {
+		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
 			qstats->q_opackets[i] = pmd->txq[i].stats.opackets;
 			qstats->q_obytes[i] = pmd->txq[i].stats.obytes;
 		}
@@ -1003,18 +998,12 @@ tap_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *tap_stats,
 static int
 tap_stats_reset(struct rte_eth_dev *dev)
 {
-	int i;
+	unsigned int i;
 	struct pmd_internals *pmd = dev->data->dev_private;
 
 	for (i = 0; i < RTE_PMD_TAP_MAX_QUEUES; i++) {
-		pmd->rxq[i].stats.ipackets = 0;
-		pmd->rxq[i].stats.ibytes = 0;
-		pmd->rxq[i].stats.ierrors = 0;
-		pmd->rxq[i].stats.rx_nombuf = 0;
-
-		pmd->txq[i].stats.opackets = 0;
-		pmd->txq[i].stats.errs = 0;
-		pmd->txq[i].stats.obytes = 0;
+		memset(&pmd->rxq[i].stats, 0, sizeof(struct pkt_stats));
+		memset(&pmd->txq[i].stats, 0, sizeof(struct pkt_stats));
 	}
 
 	return 0;
-- 
2.51.0

