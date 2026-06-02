Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3E9CD5BD1
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 21:50:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E3C47406BB;
	Tue,  2 Jun 2026 23:50:45 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id 436BD406BB;
 Tue,  2 Jun 2026 23:50:45 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id 9D65D1D0006B;
 Tue,  2 Jun 2026 17:50:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Tue, 02 Jun 2026 17:50:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1780437044; x=
 1780523444; bh=PApFKN/EM/1VqqJ0s7RfjM6nlLnmW/GNEZXlVqsUtNY=; b=c
 kxdh6D8aCfUcYUZC5bY3tsmL9duNzG1R7YnaCX3AhX0NEJ/pRqQ31jEwth4ld611
 0vXGrl9PUXt9bwsaXmSU8O6fknYjXk5dYYDIhWs3pSG8/kZZhhbPi2+vYdvL9dWI
 uBuOAAlo2lpgk4ZNg04cmK3WFaPkC7hoAexi5s7VUMzvIpRr0Qd7Wj3hfc7Uj1v0
 8UfRlB+gGBkqy+MID0w3mXLwTjz66nYv62y5KanSKnlhZkZ/bVdlilb77oLpfbeE
 yN+AdWFzev0ZeBSdYkX4yQElsTCFXyhV5khQcdVCjIlc6g03NghVCArqB7LpnRhI
 rWLS8ym3JUOJeL7EvNTPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780437044; x=1780523444; bh=P
 ApFKN/EM/1VqqJ0s7RfjM6nlLnmW/GNEZXlVqsUtNY=; b=XAkLtjyam/JQ65mUV
 kqAnpp0BfAsyrb6fc/jgZ7+K4g8n8H/Jjna3G1Ql/jh1kZ/JbZ+0C6O0hSA28+qm
 /NTmppv9qWyrqqyDEv9zNi9gBq9hkpgIeTnpsFrRMpY8IT3+Cyojd1SW5qSO1UYO
 lKrtqckh84EpsDe00Hu8E7G5WNeJreR6m+T+/KVVEUefoJwSZmy5HNnBHdTe59cD
 DHMnNoesrtuS8+PlHSoJXB8yO6hUuotr2Aj2/1/Lqzm4eadl4lO0JxM9a+PDWsq2
 TZPJwzbaa5FDrp3C+GultuYpm0u/pl6rvI36pZXrdSDYynplgU3E9nA0zzNVEgtT
 nyjyA==
X-ME-Sender: <xms:NFAfagr9-dBF4jWdbBeeI-6qb4zR_J_jHDtC5VyiTvn3_gHZMwCeeg>
 <xme:NFAfaiq3t2XLHVgqJVb8psig792Zkgs3HpIsEiCLvPw4yy5PYtyYZ11CVc58lHEFu
 ECNcIqfOECUt14ZjsCeLL-V_oQFVyZEXEokDTbRA5f0NqeZY66lWx8>
X-ME-Received: <xmr:NFAfanYJRCe5Vlz0_oZ5OdW3XpqocBnoygd3Ueufj8fUcUu8C1Xt5aeettZtSQ1exa8n-taPO3l1zCF0I4_X--yjKNibrtA>
X-ME-Proxy-Cause: dmFkZTFE0INMrLg8mEo0L67iSbjGM6kGvDg2OtlOFqu8a2NIyESVm8AfCdzHsNUysYY/Cz
 AipS2qP8sQX+R2Ghydf59fc80PIzig4hSo+i4gzXPUJzKuOkc43ZO+hG05YCHwZpnxdxa6
 N+SkAPpREzPRyJEfXfYtAUiimcSC1xYgaoRWy8emJid8rA2sLzgwg0IMjcc6sw8W87LsTb
 oeuFFzXi7icwE5UBeDg0Buy4KqONMxOwUFM9ZrJKbWGEWMAPPJSIv4uUhm6bM1uKJjQK1/
 gF37EHTzq6DGtlDEMWd1EHnGH9MOT6qW1PTY+WFPFl58417XyE4F8trvtBZx62js84nUCc
 y9mpCBtaezg+jE6RjuUqiJM4oSpBaLjLRfO6WphZP9LcZuQmvMmgFtGZ1M49Rt8RfalPBH
 NDyEQTo8w55i5/nwVfcPrwau954s5zV9iRE7TzxjObqcU5kNfXQn3z4RhFHuroU9B9qroi
 kktJS8YeOWWTrw74VBNfNJjj1kGaePGQdsB3nNflLtfTiYPkaMKj/LMl2fzMVB2Fucz2XJ
 HwlTPZZR5tYpsJNLHncM1FSGAxkpAY79/+3NHaFO7POTAEnH/0qAqgcBja/vvNC3AfZc6X
 /HGk31rxmp0FHgrp7RmBRGi2AgeYq0H9LjvDK8WBcbEZTIB1QTASqyJV9eBw
X-ME-Proxy: <xmx:NFAfao_r8xf0embuVHEcf24dsWYzR1Sgr0ytBBgyoTDdWSdZyudJpQ>
 <xmx:NFAfatmabwl63ti7FCJKYKJGaMtY7a3FTQWAYwhpZQhW0EH0gI-mOg>
 <xmx:NFAfatyZPEXY4vgGrWVBWws2i0duA7CcHhMrxZLQXP5P1mSQjtX3yw>
 <xmx:NFAfan5aWQ1Vh2kO9EyGAwFPGruA3Wt_9h1uf5oNjXpbyhS7nHXJ9g>
 <xmx:NFAfamBSZcDZ-uStatPJO1KB9b8WsKdNgO6qP-gwErC-R40yrXPTqNUz>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 17:50:43 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v6 05/10] net/mlx5: fix Rx split segment counter type
Date: Tue,  2 Jun 2026 23:49:17 +0200
Message-ID: <20260602215022.3698662-6-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602215022.3698662-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260602215022.3698662-1-thomas@monjalon.net>
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

In the API, rx_nseg and max_nseg are uint16_t.
In mlx5, MLX5_MAX_RXQ_NSEG is 32.
So there is no reason to have rxseg_n as uint32_t.
Reduce the fields to uint16_t and move them to avoid struct holes.

Fixes: 9f209b59c8b0 ("net/mlx5: support Rx buffer split description")
Fixes: 572c9d4bda08 ("net/mlx5: fix shared Rx queue segment configuration match")
Cc: stable@dpdk.org

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 drivers/net/mlx5/mlx5_rx.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_rx.h b/drivers/net/mlx5/mlx5_rx.h
index dffab3955b..01b563d981 100644
--- a/drivers/net/mlx5/mlx5_rx.h
+++ b/drivers/net/mlx5/mlx5_rx.h
@@ -164,9 +164,9 @@ struct __rte_cache_aligned mlx5_rxq_data {
 	uint64_t flow_meta_mask;
 	int32_t flow_meta_offset;
 	uint32_t flow_meta_port_mask;
-	uint32_t rxseg_n; /* Number of split segment descriptions. */
 	struct mlx5_eth_rxseg rxseg[MLX5_MAX_RXQ_NSEG];
 	/* Buffer split segment descriptions - sizes, offsets, pools. */
+	uint16_t rxseg_n; /* Number of split segment descriptions. */
 	uint16_t rq_win_cnt; /* Number of packets in the sliding window data. */
 	uint16_t rq_win_idx_mask; /* Sliding window index wrapping mask. */
 	uint16_t rq_win_idx; /* Index of the first element in sliding window. */
@@ -191,9 +191,9 @@ struct mlx5_rxq_ctrl {
 	unsigned int irq:1; /* Whether IRQ is enabled. */
 	uint32_t flow_tunnels_n[MLX5_FLOW_TUNNEL]; /* Tunnels counters. */
 	uint32_t wqn; /* WQ number. */
-	uint32_t rxseg_n; /* Number of split segment descriptions. */
 	struct rte_eth_rxseg_split rxseg[MLX5_MAX_RXQ_NSEG];
 	/* Saved original buffer split segment configuration. */
+	uint16_t rxseg_n; /* Number of split segment descriptions. */
 	uint16_t dump_file_n; /* Number of dump files. */
 };
 
-- 
2.54.0

