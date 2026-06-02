Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870E4CD6E5D
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 21:41:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BDC14066D;
	Tue,  2 Jun 2026 23:40:58 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id D5D2C40678;
 Tue,  2 Jun 2026 23:40:55 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 39F401D00061;
 Tue,  2 Jun 2026 17:40:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Tue, 02 Jun 2026 17:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1780436455; x=
 1780522855; bh=PApFKN/EM/1VqqJ0s7RfjM6nlLnmW/GNEZXlVqsUtNY=; b=e
 znCaw88ZViAKBLq/6fVx616z7pMPvDy5WyctPkIcIPSCa1GgqgcvYMbK8ZgbzL/T
 F/2fFgWGVHIDo/ES73sz6i44JHBRH4WQ5Pt4G5pmiteecskVZ+8wlOYW6/EygU+j
 6O7CQTUluVEMyu4EkmQRws+nncAX9LEBGeimJ+7RE7lSZRK7Cf+YGqpzznZmVlmn
 AEvyNFtMJ1sKRgK6UaVt7wixM4W6+R6NLQrk2S31itsWv6oQNUpPcYWXnofXCoeD
 UMI3I0zwMgjyhzgwjrjIKVYrU7VVIKh8PH2RyGlEELXr+CDsEc8Zvf3lEGGyEgZH
 45RajW2j0wQynh4YLnkmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780436455; x=1780522855; bh=P
 ApFKN/EM/1VqqJ0s7RfjM6nlLnmW/GNEZXlVqsUtNY=; b=EM38RNMwxT9FU5MEy
 annR/aycUG6UUXIhCbHzKLM9W039rRI6Fm1k9+Ej6PW7NRLSh1f5XaJRRFNnAJqO
 B2FV4fF79VfMxgRw3q+ztb4dJM77H5oB3oEMZymiJ8GMFtg2ZZdvc97rh4eqe06+
 A2KW3Lq0AjgmJvQFLAx3Y73/4seNGc6G4AJ2GcyBwFx1OVzii37NpYGemA7pCYqc
 tSAA92M+C0/+UQzhYGsVQxM8pwCJsQChFMJrJ6VfR17dJ/ZttV/HNzBHvPaeeH15
 eORB1hGkTz3UxeiwNoWvS9r4jHZUdLAVFRgoclt8lKenWHWQY71Kn9xnI7JXycIn
 Db+2g==
X-ME-Sender: <xms:500falSwf2xhpJs7gaIqHpsgJNvdy9pVrjkRvQHSVnFvpUoA21w64A>
 <xme:500faqyJ8TAoc1X4r2_iDtB8Hvo6mlOqvZwVJNyZx_IvQ1XvBaNWRszcvEECLmxin
 RaboCbl7hegYCeppzlE280KYv5rF_q-a2iARiWHKMAF_IGanJZE_A>
X-ME-Received: <xmr:500fatB22201_XnoDA-W2accbsFB2PvsocvtawOfJYjFEyLuawfNfl_jc_RjRQ3cm2pXxMd6hR1Y9QBevzCEZdfdc0qb7Ho>
X-ME-Proxy-Cause: dmFkZTGZt0xYo0P33JxOyevvANHoI8JpjNrBC/6PKXP458vBYHOGPNqnlJ0CG2/AX0L60L
 buV/G+y7lmuwK76eyRfOC+oUKFhz0DuFaa0et+lkctsMNEHj65+G4TMlYDPneJJml1s9aE
 Brkd8sfGbg0KDzJo+SS1bbYHu/h0HJc0x2E8T71ZbJ65TY9yrkyxatpby9zKfBy+Qi0wUF
 tzNwttg+3Dpg5Pl52krNpaCJNL3V10xIEcD6vFStba1EFoDwH68DMgTa15tCO0s+scKMt+
 ZDsH3xkyC/NawDezlpSDD4nx+fFSMOsJN/RUKlvESgtRztMZrcfPknXUtbF/h2bTk9/wfU
 Z14nVNbpYo++TUEQtSxEXtgmZiMdrn50AmPLOXY9/DP4JgfRAN6zOsupyp8t6UwQJEhWMp
 MBIr72Ya248SQwCXsVXubM8ypY9j5FsP8HZBPERtxIk2ylR4Vo0bkK0lY0WNoga6mwGqCI
 lM8BSLwkIbNLhb45iD9erAXUthrygGErNjLiufqeaGuLRMsMCcUfFnTZL/mZP0LBRmOucu
 QFwhW99Kp6hM4/rgUsGxR2zYPyEPLRjHzvG6dpObwvMKX6ndcC8D7tUeKeAKhi4CRxTbYb
 Yj5wwHxZC65PNcRenxXheWpXQ8jh0xgDkzI+bIxQkiFIGOsecs8RNxR0k1Jw
X-ME-Proxy: <xmx:500fauFWpA0cxrSL_bSs2xQWg7dx-cI7QRqN2GKPD5x3oUARt3TiCQ>
 <xmx:500fasP4kDEGHy8saczg2W5TeL47uj1I-tIvOmBzNAWiTlDvUtCgiA>
 <xmx:500fan7SidUHs5R5gmgOSwRTmB-NY5syv-Rvwtgs-Ev3tA2Q_qgrbA>
 <xmx:500fangDdJDX1gx1ktlw2GN8tFvMEyKHQJ7fjoL44feh2VDvX2HoNg>
 <xmx:500fapceIXEgb6RKAGstyIH70OcBzNYV65XMqhHwuW9-aiuXazR0F9Um>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 17:40:53 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v5 05/10] net/mlx5: fix Rx split segment counter type
Date: Tue,  2 Jun 2026 23:38:36 +0200
Message-ID: <20260602214036.3606359-6-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602214036.3606359-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260602214036.3606359-1-thomas@monjalon.net>
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

