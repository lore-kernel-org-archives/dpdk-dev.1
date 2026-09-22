Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE56C98302
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 19:41:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20B4342EA7;
	Tue, 22 Sep 2026 21:41:47 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id 994B742E94
 for <dev@dpdk.org>; Tue, 22 Sep 2026 21:41:44 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-39b2ad83dc6so217786a91.0
 for <dev@dpdk.org>; Tue, 22 Sep 2026 12:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790106103;
 x=1790710903; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t6vLPvaFz1HEpG817iFno3vy/yd6G1QB6QhK8YyEGuY=;
 b=OgY3oGTMs6/izvQCGZd066F4JlkSiVpEQMAPUfKwkGhcZP6G0ZQv2Pp0Py8HpN+veV
 E0nROKi3ZGMGw9/PBgp38InlOCPCDKe5iNAy/zU2WiuHV9xPO3lvQS5/dkHIRvBOrBA3
 Gb1jMpu0s4noeREano/dCxwOfxs3H3sJ6eDrthHR5SdJZKP/7lDTYRYF5YS60PRsOf8H
 BUFw+Ia0SL2ynRYJRd/wnB62icniQM1Vqwd6tPz5xs4H0XpE9m2HAleGtQiYgyWgSJ85
 lFyxoWzVlPhrjnYYbhUFGpL43zMny0it7JtsIxRRiAXLrun7mqdFwvdhlKrSYtejC4st
 EUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790106103; x=1790710903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=t6vLPvaFz1HEpG817iFno3vy/yd6G1QB6QhK8YyEGuY=;
 b=prb3CWldSazioJksZhj7QNzA648ZqD68T1LMaHZXUQfpvaKCvAorNSJWC1WuQzrRaN
 xKoXxSfSXx/PU566IaGU8w8M5Ud+8W7CXZOs1ptGl9BGk0Yr9hM+kSrpDiFLyOacYu80
 UiYPvKNksWFLThxgMGPCt3iYtD37M2+iNFYCEf1KBeRalCOOP3CexlcBuQjRsUXdNadD
 oZ4S4CzDHdm40MRjh8eDuYhi9QpgPBZJbpVFqgOUbrX5s1EEVyJuefJJLJosMTixTUT1
 oIAr0+ttARn0YH6uO5e1g4ujWOXlhcVKjZFERKtrOdt+1qBnfxk7tN7y7MXLV55A2IF6
 tS9A==
X-Gm-Message-State: AFuF++kFWBVJzajzVfB3z2w9jpIE/gKdveiVe2R2DDC6z4vdijlQVofx
 iFGPgXfGuVPbrCHgxMJYtjJmXpu3rLcKfDF3LaLDFsKFbCBHRwUEHWiOq8H9JAeVl+JraT1bJLP
 Wf9oo960=
X-Gm-Gg: AYBFou3seLTPAsvHEiqEVLOC6X1T7x22+nyR3GGA/vHL4SgshPs0rv5kGyaRd2rKdOa
 MCJfre3Tzd7h3C2LoyjS5GBMDpWwmTmR/HE6po00MM6PESH9L5aqljdpMnX+VTo7YYJXxfiL4U6
 jQsf4QTI1WqKlL9QH9xxy3eyXf2cRWrEzVcvbGpwLMiP695TBZsAiiGBrV/I+Q7LigS6EhtnKSv
 C5yS3+ZyiXesDLev1aWKCtjufvZ59YmQ6z6+jnyMg4HRr15u+v34Jey1DKoPxfWUOgcDMUcXZOg
 s2t6arFfvXAPQLU+O58GOQjjRKrMTqiLiZyGiNgQgjyEUDRM/e1Eb+bs1ctFXilqtfwigfEKDG4
 aYuVruzOt5+uh/7V/AOSjT4Zovx1SoosqcF8MQxPn8MutrbNqZzWWSpXVx+ykKEcKqzchMC52Am
 uD4teo7c/xUSMFlWU53GECnjzpKrQMVHgaKuCcwAbf20vPopsDlKhJbGNHlXvcmNsu7FYhkS409
 WQLT5u4lOzykVM8WD+bhatuw/IQLijP1cb1Gg==
X-Received: by 2002:a17:90b:2250:b0:39b:61f1:8032 with SMTP id
 98e67ed59e1d1-3a07e54a4fbmr412730a91.16.1790106103558; 
 Tue, 22 Sep 2026 12:41:43 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a07ddf1cf3sm814881a91.9.2026.09.22.12.41.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 12:41:42 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jakub Grajciar <jgrajcia@cisco.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH 2/7] net/memif: fix issues in statistics
Date: Tue, 22 Sep 2026 12:40:53 -0700
Message-ID: <20260922194138.508919-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922194138.508919-1-stephen@networkplumber.org>
References: <20260922194138.508919-1-stephen@networkplumber.org>
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

The statistics structure is already cleared in ethdev before
calling PMD.
Statistics from all queues should be counted against overall
packets; the constant RTE_ETHDEV_QUEUE_STAT_CNTRS is upper
bound on the array of queue stats.

The counters were also keyed off the negotiated ring counts in
pmd->run, which memif_disconnect() clears, so every counter read
back as zero once the peer went away. Iterate over the configured
queue counts instead, in both stats_get and stats_reset, so the
totals survive a disconnect.

Fixes: 09c7e63a71f9 ("net/memif: introduce memory interface PMD")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/memif/rte_eth_memif.c | 44 +++++++++++--------------------
 1 file changed, 15 insertions(+), 29 deletions(-)

diff --git a/drivers/net/memif/rte_eth_memif.c b/drivers/net/memif/rte_eth_memif.c
index 5d153c3a5a..89796d3ed5 100644
--- a/drivers/net/memif/rte_eth_memif.c
+++ b/drivers/net/memif/rte_eth_memif.c
@@ -1595,25 +1595,18 @@ static int
 memif_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 		struct eth_queue_stats *qstats)
 {
-	struct pmd_internals *pmd = dev->data->dev_private;
 	struct memif_queue *mq;
-	int i;
-	uint8_t tmp, nq;
-
-	stats->ipackets = 0;
-	stats->ibytes = 0;
-	stats->opackets = 0;
-	stats->obytes = 0;
+	unsigned int i;
 
-	tmp = (pmd->role == MEMIF_ROLE_CLIENT) ? pmd->run.num_s2c_rings :
-	    pmd->run.num_c2s_rings;
-	nq = (tmp < RTE_ETHDEV_QUEUE_STAT_CNTRS) ? tmp :
-	    RTE_ETHDEV_QUEUE_STAT_CNTRS;
+	/*
+	 * Use the configured queue counts, not pmd->run, which memif_disconnect()
+	 * clears; otherwise all counters would read zero once the peer is gone.
+	 */
 
 	/* RX stats */
-	for (i = 0; i < nq; i++) {
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
 		mq = dev->data->rx_queues[i];
-		if (qstats != NULL) {
+		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
 			qstats->q_ipackets[i] = mq->n_pkts;
 			qstats->q_ibytes[i] = mq->n_bytes;
 		}
@@ -1622,15 +1615,10 @@ memif_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 		stats->ierrors += mq->n_err;
 	}
 
-	tmp = (pmd->role == MEMIF_ROLE_CLIENT) ? pmd->run.num_c2s_rings :
-	    pmd->run.num_s2c_rings;
-	nq = (tmp < RTE_ETHDEV_QUEUE_STAT_CNTRS) ? tmp :
-	    RTE_ETHDEV_QUEUE_STAT_CNTRS;
-
 	/* TX stats */
-	for (i = 0; i < nq; i++) {
+	for (i = 0; i < dev->data->nb_tx_queues; i++) {
 		mq = dev->data->tx_queues[i];
-		if (qstats != NULL) {
+		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
 			qstats->q_opackets[i] = mq->n_pkts;
 			qstats->q_obytes[i] = mq->n_bytes;
 		}
@@ -1643,20 +1631,18 @@ memif_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 static int
 memif_stats_reset(struct rte_eth_dev *dev)
 {
-	struct pmd_internals *pmd = dev->data->dev_private;
-	int i;
 	struct memif_queue *mq;
+	unsigned int i;
 
-	for (i = 0; i < pmd->run.num_c2s_rings; i++) {
-		mq = (pmd->role == MEMIF_ROLE_CLIENT) ? dev->data->tx_queues[i] :
-		    dev->data->rx_queues[i];
+	/* Same as memif_stats_get(), pmd->run is cleared on disconnect. */
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		mq = dev->data->rx_queues[i];
 		mq->n_pkts = 0;
 		mq->n_bytes = 0;
 		mq->n_err = 0;
 	}
-	for (i = 0; i < pmd->run.num_s2c_rings; i++) {
-		mq = (pmd->role == MEMIF_ROLE_CLIENT) ? dev->data->rx_queues[i] :
-		    dev->data->tx_queues[i];
+	for (i = 0; i < dev->data->nb_tx_queues; i++) {
+		mq = dev->data->tx_queues[i];
 		mq->n_pkts = 0;
 		mq->n_bytes = 0;
 		mq->n_err = 0;
-- 
2.53.0

