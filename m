Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67703CD4F54
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 12:48:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8A7A40670;
	Thu, 28 May 2026 14:48:19 +0200 (CEST)
Received: from fhigh-a6-smtp.messagingengine.com
 (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by mails.dpdk.org (Postfix) with ESMTP id E1A2B40654;
 Thu, 28 May 2026 14:48:18 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 9550F140016D;
 Thu, 28 May 2026 08:48:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Thu, 28 May 2026 08:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1779972498; x=
 1780058898; bh=PApFKN/EM/1VqqJ0s7RfjM6nlLnmW/GNEZXlVqsUtNY=; b=U
 3fQnYzo8Rkri7btQke6AoqpBtiDQj4TNHSHtN85M4hruMq+HWg9KOOVYcvnNfRJK
 7dBzQ6oapOr1tkuRndMM4s4EKMNFevLfQ6xp6kqVCfwb64osraBxi6f4sXMUQQRm
 DX80DECXRxwyxwilKG3cZCtX7DgEKsa3O0Yw7CiVAxCwaBXh4qLiJ9ZLzlp/vIRn
 MaDG7WKix0wfeNIY/+sd6Hlk783NIyAhZb5YXBy+3s6vB7cqjnHkzppjvmMo/CKQ
 yR0Iv464APkIXqTFKjH2eCFbiR/TCaYJaqqs3OTkq6TbkqvEzGjHSzJa4UqcKI6M
 52NSCve5+tUtiWg1X+E6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1779972498; x=1780058898; bh=P
 ApFKN/EM/1VqqJ0s7RfjM6nlLnmW/GNEZXlVqsUtNY=; b=G3WpBPouY+boGZbqq
 XTOeYLNgMNVSZIDYl7WaNZ5nwhriwk5FCusEvG4kV+BYecgCnzHrjGcFw0tCFgmK
 8c4/3P5FcRCmJj/JqoPvkRh9fxZKv46rU7e6nIOfHz2jDd8yFJqabV5tu+nIMhMv
 joxZBhUkJd/1EHDEutjervnIC5Z5PFD8QnkJp6sEpRNDazOgWKtqDz9YckVIgb4b
 NtjjcxdyT91Pie/1xeltuTNTK3aCScBqROaVNns71BnLNBiUooQq9e5P+RTCre6C
 ZWPqy6FNtmXCIx50z+Vs/wZ2hP61UstElJNO+5Q/bk/uXtl1q5MBbnGcewaJGVT1
 FgqFw==
X-ME-Sender: <xms:kjkYalcMbaj1-yFPOFEwsuOWOsiyZnZPqbCNSHh_7YNgIfts8Hwimw>
 <xme:kjkYavNocGL8nPSQ6_z9OE_I0RH35wGIiXRaE6KTuIRrm68LDzDuARuu-AEp3wtod
 gzkUigAIjWfOT6NxYGN_915ozEd979R1mbGl18K3cktbWTM7eyesA>
X-ME-Received: <xmr:kjkYagtS7uTtUg9QlaRltS8o11OlTtKpsO-QvGCdq0iS0YM_I1iFDrIDkGvQ1clofxvOTSakjGa7rInmA_JK9Cv9Q0BMlm8>
X-ME-Proxy-Cause: dmFkZTFz9ElM8atN52hATh5ajF7s0lLxxzBfiE6j39hf1JxcqJynjt7L4NYoJmzP9WmtYq
 u29XhSikmmZn/hdK4D0eNlUDTOL4+xtzxSuEll50QDeIjqonzn2iS0r744AmS8iONeH22B
 e6d1wXko82o9bsXJoivx0/mgIs7Vm3LB9oY8NN2pjNW8pzLUPQdqVbkViVMX0PAEyesgLM
 hD2OGh7ohELaYkcv3oqISa9xhYTsEviSrpchBlaGfmEwe2jD2nyfUHUdWk1zH2nVhcHRVZ
 4YEai14FeJFaWoCXFRMw/aQsr+d8KnoAkdb0ZtV4TKc5MBAj0ia2SSMRzmmAFrXFcTiMmT
 zJpf5LuKtLiHpSfeQ7DfxNQKnACpYXnVyg/rODl74qDIE9917zfd0kbH3haEspL5oZbSEC
 ccrqb7iluquEp9zR0RWOZWL0EI/7EQx677V1QNDkQdfB6X0rjZG9rSuZrv6F9S+hpYav7o
 uXZxBbklzG99P3/ipAUP49ykjAubNWo25BriVmtmlNn7thwQIZ1ezQTQ7BQae4JUhmHqce
 g0qaK9dnP5ZVTsTx9hrxFAIyqFPjr4YAaln115VmVF8KEFu/+43EvMXIK0M/D8P9Kz6Nve
 1cuykhKM3FVuN1aZGIstHnOltiqf8eLGAtLC8kIg4EQ78faLPkDV/CGH1SOQ
X-ME-Proxy: <xmx:kjkYagCxBvZmsZWMq-_zEn6JJI7vMDeSSNvdFRE8HAGq5skXZ4UYCA>
 <xmx:kjkYavYx_XaRFPFNUQKgQ1EtSxJZA3CCFQcqJndRYA2zDDXGoRBySg>
 <xmx:kjkYajX_BZXHg8P4shzmuqOxeJbB5NGECiNwpRg7jDONLI8ElRZyDQ>
 <xmx:kjkYamN3M5Nxgsd9rQSJ-Tt69LliUOs-PvsyrU5bm1BcgxxKBOysYQ>
 <xmx:kjkYavFt0hydfpe_iUejhG3gNBy_rCYye0lGNDZ3djM1eyLuFLNwvuve>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 May 2026 08:48:17 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v3 05/10] net/mlx5: fix Rx split segment counter type
Date: Thu, 28 May 2026 14:46:32 +0200
Message-ID: <20260528124758.1984528-6-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528124758.1984528-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260528124758.1984528-1-thomas@monjalon.net>
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

